#include "mod_manager.h"

#include <algorithm>
#include <filesystem>
#include <functional>
#include <iterator>
#include <memory>
#include <ostream>
#include <queue>
#include <system_error>

#include "builtin_mods.h"
#include "cached_options.h"
#include "catalua_platform.h"
#include "cata_utility.h"
#include "debug.h"
#include "dependency_tree.h"
#include "filesystem.h"
#include "flexbuffer_json.h"
#include "generic_factory.h"
#include "get_version.h"
#include "input_context.h"
#include "json.h"
#include "localized_comparator.h"
#include "output.h"
#include "path_info.h"
#include "string_formatter.h"
#include "worldfactory.h"

static const mod_id MOD_INFORMATION_dev_default( "dev:default" );
static const mod_id MOD_INFORMATION_user_default( "user:default" );

static const std::string MOD_SEARCH_FILE( "modinfo.json" );
static constexpr std::size_t LUA_PLATFORM_DIAGNOSTIC_LIMIT = 4096;

static std::string bounded_lua_platform_diagnostic( const std::string &reason )
{
    std::string result = reason;
    std::replace( result.begin(), result.end(), '\0', '?' );
    static constexpr std::string_view suffix = "... [diagnostic truncated]";
    if( result.size() > LUA_PLATFORM_DIAGNOSTIC_LIMIT ) {
        result.resize( LUA_PLATFORM_DIAGNOSTIC_LIMIT - suffix.size() );
        result += std::string( suffix );
    }
    return result;
}

static bool path_is_within( const std::filesystem::path &path,
                            const std::filesystem::path &directory )
{
    const std::filesystem::path normalized_path = path.lexically_normal();
    const std::filesystem::path normalized_directory = directory.lexically_normal();
    auto path_it = normalized_path.begin();
    auto directory_it = normalized_directory.begin();
    while( directory_it != normalized_directory.end() ) {
        if( path_it == normalized_path.end() || *path_it != *directory_it ) {
            return false;
        }
        ++path_it;
        ++directory_it;
    }
    return true;
}

static bool is_manifest_builtin_root( const MOD_INFORMATION &mod )
{
    const std::filesystem::path builtin_root =
        PATH_INFO::moddir().get_unrelative_path().lexically_normal();
    const cata_path &source_root = mod.mod_root_path.empty() ? mod.path : mod.mod_root_path;
    const std::filesystem::path source_path = source_root.get_unrelative_path().lexically_normal();
    if( !path_is_within( source_path, builtin_root ) ) {
        return false;
    }
    const std::string relative_root =
        source_path.lexically_relative( builtin_root ).generic_u8string();
    return std::find( builtin_mod_roots.begin(), builtin_mod_roots.end(), relative_root ) !=
           builtin_mod_roots.end();
}

bool is_unexpected_builtin_mod( const MOD_INFORMATION &mod )
{
    if( test_mode || !builtin_mod_manifest_available ||
        mod.ident.str().find( '#' ) != std::string::npos ) {
        return false;
    }
    if( std::find( builtin_mod_ids.begin(), builtin_mod_ids.end(), mod.ident.str() ) !=
        builtin_mod_ids.end() ) {
        return false;
    }
    if( is_manifest_builtin_root( mod ) ) {
        return false;
    }
    const cata_path &source_root = mod.mod_root_path.empty() ? mod.path : mod.mod_root_path;
    return path_is_within( source_root.get_unrelative_path(),
                           PATH_INFO::moddir().get_unrelative_path() );
}

std::string get_mod_error_source( std::string_view src )
{
    if( src == "core" || src == "custom" ) {
        return {};
    }

    const mod_id base_mod = get_mod_base_id_from_src( mod_id( std::string( src ) ) );
    if( !base_mod.is_valid() ) {
        return {};
    }

    const MOD_INFORMATION &mod = base_mod.obj();
    std::string result = string_format( _( "Mod source: %s [%s]" ), mod.name(), mod.ident.str() );
    if( !builtin_mod_manifest_available ) {
        return result;
    }

    const bool is_builtin =
        std::find( builtin_mod_ids.begin(), builtin_mod_ids.end(), mod.ident.str() ) !=
        builtin_mod_ids.end() || is_manifest_builtin_root( mod );
    if( is_builtin ) {
        return result + "\n" + string_format( _( "Game version: %s" ), getVersionString() );
    }

    result += "\n";
    result += _( "This error may originate from a third-party mod." );
    if( !mod.version.empty() ) {
        result += "\n" + string_format( _( "Mod version: %s" ), mod.version );
    }
    return result;
}

