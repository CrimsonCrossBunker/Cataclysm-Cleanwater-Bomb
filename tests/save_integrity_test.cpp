#include <character_attire.h>
#include <character_id.h>
#include <coordinates.h>
#include <item_location.h>
#include <overmap_ui.h>
#include <pimpl.h>
#include <point.h>
#include <type_id.h>
#include <units.h>
#include <cstddef>
#include <filesystem>
#include <fstream>
#include <functional>
#include <initializer_list>
#include <iterator>
#include <memory>
#include <optional>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <system_error>
#include <unordered_set>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "catacharset.h"
#include "debug.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "faction.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "options_helpers.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "player_helpers.h"
#include "power_network.h"
#include "weather.h"
#include "worldfactory.h"
#include "zzip.h"

static const dimension_id dimension_world_abyss( "abyss" );
static const dimension_id dimension_world_default( "default" );
namespace
{
void reset_save_test_state()
{
    g->reset_game_state();
    g->faction_manager_ptr->create_if_needed();
    get_avatar().setID( g->assign_npc_id(), true );
    clear_avatar();
    get_avatar().ensure_player_id();
    g->bind_local_player_control();
    CHECK( get_map().inbounds( get_avatar().pos_bub() ) );
}



std::string replace_save_member( const std::string &contents, std::string_view name,
                                 const std::optional<std::string> &replacement )
{
    std::istringstream input( contents );
    std::string header;
    if( input.peek() == '#' ) {
        std::getline( input, header );
    }
    TextJsonIn source( input );
    const TextJsonObject data = source.get_object();
    data.allow_omitted_members();
    const size_t separator = name.find( '.' );
    if( separator != std::string_view::npos ) {
        const std::string_view parent = name.substr( 0, separator );
        return replace_save_member( contents, parent,
                                    replace_save_member( data.get_object( parent ).str(),
                                            name.substr( separator + 1 ), replacement ) );
    }
    std::ostringstream output;
    if( !header.empty() ) {
        output << header << '\n';
    }
    JsonOut json( output );
    json.start_object();
    for( const TextJsonMember &member : data ) {
        if( member.name() == name ) {
            continue;
        }
        json.member( member.name() );
        TextJsonIn &value = *data.get_raw( member.name() );
        const int start = value.tell();
        value.skip_value();
        std::string token = value.substr( start, value.tell() - start );
        const size_t last = token.find_last_not_of( std::string{ ' ', '\t', '\r', '\n' } );
        if( token[last] == ',' ) {
            token.erase( last );
        }
        output << token;
        json.set_need_separator();
    }
    if( replacement ) {
        json.member( std::string( name ) );
        output << *replacement;
        json.set_need_separator();
    }
    json.end_object();
    return output.str();
}

void select_dimension_for_load( const dimension_id &dimension )
{
    restore_on_out_of_scope restore_version( savegame_loading_version );
    std::ostringstream output;
    g->serialize_json( output );
    const std::string data = replace_save_member(
                                 replace_save_member( output.str(), "dimension_prefix", '"' + dimension.str() + '"' ),
                                 "mostseen", std::string( "\"stop\"" ) );
    capture_debugmsg_during( [&]() {
        CHECK_THROWS( g->unserialize( data ) );
    } );
    REQUIRE( g->get_dimension_prefix() == dimension );
}

std::filesystem::path save_integrity_directory()
{
    for( int attempt = 0; attempt < 100; ++attempt ) {
        const std::filesystem::path directory = std::filesystem::temp_directory_path() /
                                                std::filesystem::u8path( "ccb-critical-load-test-" + std::to_string( attempt ) );
        if( std::filesystem::create_directory( directory ) ) {
            return directory;
        }
    }
    FAIL( "Could not create a save integrity test directory" );
    return {};
}

struct save_probe : event_subscriber {
    using event_subscriber::notify;
    int attempts = 0;
    void notify( const cata::event &event ) override {
        if( event.type() == event_type::game_save ) {
            ++attempts;
            throw std::runtime_error( "Unexpected save after a failed load" );
        }
    }
};

struct load_probe : event_subscriber {
    using event_subscriber::notify;
    bool loaded = false;
    void notify( const cata::event &event ) override {
        if( event.type() == event_type::game_load ) {
            loaded = true;
            throw std::runtime_error( "Load reached world-ready stage" );
        }
    }
};
} // namespace

