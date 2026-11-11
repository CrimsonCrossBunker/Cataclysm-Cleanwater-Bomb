#include "mapbuffer.h"

#include <chrono>
#include <cstddef>
#include <exception>
#include <filesystem>
#include <functional>
#include <optional>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <unordered_set>
#include <utility>
#include <vector>

#include "calendar.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "coordinates.h"
#include "debug.h"
#include "filesystem.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "input.h"
#include "json.h"
#include "json_loader.h"
#include "json_loader_buffer.h"
#include "map.h"
#include "map_storage_context.h"
#include "output.h"
#include "overmap_types.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "point.h"
#include "popup.h"
#include "profiling.h"
#include "std_hash_fs_path.h"
#include "string_formatter.h"
#include "submap.h"
#include "submap_prefetch.h"
#include "translations.h"
#include "type_id.h"
#include "ui_manager.h"
#include "vehicle.h"
#include "worldfactory.h"
#include "zzip.h"

#define dbg(x) DebugLog((x),D_MAP) << __FILE__ << ":" << __LINE__ << ": "

static std::string quad_file_name( const tripoint_abs_omt &om_addr )
{
    return string_format( "%d.%d.%d.map", om_addr.x(), om_addr.y(), om_addr.z() );
}

cata_path mapbuffer::find_dirname( const tripoint_abs_omt &om_addr )
{
    const tripoint_abs_seg segment_addr = project_to<coords::seg>( om_addr );
    std::string segment = string_format( "%d.%d.%d",
                                         segment_addr.x(),
                                         segment_addr.y(), segment_addr.z() );
    return storage().directory() / "maps" / segment;
}

mapbuffer MAPBUFFER;

mapbuffer::mapbuffer() : active_world_adapter_( true )
{
    uniform_terrain_ = [this]( const tripoint_abs_omt & p ) {
        const map_storage_context &context = storage();
        if( !world_generator || !world_generator->active_world || !g ||
            world_generator->active_world->identity() != context.world() ||
            g->get_dimension_prefix() != context.dimension() ) {
            throw std::logic_error( "Map buffer uniform terrain belongs to another world or dimension" );
        }
        return overmap_buffer.ter( p );
    };
}

mapbuffer::mapbuffer( map_storage_context context, uniform_terrain_lookup uniform ) :
    active_world_adapter_( false ),
    storage_( std::make_unique<const map_storage_context>( std::move( context ) ) ),
    uniform_terrain_( std::move( uniform ) )
{
}

mapbuffer::~mapbuffer() = default;

std::size_t mapbuffer::submap_count() const
{
    std::scoped_lock lock( submaps_mutex_ );
    return submaps.size();
}

const map_storage_context &mapbuffer::storage()
{
    if( !storage_ ) {
        if( !world_generator || !world_generator->active_world || !g ) {
            throw std::logic_error( "Cannot bind map storage without an active world" );
        }
        const WORLD &world = *world_generator->active_world;
        storage_ = std::make_unique<const map_storage_context>( world.identity(),
                   g->get_dimension_prefix(), world.folder_path(), world.has_compression_enabled() );
    }
    return *storage_;
}

void mapbuffer::clear()
{
    // Drop any pending/completed background reads first: their captured paths
    // belong to the world being torn down and must not be consumed afterward.
    prefetcher_.clear();
    submaps.clear();
    // The listing cache is keyed by archive path and belongs to the old world.
    zzip_listing_cache.clear();
    if( active_world_adapter_ ) {
        storage_.reset();
    }
}

void mapbuffer::clear_outside_reality_bubble()
{
    map &here = get_map();
    auto it = submaps.begin();
    while( it != submaps.end() ) {
        if( here.inbounds( it->first ) ) {
            ++it;
        } else {
            it = submaps.erase( it );
        }
    }
}