mod_id get_mod_base_id_from_src( mod_id src )
{
    mod_id base_mod_id;
    size_t split_loc = src.str().find( '#' );
    if( split_loc == std::string::npos ) {
        return src;
    } else {
        return mod_id( src.str().substr( 0, split_loc ) );
    }
}

template<>
const MOD_INFORMATION &string_id<MOD_INFORMATION>::obj() const
{
    const auto &map = world_generator->get_mod_manager().mod_map;
    const auto iter = map.find( get_mod_base_id_from_src( *this ) );
    if( iter == map.end() ) {
        debugmsg( "Invalid mod %s requested", str() );
        static const MOD_INFORMATION dummy{};
        return dummy;
    }
    return iter->second;
}

template<>
bool string_id<MOD_INFORMATION>::is_valid() const
{
    return world_generator->get_mod_manager().mod_map.count( *this ) > 0;
}

std::string MOD_INFORMATION::name() const
{
    if( name_.empty() ) {
        // "No name" gets confusing if many mods have no name
        //~ name of a mod that has no name entry, (%s is the mods identifier)
        return string_format( _( "No name (%s)" ), ident.c_str() );
    } else {
        return name_.translated();
    }
}

// These accessors are to delay the initialization of the strings in the respective containers until after gettext is initialized.
const std::vector<std::pair<std::string, translation>> &get_mod_list_categories()
{
    static const std::vector<std::pair<std::string, translation>> mod_list_categories = {
        {"total_conversion", to_translation( "TOTAL CONVERSIONS" )},
        {"content", to_translation( "CORE CONTENT PACKS" )},
        {"items", to_translation( "ITEM ADDITION MODS" )},
        {"creatures", to_translation( "CREATURE MODS" )},
        {"misc_additions", to_translation( "MISC ADDITIONS" )},
        {"buildings", to_translation( "BUILDINGS MODS" )},
        {"vehicles", to_translation( "VEHICLE MODS" )},
        {"rebalance", to_translation( "REBALANCING MODS" )},
        {"magical", to_translation( "MAGICAL MODS" )},
        {"item_exclude", to_translation( "ITEM EXCLUSION MODS" )},
        {"monster_exclude", to_translation( "MONSTER EXCLUSION MODS" )},
        {"graphical", to_translation( "GRAPHICAL MODS" )},
        {"accessibility", to_translation( "ACCESSIBILITY MODS" )},
        {"", to_translation( "NO CATEGORY" )}
    };

    return mod_list_categories;
}

const std::vector<std::pair<std::string, translation>> &get_mod_list_tabs()
{
    static const std::vector<std::pair<std::string, translation>> mod_list_tabs = {
        {"tab_default", to_translation( "Default" )},
        {"tab_blacklist", to_translation( "Blacklist" )},
        {"tab_balance", to_translation( "Balance" )}
    };

    return mod_list_tabs;
}

const std::map<std::string, std::string> &get_mod_list_cat_tab()
{
    static const std::map<std::string, std::string> mod_list_cat_tab = {
        {"item_exclude", "tab_blacklist"},
        {"monster_exclude", "tab_blacklist"},
        {"rebalance", "tab_balance"}
    };

    return mod_list_cat_tab;
}

static std::map<mod_id, mod_id> migrated_mods;
static std::map<mod_id, translation> removed_mods;

void mod_migrations::load( const JsonObject &jo )
{
    const mod_id old_id( jo.get_string( "id" ) );
    if( jo.has_string( "new_id" ) ) {
        const mod_id new_id( jo.get_string( "new_id" ) );
        migrated_mods.insert( std::make_pair( old_id, new_id ) );
    } else {
        translation removal_reason;
        jo.read( "removal_reason", removal_reason );
        removed_mods.insert( std::make_pair( old_id, removal_reason ) );
    }
}

void mod_migrations::reset()
{
    migrated_mods.clear();
    removed_mods.clear();
}

void mod_migrations::check()
{
    for( const auto &migration : migrated_mods ) {
        if( !migration.second.is_valid() ) {
            debugmsg( "mod_migration from '%s' specifies invalid new_id '%s'", migration.first.c_str(),
                      migration.second.c_str() );
        }
    }
}

mod_manager::mod_manager()
{
    refresh_mod_list();
    set_usable_mods();
}

mod_manager::~mod_manager() = default;

std::vector<mod_id> mod_manager::all_mods() const
{
    std::vector<mod_id> result;
    std::transform( mod_map.begin(), mod_map.end(),
    std::back_inserter( result ), []( const decltype( mod_manager::mod_map )::value_type & pair ) {
        return pair.first;
    } );
    return result;
}

dependency_tree &mod_manager::get_tree()
{
    return *tree;
}

