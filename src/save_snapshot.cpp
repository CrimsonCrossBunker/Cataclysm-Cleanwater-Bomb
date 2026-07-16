#include "save_snapshot.h"

#include <algorithm>
#include <cstdint>
#include <ctime>
#include <filesystem>
#include <functional>
#include <iosfwd>
#include <string>
#include <system_error>
#include <vector>

#include "calendar.h"
#include "cata_path.h"
#include "cata_utility.h"
#include "debug.h"
#include "filesystem.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "output.h"
#include "string_formatter.h"
#include "string_input_popup.h"
#include "translations.h"
#include "uilist.h"

namespace
{

// Folder under a world directory that holds all snapshots.
const std::string SNAPSHOTS_DIR = "snapshots";
// Per-snapshot metadata file name.
const std::string SNAPSHOT_META = "snapshot_meta.json";
// Temp folder used to stage a rollback during restore.
const std::string RESTORE_BACKUP_DIR = ".snapshot_restore_backup";

// Returns <world_dir>/snapshots .
cata_path snapshots_root( const cata_path &world_dir )
{
    return world_dir / SNAPSHOTS_DIR;
}

// Collect the immediate children of dir whose filename is NOT in skip.
// Collecting up front (rather than acting during iteration) avoids the
// unspecified behavior of mutating a directory while iterating it.
std::vector<std::filesystem::path> top_level_entries(
    const std::filesystem::path &dir, const std::vector<std::string> &skip )
{
    std::vector<std::filesystem::path> result;
    std::error_code ec;
    for( const std::filesystem::directory_entry &entry :
         std::filesystem::directory_iterator( dir, ec ) ) {
        const std::string name = entry.path().filename().u8string();
        if( std::find( skip.begin(), skip.end(), name ) != skip.end() ) {
            continue;
        }
        result.push_back( entry.path() );
    }
    return result;
}

// Recursively copy everything under src_dir into dst_dir, skipping any path
// whose top-level component name is in skip_top. Returns false on the first
// failed file copy.
bool copy_tree( const std::filesystem::path &src_dir,
                const std::filesystem::path &dst_dir,
                const std::vector<std::string> &skip_top )
{
    std::error_code ec;
    const std::filesystem::path canon_src = std::filesystem::weakly_canonical( src_dir, ec );
    const std::filesystem::path src_root = ec ? src_dir : canon_src;

    for( auto iter = std::filesystem::recursive_directory_iterator( src_root, ec );
         !ec && iter != std::filesystem::recursive_directory_iterator(); iter.increment( ec ) ) {
        const std::filesystem::path &entry = iter->path();
        const std::filesystem::path rel = entry.lexically_relative( src_root );

        // Skip excluded top-level subtrees / files.
        if( !rel.empty() && rel.begin() != rel.end() ) {
            const std::string top = rel.begin()->u8string();
            if( std::find( skip_top.begin(), skip_top.end(), top ) != skip_top.end() ) {
                if( iter->is_directory() ) {
                    iter.disable_recursion_pending();
                }
                continue;
            }
        }

        const std::filesystem::path dst = dst_dir / rel;
        if( iter->is_directory() ) {
            if( !assure_dir_exist( dst ) ) {
                debugmsg( "snapshot: failed to create directory '%s'", dst.u8string() );
                return false;
            }
        } else if( iter->is_regular_file() ) {
            if( !assure_dir_exist( dst.parent_path() ) ) {
                debugmsg( "snapshot: failed to create directory '%s'", dst.parent_path().u8string() );
                return false;
            }
            if( !copy_file( entry.u8string(), dst.u8string() ) ) {
                debugmsg( "snapshot: failed to copy '%s'", entry.u8string() );
                return false;
            }
        }
    }
    if( ec ) {
        debugmsg( "snapshot: error walking '%s': %s", src_root.u8string(), ec.message() );
        return false;
    }
    return true;
}

// Remove every immediate child of dir except those whose name is in keep.
bool clear_dir_except( const std::filesystem::path &dir,
                       const std::vector<std::string> &keep )
{
    bool ok = true;
    for( const std::filesystem::path &entry : top_level_entries( dir, keep ) ) {
        std::error_code rm_ec;
        // Many world subdirs are non-empty (maps/, overmaps/, dimensions/, the
        // character <id>/ folder, the <id>.mm1/ map-memory dir), so remove_all()
        // is needed; it also handles plain files.
        std::filesystem::remove_all( entry, rm_ec );
        if( rm_ec ) {
            debugmsg( "snapshot: failed to remove '%s': %s", entry.u8string(), rm_ec.message() );
            ok = false;
        }
    }
    return ok;
}

// Move every immediate child of from_dir (except names in skip) into to_dir,
// using rename (cheap within one filesystem). Returns false on first failure.
bool move_entries( const std::filesystem::path &from_dir,
                   const std::filesystem::path &to_dir,
                   const std::vector<std::string> &skip )
{
    for( const std::filesystem::path &entry : top_level_entries( from_dir, skip ) ) {
        std::error_code mv_ec;
        std::filesystem::rename( entry, to_dir / entry.filename(), mv_ec );
        if( mv_ec ) {
            debugmsg( "snapshot: failed to move '%s': %s", entry.u8string(), mv_ec.message() );
            return false;
        }
    }
    return true;
}

} // namespace