bool mapbuffer::add_submap( const tripoint_abs_sm &p, std::unique_ptr<submap> &sm )
{
    std::scoped_lock lk( submaps_mutex_ );
    storage();
    if( submaps.count( p ) ) {
        return false;
    }

    // Vehicles store their mount origin within the submap, not its absolute
    // coordinates. Cable lookup can load this submap without map::loadn(), so
    // establish the absolute origin here before any off-bubble processing.
    for( const std::unique_ptr<vehicle> &veh : sm->vehicles ) {
        veh->sm_pos = p;
    }
    submaps[p] = std::move( sm );

    return true;
}

bool mapbuffer::add_submap( const tripoint_abs_sm &p, submap *sm )
{
    // Binding can fail; do not adopt the caller's raw pointer before that check.
    storage();
    // FIXME: get rid of this overload and make submap ownership semantics sane.
    std::unique_ptr<submap> temp( sm );
    bool result = add_submap( p, temp );
    if( !result ) {
        // NOLINTNEXTLINE( bugprone-unused-return-value )
        temp.release();
    }
    return result;
}

void mapbuffer::remove_submap( const tripoint_abs_sm &addr )
{
    std::scoped_lock lk( submaps_mutex_ );
    auto m_target = submaps.find( addr );
    if( m_target == submaps.end() ) {
        debugmsg( "Tried to remove non-existing submap %s", addr.to_string() );
        return;
    }
    submaps.erase( m_target );
}

submap *mapbuffer::lookup_submap( const tripoint_abs_sm &p )
{
    storage();
    dbg( D_INFO ) << "mapbuffer::lookup_submap( x[" << p.x() << "], y[" << p.y() << "], z["
                  << p.z() << "])";

    const auto iter = submaps.find( p );
    if( iter == submaps.end() ) {
        try {
            return unserialize_submaps( p );
        } catch( const std::exception &err ) {
            debugmsg( "Failed to load submap %s: %s", p.to_string(), err.what() );
        }
        return nullptr;
    }

    return iter->second.get();
}

bool mapbuffer::submap_exists( const tripoint_abs_sm &p )
{
    storage();
    // Could so with a second check against a std::unordered_set<tripoint_abs_sm> of already checked existing but not loaded submaps before resorting to unserializing?
    const auto iter = submaps.find( p );
    if( iter == submaps.end() ) {
        try {
            return unserialize_submaps( p );
        } catch( const std::exception &err ) {
            debugmsg( "Failed to load submap %s: %s", p.to_string(), err.what() );
        }
        return false;
    }

    return true;
}

bool mapbuffer::submap_exists_approx( const tripoint_abs_sm &p )
{
    storage();
    const auto iter = submaps.find( p );
    if( iter == submaps.end() ) {
        try {
            const tripoint_abs_omt om_addr = project_to<coords::omt>( p );
            const cata_path dirname = find_dirname( om_addr );
            std::string file_name = quad_file_name( om_addr );

            if( storage().compressed() ) {
                cata_path zzip_name = dirname;
                zzip_name += zzip_suffix;
                // Route through the cached entry listing instead of a fresh
                // zzip::load + has_file on every call: same answer, no per-call
                // mmap + footer parse, and it shares one code path with
                // unserialize_submaps so the two existence checks cannot drift.
                const std::unordered_set<std::string> *listing = zzip_listing( zzip_name );
                return listing && listing->find( file_name ) != listing->end();
            } else {
                return file_exist( dirname / file_name );
            }
        } catch( const std::exception &err ) {
            debugmsg( "Failed to load submap %s: %s", p.to_string(), err.what() );
        }
        return false;
    }

    return true;
}