void mod_manager::clear()
{
    tree->clear();
    mod_map.clear();
    default_mods.clear();
    migrated_mods.clear();
    removed_mods.clear();
}

void mod_manager::refresh_mod_list()
{
    clear();

    if( !dir_exist( PATH_INFO::user_moddir() ) ) {
        assure_dir_exist( PATH_INFO::user_moddir() );
    }

    std::map<mod_id, std::vector<mod_id>> mod_dependency_map;
    load_mods_from( PATH_INFO::moddir() );
    load_mods_from( PATH_INFO::user_moddir_path() );

    if( file_exist( PATH_INFO::mods_dev_default() ) ) {
        load_mod_info( PATH_INFO::mods_dev_default() );
    }
    if( file_exist( PATH_INFO::mods_user_default() ) ) {
        load_mod_info( PATH_INFO::mods_user_default() );
    }

    if( !set_default_mods( MOD_INFORMATION_user_default ) ) {
        set_default_mods( MOD_INFORMATION_dev_default );
    }
    for( auto &elem : mod_map ) {
        const auto &deps = elem.second.dependencies;
        mod_dependency_map[elem.second.ident] = std::vector<mod_id>( deps.begin(), deps.end() );
    }
    tree->init( mod_dependency_map );
}

bool mod_manager::set_default_mods( const mod_id &ident )
{
    // can't use string_id::is_valid as the global mod_manger instance does not exist yet
    const auto iter = mod_map.find( ident );
    if( iter == mod_map.end() ) {
        return false;
    }
    const MOD_INFORMATION &mod = iter->second;
    auto deps = std::vector<mod_id>( mod.dependencies.begin(), mod.dependencies.end() );
    default_mods = deps;
    return true;
}

void mod_manager::load_mods_from( const cata_path &path )
{
    if( !dir_exist( path.get_unrelative_path() ) ) {
        return; // don't try to enumerate non-existing directories
    }
    for( cata_path &mod_file : get_files_from_path( MOD_SEARCH_FILE, path, true ) ) {
        load_mod_info( mod_file );
    }
    for( const cata_path &root : get_directories( path, false ) ) {
        if( file_exist( root / "main.lua" ) || file_exist( root / "mod.lua" ) ) {
            load_lua_platform_mod( root );
        }
    }
}

