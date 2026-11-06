#include "android_storage.h"

#include <array>
#include <filesystem>
#include <fstream>
#include <string>
#include <system_error>

#include "debug.h"

static bool remove_android_migration_cache( const std::filesystem::path &cache_path )
{
    std::error_code error;
    std::filesystem::remove_all( cache_path, error );
    if( error ) {
        DebugLog( D_ERROR, D_MAIN ) << "Unable to remove generated Android cache " <<
                                    cache_path.u8string() << ": " << error.message();
        return false;
    }
    return true;
}

static bool copy_legacy_android_directory( const std::filesystem::path &source,
        const std::filesystem::path &destination, bool skip_generated_cache )
{
    std::error_code error;
    std::filesystem::create_directories( destination, error );
    if( error ) {
        DebugLog( D_ERROR, D_MAIN ) << "Unable to create Android migration directory " <<
                                    destination.u8string() << ": " << error.message();
        return false;
    }

    bool success = true;
    std::filesystem::directory_iterator entry( source,
            std::filesystem::directory_options::skip_permission_denied, error );
    const std::filesystem::directory_iterator end;
    if( error ) {
        DebugLog( D_ERROR, D_MAIN ) << "Unable to scan legacy Android directory " <<
                                    source.u8string() << ": " << error.message();
        return false;
    }

    while( entry != end ) {
        const std::filesystem::path source_entry = entry->path();
        if( !skip_generated_cache || source_entry.filename() != "cache" ) {
            const std::filesystem::path destination_entry = destination / source_entry.filename();
            error.clear();
            std::filesystem::copy( source_entry, destination_entry,
                                   std::filesystem::copy_options::recursive |
                                   std::filesystem::copy_options::skip_existing |
                                   std::filesystem::copy_options::skip_symlinks, error );
            if( error ) {
                DebugLog( D_ERROR, D_MAIN ) << "Unable to migrate Android path " <<
                                            source_entry.u8string() << ": " << error.message();
                success = false;
            }
        }

        error.clear();
        entry.increment( error );
        if( error ) {
            DebugLog( D_ERROR, D_MAIN ) << "Unable to continue scanning legacy Android directory " <<
                                        source.u8string() << ": " << error.message();
            success = false;
            break;
        }
    }
    return success;
}

static bool copy_legacy_android_saves( const std::filesystem::path &source,
                                       const std::filesystem::path &destination )
{
    std::error_code error;
    std::filesystem::create_directories( destination, error );
    if( error ) {
        DebugLog( D_ERROR, D_MAIN ) << "Unable to create Android save migration directory " <<
                                    destination.u8string() << ": " << error.message();
        return false;
    }

    bool success = true;
    std::filesystem::directory_iterator entry( source,
            std::filesystem::directory_options::skip_permission_denied, error );
    const std::filesystem::directory_iterator end;
    if( error ) {
        DebugLog( D_ERROR, D_MAIN ) << "Unable to scan legacy Android save directory " <<
                                    source.u8string() << ": " << error.message();
        return false;
    }

    while( entry != end ) {
        const std::filesystem::path source_entry = entry->path();
        const std::filesystem::path destination_entry = destination / source_entry.filename();
        error.clear();
        const bool destination_exists = std::filesystem::exists( destination_entry, error );
        if( error ) {
            DebugLog( D_ERROR, D_MAIN ) << "Unable to inspect Android save destination " <<
                                        destination_entry.u8string() << ": " << error.message();
            success = false;
        } else if( destination_exists ) {
            DebugLog( D_INFO, D_MAIN ) << "Keeping existing Documents save entry " <<
                                       destination_entry.u8string();
        } else {
            const std::filesystem::path temporary_entry = destination /
                    ( ".migration-" + source_entry.filename().u8string() + ".tmp" );
            error.clear();
            std::filesystem::remove_all( temporary_entry, error );
            if( !error ) {
                std::filesystem::copy( source_entry, temporary_entry,
                                       std::filesystem::copy_options::recursive |
                                       std::filesystem::copy_options::skip_symlinks, error );
            }
            if( !error ) {
                std::filesystem::rename( temporary_entry, destination_entry, error );
            }
            if( error ) {
                DebugLog( D_ERROR, D_MAIN ) << "Unable to migrate Android save entry " <<
                                            source_entry.u8string() << ": " << error.message();
                std::error_code cleanup_error;
                std::filesystem::remove_all( temporary_entry, cleanup_error );
                success = false;
            }
        }

        error.clear();
        entry.increment( error );
        if( error ) {
            DebugLog( D_ERROR, D_MAIN ) << "Unable to continue scanning legacy Android save directory " <<
                                        source.u8string() << ": " << error.message();
            success = false;
            break;
        }
    }
    return success;
}