namespace save_snapshot
{

bool make_snapshot( const cata_path &world_dir, const std::string &slot_name,
                    const std::string &character_name, const int turn )
{
    const std::string dir_name = ensure_valid_file_name( slot_name );
    if( dir_name.empty() ) {
        return false;
    }

    const cata_path dest = snapshots_root( world_dir ) / dir_name;
    const std::filesystem::path dest_fs = dest.get_unrelative_path();

    // Replace any existing slot with this name.
    if( dir_exist( dest_fs ) ) {
        std::error_code ec;
        std::filesystem::remove_all( dest_fs, ec );
        if( ec ) {
            debugmsg( "snapshot: could not clear existing slot '%s': %s",
                      dest_fs.u8string(), ec.message() );
            return false;
        }
    }
    if( !assure_dir_exist( dest_fs ) ) {
        debugmsg( "snapshot: could not create snapshot directory '%s'", dest_fs.u8string() );
        return false;
    }

    // Copy the whole world, excluding the snapshots folder itself (so a snapshot
    // never nests prior snapshots).
    if( !copy_tree( world_dir.get_unrelative_path(), dest_fs, { SNAPSHOTS_DIR } ) ) {
        // Clean up the partial snapshot so it is never presented as restorable.
        std::error_code ec;
        std::filesystem::remove_all( dest_fs, ec );
        return false;
    }

    // Write metadata. real_time is stamped here to keep the storage layer
    // self-contained. If the meta write fails, drop the whole snapshot rather
    // than leave a meta-less directory that would still list as restorable.
    const cata_path meta_path = dest / SNAPSHOT_META;
    const int64_t real_time = static_cast<int64_t>( std::time( nullptr ) );
    const bool meta_ok = write_to_file( meta_path, [&]( std::ostream & fout ) {
        JsonOut jsout( fout );
        jsout.start_object();
        jsout.member( "name", slot_name );
        jsout.member( "character_name", character_name );
        jsout.member( "turn", turn );
        jsout.member( "real_time", real_time );
        jsout.end_object();
    }, _( "snapshot metadata" ) );
    if( !meta_ok ) {
        std::error_code ec;
        std::filesystem::remove_all( dest_fs, ec );
        return false;
    }

    return true;
}

std::vector<snapshot_info> list_snapshots( const cata_path &world_dir )
{
    std::vector<snapshot_info> result;
    const cata_path root = snapshots_root( world_dir );
    if( !dir_exist( root.get_unrelative_path() ) ) {
        return result;
    }

    const std::vector<cata_path> dirs = get_directories( root );
    for( const cata_path &dir : dirs ) {
        snapshot_info info;
        info.dir_name = dir.get_relative_path().filename().u8string();
        info.name = info.dir_name; // fallback if no/invalid meta

        const cata_path meta_path = dir / SNAPSHOT_META;
        read_from_file_optional_json( meta_path, [&info]( const JsonValue & jsin ) {
            JsonObject jo = jsin;
            jo.allow_omitted_members();
            jo.read( "name", info.name, false );
            jo.read( "character_name", info.character_name, false );
            jo.read( "turn", info.turn, false );
            jo.read( "real_time", info.real_time, false );
        } );
        result.push_back( info );
    }

    // Newest first.
    std::sort( result.begin(), result.end(),
    []( const snapshot_info & a, const snapshot_info & b ) {
        return a.real_time > b.real_time;
    } );
    return result;
}

bool snapshot_exists( const cata_path &world_dir, const std::string &slot_name )
{
    const std::string dir_name = ensure_valid_file_name( slot_name );
    if( dir_name.empty() ) {
        return false;
    }
    const cata_path dest = snapshots_root( world_dir ) / dir_name;
    return dir_exist( dest.get_unrelative_path() );
}

bool restore_snapshot( const cata_path &world_dir, const std::string &dir_name )
{
    const cata_path snap_path = snapshots_root( world_dir ) / dir_name;
    const std::filesystem::path snap_fs = snap_path.get_unrelative_path();
    if( !dir_exist( snap_fs ) ) {
        debugmsg( "snapshot: '%s' no longer exists", snap_fs.u8string() );
        return false;
    }

    const std::filesystem::path world_fs = world_dir.get_unrelative_path();
    const std::filesystem::path backup_fs =
        ( world_dir / RESTORE_BACKUP_DIR ).get_unrelative_path();

    // Atomic-ish restore with rollback:
    //   1. Move the live world's files (except snapshots/ and any old backup)
    //      into a backup folder — cheap renames, nothing destroyed yet.
    //   2. Copy the snapshot into the world (excluding its own meta file).
    //   3. On success, delete the backup. On any failure, move the backup
    //      contents back so the world is never left half-deleted.
    const std::vector<std::string> protect = { SNAPSHOTS_DIR, RESTORE_BACKUP_DIR };

    std::error_code ec;
    std::filesystem::remove_all( backup_fs, ec ); // clear any stale backup
    if( !assure_dir_exist( backup_fs ) ) {
        debugmsg( "snapshot: could not create restore backup dir '%s'", backup_fs.u8string() );
        return false;
    }

    if( !move_entries( world_fs, backup_fs, protect ) ) {
        // Roll back whatever we managed to move, then bail.
        move_entries( backup_fs, world_fs, {} );
        std::filesystem::remove_all( backup_fs, ec );
        return false;
    }

    // Copy the snapshot in, excluding the per-snapshot meta file so it does not
    // pollute the world root (and snowball into future snapshots).
    if( !copy_tree( snap_fs, world_fs, { SNAPSHOT_META } ) ) {
        // Restore failed: wipe the partial copy and move the backup back.
        clear_dir_except( world_fs, protect );
        move_entries( backup_fs, world_fs, {} );
        std::filesystem::remove_all( backup_fs, ec );
        return false;
    }

    // Success: discard the backup.
    std::filesystem::remove_all( backup_fs, ec );
    return true;
}

bool delete_snapshot( const cata_path &world_dir, const std::string &dir_name )
{
    const cata_path snap_path = snapshots_root( world_dir ) / dir_name;
    const std::filesystem::path snap_fs = snap_path.get_unrelative_path();
    if( !dir_exist( snap_fs ) ) {
        return false;
    }
    std::error_code ec;
    const bool ok = std::filesystem::remove_all( snap_fs, ec ) !=
                    static_cast<std::uintmax_t>( -1 ) && !ec;
    if( !ok ) {
        debugmsg( "snapshot: failed to delete '%s': %s", snap_fs.u8string(), ec.message() );
    }
    return ok;
}

std::string snapshot_info::display_label() const
{
    std::string label = name;
    if( turn > 0 ) {
        label += string_format( " — %s", to_string( time_point::from_turn( turn ) ) );
    }
    if( !character_name.empty() ) {
        label += string_format( " (%s)", character_name );
    }
    return label;
}

menu_selection query_snapshot_menu( const cata_path &world_dir,
                                    const std::string &title,
                                    const std::string &restore_verb )
{
    const std::vector<snapshot_info> snaps = list_snapshots( world_dir );

    uilist menu;
    menu.title = title;
    menu.text = _( "Snapshots capture the entire world.  Restoring overwrites the "
                   "world's current save with the snapshot." );

    // Entry 0: create a new snapshot.
    menu.addentry( 0, true, 'n', _( "Save a new snapshot…" ) );

    // Entries 1..N: existing snapshots.
    int idx = 1;
    for( const snapshot_info &s : snaps ) {
        menu.addentry( idx, true, MENU_AUTOASSIGN, "%s", s.display_label() );
        ++idx;
    }

    menu.query();
    const int ret = menu.ret;
    if( ret < 0 ) {
        return menu_selection{};
    }

    if( ret == 0 ) {
        string_input_popup popup;
        const std::string name = popup
                                 .title( _( "Snapshot name:" ) )
                                 .width( 30 )
                                 .max_length( 60 )
                                 .query_string();
        if( name.empty() ) {
            return menu_selection{};
        }
        // Warn if this name would silently overwrite an existing slot — including
        // the case where a different display name sanitizes to the same folder.
        if( snapshot_exists( world_dir, name ) &&
            !query_yn( _( "A snapshot with this name already exists.  Overwrite it?" ) ) ) {
            return menu_selection{};
        }
        menu_selection sel;
        sel.action = menu_action::create;
        sel.new_name = name;
        return sel;
    }

    const size_t i = static_cast<size_t>( ret - 1 );
    if( i >= snaps.size() ) {
        return menu_selection{};
    }
    const snapshot_info &chosen = snaps[i];

    uilist action;
    action.title = chosen.name;
    action.addentry( 0, true, 'l', restore_verb );
    action.addentry( 1, true, 'd', _( "Delete this snapshot" ) );
    action.query();

    menu_selection sel;
    sel.chosen = chosen;
    if( action.ret == 0 ) {
        sel.action = menu_action::load;
    } else if( action.ret == 1 ) {
        sel.action = menu_action::remove;
    }
    return sel;
}

} // namespace save_snapshot