void mod_manager::load_lua_platform_mod( const cata_path &root )
{
    namespace fs = std::filesystem;

    const std::string default_id = root.get_relative_path().filename().u8string();
    cata::lua_platform::mod_definition definition;
    const bool has_metadata = file_exist( root / "mod.lua" );
    std::string platform_error;

    std::vector<MOD_INFORMATION *> legacy_mods;
    for( auto &known : mod_map ) {
        const cata_path &known_root = known.second.mod_root_path.empty() ?
                                      known.second.path : known.second.mod_root_path;
        if( path_is_within( known_root.get_unrelative_path().lexically_normal(),
                            root.get_unrelative_path().lexically_normal() ) ) {
            legacy_mods.push_back( &known.second );
        }
    }

    const auto record_rejection = [&]( const std::string & unbounded_reason ) {
        const std::string reason = bounded_lua_platform_diagnostic( unbounded_reason );
        DebugLog( D_WARNING, D_MAIN ) << "Rejected Lua-first Mod at " << root << ": " << reason;
        if( legacy_mods.size() == 1 ) {
            MOD_INFORMATION &hybrid = *legacy_mods.front();
            // Keep a legacy hybrid usable when its optional Platform entry is
            // malformed, while retaining the rejected-entry diagnostic.
            hybrid.lua_platform_version = 0;
            hybrid.lua_platform_error = reason;
            hybrid.lua_platform_entry = cata_path();
            hybrid.mod_root_path = root;
            return;
        }
        std::string diagnostic_base = default_id.empty() ?
                                      "lua_platform_candidate" : default_id;
        std::replace( diagnostic_base.begin(), diagnostic_base.end(), '#', '_' );
        if( diagnostic_base.empty() ) {
            diagnostic_base = "lua_platform_candidate";
        }
        std::string diagnostic_ident = diagnostic_base;
        std::size_t suffix = 1;
        while( mod_map.count( mod_id( diagnostic_ident ) ) > 0 ) {
            diagnostic_ident = diagnostic_base + "_lua_platform_rejected_" +
                               std::to_string( suffix++ );
        }
        const mod_id diagnostic_id( diagnostic_ident );
        MOD_INFORMATION diagnostic;
        diagnostic.ident = diagnostic_id;
        diagnostic.name_ = no_translation( diagnostic_ident == default_id ? default_id :
                                           diagnostic_base +
                                           " (rejected Lua-first candidate)" );
        const size_t default_category = get_mod_list_categories().size() - 1;
        diagnostic.category = { static_cast<int>( default_category ),
                                get_mod_list_categories()[default_category].second
                              };
        diagnostic.path = root;
        diagnostic.mod_root_path = root;
        diagnostic.lua_platform_entry = root / "main.lua";
        diagnostic.lua_platform_version = cata::lua_platform::platform_version;
        diagnostic.lua_platform_error = reason;
        mod_map.emplace( diagnostic_id, std::move( diagnostic ) );
    };

    if( !cata::lua_platform::is_enabled() ) {
        // Keep pure Platform candidates visible but unavailable.  A hybrid's
        // legacy content remains loadable because record_rejection() retires
        // only its optional Platform entry.
        record_rejection( "Lua-first Platform is not enabled in this build" );
        return;
    }

    if( has_metadata ) {
        if( !cata::lua_platform::read_mod_definition( root.get_unrelative_path(), definition,
                platform_error ) ) {
            record_rejection( platform_error );
            return;
        }
    }

    // An omitted Platform id inherits the sole legacy id in a hybrid root.
    // This keeps a transitional Mod zero-configuration even when its packaged
    // directory name and stable MOD_INFO id differ.
    const bool use_legacy_id = !definition.id_set && legacy_mods.size() == 1;
    const std::string ident_string = use_legacy_id ? legacy_mods.front()->ident.str() :
                                     ( definition.id_set ? definition.id : default_id );
    if( ident_string.empty() || ident_string.size() > 256 ||
        ident_string.find( '\0' ) != std::string::npos ) {
        record_rejection( "Mod id must contain between 1 and 256 bytes" );
        return;
    }

    if( definition.name_set &&
        ( definition.name.empty() || definition.name.size() > 512 ||
          definition.name.find( '\0' ) != std::string::npos ) ) {
        record_rejection( "Mod display name must contain between 1 and 512 bytes" );
        return;
    }
    if( definition.version_set &&
        ( definition.version.empty() || definition.version.size() > 128 ||
          definition.version.find( '\0' ) != std::string::npos ) ) {
        record_rejection( "Mod version must contain between 1 and 128 bytes" );
        return;
    }
    if( definition.description_set &&
        ( definition.description.size() > 4096 ||
          definition.description.find( '\0' ) != std::string::npos ) ) {
        record_rejection( "Mod description cannot exceed 4096 bytes or contain NUL" );
        return;
    }
    if( definition.category_set &&
        ( definition.category.empty() || definition.category.size() > 128 ||
          definition.category.find( '\0' ) != std::string::npos ) ) {
        record_rejection( "Mod category must contain between 1 and 128 bytes" );
        return;
    }
    if( ident_string.find( '#' ) != std::string::npos ) {
        record_rejection( "Mod id '" + ident_string +
                          "' contains illegal '#' character" );
        return;
    }

    const mod_id ident( ident_string );
    std::vector<mod_id> dependencies;
    dependencies.reserve( definition.dependencies.size() );
    for( const std::string &dependency_string : definition.dependencies ) {
        if( dependency_string.empty() || dependency_string.size() > 256 ||
            dependency_string.find( '#' ) != std::string::npos ||
            dependency_string.find( '\0' ) != std::string::npos ) {
            record_rejection( "invalid dependency id '" + dependency_string + "'" );
            return;
        }
        const mod_id dependency( dependency_string );
        if( dependency == ident ) {
            record_rejection( "Mod specifies itself as a dependency" );
            return;
        }
        if( std::find( dependencies.begin(), dependencies.end(), dependency ) != dependencies.end() ) {
            record_rejection( "duplicate dependency id '" + dependency_string + "'" );
            return;
        }
        dependencies.push_back( dependency );
    }
    std::set<std::string> authors;
    for( const std::string &author : definition.authors ) {
        if( author.empty() || author.size() > 256 ||
            author.find( '\0' ) != std::string::npos ) {
            record_rejection( "Mod authors must contain between 1 and 256 bytes" );
            return;
        }
        if( !authors.insert( author ).second ) {
            record_rejection( "duplicate Mod author '" + author + "'" );
            return;
        }
    }

    std::optional<std::pair<int, translation>> category;
    if( definition.category_set ) {
        const auto found = std::find_if(
                               get_mod_list_categories().begin(),
                               get_mod_list_categories().end(),
        [&definition]( const auto & entry ) {
            return entry.first == definition.category;
        } );
        if( found == get_mod_list_categories().end() ) {
            record_rejection( "unknown Mod category '" + definition.category + "'" );
            return;
        }
        category = std::make_pair(
                       static_cast<int>( std::distance(
                                             get_mod_list_categories().begin(), found ) ),
                       found->second );
    }

    const std::string entry_string = definition.entry_set ? definition.entry : "main.lua";
    const fs::path relative_entry = fs::u8path( entry_string );
    cata_path entry = root / relative_entry;
    if( platform_error.empty() ) {
        if( entry_string.empty() || entry_string.size() > 4096 ||
            entry_string.find( '\0' ) != std::string::npos || relative_entry.is_absolute() ) {
            record_rejection( "entry must be a non-empty relative path" );
            return;
        }

        std::error_code filesystem_error;
        const fs::path canonical_root = fs::canonical( root.get_unrelative_path(), filesystem_error );
        if( filesystem_error ) {
            record_rejection( "cannot resolve Mod root: " + filesystem_error.message() );
            return;
        }
        const fs::path canonical_entry = fs::canonical( entry.get_unrelative_path(), filesystem_error );
        if( filesystem_error || !path_is_within( canonical_entry, canonical_root ) ) {
            record_rejection( "entry escapes the Mod root or cannot be resolved" );
            return;
        }
        if( !fs::is_regular_file( canonical_entry, filesystem_error ) || filesystem_error ) {
            record_rejection( "entry is not a regular file" );
            return;
        }
    }

    if( legacy_mods.size() > 1 ) {
        record_rejection( "Mod root contains more than one legacy MOD_INFO" );
        return;
    }
    if( legacy_mods.size() == 1 ) {
        MOD_INFORMATION &hybrid = *legacy_mods.front();
        if( hybrid.ident != ident ) {
            record_rejection( "Platform id '" + ident_string +
                              "' conflicts with legacy id '" + hybrid.ident.str() + "'" );
            return;
        }
        if( definition.name_set ) {
            hybrid.name_ = no_translation( definition.name );
        }
        if( definition.version_set ) {
            hybrid.version = definition.version;
        }
        if( definition.dependencies_set ) {
            hybrid.dependencies = std::move( dependencies );
        }
        if( definition.authors_set ) {
            hybrid.authors = std::move( authors );
        }
        if( definition.description_set ) {
            hybrid.description = no_translation( definition.description );
        }
        if( category ) {
            hybrid.category = *category;
        }
        if( definition.core_set ) {
            hybrid.core = definition.core;
        }
        hybrid.lua_platform_entry = std::move( entry );
        hybrid.mod_root_path = root;
        hybrid.lua_platform_version = cata::lua_platform::platform_version;
        hybrid.lua_platform_error = std::move( platform_error );
        return;
    }

    if( mod_map.count( ident ) > 0 ) {
        record_rejection( "another Mod already uses id '" + ident_string + "'" );
        return;
    }

    MOD_INFORMATION mod;
    mod.ident = ident;
    mod.name_ = no_translation( definition.name_set ? definition.name : ident_string );
    const size_t default_category = get_mod_list_categories().size() - 1;
    mod.category = category.value_or( std::make_pair(
                                          static_cast<int>( default_category ),
                                          get_mod_list_categories()[default_category].second ) );
    mod.version = definition.version_set ? definition.version : std::string();
    mod.dependencies = std::move( dependencies );
    mod.authors = std::move( authors );
    mod.description = definition.description_set ?
                      no_translation( definition.description ) : translation();
    mod.core = definition.core_set && definition.core;
    mod.path = root;
    mod.mod_root_path = root;
    mod.lua_platform_entry = std::move( entry );
    mod.lua_platform_version = cata::lua_platform::platform_version;
    mod.lua_platform_error = std::move( platform_error );
    mod_map.emplace( ident, std::move( mod ) );
}