void migrate_legacy_android_user_data( const std::string &legacy_user_dir,
                                       const std::string &user_dir )
{
    const std::filesystem::path source = std::filesystem::u8path( legacy_user_dir ).lexically_normal();
    const std::filesystem::path destination =
        std::filesystem::u8path( user_dir ).lexically_normal();
    std::error_code error;
    if( std::filesystem::equivalent( source, destination, error ) ) {
        return;
    }
    if( error ) {
        DebugLog( D_ERROR, D_MAIN ) << "Unable to compare Android storage directories; "
                                    "migration will not run: " << error.message();
        return;
    }

    const std::filesystem::path completion_marker =
        destination / ".legacy-android-migration-v1.complete";
    if( std::filesystem::exists( completion_marker, error ) &&
        std::filesystem::is_regular_file( completion_marker, error ) ) {
        return;
    }
    if( error ) {
        DebugLog( D_WARNING, D_MAIN ) << "Unable to inspect Android migration marker: " <<
                                      error.message();
    }

    DebugLog( D_INFO, D_MAIN ) << "Migrating missing Android user data from " <<
                               source.u8string() << " to " << destination.u8string();

    bool success = true;
    // The legacy gfx directory mixes bundled and custom tilesets.  It remains a normal resource
    // search path, so copying it would only make old bundled tilesets shadow future APK updates.
    constexpr std::array<const char *, 9> user_directories = {{
            "config", "font", "save", "sound", "templates", "mods", "memorial",
            "achievements", "graveyard"
        }
    };
    for( const char *directory : user_directories ) {
        const std::filesystem::path source_directory = source / directory;
        error.clear();
        if( !std::filesystem::exists( source_directory, error ) ||
            !std::filesystem::is_directory( source_directory, error ) ) {
            if( error ) {
                DebugLog( D_ERROR, D_MAIN ) << "Unable to inspect legacy Android directory " <<
                                            source_directory.u8string() << ": " << error.message();
                success = false;
            }
            continue;
        }
        if( std::string( directory ) == "save" ) {
            success = copy_legacy_android_saves( source_directory,
                                                 destination / directory ) && success;
        } else {
            const bool skip_generated_cache = std::string( directory ) == "config" ||
                                              std::string( directory ) == "memorial";
            success = copy_legacy_android_directory( source_directory,
                      destination / directory, skip_generated_cache ) && success;
        }
    }

    success = remove_android_migration_cache( destination / "cache" ) && success;
    success = remove_android_migration_cache( destination / "config" / "cache" ) && success;
    success = remove_android_migration_cache( destination / "memorial" / "cache" ) && success;

    if( !success ) {
        DebugLog( D_ERROR, D_MAIN ) <<
                                    "Android user-data migration was incomplete and will be retried next launch.";
        return;
    }

    std::ofstream marker( completion_marker, std::ios::out | std::ios::trunc );
    marker << "Legacy Android user data copied without overwriting Documents files.\n";
    marker.close();
    if( !marker ) {
        DebugLog( D_ERROR, D_MAIN ) << "Unable to write Android migration marker " <<
                                    completion_marker.u8string() << "; migration will be retried.";
        return;
    }
    DebugLog( D_INFO, D_MAIN ) << "Android user-data migration completed.";
}