void mapbuffer::prefetch_quad( const tripoint_abs_omt &om_addr, int priority )
{
    // Bind on the owner thread, then hand a self-contained request to the worker.
    // Explicitly owned buffers never resolve paths through the active world.
    storage();
    // An OMT ".map" file holds the 2x2 submap quad for a single z-level.
    const tripoint_abs_sm sm_base = project_to<coords::sm>( om_addr );
    bool any_missing = false;
    for( int dx = 0; dx <= 1 && !any_missing; dx++ ) {
        for( int dy = 0; dy <= 1 && !any_missing; dy++ ) {
            if( submaps.find( sm_base + point( dx, dy ) ) == submaps.end() ) {
                any_missing = true;
            }
        }
    }
    if( !any_missing ) {
        return;
    }

    const cata_path dirname = find_dirname( om_addr );
    const std::string file_name = quad_file_name( om_addr );

    submap_prefetcher::request_t req;
    req.om = om_addr;
    req.entry_name = std::filesystem::u8path( file_name );

    if( storage().compressed() ) {
        cata_path zzip_name = dirname;
        zzip_name += zzip_suffix;
        req.compressed = true;
        req.zzip_path = zzip_name.get_unrelative_path();
        req.dict_path = storage().dictionary().get_unrelative_path();
    } else {
        req.compressed = false;
        req.quad_path = ( dirname / file_name ).get_unrelative_path();
    }

    prefetcher_.request( req, priority );
}

void mapbuffer::prefetch_evict_beyond( const tripoint_abs_omt &center, int max_dist )
{
    prefetcher_.evict_beyond( center, max_dist );
}

submap_prefetcher::status mapbuffer::prefetch_status() const
{
    return prefetcher_.inspect();
}

void mapbuffer::save( bool delete_after_save, const map *resident_map )
{
    storage();
    // The prefetch worker reads the same zzip archives this loop rewrites. Park it
    // (and force it to drop any cached archive handle) for the duration of the save
    // so the save path is the sole writer. Resumes on scope exit, even on throw.
    scoped_prefetch_pause prefetch_pause( prefetcher_ );
    // A failed save may already have rewritten earlier quads. Cached listings
    // must be invalidated on both success and failure; buffered maps stay owned.
    on_out_of_scope invalidate_listings( [this]() {
        zzip_listing_cache.clear();
    } );

    if( !assure_dir_exist( storage().directory() / "maps" ) ) {
        throw std::runtime_error( "Cannot create map storage directory" );
    }
    int num_saved_submaps = 0;
    int num_total_submaps = submaps.size();

    static_popup popup;

    // A set of already-saved submaps, in global overmap coordinates.
    std::set<tripoint_abs_omt> saved_submaps;
    std::list<tripoint_abs_sm> submaps_to_delete;
    static constexpr std::chrono::milliseconds update_interval( 500 );
    std::chrono::steady_clock::time_point last_update = std::chrono::steady_clock::now();

    for( auto &elem : submaps ) {
        std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
        if( last_update + update_interval < now ) {
            popup.message( _( "Please wait as the map saves [%d/%d]" ),
                           num_saved_submaps, num_total_submaps );
            ui_manager::redraw();
            refresh_display();
            inp_mngr.pump_events();
            last_update = now;
        }
        // Whatever the coordinates of the current submap are,
        // we're saving a 2x2 quad of submaps at a time.
        // Submaps are generated in quads, so we know if we have one member of a quad,
        // we have the rest of it, if that assumption is broken we have REAL problems.
        const tripoint_abs_omt om_addr = project_to<coords::omt>( elem.first );
        if( saved_submaps.count( om_addr ) != 0 ) {
            // Already handled this one.
            continue;
        }
        saved_submaps.insert( om_addr );

        // A segment is a chunk of 32x32 submap quads.
        // We're breaking them into subdirectories so there aren't too many files per directory.
        // Might want to make a set for this one too so it's only checked once per save().
        const cata_path dirname = find_dirname( om_addr );
        const cata_path quad_path = dirname / quad_file_name( om_addr );

        const bool outside_resident_map = resident_map && !resident_map->inbounds( om_addr );
        // delete_on_save deletes everything, otherwise delete submaps
        // outside the current map.
        save_quad( dirname, quad_path, om_addr, submaps_to_delete,
                   delete_after_save || outside_resident_map );
        num_saved_submaps += 4;
    }
    for( auto &elem : submaps_to_delete ) {
        remove_submap( elem );
    }
}