void mod_manager::load_modfile( const JsonObject &jo, const cata_path &path )
{
    if( !jo.has_string( "type" ) || jo.get_string( "type" ) != "MOD_INFO" ) {
        // Ignore anything that is not a mod-info
        jo.allow_omitted_members();
        return;
    }

    const mod_id m_ident( jo.get_string( "id" ) );
    // can't use string_id::is_valid as the global mod_manger instance does not exist yet
    if( mod_map.count( m_ident ) > 0 ) {
        // TODO: change this to make unique ident for the mod
        // (instead of discarding it?)
        debugmsg( "there is already a mod with ident %s", m_ident.c_str() );
        return;
    }
    if( m_ident.str().find( '#' ) != std::string::npos ) {
        debugmsg( "Mod id %s contains illegal '#' character.", m_ident.str() );
        return;
    }

    translation m_name;
    jo.read( "name", m_name );

    std::string m_cat = jo.get_string( "category", "" );
    std::pair<int, translation> p_cat = {-1, translation()};
    bool bCatFound = false;

    do {
        for( size_t i = 0; i < get_mod_list_categories().size(); ++i ) {
            if( get_mod_list_categories()[i].first == m_cat ) {
                p_cat = { static_cast<int>( i ), get_mod_list_categories()[i].second };
                bCatFound = true;
                break;
            }
        }

        if( !bCatFound && !m_cat.empty() ) {
            m_cat.clear();
        } else {
            break;
        }
    } while( !bCatFound );

    MOD_INFORMATION modfile;
    modfile.ident = m_ident;
    modfile.name_ = m_name;
    modfile.category = p_cat;
    modfile.mod_root_path = path;

    std::string mod_json_path;
    if( jo.has_member( "path" ) ) {
        optional( jo, false, "path", mod_json_path );
        modfile.path = path / mod_json_path;
    } else {
        modfile.path = path;
    }

    optional( jo, false, "authors", modfile.authors );
    optional( jo, false, "maintainers", modfile.maintainers );
    optional( jo, false, "description", modfile.description );
    optional( jo, false, "version", modfile.version );
    optional( jo, false, "dependencies", modfile.dependencies );
    optional( jo, false, "conflicts", modfile.conflicts );
    optional( jo, false, "core", modfile.core, false );
    optional( jo, false, "obsolete", modfile.obsolete, false );
    optional( jo, false, "loading_images", modfile.loading_images );
    optional( jo, false, "disable_other_loading_screens", modfile.disable_other_loading_screens,
              false );

    if( std::find( modfile.dependencies.begin(), modfile.dependencies.end(),
                   modfile.ident ) != modfile.dependencies.end() ) {
        jo.throw_error_at( "dependencies", "mod specifies self as a dependency" );
    }

    // TODO: Temporary migration, remove after 0.I stable
    if( !modfile.obsolete && modfile.ident.str() == "user:default" ) {
        modfile.obsolete = true;
        set_default_mods( modfile.dependencies );
    }

    mod_map[modfile.ident] = std::move( modfile );
}