TEST_CASE( "new_character_world_loads_retained_state_and_blocks_corruption",
           "[save_integrity][save]" )
{
    restore_on_out_of_scope restore_version( savegame_loading_version );
    const unsigned int previous_seed = g->get_seed();
    const dimension_id previous_dimension = g->get_dimension_prefix();
    const units::temperature previous_temperature = get_weather().temperature;
    const overmap_global_state previous_overmap_state = overmap_buffer.global_state;
    REQUIRE( world_generator->active_world != nullptr );
    WORLD *previous_world = world_generator->active_world;
    const std::string previous_savedir = PATH_INFO::savedir();
    const std::filesystem::path directory = save_integrity_directory();
    WORLD world( "new-character-world" );
    world.WORLD_OPTIONS = previous_world->WORLD_OPTIONS;
    on_out_of_scope cleanup( [&]() {
        world_generator->set_active_world( previous_world );
        PATH_INFO::set_savedir( previous_savedir );
        select_dimension_for_load( previous_dimension );
        reset_save_test_state();
        g->set_seed( previous_seed );
        get_weather().temperature = previous_temperature;
        overmap_buffer.global_state = previous_overmap_state;
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    PATH_INFO::set_savedir( directory.generic_u8string() + "/" );
    world_generator->set_active_world( &world );
    const cata_path worldpath = world.folder_path();
    std::filesystem::create_directories( worldpath.get_unrelative_path() );
    g->reset_game_state();
    REQUIRE( g->load_new_character_world() );
    const std::string kind = GENERATE( "fresh", "fresh-dictionaries", "fresh-empty-directories",
                                       "retained", "legacy", "legacy-unique-specials", "legacy-missing-weather",
                                       "legacy-missing-overmap", "missing-dimension", "travel-new", "travel-empty",
                                       "travel-missing", "corrupt-master", "empty-master",
                                       "corrupt-dimension", "empty-dimension", "missing-master-maps",
                                       "missing-master-dimensions", "missing-master-overmap",
                                       "missing-master-archive", "missing-master-dimension" );
    CAPTURE( kind );
    const cata_path master = worldpath / SAVE_MASTER;
    const cata_path dimension = worldpath / SAVE_DIMENSION_DATA;
    if( kind.compare( 0, 5, "fresh" ) == 0 ) {
        REQUIRE( world.save() );
        if( kind == "fresh-dictionaries" ) {
            for( const std::string filename : {
                     "maps.dict", "overmaps.dict", "mmr.dict"
                 } ) {
                write_to_file( worldpath / filename, []( std::ostream & output ) {
                    output << "dictionary";
                } );
            }
        } else if( kind == "fresh-empty-directories" ) {
            for( const std::string filename : {
                     "maps", "overmaps", "dimensions", "snapshots"
                 } ) {
                std::filesystem::create_directory( ( worldpath / filename ).get_unrelative_path() );
            }
        }
        g->reset_game_state();
        REQUIRE( g->load_new_character_world() );
        CHECK_FALSE( std::filesystem::exists( master.get_unrelative_path() ) );
        CHECK_FALSE( std::filesystem::exists( dimension.get_unrelative_path() ) );
        save_probe probe;
        get_event_bus().subscribe( &probe );
        CHECK_THROWS_AS( g->save(), std::runtime_error );
        CHECK( probe.attempts == 1 );
        return;
    }
    if( kind.compare( 0, 15, "missing-master-" ) == 0 ) {
        std::string relative;
        if( kind == "missing-master-maps" ) {
            relative = "maps/0.0.0/0.0.0.map";
        } else if( kind == "missing-master-dimensions" ) {
            relative = "dimensions/abyss/maps/0.0.0/0.0.0.map";
        } else if( kind == "missing-master-overmap" ) {
            relative = "o.0.0";
        } else if( kind == "missing-master-archive" ) {
            relative = "survivor.sav";
            relative += zzip_suffix;
        } else {
            relative = SAVE_DIMENSION_DATA;
        }
        const cata_path artifact = worldpath / relative;
        std::filesystem::create_directories( artifact.get_unrelative_path().parent_path() );
        write_to_file( artifact, []( std::ostream & output ) {
            output << "retained world data";
        } );
        REQUIRE( world.world_saves.empty() );
        const std::string errors = capture_debugmsg_during( [&]() {
            CHECK_FALSE( g->load_new_character_world() );
        } );
        CHECK( errors.find( SAVE_MASTER ) != std::string::npos );
        save_probe probe;
        get_event_bus().subscribe( &probe );
        CHECK_FALSE( g->save() );
        CHECK( probe.attempts == 0 );
        CHECK_FALSE( std::filesystem::exists( master.get_unrelative_path() ) );
        CHECK( read_whole_file( artifact.get_unrelative_path() ) == "retained world data" );
        return;
    }
    g->set_seed( 0xf1234567u );
    get_avatar().set_save_id( "retained-survivor" );
    get_avatar().setID( g->assign_npc_id(), true );
    for( const int offset_x : {
             0, get_map().getmapsize() - 1
         } ) {
        for( const int offset_y : {
                 0, get_map().getmapsize() - 1
             } ) {
            overmap_buffer.get( project_to<coords::om>( get_map().get_abs_sub().xy() +
                                point_rel_sm( offset_x, offset_y ) ) );
        }
    }
    get_weather().temperature = units::from_fahrenheit( 77.0f );
    overmap_buffer.global_state.overmap_count = 73;
    g->power_networks().deserialize( json_loader::from_string(
                                         R"({"next_id":42,"networks":[]})" ).get_object() );
    REQUIRE( g->save() );
    world.world_saves.clear();
    REQUIRE( std::filesystem::remove( ( worldpath / ( save_t::from_save_id(
                                            "retained-survivor" ).base_path() + SAVE_EXTENSION ) ).get_unrelative_path() ) );
    const auto saved_master = read_whole_file( master.get_unrelative_path() );
    const auto saved_dimension = read_whole_file( dimension.get_unrelative_path() );
    REQUIRE( saved_master.has_value() );
    REQUIRE( saved_dimension.has_value() );
    const auto saved_specials = overmap_buffer.global_state.placed_unique_specials;
    const bool legacy = kind.compare( 0, 6, "legacy" ) == 0;
    const bool travel = kind.compare( 0, 7, "travel-" ) == 0;
    if( legacy ) {
        const JsonObject dimension_data = json_loader::from_path_at_offset(
                                              dimension, saved_dimension->find( '\n' ) + 1 ).get_object();
        dimension_data.allow_omitted_members();
        const JsonObject weather = dimension_data.get_object( "weather" );
        weather.allow_omitted_members();
        const JsonObject overmap = dimension_data.get_object( "overmapbuffer" );
        overmap.allow_omitted_members();
        std::string contents = *saved_master;
        if( kind != "legacy-missing-weather" ) {
            contents = replace_save_member( contents, "weather", weather.str() );
        }
        if( kind == "legacy-unique-specials" ) {
            std::ostringstream specials;
            JsonOut json( specials );
            json.write_as_array( saved_specials );
            contents = replace_save_member( contents, "placed_unique_specials", specials.str() );
        } else if( kind != "legacy-missing-overmap" ) {
            contents = replace_save_member( contents, "overmapbuffer", overmap.str() );
        }
        contents.replace( 0, contents.find( '\n' ), "# version 31" );
        write_to_file( master, [&]( std::ostream & output ) {
            output << contents;
        } );
        REQUIRE( std::filesystem::remove( dimension.get_unrelative_path() ) );
    } else if( kind == "missing-dimension" ) {
        REQUIRE( std::filesystem::remove( dimension.get_unrelative_path() ) );
    } else if( kind != "retained" && !travel ) {
        const cata_path &rejected = kind == "corrupt-master" || kind == "empty-master" ?
                                    master : dimension;
        write_to_file( rejected, [&]( std::ostream & output ) {
            output << ( kind == "empty-master" || kind == "empty-dimension" ? "{}" : "{" );
        } );
    }
    const auto original_master = read_whole_file( master.get_unrelative_path() );
    const auto original_dimension = legacy || kind == "missing-dimension" ?
                                    std::optional<std::string>() :
                                    read_whole_file( dimension.get_unrelative_path() );
    g->reset_game_state();
    overmap_buffer.global_state.overmap_count = 999;
    g->set_seed( 1u );
    savegame_loading_version = savegame_version;
    const bool valid = kind == "retained" || kind == "legacy" ||
                       kind == "legacy-unique-specials" || travel;
    const std::string errors = capture_debugmsg_during( [&]() {
        CHECK( g->load_new_character_world() == valid );
    } );
    CHECK( savegame_loading_version == savegame_version );
    if( valid ) {
        CHECK( errors.empty() );
        CHECK( g->get_dimension_prefix() == dimension_world_default );
        CHECK( g->get_seed() == 0xf1234567u );
        CHECK( g->assign_npc_id().get_value() == 2 );
        REQUIRE( g->save() );
        std::ifstream input( dimension.get_unrelative_path(), std::ios::binary );
        REQUIRE_NOTHROW( g->unserialize_dimension_data( dimension, input ) );
        input.close();
        CHECK( units::to_fahrenheit( get_weather().temperature ) == Approx( 77.0f ) );
        CHECK( overmap_buffer.global_state.overmap_count == ( kind == "legacy-unique-specials" ? 0 : 73 ) );
        CHECK( overmap_buffer.global_state.placed_unique_specials == saved_specials );
        if( kind == "retained" ) {
            std::ostringstream networks;
            JsonOut json( networks );
            g->power_networks().serialize( json );
            const JsonObject networks_data = json_loader::from_string( networks.str() ).get_object();
            CHECK( networks_data.get_int( "next_id" ) == 42 );
            CHECK( networks_data.get_array( "networks" ).empty() );
        }
        if( travel ) {
            const cata_path destination = worldpath / std::filesystem::u8path( "dimensions" ) /
                                          std::filesystem::u8path( "abyss" );
            const cata_path artifact = destination / std::filesystem::u8path( "maps" ) /
                                       std::filesystem::u8path( "0.0.0" ) / std::filesystem::u8path( "0.0.0.map" );
            if( kind == "travel-empty" ) {
                std::filesystem::create_directories( ( destination /
                                                       std::filesystem::u8path( "maps" ) ).get_unrelative_path() );
            } else if( kind == "travel-missing" ) {
                std::filesystem::create_directories( artifact.get_unrelative_path().parent_path() );
                write_to_file( artifact, []( std::ostream & output ) {
                    output << "retained dimension map";
                } );
            }
            const bool first_visit = kind != "travel-missing";
            const std::string travel_errors = capture_debugmsg_during( [&]() {
                CHECK( g->travel_to_dimension( dimension_world_abyss, {}, {}, std::nullopt ) == first_visit );
            } );
            if( first_visit ) {
                CHECK( travel_errors.empty() );
                CHECK( g->get_dimension_prefix() == dimension_world_abyss );
                REQUIRE( g->save() );
                CHECK( std::filesystem::exists( ( destination / SAVE_DIMENSION_DATA ).get_unrelative_path() ) );
            } else {
                CHECK( travel_errors.find( SAVE_DIMENSION_DATA ) != std::string::npos );
                CHECK( g->uquit == QUIT_NOSAVED );
                save_probe probe;
                get_event_bus().subscribe( &probe );
                CHECK_FALSE( g->save() );
                CHECK( probe.attempts == 0 );
                CHECK_FALSE( std::filesystem::exists( ( destination /
                                                        SAVE_DIMENSION_DATA ).get_unrelative_path() ) );
                CHECK( read_whole_file( artifact.get_unrelative_path() ) == "retained dimension map" );
            }
        }
    } else {
        CHECK_FALSE( errors.empty() );
        save_probe probe;
        get_event_bus().subscribe( &probe );
        CHECK_FALSE( g->save() );
        CHECK( probe.attempts == 0 );
        CHECK( read_whole_file( master.get_unrelative_path() ) == original_master );
        if( original_dimension ) {
            CHECK( read_whole_file( dimension.get_unrelative_path() ) == original_dimension );
        } else {
            CHECK_FALSE( std::filesystem::exists( dimension.get_unrelative_path() ) );
        }
    }
}

TEST_CASE( "player_save_failure_preserves_dependent_files", "[save_integrity][save][player_save]" )
{
    restore_on_out_of_scope restore_version( savegame_loading_version );
    REQUIRE( world_generator->active_world != nullptr );
    WORLD *previous_world = world_generator->active_world;
    const std::string previous_savedir = PATH_INFO::savedir();
    const std::string previous_save_id = get_avatar().get_save_id();
    const tripoint_abs_sm previous_map_position = get_map().get_abs_sub();
    const dimension_id previous_dimension = g->get_dimension_prefix();
    const unsigned int previous_seed = g->get_seed();
    const overmap_global_state previous_overmap_state = overmap_buffer.global_state;
    restore_on_out_of_scope restore_name( get_avatar().name );
    const std::filesystem::path directory = save_integrity_directory();
    const std::string world_name = "player-save-failure";
    REQUIRE_FALSE( world_generator->has_world( world_name ) );
    restore_on_out_of_scope restore_last_world( world_generator->last_world_name );
    restore_on_out_of_scope restore_last_character( world_generator->last_character_name );
    const override_option disable_compression( "WORLD_COMPRESSION2", "false" );
    on_out_of_scope cleanup( [&]() {
        world_generator->set_active_world( previous_world );
        world_generator->remove_world( world_name );
        PATH_INFO::set_savedir( previous_savedir );
        get_avatar().set_save_id( previous_save_id );
        select_dimension_for_load( previous_dimension );
        overmap_buffer.clear();
        overmap_buffer.global_state = previous_overmap_state;
        overmap_buffer.init_region_layout();
        get_map().load( previous_map_position, false );
        reset_save_test_state();
        g->set_seed( previous_seed );
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    PATH_INFO::set_savedir( directory.generic_u8string() + "/" );
    WORLD *world = world_generator->make_new_world( world_name, previous_world->active_mod_order );
    REQUIRE( world != nullptr );
    world->WORLD_OPTIONS = previous_world->WORLD_OPTIONS;
    world_generator->set_active_world( world );
    select_dimension_for_load( dimension_world_default );
    overmap_buffer.clear();
    overmap_buffer.init_region_layout();
    g->reset_game_state();
    get_avatar().set_save_id( "player-save-survivor" );
    get_avatar().setID( g->assign_npc_id(), true );
    get_avatar().name = "Player save survivor";
    std::filesystem::create_directories(
        PATH_INFO::current_dimension_save_path().get_unrelative_path() );
    bool compressed = false;
    bool block_compaction = false;
    bool travel = false;
    std::string memory_tier;
    SECTION( "uncompressed" ) {
        compressed = false;
    }
    SECTION( "compressed" ) {
        compressed = true;
    }
    SECTION( "compressed_without_compaction" ) {
        compressed = true;
        block_compaction = true;
    }
    SECTION( "compressed_memory_cold" ) {
        compressed = true;
        memory_tier = "cold";
    }
    SECTION( "compressed_memory_warm" ) {
        compressed = true;
        memory_tier = "warm";
    }
    SECTION( "compressed_memory_hot" ) {
        compressed = true;
        memory_tier = "hot";
    }
    SECTION( "dimension_travel_memory_failure" ) {
        compressed = true;
        travel = true;
        memory_tier = GENERATE( "cold", "warm", "hot" );
        CAPTURE( memory_tier );
    }
    if( compressed ) {
        for( const std::string filename : {
                 "maps.dict", "mmr.dict", "overmaps.dict"
             } ) {
            write_to_file( PATH_INFO::world_base_save_path() / filename, []( std::ostream & output ) {
                output << "dictionary";
            } );
        }
    }
    world->invalidate_compression_cache();
    REQUIRE( world->has_compression_enabled() == compressed );
    get_map().load( previous_map_position, false );
    const cata_path playerfile = PATH_INFO::player_base_save_path();
    const cata_path target = playerfile + SAVE_EXTENSION + ( compressed ? zzip_suffix : "" );
    const cata_path memory = PATH_INFO::current_dimension_player_save_path() + ".mm1";
    const cata_path blocked = memory_tier.empty() ? target : memory /
                              ( memory.get_unrelative_path().filename().u8string() + "." + memory_tier + ".zzip" );
    REQUIRE( std::filesystem::create_directories( blocked.get_unrelative_path() ) );
    if( travel ) {
        const dimension_id original_dimension = g->get_dimension_prefix();
        const std::string errors = capture_debugmsg_during( [&]() {
            CHECK_FALSE( g->travel_to_dimension( dimension_world_abyss, {}, {}, std::nullopt ) );
        } );
        CHECK( errors.find( blocked.get_unrelative_path().filename().u8string() ) != std::string::npos );
        CHECK( g->get_dimension_prefix() == original_dimension );
        CHECK( g->uquit == QUIT_NOSAVED );
        save_probe probe;
        get_event_bus().subscribe( &probe );
        CHECK_FALSE( g->save() );
        CHECK( probe.attempts == 0 );
        return;
    }
    const std::vector<cata_path> dependent_files = {
        playerfile + SAVE_EXTENSION_LOG,
        PATH_INFO::world_base_save_path() / ( base64_encode( get_avatar().get_save_id() + "_diary" ) +
                                              ".json" ),
        PATH_INFO::world_base_save_path() / SAVE_MASTER,
        PATH_INFO::current_dimension_save_path() / SAVE_DIMENSION_DATA
    };
    for( const cata_path &path : dependent_files ) {
        write_to_file( path, []( std::ostream & output ) {
            output << "unchanged";
        } );
    }
    const bool previous_errors = debug_has_error_been_observed();
    const std::string errors = capture_debugmsg_during( [&]() {
        CHECK_FALSE( g->save() );
    } );
    if( !compressed && !previous_errors ) {
        CHECK( debug_has_error_been_observed() );
        debug_reset_error_observed();
    }
    if( compressed ) {
        CHECK( errors.find( blocked.get_unrelative_path().filename().u8string() ) != std::string::npos );
    }
    for( const cata_path &path : dependent_files ) {
        CHECK( read_whole_file( path.get_unrelative_path() ) == "unchanged" );
    }
    if( memory_tier.empty() ) {
        CHECK_FALSE( std::filesystem::exists( memory.get_unrelative_path() ) );
    }
    REQUIRE( std::filesystem::remove( blocked.get_unrelative_path() ) );
    if( block_compaction ) {
        REQUIRE( std::filesystem::create_directory( ( target + ".tmp" ).get_unrelative_path() ) );
    }
    for( const std::string name : {
             "First successful save", "Updated successful save"
         } ) {
        get_avatar().name = name;
        REQUIRE( g->save() );
        if( compressed ) {
            std::optional<zzip> archive = zzip::load( target.get_unrelative_path() );
            REQUIRE( archive.has_value() );
            const std::vector<std::byte> contents = archive->get_file(
                    ( playerfile + SAVE_EXTENSION ).get_unrelative_path().filename() );
            const JsonObject data = json_loader::from_string( std::string(
                                        reinterpret_cast<const char *>( contents.data() ), contents.size() ) ).get_object();
            data.allow_omitted_members();
            const JsonObject player = data.get_object( "player" );
            player.allow_omitted_members();
            CHECK( player.get_string( "name" ) == name );
            if( name == "First successful save" ) {
                REQUIRE( archive->add_file( std::filesystem::u8path( "preserved-entry" ), "unchanged" ) );
            } else {
                CHECK( read_from_zzip_optional( *archive,
                std::filesystem::u8path( "preserved-entry" ), [&]( std::string_view contents ) {
                    CHECK( contents == "unchanged" );
                } ) );
            }
        } else {
            const JsonObject data = json_loader::from_path( target ).get_object();
            data.allow_omitted_members();
            const JsonObject player = data.get_object( "player" );
            player.allow_omitted_members();
            CHECK( player.get_string( "name" ) == name );
        }
    }
    load_probe probe;
    get_event_bus().subscribe( &probe );
    const save_t save = save_t::from_save_id( get_avatar().get_save_id() );
    capture_debugmsg_during( [&]() {
        CHECK_FALSE( g->reload_active_save( save ) );
    } );
    CHECK( probe.loaded );
    CHECK( get_avatar().name == "Updated successful save" );
}

TEST_CASE( "failed_critical_loads_block_saving", "[save_integrity][save]" )
{
    const int previous_version = savegame_loading_version;
    on_out_of_scope check_version( [previous_version]() {
        CHECK( savegame_loading_version == previous_version );
    } );
    restore_on_out_of_scope restore_version( savegame_loading_version );
    REQUIRE( g != nullptr );
    const std::filesystem::path directory = save_integrity_directory();
    on_out_of_scope cleanup( [&]() {
        reset_save_test_state();
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const std::string contents = GENERATE( std::string( "null" ), std::string( "{" ),
                                           std::string(), std::string( "\0payload", 8 ), std::string( "{}" ),
                                           std::string( "# version 39" ), std::string( "# version 39\n" ) );
    const cata_path path( cata_path::root_path::unknown,
                          directory / std::filesystem::u8path( "save.json" ) );
    {
        std::ofstream output( path.get_unrelative_path(), std::ios::binary );
        output.write( contents.data(), contents.size() );
    }
    save_probe probe;
    get_event_bus().subscribe( &probe );
    SECTION( "compressed_character_json" ) {
        CHECK_THROWS_AS( g->unserialize( contents ), JsonError );
    }
    SECTION( "character_file" ) {
        std::ifstream input( path.get_unrelative_path(), std::ios::binary );
        CHECK_THROWS( g->unserialize( input, path ) );
    }
    SECTION( "master_file" ) {
        std::ifstream input( path.get_unrelative_path(), std::ios::binary );
        CHECK_THROWS( g->unserialize_master( path, input ) );
    }
    SECTION( "dimension_file" ) {
        savegame_loading_version = 31;
        std::ifstream input( path.get_unrelative_path(), std::ios::binary );
        CHECK_THROWS( g->unserialize_dimension_data( path, input ) );
        CHECK( savegame_loading_version == 31 );
    }
    CHECK_FALSE( g->save() );
    CHECK( probe.attempts == 0 );
    g->reset_game_state();
    CHECK_THROWS_AS( g->save(), std::runtime_error );
    CHECK( probe.attempts == 1 );
}

TEST_CASE( "valid_critical_loads_allow_saving", "[save_integrity][save]" )
{
    const int previous_version = savegame_loading_version;
    on_out_of_scope check_version( [previous_version]() {
        CHECK( savegame_loading_version == previous_version );
    } );
    restore_on_out_of_scope restore_version( savegame_loading_version );
    const std::filesystem::path directory = save_integrity_directory();
    REQUIRE( world_generator->active_world != nullptr );
    WORLD *previous_world = world_generator->active_world;
    const std::string previous_savedir = PATH_INFO::savedir();
    WORLD world( "valid-save" );
    world.WORLD_OPTIONS = previous_world->WORLD_OPTIONS;
    on_out_of_scope cleanup( [&]() {
        world_generator->set_active_world( previous_world );
        PATH_INFO::set_savedir( previous_savedir );
        reset_save_test_state();
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    PATH_INFO::set_savedir( directory.generic_u8string() + "/" );
    world_generator->set_active_world( &world );
    g->reset_game_state();
    std::filesystem::create_directories(
        PATH_INFO::current_dimension_save_path().get_unrelative_path() );
    get_avatar().set_save_id( "valid-survivor" );
    get_avatar().setID( g->assign_npc_id(), true );
    REQUIRE( g->save() );
    const bool master = GENERATE( false, true );
    const bool legacy = GENERATE( false, true );
    const cata_path path( cata_path::root_path::unknown,
                          directory / std::filesystem::u8path( "save.json" ) );
    const auto original = read_whole_file( ( master ? PATH_INFO::world_base_save_path() / SAVE_MASTER :
                                           PATH_INFO::current_dimension_save_path() / SAVE_DIMENSION_DATA ).get_unrelative_path() );
    REQUIRE( original.has_value() );
    std::string contents = *original;
    if( legacy ) {
        if( master ) {
            for( const std::string_view name : {
                     "next_item_uid", "next_monster_uid", "next_vehicle_uid", "item_wakeups", "timed_events"
                 } ) {
                contents = replace_save_member( contents, name, std::nullopt );
            }
        } else {
            contents = replace_save_member( contents, "power_networks", std::nullopt );
        }
        contents.replace( 0, contents.find( '\n' ), "# version 31" );
    }
    write_to_file( path, [&]( std::ostream & stream ) {
        stream << contents;
    } );
    std::ifstream input( path.get_unrelative_path(), std::ios::binary );
    if( master ) {
        REQUIRE_NOTHROW( g->unserialize_master( path, input ) );
    } else {
        REQUIRE_NOTHROW( g->unserialize_dimension_data( path, input ) );
    }
    save_probe probe;
    get_event_bus().subscribe( &probe );
    CHECK_THROWS_AS( g->save(), std::runtime_error );
    CHECK( probe.attempts == 1 );
}

TEST_CASE( "critical_save_schema_rejects_missing_and_invalid_members", "[save_integrity][save]" )
{
    restore_on_out_of_scope restore_version( savegame_loading_version );
    const unsigned int previous_seed = g->get_seed();
    const std::filesystem::path directory = save_integrity_directory();
    REQUIRE( world_generator->active_world != nullptr );
    WORLD *previous_world = world_generator->active_world;
    const std::string previous_savedir = PATH_INFO::savedir();
    WORLD world( "save-schema" );
    world.WORLD_OPTIONS = previous_world->WORLD_OPTIONS;
    on_out_of_scope cleanup( [&]() {
        world_generator->set_active_world( previous_world );
        PATH_INFO::set_savedir( previous_savedir );
        reset_save_test_state();
        g->set_seed( previous_seed );
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    PATH_INFO::set_savedir( directory.generic_u8string() + "/" );
    world_generator->set_active_world( &world );
    g->reset_game_state();
    std::filesystem::create_directories(
        PATH_INFO::current_dimension_save_path().get_unrelative_path() );
    get_avatar().set_save_id( "schema-survivor" );
    get_avatar().setID( g->assign_npc_id(), true );
    REQUIRE( g->save() );
    const std::string kind = GENERATE( "master", "dimension", "character" );
    std::vector<std::string> fields;
    if( kind == "master" ) {
        fields = { "next_mission_id", "next_npc_id", "seed", "active_missions", "factions",
                   "next_item_uid", "next_monster_uid", "next_vehicle_uid", "timed_events"
                 };
    } else if( kind == "dimension" ) {
        fields = { "weather", "weather.temperature", "overmapbuffer", "overmapbuffer.placed_unique_specials",
                   "overmapbuffer.overmap_count", "power_networks.next_id", "power_networks.networks"
                 };
    } else {
        fields = { "turn", "calendar_start", "run_mode", "levx", "levy", "levz", "om_x", "om_y",
                   "player", "player.name", "player.str_max", "player.dex_max", "player.int_max", "player.per_max",
                   "player.location", "player.inv", "player.worn", "player.worn.worn"
                 };
    }
    const cata_path path( cata_path::root_path::unknown,
                          directory / std::filesystem::u8path( "save.json" ) );
    const cata_path source_path = kind == "master" ? PATH_INFO::world_base_save_path() / SAVE_MASTER :
                                  kind == "dimension" ? PATH_INFO::current_dimension_save_path() / SAVE_DIMENSION_DATA :
                                  PATH_INFO::player_base_save_path() + SAVE_EXTENSION;
    const auto original = read_whole_file( source_path.get_unrelative_path() );
    REQUIRE( original.has_value() );
    const auto snapshot = []() {
        std::ostringstream output;
        g->serialize_json( output );
        output << g->get_seed();
        JsonOut json( output );
        weather_manager::serialize_all( json );
        overmap_buffer.global_state.serialize( json );
        g->power_networks().serialize( json );
        return output.str();
    };
    for( const std::string &field : fields ) {
        for( const bool invalid : {
                 false, true
             } ) {
            if( !invalid && kind == "master" &&
                ( field == "next_item_uid" || field == "next_monster_uid" ||
                  field == "next_vehicle_uid" || field == "timed_events" ) ) {
                continue;
            }
            CAPTURE( kind, field, invalid );
            g->reset_game_state();
            g->set_seed( 0xfedcba98U );
            const std::string contents = replace_save_member( *original, field,
                                         invalid ? std::optional<std::string>( "null" ) : std::nullopt );
            write_to_file( path, [&]( std::ostream & stream ) {
                stream << contents;
            } );
            const std::string before = snapshot();
            const tripoint_abs_sm position = get_map().get_abs_sub();
            std::ifstream input( path.get_unrelative_path(), std::ios::binary );
            if( kind == "master" ) {
                CHECK_THROWS_AS( g->unserialize_master( path, input ), JsonError );
            } else if( kind == "dimension" ) {
                CHECK_THROWS_AS( g->unserialize_dimension_data( path, input ), JsonError );
            } else {
                CHECK_THROWS_AS( g->unserialize( input, path ), JsonError );
            }
            CHECK( snapshot() == before );
            CHECK( get_map().get_abs_sub() == position );
            save_probe probe;
            get_event_bus().subscribe( &probe );
            CHECK_FALSE( g->save() );
            CHECK( probe.attempts == 0 );
            CHECK( read_whole_file( path.get_unrelative_path() ) == contents );
        }
    }
}

TEST_CASE( "critical_saves_round_trip_and_reject_incomplete_reloads", "[save_integrity][save]" )
{
    const int previous_version = savegame_loading_version;
    on_out_of_scope check_version( [previous_version]() {
        CHECK( savegame_loading_version == previous_version );
    } );
    REQUIRE( world_generator != nullptr );
    REQUIRE( world_generator->active_world != nullptr );
    const std::filesystem::path directory = save_integrity_directory();
    WORLD *previous_world = world_generator->active_world;
    const tripoint_abs_sm previous_map_position = get_map().get_abs_sub();
    const dimension_id previous_dimension = g->get_dimension_prefix();
    const std::string previous_savedir = PATH_INFO::savedir();
    WORLD world( "save-integrity" );
    world.WORLD_OPTIONS = previous_world->WORLD_OPTIONS;
    on_out_of_scope cleanup( [&]() {
        world_generator->set_active_world( previous_world );
        PATH_INFO::set_savedir( previous_savedir );
        select_dimension_for_load( previous_dimension );
        CHECK( savegame_loading_version == previous_version );
        get_map().load( previous_map_position, false );
        reset_save_test_state();
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    restore_on_out_of_scope restore_version( savegame_loading_version );
    PATH_INFO::set_savedir( directory.generic_u8string() + "/" );
    world_generator->set_active_world( &world );
    const save_t save = save_t::from_save_id( "integrity-survivor" );
    world.world_saves.push_back( save );
    g->reset_game_state();
    std::filesystem::create_directories(
        PATH_INFO::current_dimension_save_path().get_unrelative_path() );
    const cata_path master = PATH_INFO::world_base_save_path() / SAVE_MASTER;
    const cata_path dimension = PATH_INFO::current_dimension_save_path() / SAVE_DIMENSION_DATA;
    const cata_path character = PATH_INFO::world_base_save_path() /
                                ( save.base_path() + SAVE_EXTENSION );
    get_avatar().set_save_id( save.decoded_name() );
    get_avatar().setID( g->assign_npc_id(), true );
    REQUIRE( g->save() );
    const std::string failure = GENERATE( "round-trip", "master", "missing-master", "dimension",
                                          "missing-dimension",
                                          "character", "missing-character", "legacy-dimension",
                                          "stale-dimension", "legacy-dimension-field", "legacy-version",
                                          "legacy-version-field", "legacy-position", "legacy-worn",
                                          "master-header", "dimension-header",
                                          "character-header", "master-weather", "dimension-weather",
                                          "missing-player", "invalid-player", "empty-player",
                                          "empty-master", "empty-dimension", "compressed-empty-player" );
    if( failure == "legacy-position" || failure == "legacy-worn" ) {
        const int previous_kcal = get_avatar().get_stored_kcal();
        std::ostringstream output;
        g->serialize_json( output );
        std::string contents = replace_save_member( output.str(), "savegame_loading_version",
                               std::string( "31" ) );
        contents = replace_save_member( contents, "player.stored_calories",
                                        std::to_string( previous_kcal ) );
        const tripoint_bub_ms position( 24, 37, get_map().get_abs_sub().z() );
        if( failure == "legacy-position" ) {
            contents = replace_save_member( contents, "player.location", std::nullopt );
            contents = replace_save_member( contents, "player.posx", std::to_string( position.x() ) );
            contents = replace_save_member( contents, "player.posy", std::to_string( position.y() ) );
            contents = replace_save_member( contents, "player.posz", std::to_string( position.z() ) );
        } else {
            contents = replace_save_member( contents, "player.worn", std::string( "[]" ) );
        }
        get_avatar() = avatar();
        REQUIRE_NOTHROW( g->unserialize( contents ) );
        CHECK( get_avatar().get_stored_kcal() == previous_kcal );
        if( failure == "legacy-position" ) {
            CHECK( get_avatar().pos_abs() == get_map().get_abs( position ) );
        } else {
            CHECK( get_avatar().worn.empty() );
        }
        return;
    }
    if( failure == "legacy-version" || failure == "legacy-version-field" ) {
        const int previous_kcal = get_avatar().get_stored_kcal();
        on_out_of_scope restore_calories( [&]() {
            get_avatar().set_stored_kcal( previous_kcal );
        } );
        get_avatar().set_stored_kcal( 12 );
        std::ostringstream output;
        g->serialize_json( output );
        std::string contents = output.str();
        const std::string version_key = "\"savegame_loading_version\":";
        const size_t version_start = contents.find( version_key );
        REQUIRE( version_start != std::string::npos );
        const size_t version_end = contents.find( ',', version_start );
        REQUIRE( version_end != std::string::npos );
        contents.replace( version_start + version_key.size(),
                          version_end - version_start - version_key.size(), "31" );
        if( failure == "legacy-version" ) {
            const size_t dimension_start = contents.find( "\"dimension_prefix\":" );
            REQUIRE( dimension_start != std::string::npos );
            const size_t dimension_end = contents.find( ',', dimension_start );
            REQUIRE( dimension_end != std::string::npos );
            contents.erase( dimension_start, dimension_end - dimension_start + 1 );
        }
        get_avatar() = avatar();
        REQUIRE_NOTHROW( g->unserialize( contents ) );
        CHECK( savegame_loading_version == 31 );
        CHECK( get_avatar().get_stored_kcal() == 12000 );
        return;
    }
    if( failure == "stale-dimension" || failure == "legacy-dimension-field" ) {
        const dimension_id &unrelated_dimension = dimension_world_abyss;
        REQUIRE( unrelated_dimension.is_valid() );
        select_dimension_for_load( unrelated_dimension );
        const cata_path unrelated = PATH_INFO::current_dimension_save_path() / SAVE_DIMENSION_DATA;
        std::filesystem::create_directories( unrelated.get_unrelative_path().parent_path() );
        write_to_file( unrelated, []( std::ostream & output ) {
            output << "{";
        } );
        if( failure == "legacy-dimension-field" ) {
            std::ostringstream output;
            g->serialize_json( output );
            const std::string contents = replace_save_member(
                                             replace_save_member( output.str(), "dimension_prefix", std::nullopt ),
                                             "mostseen", std::string( "\"stop\"" ) );
            g->reset_game_state();
            CHECK_THROWS_AS( g->unserialize( contents ), JsonError );
        } else {
            load_probe probe;
            get_event_bus().subscribe( &probe );
            const std::string errors = capture_debugmsg_during( [&]() {
                CHECK_FALSE( g->reload_active_save( save ) );
            } );
            CHECK( probe.loaded );
            CHECK( errors.find( unrelated.generic_u8string() ) == std::string::npos );
        }
        CHECK( g->get_dimension_prefix() == dimension_world_default );
        CHECK( read_whole_file( unrelated.get_unrelative_path() ) == "{" );
        return;
    }
    if( failure == "legacy-dimension" ) {
        const auto original_master = read_whole_file( master.get_unrelative_path() );
        const auto original_dimension = read_whole_file( dimension.get_unrelative_path() );
        REQUIRE( original_master.has_value() );
        REQUIRE( original_dimension.has_value() );
        const JsonObject dimension_data = json_loader::from_path_at_offset(
                                              dimension, original_dimension->find( '\n' ) + 1 ).get_object();
        dimension_data.allow_omitted_members();
        const JsonObject weather = dimension_data.get_object( "weather" );
        weather.allow_omitted_members();
        const JsonObject overmap = dimension_data.get_object( "overmapbuffer" );
        overmap.allow_omitted_members();
        const float temperature = weather.get_float( "temperature" );
        const int overmap_count = 73000;
        std::string contents = replace_save_member( *original_master, "weather", weather.str() );
        contents = replace_save_member( contents, "overmapbuffer",
                                        replace_save_member( overmap.str(), "overmap_count", std::to_string( overmap_count ) ) );
        contents.replace( 0, contents.find( '\n' ), "# version 31" );
        write_to_file( master, [&]( std::ostream & output ) {
            output << contents;
        } );
        REQUIRE( std::filesystem::remove( dimension.get_unrelative_path() ) );
        load_probe probe;
        get_event_bus().subscribe( &probe );
        capture_debugmsg_during( [&]() {
            CHECK_FALSE( g->reload_active_save( save ) );
        } );
        CHECK( probe.loaded );
        CHECK( units::to_fahrenheit( get_weather().temperature ) == Approx( temperature ) );
        CHECK( overmap_buffer.global_state.overmap_count >= overmap_count );
        CHECK( savegame_loading_version == savegame_version );
        CHECK_FALSE( std::filesystem::exists( dimension.get_unrelative_path() ) );
        return;
    }
    if( failure == "round-trip" ) {
        const auto original_master = read_whole_file( master.get_unrelative_path() );
        const auto original_dimension = read_whole_file( dimension.get_unrelative_path() );
        REQUIRE( original_master.has_value() );
        REQUIRE( original_dimension.has_value() );
        const weather_type_id original_weather = get_weather().weather_id;
        const float original_temperature = units::to_fahrenheit( get_weather().temperature );
        {
            std::ifstream input( master.get_unrelative_path(), std::ios::binary );
            REQUIRE_NOTHROW( g->unserialize_master( master, input ) );
        }
        {
            std::ifstream input( dimension.get_unrelative_path(), std::ios::binary );
            REQUIRE_NOTHROW( g->unserialize_dimension_data( dimension, input ) );
        }
        CHECK( get_weather().weather_id == original_weather );
        CHECK( units::to_fahrenheit( get_weather().temperature ) == Approx( original_temperature ) );
        REQUIRE( g->save() );
        CHECK( read_whole_file( master.get_unrelative_path() ) == original_master );
        std::ifstream input( dimension.get_unrelative_path(), std::ios::binary );
        CHECK_NOTHROW( g->unserialize_dimension_data( dimension, input ) );
        return;
    }
    cata_path rejected = character;
    if( failure == "master" || failure == "empty-master" || failure == "missing-master" ||
        failure == "master-header" ||
        failure == "master-weather" ) {
        rejected = master;
    } else if( failure == "dimension" || failure == "empty-dimension" ||
               failure == "missing-dimension" ||
               failure == "dimension-header" ||
               failure == "dimension-weather" ) {
        rejected = dimension;
    }
    std::string rejected_contents = "{";
    if( failure == "master-header" || failure == "dimension-header" || failure == "character-header" ) {
        rejected_contents = "# version 39";
    } else if( failure == "empty-master" || failure == "empty-dimension" ) {
        rejected_contents = "{}";
    } else if( failure == "master-weather" || failure == "dimension-weather" ) {
        const auto original = read_whole_file( rejected.get_unrelative_path() );
        REQUIRE( original.has_value() );
        rejected_contents = replace_save_member( *original, "weather", std::string( "{}" ) );
    }
    if( failure == "missing-player" || failure == "invalid-player" || failure == "empty-player" ||
        failure == "compressed-empty-player" ) {
        const auto original = read_whole_file( character.get_unrelative_path() );
        REQUIRE( original.has_value() );
        rejected_contents = replace_save_member( *original, "player",
                            failure == "missing-player" ? std::nullopt :
                            std::optional<std::string>( failure == "invalid-player" ? "null" : "{}" ) );
        const JsonObject rejected_data = json_loader::from_string( rejected_contents ).get_object();
        rejected_data.allow_omitted_members();
        if( failure == "missing-player" ) {
            REQUIRE_FALSE( rejected_data.has_member( "player" ) );
        } else if( failure == "invalid-player" ) {
            REQUIRE( rejected_data.has_null( "player" ) );
        } else {
            REQUIRE( rejected_data.has_object( "player" ) );
        }
        const tripoint_abs_sm map_position = get_map().get_abs_sub();
        const dimension_id dimension_prefix = g->get_dimension_prefix();
        CHECK_THROWS_WITH( g->unserialize( rejected_contents ), Catch::Matchers::Contains( "player" ) );
        CHECK( get_map().get_abs_sub() == map_position );
        CHECK( g->get_dimension_prefix() == dimension_prefix );
        {
            save_probe probe;
            get_event_bus().subscribe( &probe );
            CHECK_FALSE( g->save() );
            CHECK( probe.attempts == 0 );
        }
        CHECK( read_whole_file( character.get_unrelative_path() ) == original );
        g->reset_game_state();
    }
    const bool missing = failure == "missing-master" || failure == "missing-character" ||
                         failure == "missing-dimension";
    bool compressed_missing_dimension = false;
    if( failure == "missing-master" ) {
        REQUIRE( std::filesystem::remove( master.get_unrelative_path() ) );
    } else if( failure == "missing-character" ) {
        REQUIRE( std::filesystem::remove( character.get_unrelative_path() ) );
    } else if( failure == "missing-dimension" ) {
        const bool non_default_dimension = GENERATE( false, true );
        compressed_missing_dimension = GENERATE( false, true );
        if( non_default_dimension ) {
            const auto original = read_whole_file( character.get_unrelative_path() );
            REQUIRE( original.has_value() );
            const std::string contents = replace_save_member( *original, "dimension_prefix", "\"abyss\"" );
            write_to_file( character, [&]( std::ostream & output ) {
                output << contents;
            } );
            rejected = PATH_INFO::dimensions_save_path() / std::filesystem::u8path( "abyss" ) /
                       SAVE_DIMENSION_DATA;
            CHECK_FALSE( std::filesystem::exists( rejected.get_unrelative_path() ) );
        } else {
            REQUIRE( std::filesystem::remove( dimension.get_unrelative_path() ) );
        }
    }
    std::optional<std::string> archive_contents;
    const cata_path archive_path = character + zzip_suffix;
    if( failure == "compressed-empty-player" || compressed_missing_dimension ) {
        if( !compressed_missing_dimension ) {
            rejected = archive_path;
        }
        {
            std::ofstream dictionary( ( PATH_INFO::world_base_save_path() /
                                        "maps.dict" ).get_unrelative_path() );
        }
        world.invalidate_compression_cache();
        REQUIRE( world.has_compression_enabled() );
        {
            std::optional<zzip> archive = zzip::load( archive_path.get_unrelative_path() );
            REQUIRE( archive.has_value() );
            const auto character_contents = compressed_missing_dimension ?
                                            read_whole_file( character.get_unrelative_path() ) :
                                            std::optional<std::string>( rejected_contents );
            REQUIRE( character_contents.has_value() );
            REQUIRE( archive->add_file( character.get_unrelative_path().filename(), *character_contents ) );
        }
        std::ifstream input( archive_path.get_unrelative_path(), std::ios::binary );
        archive_contents = std::string( std::istreambuf_iterator<char>( input ),
                                        std::istreambuf_iterator<char>() );
    } else if( !missing ) {
        write_to_file( rejected, [&]( std::ostream & output ) {
            output << rejected_contents;
        } );
    }
    const std::string errors = capture_debugmsg_during( [&]() {
        CHECK_FALSE( g->reload_active_save( save ) );
    } );
    CHECK( errors.find( ( failure == "compressed-empty-player" ? character :
                          rejected ).get_unrelative_path().filename().u8string() ) !=
           std::string::npos );
    if( failure == "master-weather" || failure == "dimension-weather" ) {
        CHECK( errors.find( "temperature" ) != std::string::npos );
    }
    if( failure == "missing-player" || failure == "invalid-player" || failure == "empty-player" ||
        failure == "compressed-empty-player" ) {
        CHECK( errors.find( "player" ) != std::string::npos );
    }
    CHECK( g->uquit == QUIT_NOSAVED );
    save_probe probe;
    get_event_bus().subscribe( &probe );
    CHECK_FALSE( g->save() );
    CHECK( probe.attempts == 0 );
    if( missing ) {
        CHECK_FALSE( std::filesystem::exists( rejected.get_unrelative_path() ) );
    } else if( !archive_contents ) {
        CHECK( read_whole_file( rejected.get_unrelative_path() ) == rejected_contents );
    }
    if( archive_contents ) {
        std::ifstream input( archive_path.get_unrelative_path(), std::ios::binary );
        CHECK( std::string( std::istreambuf_iterator<char>( input ),
                            std::istreambuf_iterator<char>() ) == *archive_contents );
    }
}