void mapbuffer::save_quad(
    const cata_path &dirname, const cata_path &filename, const tripoint_abs_omt &om_addr,
    std::list<tripoint_abs_sm> &submaps_to_delete, bool delete_after_save )
{
    std::vector<point_rel_sm> offsets;
    std::vector<tripoint_abs_sm> submap_addrs;
    offsets.reserve( 4 );
    submap_addrs.reserve( 4 );
    offsets.push_back( point_rel_sm::zero );
    offsets.push_back( point_rel_sm::south );
    offsets.push_back( point_rel_sm::east );
    offsets.push_back( point_rel_sm::south_east );

    bool all_uniform = true;
    bool reverted_to_uniform = false;
    bool file_exists = false;

    std::optional<zzip> z;
    cata_path zzip_name = dirname;
    zzip_name += zzip_suffix;
    // The number of uniform submaps is so enormous that the filesystem overhead
    // for this step of just checking if the quad exists approaches 70% of the
    // total cost of saving the mapbuffer, in one test save I had.
    if( storage().compressed() ) {
        z = zzip::load( zzip_name.get_unrelative_path(),
                        storage().dictionary().get_unrelative_path() );
        if( !z ) {
            throw std::runtime_error( "Failed opening compressed save file " +
                                      zzip_name.get_unrelative_path().generic_u8string() );
        }
        file_exists = z->has_file( filename.get_relative_path().filename() );
    } else {
        file_exists = std::filesystem::exists( filename.get_unrelative_path() );
    }

    for( point_rel_sm &offsets_offset : offsets ) {
        tripoint_abs_sm submap_addr = project_to<coords::sm>( om_addr );
        submap_addr += offsets_offset.raw(); // TODO: Make += etc. available to relative parameters as well.
        submap_addrs.push_back( submap_addr );
        const auto existing = submaps.find( submap_addr );
        submap *sm = existing == submaps.end() ? nullptr : existing->second.get();
        if( sm != nullptr ) {
            if( !sm->is_uniform() ) {
                all_uniform = false;
            } else if( sm->reverted ) {
                reverted_to_uniform = file_exists;
            }
        }
    }

    // An explicit storage owner may have no overmap terrain resolver. In that
    // case even uniform submaps must be persisted, because they cannot be
    // reconstructed after eviction or reload.
    const bool regenerable_uniform = all_uniform && static_cast<bool>( uniform_terrain_ );
    if( regenerable_uniform ) {
        // Nothing to save - this quad will be regenerated faster than it would be re-read
        if( delete_after_save ) {
            for( auto &submap_addr : submap_addrs ) {
                if( submaps.count( submap_addr ) > 0 && submaps[submap_addr] != nullptr ) {
                    submaps_to_delete.push_back( submap_addr );
                }
            }
        }

        // deleting the file might fail on some platforms in some edge cases so force serialize this
        // uniform quad
        if( !reverted_to_uniform ) {
            return;
        }
    }

    std::stringstream stringout;
    JsonOut jsout( stringout );
    jsout.start_array();
    for( auto &submap_addr : submap_addrs ) {
        if( submaps.count( submap_addr ) == 0 ) {
            continue;
        }

        submap *sm = submaps[submap_addr].get();

        if( sm == nullptr ) {
            continue;
        }

        jsout.start_object();

        jsout.member( "version", savegame_version );
        jsout.member( "coordinates" );

        jsout.start_array();
        jsout.write( submap_addr.x() );
        jsout.write( submap_addr.y() );
        jsout.write( submap_addr.z() );
        jsout.end_array();

        sm->store( jsout );

        jsout.end_object();

        if( delete_after_save ) {
            submaps_to_delete.push_back( submap_addr );
        }
    }

    jsout.end_array();

    std::string s = std::move( stringout ).str();

    if( z ) {
        if( !z->add_file( filename.get_relative_path().filename(), s ) ) {
            throw std::runtime_error( "Failed writing map archive " + zzip_name.generic_u8string() );
        }
    } else {
        // Don't create the directory if it would be empty
        if( !assure_dir_exist( dirname ) ) {
            throw std::runtime_error( "Failed writing map quad " + filename.generic_u8string() );
        }
        write_to_file( filename, [&]( std::ostream & fout ) {
            fout << s;
        } );
    }

    if( regenerable_uniform && reverted_to_uniform ) {
        if( z ) {
            if( !z->delete_files( { filename.get_relative_path().filename() } ) ) {
                throw std::runtime_error( "Failed removing uniform quad from map archive" );
            }
        } else {
            std::filesystem::remove( filename.get_unrelative_path() );
        }
    }
    if( z ) {
        cata_path tmp_path = zzip_name + ".tmp";
        if( z->compact_to( tmp_path.get_unrelative_path(), 2.0 ) ) {
            z.reset();
            if( !rename_file( tmp_path, zzip_name ) ) {
                throw std::runtime_error( "Failed replacing compacted map archive" );
            }
        }
    }
}