bool mod_manager::set_default_mods( const t_mod_list &mods )
{
    default_mods = mods;
    return write_to_file( PATH_INFO::mods_user_default(), [&]( std::ostream & fout ) {
        JsonOut json( fout, true ); // pretty-print
        json.start_object();
        json.member( "type", "MOD_INFO" );
        json.member( "id", "user:default" );
        json.member( "conflicts", std::vector<std::string>() );
        json.member( "dependencies" );
        json.write( mods );
        json.member( "//",
                     "Not really obsolete!  Marked as such to prevent it from showing in the main list" );
        json.member( "obsolete", true );
        json.end_object();
    }, _( "list of default mods" ) );
}

bool mod_manager::copy_mod_contents( const t_mod_list &mods_to_copy,
                                     const cata_path &output_base_path )
{
    if( mods_to_copy.empty() ) {
        // nothing to copy, so technically we succeeded already!
        return true;
    }
    std::vector<std::string> search_extensions;
    search_extensions.emplace_back( ".json" );
    search_extensions.emplace_back( ".lua" );

    DebugLog( D_INFO, DC_ALL ) << "Copying mod contents into directory: " << output_base_path;

    if( !assure_dir_exist( output_base_path ) ) {
        DebugLog( D_ERROR, DC_ALL ) << "Unable to create or open mod directory at [" << output_base_path <<
                                    "] for saving";
        return false;
    }

    for( size_t i = 0; i < mods_to_copy.size(); ++i ) {
        const MOD_INFORMATION &mod = *mods_to_copy[i];
        cata_path mod_base_path = mod.mod_root_path.empty() ? mod.path : mod.mod_root_path;

        // Gather both legacy data and Lua-first source files.
        auto input_files = get_files_from_path( ".json", mod.path, true, true );
        std::vector<cata_path> lua_files = get_files_from_path( ".lua", mod_base_path,
                                           true, true );
        input_files.insert( input_files.end(), lua_files.begin(), lua_files.end() );
        std::sort( input_files.begin(), input_files.end(), []( const cata_path & lhs,
        const cata_path & rhs ) {
            return lhs.generic_u8string() < rhs.generic_u8string();
        } );
        input_files.erase( std::unique( input_files.begin(), input_files.end() ), input_files.end() );
        auto input_dirs = get_directories_with( search_extensions, mod_base_path, true );

        if( input_files.empty() && mod.path.get_relative_path().filename().u8string() == MOD_SEARCH_FILE ) {
            // Self contained mod, all data is inside the modinfo.json file
            input_files.push_back( mod.path );
            mod_base_path = mod.path.parent_path();
        }

        if( input_files.empty() ) {
            continue;
        }

        // create needed directories
        // NOLINTNEXTLINE(cata-translate-string-literal)
        const cata_path cur_mod_dir = output_base_path / string_format( "mod_%05d", i + 1 );

        std::queue<cata_path> dir_to_make;
        dir_to_make.push( cur_mod_dir );
        for( cata_path &input_dir : input_dirs ) {
            dir_to_make.push( cur_mod_dir / input_dir.get_relative_path().lexically_relative(
                                  mod_base_path.get_relative_path() ) );
        }

        while( !dir_to_make.empty() ) {
            if( !assure_dir_exist( dir_to_make.front() ) ) {
                DebugLog( D_ERROR, DC_ALL ) << "Unable to create or open mod directory at [" <<
                                            dir_to_make.front() << "] for saving";
            }

            dir_to_make.pop();
        }

        // trim file paths from full length down to just /data forward
        for( cata_path &input_file : input_files ) {
            cata_path output_path = cur_mod_dir / ( input_file.get_relative_path().lexically_relative(
                    mod_base_path.get_relative_path() ) );
            copy_file( input_file, output_path );
        }
    }
    return true;
}

void mod_manager::load_mod_info( const cata_path &info_file_path )
{
    const cata_path main_path = info_file_path.parent_path();
    read_from_file_optional_json( info_file_path, [&]( const JsonValue & jsin ) {
        if( jsin.test_object() ) {
            // find type and dispatch single object
            JsonObject jo = jsin.get_object();
            load_modfile( jo, main_path );
        } else if( jsin.test_array() ) {
            // find type and dispatch each object until array close
            for( JsonObject jo : jsin.get_array() ) {
                load_modfile( jo, main_path );
            }
        } else {
            // not an object or an array?
            jsin.throw_error( "expected array or object" );
        }
    } );
}

cata_path mod_manager::get_mods_list_file( const WORLD *world )
{
    return world->folder_path() / "mods.json";
}

void mod_manager::save_mods_list( const WORLD *world ) const
{
    if( world == nullptr ) {
        return;
    }
    const cata_path path = get_mods_list_file( world );
    if( world->active_mod_order.empty() ) {
        // If we were called from load_mods_list to prune the list,
        // and it's empty now, delete the file.
        remove_file( path.get_unrelative_path() );
        return;
    }
    write_to_file( path, [&]( std::ostream & fout ) {
        JsonOut json( fout, true ); // pretty-print
        json.write( world->active_mod_order );
    }, _( "list of mods" ) );
}

void mod_manager::load_mods_list( WORLD *world ) const
{
    if( world == nullptr ) {
        return;
    }
    std::vector<mod_id> &amo = world->active_mod_order;
    amo.clear();
    read_from_file_optional_json( get_mods_list_file( world ), [&]( const JsonArray & jsin ) {
        for( const std::string line : jsin ) {
            const mod_id mod( line );
            if( std::find( amo.begin(), amo.end(), mod ) != amo.end() ) {
                continue;
            }
            amo.push_back( mod );
        }
    } );
}