const std::unordered_set<std::string> *mapbuffer::zzip_listing( const cata_path &zzip_path )
{
    const std::string key = zzip_path.get_unrelative_path().generic_u8string();
    const auto it = zzip_listing_cache.find( key );
    if( it != zzip_listing_cache.end() ) {
        return &it->second;
    }
    if( !file_exist( zzip_path ) ) {
        return nullptr;
    }
    std::optional<zzip> z = zzip::load( zzip_path.get_unrelative_path(),
                                        storage().dictionary().get_unrelative_path() );
    if( !z ) {
        return nullptr;
    }
    // Snapshot the entry names, then drop the zzip handle (mmap) immediately: we
    // must not hold it across a save that rewrites this archive.
    std::unordered_set<std::string> listing;
    for( const std::filesystem::path &entry : z->get_entries() ) {
        listing.insert( entry.generic_u8string() );
    }
    return &zzip_listing_cache.emplace( key, std::move( listing ) ).first->second;
}

// We're reading in way too many entities here to mess around with creating sub-objects and
// seeking around in them, so we're using the json streaming API.
submap *mapbuffer::unserialize_submaps( const tripoint_abs_sm &p )
{
    CATA_PROFILE_SCOPE();
    // Map the tripoint to the submap quad that stores it.
    const tripoint_abs_omt om_addr = project_to<coords::omt>( p );
    const cata_path dirname = find_dirname( om_addr );
    std::string file_name = quad_file_name( om_addr );
    std::filesystem::path file_name_path = std::filesystem::u8path( file_name );
    cata_path quad_path = dirname / file_name;

    bool read = [&] {
        // Fast path: the background prefetcher may have already read+decompressed
        // this quad's bytes off the main thread. Parsing (deserialize) still happens
        // here on the main thread, because it builds submap/string_id state that is
        // not safe to touch from the worker.
        auto prefetched = prefetcher_.take( om_addr );
        if( prefetched )
        {
            try {
                JsonValue jsin = json_from_owned_buffer( std::move( prefetched->bytes ) );
                deserialize( jsin );
                return true;
            } catch( std::exception &err ) {
                // Fall through to the normal synchronous load on any parse failure.
                debugmsg( _( "Failed to parse prefetched submap %1$s: %2$s" ),
                          om_addr.to_string(), err.what() );
            }
        }

        if( storage().compressed() )
        {
            cata_path zzip_name = dirname;
            zzip_name += zzip_suffix;
            // Consult the cached entry listing before touching the archive: a column
            // walked back over re-probes ~84 absent quads, and without this each one
            // paid a fresh zzip::load (mmap + footer parse). nullptr == archive missing.
            const std::unordered_set<std::string> *listing = zzip_listing( zzip_name );
            if( !listing || listing->find( file_name ) == listing->end() ) {
                return false;
            }

            std::optional<zzip> z = zzip::load( zzip_name.get_unrelative_path(),
                                                storage().dictionary().get_unrelative_path() );
            if( !z ) {
                debugmsg( _fmt( "Failed to load submaps from {0}, could not open zzip.", zzip_name ) );
                return false;
            }
            if( !z->has_file( file_name_path ) ) {
                return false;
            }
            std::vector<std::byte> contents = z->get_file( file_name_path );
            std::string_view string_contents{ reinterpret_cast<char *>( contents.data() ), contents.size() };
            JsonValue jsin = json_loader::from_string( std::string( string_contents ) );
            try {
                deserialize( jsin );
            } catch( std::exception &err ) {
                debugmsg( _( "Failed to read from \"%1$s\": %2$s" ), zzip_name.generic_u8string() + ":" + file_name,
                          err.what() );
                return false;
            }
            return true;
        } else
        {
            return read_from_file_optional_json( quad_path, [this]( const JsonValue & jsin ) {
                deserialize( jsin );
            } );
        }
    }();

    if( !read ) {
        return nullptr;
    }

    // fill in uniform submaps that were not serialized. Note that failure as a result of it
    // not being uniform is OK and results in any missing uniform submaps being generated.
    if( uniform_terrain_ ) {
        const std::optional<ter_str_id> terrain = uniform_terrain_( om_addr )->get_uniform_terrain();
        if( terrain ) {
            for( int x = 0; x <= 1; ++x ) {
                for( int y = 0; y <= 1; ++y ) {
                    const tripoint_abs_sm missing = project_to<coords::sm>( om_addr ) + point_rel_sm( x, y );
                    if( submaps.count( missing ) == 0 ) {
                        // This quad was just read. Probing disk again here would
                        // recursively reload the same partial quad.
                        add_uniform_submap( missing, *terrain );
                    }
                }
            }
        }
    }
    if( submaps.count( p ) == 0 ) {
        debugmsg( "file %s did not contain the expected submap %s",
                  quad_path.generic_u8string(), p.to_string() );
        return nullptr;
    }

    return submaps[ p ].get();
}

// Optimized mapgen function that only works properly for very simple overmap types
// Does not create or require a temporary map and does its own saving.
// Note that it assumes the map doesn't exist: it's an error to call this when it does.
bool mapbuffer::generate_uniform( const tripoint_abs_sm &p, const ter_str_id &ter )
{
    if( submap_exists( p ) ) {
        return false;
    }

    return add_uniform_submap( p, ter );
}

bool mapbuffer::add_uniform_submap( const tripoint_abs_sm &p, const ter_str_id &ter )
{
    std::unique_ptr<submap> sm = std::make_unique<submap>();
    sm->set_all_ter( ter, true );
    sm->last_touched = calendar::turn;
    return add_submap( p, sm );
}

bool mapbuffer::generate_uniform_omt( const tripoint_abs_sm &p, const oter_id &terrain_type )
{
    dbg( D_INFO ) << "generate_uniform p: " << p
                  << "  terrain_type: " << terrain_type.id().str();

    const std::optional<ter_str_id> ter = terrain_type->get_uniform_terrain();

    if( !ter ) {
        return false;
    }

    bool ret = true;
    for( int xd = 0; xd <= 1; xd++ ) {
        for( int yd = 0; yd <= 1; yd++ ) {
            ret &= generate_uniform( p + point_rel_sm( xd, yd ), *ter );
        }
    }
    return ret;
}

void mapbuffer::deserialize( const JsonArray &ja )
{
    for( JsonObject submap_json : ja ) {
        std::unique_ptr<submap> sm = std::make_unique<submap>();
        tripoint_abs_sm submap_coordinates;
        int version = 0;
        // We have to read version first because the iteration order of json members is undefined.
        if( submap_json.has_int( "version" ) ) {
            version = submap_json.get_int( "version" );
        }
        for( JsonMember submap_member : submap_json ) {
            std::string submap_member_name = submap_member.name();
            if( submap_member_name == "coordinates" ) {
                JsonArray coords_array = submap_member;
                tripoint_abs_sm loc{ coords_array.next_int(), coords_array.next_int(), coords_array.next_int() };
                submap_coordinates = loc;
            } else {
                sm->load( submap_member, submap_member_name, version );
            }
        }

        if( !add_submap( submap_coordinates, sm ) ) {
            debugmsg( "submap %s was already loaded", submap_coordinates.to_string() );
        }
    }
}