bool mod_manager::check_mods_list( WORLD *world ) const
{
    if( world == nullptr ) {
        return true;
    }
    std::vector<mod_id> &amo = world->active_mod_order;
    bool changed = false;

    const auto is_virtual_mod = []( const mod_id & mod ) {
        return mod.str().find( '#' ) != std::string::npos;
    };
    std::set<std::string> mods_to_remove;
    std::vector<mod_id> incorrectly_installed_mods;
    for( const mod_id &mod : amo ) {
        if( !is_virtual_mod( mod ) && mod.is_valid() && is_unexpected_builtin_mod( mod.obj() ) ) {
            mods_to_remove.emplace( mod.str() );
            incorrectly_installed_mods.emplace_back( mod );
        }
    }

    if( !mods_to_remove.empty() ) {
        bool added_dependent;
        do {
            added_dependent = false;
            for( const mod_id &mod : amo ) {
                if( is_virtual_mod( mod ) || !mod.is_valid() || mods_to_remove.count( mod.str() ) > 0 ) {
                    continue;
                }
                for( const mod_id &dependency : mod->dependencies ) {
                    if( mods_to_remove.count( get_mod_base_id_from_src( dependency ).str() ) > 0 ) {
                        mods_to_remove.emplace( mod.str() );
                        added_dependent = true;
                        break;
                    }
                }
            }
        } while( added_dependent );

#if defined(RELEASE)
        std::vector<std::string> descriptions;
        descriptions.reserve( incorrectly_installed_mods.size() );
        for( const mod_id &mod : incorrectly_installed_mods ) {
            std::string description = string_format( "%s [%s]", mod->name(), mod.str() );
            if( !mod->version.empty() ) {
                description += string_format( " (%s)", mod->version );
            }
            description += string_format( "\n%s", mod->path.generic_u8string() );
            descriptions.emplace_back( std::move( description ) );
        }
        const std::string warning = string_format(
                                        _( "<color_red>Third-party mods were installed in the built-in mod directory.</color>\n\n"
                                           "The following mods are not distributed with this game:\n%s\n\n"
                                           "Move them to %s and restart the game.\n\n"
                                           "Some resources loaded from the built-in mod directory do not support "
                                           "third-party mods.  This may cause parts of them to stop working.\n\n"
                                           "Choose Yes only to ignore this warning, permanently remove the listed mods "
                                           "and their dependents from this world's mod list, and continue loading." ),
                                        string_join( descriptions, "\n\n" ), PATH_INFO::user_moddir() );
        if( !query_yn( warning ) ) {
            return false;
        }
        amo.erase( std::remove_if( amo.begin(), amo.end(),
        [&mods_to_remove, &is_virtual_mod]( const mod_id & mod ) {
            return !is_virtual_mod( mod ) && mods_to_remove.count( mod.str() ) > 0;
        } ), amo.end() );
        save_mods_list( world );
#else
        for( const mod_id &mod : incorrectly_installed_mods ) {
            DebugLog( D_WARNING, D_MAIN ) << "Third-party mod '" << mod.str()
                                          << "' is installed in the built-in mod directory: "
                                          << mod->path.generic_u8string();
        }
#endif
    }

    for( auto check_it = amo.begin(); check_it != amo.end(); check_it++ ) {
        if( !check_it->is_valid() ) {
            if( const auto replace_it = migrated_mods.find( *check_it ); replace_it != migrated_mods.end() &&
                std::find( amo.begin(), amo.end(), replace_it->second ) == amo.end() ) {
                amo.insert( check_it, replace_it->second );
                amo.erase( check_it );
                changed = true;
            } else {
                input_context dummy_ctxt( "YESNOQUIT" );
                const std::string cancel_option_name = dummy_ctxt.get_action_name( "QUIT" );
                query_ynq_result res;
                if( const auto it = removed_mods.find( *check_it ); it != removed_mods.end() ) {
                    res = query_ynq(
                              _( "Mod %s has been removed with reason: %s\nRemove it from this world's active mods?  (%s aborts load)" ),
                              check_it->c_str(), it->second.translated(), cancel_option_name );
                } else {
                    res = query_ynq(
                              _( "Mod %s not found in mods folder, remove it from this world's active mods?  (%s aborts load)" ),
                              check_it->c_str(), cancel_option_name );
                }
                switch( res ) {
                    case query_ynq_result::quit:
                        return false;
                    case query_ynq_result::no:
                        break;
                    case query_ynq_result::yes:
                        amo.erase( check_it-- );
                        changed = true;
                        break;
                }
            }
        }
    }
    // If we migrated or the player chose to remove a mod, overwrite the mod list.
    if( changed ) {
        save_mods_list( world );
    }
    return true;
}

const mod_manager::t_mod_list &mod_manager::get_default_mods() const
{
    return default_mods;
}

static bool compare_mod_by_name_and_category( const MOD_INFORMATION *const a,
        const MOD_INFORMATION *const b )
{
    return localized_compare( std::make_pair( a->category, a->name() ),
                              std::make_pair( b->category, b->name() ) );
}

void mod_manager::set_usable_mods()
{
    std::vector<mod_id> available_cores;
    std::vector<mod_id> available_supplementals;
    std::vector<mod_id> ordered_mods;

    std::vector<const MOD_INFORMATION *> mods;
    for( const auto &pair : mod_map ) {
        if( !pair.second.obsolete ) {
            mods.push_back( &pair.second );
        }
    }
    std::sort( mods.begin(), mods.end(), &compare_mod_by_name_and_category );

    for( const MOD_INFORMATION *const modinfo : mods ) {
        if( modinfo->core ) {
            available_cores.push_back( modinfo->ident );
        } else {
            available_supplementals.push_back( modinfo->ident );
        }
    }
    ordered_mods.insert( ordered_mods.begin(), available_supplementals.begin(),
                         available_supplementals.end() );
    ordered_mods.insert( ordered_mods.begin(), available_cores.begin(), available_cores.end() );

    usable_mods = ordered_mods;
}
