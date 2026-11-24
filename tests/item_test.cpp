#include <array>
#include <cmath>
#include <functional>
#include <initializer_list>
#include <limits>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <utility>
#include <vector>
#include <sstream>

#include "avatar.h"
#include "avatar_action.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character_attire.h"
#include "coordinates.h"
#include "enum_bitset.h"
#include "enums.h"
#include "flag.h"
#include "game.h"
#include "game_constants.h"
#include "item.h"
#include "item_category.h"
#include "item_factory.h"
#include "item_location.h"
#include "item_tname.h"
#include "item_transformation.h"
#include "itype.h"
#include "material.h"
#include "math_defines.h"
#include "monstergenerator.h"
#include "mtype.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "requirements.h"
#include "ret_val.h"
#include "string_formatter.h"
#include "subbodypart.h"
#include "test_data.h"
#include "type_id.h"
#include "units.h"
#include "value_ptr.h"
#include "input.h"
#include "input_context.h"
#include "input_enums.h"
#include "character.h"
#include "inventory.h"
#include "item_components.h"
#include "pimpl.h"
#include "item_uid.h"
#include "flat_set.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "item_contents.h"
#include "item_pocket.h"
#include "json.h"
#include "json_loader.h"
#include "rng.h"
#include "map.h"

static const flag_id json_flag_COLD( "COLD" );
static const flag_id json_flag_FILTHY( "FILTHY" );
static const flag_id json_flag_FIX_NEARSIGHT( "FIX_NEARSIGHT" );
static const flag_id json_flag_HOT( "HOT" );

static const item_category_id item_category_clothing( "clothing" );
static const item_category_id item_category_container( "container" );
static const item_category_id item_category_food( "food" );
static const item_category_id item_category_guns( "guns" );
static const item_category_id item_category_spare_parts( "spare_parts" );
static const item_category_id item_category_tools( "tools" );

static const itype_id itype_10gal_hat( "10gal_hat" );
static const itype_id itype_arm_splint( "arm_splint" );
static const itype_id itype_arm_warmers( "arm_warmers" );
static const itype_id itype_armor_mc_lightplate( "armor_mc_lightplate" );
static const itype_id itype_aspirin( "aspirin" );
static const itype_id itype_attachable_ear_muffs( "attachable_ear_muffs" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_bag_plastic( "bag_plastic" );
static const itype_id itype_barrel_glock_short( "barrel_glock_short" );
static const itype_id itype_battery( "battery" );
static const itype_id itype_bottle_plastic_small( "bottle_plastic_small" );
static const itype_id itype_butter( "butter" );
static const itype_id itype_cash_card( "cash_card" );
static const itype_id itype_chem_black_powder( "chem_black_powder" );
static const itype_id itype_chem_muriatic_acid( "chem_muriatic_acid" );
static const itype_id itype_down_mattress( "down_mattress" );
static const itype_id itype_duffelbag( "duffelbag" );
static const itype_id itype_efile_photos( "efile_photos" );
static const itype_id itype_efile_recipes( "efile_recipes" );
static const itype_id itype_glock_19( "glock_19" );
static const itype_id itype_hammer( "hammer" );
static const itype_id itype_hat_hard( "hat_hard" );
static const itype_id itype_jeans( "jeans" );
static const itype_id itype_legrig( "legrig" );
static const itype_id itype_money( "money" );
static const itype_id itype_neccowafers( "neccowafers" );
static const itype_id itype_rocuronium( "rocuronium" );
static const itype_id itype_shoulder_strap( "shoulder_strap" );
static const itype_id itype_single_malt_whiskey( "single_malt_whiskey" );
static const itype_id itype_software_hacking( "software_hacking" );
static const itype_id itype_test_armguard( "test_armguard" );
static const itype_id itype_test_backpack( "test_backpack" );
static const itype_id itype_test_consolidate( "test_consolidate" );
static const itype_id itype_test_duffelbag( "test_duffelbag" );
static const itype_id itype_test_exo_lense_module( "test_exo_lense_module" );
static const itype_id itype_test_liquid( "test_liquid" );
static const itype_id itype_test_modular_exosuit( "test_modular_exosuit" );
static const itype_id itype_test_mp3( "test_mp3" );
static const itype_id itype_test_one_per_layer_ring_a( "test_one_per_layer_ring_a" );
static const itype_id itype_test_one_per_layer_ring_b( "test_one_per_layer_ring_b" );
static const itype_id itype_test_one_per_layer_ring_c( "test_one_per_layer_ring_c" );
static const itype_id itype_test_rock( "test_rock" );
static const itype_id itype_test_smart_phone( "test_smart_phone" );
static const itype_id itype_test_waterproof_bag( "test_waterproof_bag" );
static const itype_id itype_tire_repair_kit( "tire_repair_kit" );
static const itype_id itype_towel( "towel" );
static const itype_id itype_usb_drive( "usb_drive" );
static const itype_id itype_walnut( "walnut" );
static const itype_id itype_water( "water" );
static const itype_id itype_win70( "win70" );
static const itype_id itype_wrapper( "wrapper" );

static const json_character_flag json_flag_DEAF( "DEAF" );

static const mod_id MOD_INFORMATION_test_data( "test_data" );

static const recipe_id recipe_2byarm_guard( "2byarm_guard" );
static const recipe_id recipe_armguard_chitin( "armguard_chitin" );
static const recipe_id recipe_balclava( "balclava" );

TEST_CASE( "item_volume", "[item]" )
{
    // Need to pick some item here which is count_by_charges and for which each
    // charge is at least 1_ml.  Battery works for now.
    item i( itype_battery, calendar::turn_zero, item::default_charges_tag() );
    REQUIRE( i.count_by_charges() );
    // Would be better with Catch2 generators
    const units::volume big_volume = units::from_milliliter( std::numeric_limits<int>::max() / 2 );
    for( units::volume v : {
             0_ml, 1_ml, i.volume(), big_volume
         } ) {
        INFO( "checking batteries that fit in " << v );
        const int charges_that_should_fit = i.charges_per_volume( v );
        i.charges = charges_that_should_fit;
        CHECK( i.volume() <= v ); // this many charges should fit
        i.charges++;
        CHECK( i.volume() > v ); // one more charge should not fit
    }
}

TEST_CASE( "simple_item_layers", "[item]" )
{
    CHECK( item( itype_arm_warmers ).get_layer().front() == layer_level::SKINTIGHT );
    CHECK( item( itype_10gal_hat ).get_layer().front() == layer_level::NORMAL );
    // intentionally no waist layer check since it is obsoleted
    CHECK( item( itype_armor_mc_lightplate ).get_layer().front() == layer_level::OUTER );
    CHECK( item( itype_legrig ).get_layer().front() == layer_level::BELTED );
}

TEST_CASE( "gun_layer", "[item]" )
{
    item gun( itype_win70 );
    item mod( itype_shoulder_strap );
    CHECK( gun.is_gunmod_compatible( mod ).success() );
    gun.put_in( mod, pocket_type::MOD );
    CHECK( gun.get_layer().front() == layer_level::BELTED );
    CHECK( gun.get_category_of_contents().id == item_category_guns );
}

TEST_CASE( "gun_with_gunmod_price_sums_components", "[item][price][gunmod]" )
{
    item gun( itype_glock_19 );
    item mod( itype_barrel_glock_short );
    REQUIRE( gun.is_gunmod_compatible( mod ).success() );
    const int gun_pre = gun.price_no_contents( false );
    const int mod_pre = mod.price_no_contents( false );
    const int gun_post = gun.price_no_contents( true );
    const int mod_post = mod.price_no_contents( true );
    gun.put_in( mod, pocket_type::MOD );
    CHECK( gun.price( false ) == gun_pre + mod_pre );
    CHECK( gun.price( true ) == gun_post + mod_post );
}

TEST_CASE( "stacking_cash_cards", "[item]" )
{
    // Differently-charged cash cards should stack if neither is zero.
    item cash0( itype_cash_card, calendar::turn_zero );
    item cash1( itype_cash_card, calendar::turn_zero );
    item cash2( itype_cash_card, calendar::turn_zero );
    cash1.put_in( item( itype_money, calendar::turn_zero, 1 ), pocket_type::MAGAZINE );
    cash2.put_in( item( itype_money, calendar::turn_zero, 2 ), pocket_type::MAGAZINE );
    CHECK( !cash0.stacks_with( cash1 ) );
    //CHECK( cash1.stacks_with( cash2 ) ); Enable this once cash card stacking is brought back.
}

// second minute hour day week season year

TEST_CASE( "stacking_over_time", "[item]" )
{
    item A( itype_neccowafers );
    item B( itype_neccowafers );

    GIVEN( "Two items with the same birthday" ) {
        REQUIRE( A.stacks_with( B ) );
        WHEN( "the items are aged different numbers of seconds" ) {
            A.mod_rot( A.type->comestible->spoils - 1_turns );
            B.mod_rot( B.type->comestible->spoils - 3_turns );
            THEN( "they don't stack" ) {
                CHECK( !A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged the same to the minute but different numbers of seconds" ) {
            A.mod_rot( A.type->comestible->spoils - 5_minutes );
            B.mod_rot( B.type->comestible->spoils - 5_minutes );
            B.mod_rot( -5_turns );
            THEN( "they stack" ) {
                CHECK( A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged a few seconds different but different minutes" ) {
            A.mod_rot( A.type->comestible->spoils - 5_minutes );
            B.mod_rot( B.type->comestible->spoils - 5_minutes );
            B.mod_rot( 5_turns );
            THEN( "they don't stack" ) {
                CHECK( !A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged the same to the hour but different numbers of minutes" ) {
            A.mod_rot( A.type->comestible->spoils - 5_hours );
            B.mod_rot( B.type->comestible->spoils - 5_hours );
            B.mod_rot( -5_minutes );
            THEN( "they stack" ) {
                CHECK( A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged a few seconds different but different hours" ) {
            A.mod_rot( A.type->comestible->spoils - 5_hours );
            B.mod_rot( B.type->comestible->spoils - 5_hours );
            B.mod_rot( 5_turns );
            THEN( "they don't stack" ) {
                CHECK( !A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged the same to the day but different numbers of seconds" ) {
            A.mod_rot( A.type->comestible->spoils - 3_days );
            B.mod_rot( B.type->comestible->spoils - 3_days );
            B.mod_rot( -5_turns );
            THEN( "they stack" ) {
                CHECK( A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged a few seconds different but different days" ) {
            A.mod_rot( A.type->comestible->spoils - 3_days );
            B.mod_rot( B.type->comestible->spoils - 3_days );
            B.mod_rot( 5_turns );
            THEN( "they don't stack" ) {
                CHECK( !A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged the same to the week but different numbers of seconds" ) {
            A.mod_rot( A.type->comestible->spoils - 7_days );
            B.mod_rot( B.type->comestible->spoils - 7_days );
            B.mod_rot( -5_turns );
            THEN( "they stack" ) {
                CHECK( A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged a few seconds different but different weeks" ) {
            A.mod_rot( A.type->comestible->spoils - 7_days );
            B.mod_rot( B.type->comestible->spoils - 7_days );
            B.mod_rot( 5_turns );
            THEN( "they don't stack" ) {
                CHECK( !A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged the same to the season but different numbers of seconds" ) {
            A.mod_rot( A.type->comestible->spoils - calendar::season_length() );
            B.mod_rot( B.type->comestible->spoils - calendar::season_length() );
            B.mod_rot( -5_turns );
            THEN( "they stack" ) {
                CHECK( A.stacks_with( B ) );
            }
        }
        WHEN( "the items are aged a few seconds different but different seasons" ) {
            A.mod_rot( A.type->comestible->spoils - calendar::season_length() );
            B.mod_rot( B.type->comestible->spoils - calendar::season_length() );
            B.mod_rot( 5_turns );
            THEN( "they don't stack" ) {
                CHECK( !A.stacks_with( B ) );
            }
        }
    }
}

TEST_CASE( "liquids_at_different_temperatures", "[item][temperature][stack][combine]" )
{
    item liquid_hot( itype_test_liquid );
    item liquid_cold( itype_test_liquid );
    item liquid_filthy( itype_test_liquid );

    // heat_up/cold_up sets temperature of item and corresponding HOT/COLD flags
    liquid_hot.heat_up(); // 60 C (333.15 K)
    liquid_cold.cold_up(); // 3 C (276.15 K)
    liquid_filthy.cold_up(); // 3 C (276.15 K)
    liquid_filthy.set_flag( json_flag_FILTHY );

    REQUIRE( units::to_kelvin( liquid_hot.temperature ) == Approx( 333.15 ) );
    REQUIRE( units::to_kelvin( liquid_cold.temperature ) == Approx( 276.15 ) );
    REQUIRE( liquid_hot.has_flag( json_flag_HOT ) );
    REQUIRE( liquid_cold.has_flag( json_flag_COLD ) );

    SECTION( "liquids at the same temperature can stack together" ) {
        CHECK( liquid_cold.stacks_with( liquid_cold ) );
        CHECK( liquid_hot.stacks_with( liquid_hot ) );
    }

    SECTION( "liquids at different temperature do not stack" ) {
        // Items with different flags do not stack
        CHECK_FALSE( liquid_cold.stacks_with( liquid_hot ) );
        CHECK_FALSE( liquid_hot.stacks_with( liquid_cold ) );
    }

    SECTION( "liquids at different temperature can be combined" ) {
        CHECK( liquid_cold.can_combine( liquid_hot ) );
        CHECK( liquid_hot.can_combine( liquid_cold ) );
    }

    SECTION( "liquids with different flags can not be combined" ) {
        CHECK( !liquid_cold.can_combine( liquid_filthy ) );
        CHECK( !liquid_filthy.can_combine( liquid_cold ) );
    }
}

static void assert_minimum_length_to_volume_ratio( const item &target )
{
    if( target.type->get_id().is_null() ) {
        return;
    }
    CAPTURE( target.type->get_id() );
    CAPTURE( target.volume() );
    CAPTURE( target.base_volume() );
    CAPTURE( target.type->volume );
    if( target.made_of( phase_id::LIQUID ) || target.is_soft() ) {
        CHECK( target.length() == 0_mm );
        return;
    }
    if( target.volume() == 0_ml ) {
        CHECK( target.length() == -1_mm );
        return;
    }
    if( target.volume() == 1_ml ) {
        CHECK( target.length() >= 0_mm );
        return;
    }
    // Minimum possible length is if the item is a sphere.
    const float minimal_diameter = std::cbrt( ( 3.0 * units::to_milliliter( target.base_volume() ) ) /
        ( 4.0 * M_PI ) );
    CHECK( units::to_millimeter( target.length() ) >= minimal_diameter * 10.0 );
}

TEST_CASE( "item_length_sanity_check", "[item]" )
{
    for( const itype *type : item_controller->all() ) {
        const item sample( type, calendar::turn_zero, item::solitary_tag {} );
        assert_minimum_length_to_volume_ratio( sample );
    }
}

TEST_CASE( "corpse_length_sanity_check", "[item]" )
{
    for( const mtype &type : MonsterGenerator::generator().get_all_mtypes() ) {
        INFO( type.id.str() )
        const item sample = item::make_corpse( type.id );
        assert_minimum_length_to_volume_ratio( sample );
    }
}

static void check_spawning_in_container( const itype_id &item_type )
{
    item test_item( item_type );
    REQUIRE( test_item.type->default_container );
    item container_item = test_item.in_its_container( 1 );
    CHECK( container_item.typeId() == *test_item.type->default_container );
    if( container_item.is_container() ) {
        CHECK( container_item.has_item_with( [&test_item]( const item & it ) {
            return it.typeId() == test_item.typeId();
        } ) );
    } else if( test_item.is_software() ) {
        REQUIRE( container_item.is_estorage() );
        const std::vector<const item *> softwares = container_item.softwares();
        CHECK( !softwares.empty() );
        for( const item *itm : softwares ) {
            CHECK( itm->typeId() == test_item.typeId() );
        }
    } else {
        FAIL( "Not container or software storage." );
    }
}

TEST_CASE( "items_spawn_in_their_default_containers", "[item]" )
{
    check_spawning_in_container( itype_water );
    check_spawning_in_container( itype_single_malt_whiskey );
    check_spawning_in_container( itype_rocuronium );
    check_spawning_in_container( itype_chem_muriatic_acid );
    check_spawning_in_container( itype_chem_black_powder );
}

TEST_CASE( "item_variables_round-trip_accurately", "[item]" )
{
    item i( itype_water );
    i.set_var( "A", 17 );
    CHECK( i.get_var( "A", 0 ) == 17 );
    i.set_var( "B", 0.125 );
    CHECK( i.get_var( "B", 0.0 ) == 0.125 );
    i.set_var( "C", tripoint_abs_ms( 2, 3, 4 ) );
    CHECK( i.get_var( "C", tripoint_abs_ms::zero ) == tripoint_abs_ms( 2, 3, 4 ) );
}

static item make_photo_gallery( int n_photos )
{
    item gallery( itype_efile_photos );
    std::vector<item::extended_photo_def> photos;
    photos.reserve( n_photos );
    for( int i = 0; i < n_photos; ++i ) {
        item::extended_photo_def photo;
        photo.quality = 3;
        photo.name = string_format( "test_photo_%d", i );
        photo.description = "A test photo for stacking comparison.";
        photos.push_back( photo );
    }
    gallery.write_extended_photos( photos, "CAMERA_EXTENDED_PHOTOS" );
    return gallery;
}

TEST_CASE( "efile_photos_total_photos_count_cache", "[item][estorage]" )
{
    SECTION( "fresh write caches the count" ) {
        item gallery = make_photo_gallery( 5 );
        CHECK( gallery.has_var( "CAMERA_EXTENDED_PHOTOS_count" ) );
        CHECK( gallery.get_var( "CAMERA_EXTENDED_PHOTOS_count", 0 ) == 5 );
        CHECK( gallery.total_photos() == 5 );
    }

    SECTION( "legacy save without cache var lazy-fills on first call" ) {
        item gallery = make_photo_gallery( 7 );
        gallery.erase_var( "CAMERA_EXTENDED_PHOTOS_count" );
        REQUIRE_FALSE( gallery.has_var( "CAMERA_EXTENDED_PHOTOS_count" ) );
        CHECK( gallery.total_photos() == 7 );
        CHECK( gallery.has_var( "CAMERA_EXTENDED_PHOTOS_count" ) );
        CHECK( gallery.get_var( "CAMERA_EXTENDED_PHOTOS_count", 0 ) == 7 );
    }

    SECTION( "two galleries with same photos stack" ) {
        item a = make_photo_gallery( 3 );
        item b = make_photo_gallery( 3 );
        stacking_info info = a.stacks_with( b );
        CHECK( static_cast<bool>( info ) );
        CHECK( info.bits[tname::segments::EMEMORY] );
    }

    SECTION( "mixed cache state still stacks" ) {
        // Cache key is derived; VARS must ignore it or lazy-fill desyncs split stacks.
        item a = make_photo_gallery( 4 );
        item b = make_photo_gallery( 4 );
        b.erase_var( "CAMERA_EXTENDED_PHOTOS_count" );
        REQUIRE( a.has_var( "CAMERA_EXTENDED_PHOTOS_count" ) );
        REQUIRE_FALSE( b.has_var( "CAMERA_EXTENDED_PHOTOS_count" ) );
        stacking_info info = a.stacks_with( b );
        CHECK( static_cast<bool>( info ) );
        CHECK( info.bits[tname::segments::VARS] );
    }

    SECTION( "differing photo counts do not stack" ) {
        item a = make_photo_gallery( 3 );
        item b = make_photo_gallery( 5 );
        REQUIRE( a.total_photos() != b.total_photos() );
        stacking_info info = a.stacks_with( b );
        CHECK_FALSE( static_cast<bool>( info ) );
        CHECK_FALSE( info.bits[tname::segments::VARS] );
    }

    SECTION( "containers with differing nested galleries report EMEMORY mismatch" ) {
        // EMEMORY bit drives aggregated free-mem display, must reflect real mismatch.
        item a( itype_usb_drive );
        item b( itype_usb_drive );
        REQUIRE( a.put_in( make_photo_gallery( 3 ), pocket_type::E_FILE_STORAGE ).success() );
        REQUIRE( b.put_in( make_photo_gallery( 5 ), pocket_type::E_FILE_STORAGE ).success() );
        stacking_info info = a.stacks_with( b );
        CHECK_FALSE( static_cast<bool>( info ) );
        CHECK_FALSE( info.bits[tname::segments::EMEMORY] );
    }

    SECTION( "occupied_ememory sums every top-level efile" ) {
        item drive( itype_usb_drive );
        const item g1 = make_photo_gallery( 2 );
        const item g2 = make_photo_gallery( 5 );
        const units::ememory expected = g1.ememory_size() + g2.ememory_size();
        REQUIRE( drive.put_in( g1, pocket_type::E_FILE_STORAGE ).success() );
        REQUIRE( drive.put_in( g2, pocket_type::E_FILE_STORAGE ).success() );
        const bool sum_matches = drive.occupied_ememory() == expected;
        CHECK( sum_matches );
    }

    SECTION( "estorage and non-estorage pair fails EMEMORY bit" ) {
        // Aggregated headers AND this bit; mixed pairs must drop it.
        item drive( itype_usb_drive );
        item rock( itype_test_rock );
        REQUIRE( drive.is_estorage() );
        REQUIRE_FALSE( rock.is_estorage() );
        stacking_info info = drive.stacks_with( rock );
        CHECK_FALSE( info.bits[tname::segments::EMEMORY] );
    }

    SECTION( "non-estorage pair short-circuits EMEMORY bit to true" ) {
        item a( itype_test_rock );
        item b( itype_test_rock );
        REQUIRE_FALSE( a.is_estorage() );
        stacking_info info = a.stacks_with( b );
        CHECK( info.bits[tname::segments::EMEMORY] );
    }
}

static item make_recipe_book( const std::set<recipe_id> &recipes )
{
    item book( itype_efile_recipes );
    book.set_saved_recipes( recipes );
    return book;
}

TEST_CASE( "efile_recipes_count_cache", "[item][estorage]" )
{
    const std::set<recipe_id> two = { recipe_balclava, recipe_2byarm_guard };
    const std::set<recipe_id> three = { recipe_balclava, recipe_2byarm_guard, recipe_armguard_chitin };

    SECTION( "set_saved_recipes caches the count" ) {
        item book = make_recipe_book( two );
        CHECK( book.has_var( "EIPC_RECIPES_count" ) );
        CHECK( book.get_var( "EIPC_RECIPES_count", 0 ) == 2 );
    }

    SECTION( "legacy save without cache var lazy-fills via ememory_size" ) {
        item book = make_recipe_book( three );
        book.erase_var( "EIPC_RECIPES_count" );
        REQUIRE_FALSE( book.has_var( "EIPC_RECIPES_count" ) );
        const bool nonzero = book.ememory_size().value() > 0;
        REQUIRE( nonzero );
        CHECK( book.has_var( "EIPC_RECIPES_count" ) );
        CHECK( book.get_var( "EIPC_RECIPES_count", 0 ) == 3 );
    }

    SECTION( "broken e-file reports zero ememory_size" ) {
        item book = make_recipe_book( two );
        book.set_flag( flag_ITEM_BROKEN );
        REQUIRE( book.is_broken_on_active() );
        CHECK( book.ememory_size().value() == 0 );
    }

    SECTION( "lazy fill deduplicates malformed CSV" ) {
        item book( itype_efile_recipes );
        book.set_var( "EIPC_RECIPES", std::string( ",balclava,balclava," ) );
        REQUIRE_FALSE( book.has_var( "EIPC_RECIPES_count" ) );
        const bool nonzero = book.ememory_size().value() > 0;
        REQUIRE( nonzero );
        CHECK( book.get_var( "EIPC_RECIPES_count", 0 ) == 1 );
    }

    SECTION( "set_saved_recipes while broken caches steady-state count" ) {
        item book( itype_efile_recipes );
        book.set_flag( flag_ITEM_BROKEN );
        REQUIRE( book.is_broken_on_active() );
        book.set_saved_recipes( two );
        CHECK( book.get_var( "EIPC_RECIPES_count", 0 ) == 2 );
        book.unset_flag( flag_ITEM_BROKEN );
        REQUIRE_FALSE( book.is_broken_on_active() );
        const bool nonzero = book.ememory_size().value() > 0;
        CHECK( nonzero );
    }

    SECTION( "mixed cache state still stacks" ) {
        item a = make_recipe_book( two );
        item b = make_recipe_book( two );
        b.erase_var( "EIPC_RECIPES_count" );
        REQUIRE( a.has_var( "EIPC_RECIPES_count" ) );
        REQUIRE_FALSE( b.has_var( "EIPC_RECIPES_count" ) );
        stacking_info info = a.stacks_with( b );
        CHECK( static_cast<bool>( info ) );
        CHECK( info.bits[tname::segments::VARS] );
    }
}

TEST_CASE( "water_affect_items_while_swimming_check", "[item][water][swimming]" )
{
    avatar &guy = get_avatar();
    clear_avatar();

    GIVEN( "an item with flag WATER_DISSOLVE" ) {

        REQUIRE( item( itype_aspirin ).has_flag( flag_WATER_DISSOLVE ) );

        WHEN( "item in hand" ) {
            guy.unwield();
            guy.clear_worn();

            item aspirin( itype_aspirin );

            REQUIRE( guy.wield( aspirin ) );

            THEN( "should dissolve in water" ) {
                g->water_affect_items( guy );
                CHECK_FALSE( guy.has_item_with_flag( flag_WATER_DISSOLVE ) );
            }
        }

        WHEN( "item in backpack" ) {
            guy.unwield();
            guy.clear_worn();

            item aspirin( itype_aspirin );
            item backpack( itype_backpack );

            backpack.put_in( aspirin, pocket_type::CONTAINER );

            REQUIRE( guy.wear_item( backpack ) );

            THEN( "should dissolve in water" ) {
                g->water_affect_items( guy );
                CHECK_FALSE( guy.has_item_with_flag( flag_WATER_DISSOLVE ) );
            }
        }

        WHEN( "item in small plastic bottle" ) {
            guy.unwield();
            guy.clear_worn();

            item aspirin( itype_aspirin );
            item bottle_small( itype_bottle_plastic_small );

            bottle_small.put_in( aspirin, pocket_type::CONTAINER );

            REQUIRE( guy.wield( bottle_small ) );

            THEN( "should not dissolve in water" ) {
                g->water_affect_items( guy );
                CHECK( guy.has_item_with_flag( flag_WATER_DISSOLVE ) );
            }
        }

        WHEN( "item in backpack inside duffel bag" ) {
            guy.unwield();
            guy.clear_worn();

            item aspirin( itype_aspirin );
            item backpack( itype_backpack );
            item duffelbag( itype_duffelbag );

            backpack.put_in( aspirin, pocket_type::CONTAINER );
            duffelbag.put_in( backpack, pocket_type::CONTAINER );

            REQUIRE( guy.wear_item( duffelbag ) );

            THEN( "should dissolve in water" ) {
                g->water_affect_items( guy );
                CHECK_FALSE( guy.has_item_with_flag( flag_WATER_DISSOLVE ) );
            }
        }

        WHEN( "item in backpack inside body bag" ) {
            guy.unwield();
            guy.clear_worn();

            item aspirin( itype_aspirin );
            item backpack( itype_backpack );
            item body_bag( itype_test_waterproof_bag );

            backpack.put_in( aspirin, pocket_type::CONTAINER );
            body_bag.put_in( backpack, pocket_type::CONTAINER );

            REQUIRE( guy.wield( body_bag ) );

            THEN( "should not dissolve in water" ) {
                g->water_affect_items( guy );
                CHECK( guy.has_item_with_flag( flag_WATER_DISSOLVE ) );
            }
        }
    }

    GIVEN( "an item with flag WATER_BREAK" ) {

        REQUIRE( itype_test_smart_phone->has_flag( flag_WATER_BREAK ) );

        WHEN( "item in hand" ) {
            guy.unwield();
            guy.clear_worn();

            item smart_phone( itype_test_smart_phone );

            REQUIRE( guy.wield( smart_phone ) );
            item *test_item = guy.get_wielded_item().get_item();

            THEN( "should be broken by water" ) {
                g->water_affect_items( guy );

                CHECK_FALSE( test_item->faults.empty() );
                CHECK( test_item->is_broken() );
            }
        }

        WHEN( "item in backpack" ) {
            guy.unwield();
            guy.clear_worn();

            item smart_phone( itype_test_smart_phone );
            item backpack( itype_test_backpack );

            backpack.put_in( smart_phone, pocket_type::CONTAINER );

            REQUIRE( guy.wield( backpack ) );
            item *test_item = &guy.get_wielded_item()->only_item();

            THEN( "should be broken by water" ) {
                g->water_affect_items( guy );
                CHECK_FALSE( test_item->faults.empty() );
                CHECK( test_item->is_broken() );
            }
        }

        WHEN( "item in body bag" ) {
            guy.unwield();
            guy.clear_worn();

            item smart_phone( itype_test_smart_phone );
            item body_bag( itype_test_waterproof_bag );

            body_bag.put_in( smart_phone, pocket_type::CONTAINER );

            REQUIRE( guy.wield( body_bag ) );
            item *test_item = &guy.get_wielded_item()->only_item();

            THEN( "should not be broken by water" ) {
                g->water_affect_items( guy );
                CHECK( test_item->faults.empty() );
                CHECK_FALSE( test_item->is_broken() );
            }
        }

        WHEN( "item in backpack inside duffel bag" ) {
            guy.unwield();
            guy.clear_worn();

            item smart_phone( itype_test_smart_phone );
            item backpack( itype_test_backpack );
            item duffelbag( itype_test_duffelbag );

            backpack.put_in( smart_phone, pocket_type::CONTAINER );
            duffelbag.put_in( backpack, pocket_type::CONTAINER );

            REQUIRE( guy.wield( duffelbag ) );
            item *test_item = &guy.get_wielded_item()->only_item().only_item();

            THEN( "should be broken by water" ) {
                g->water_affect_items( guy );
                CHECK_FALSE( test_item->faults.empty() );
                CHECK( test_item->is_broken() );
            }
        }

        WHEN( "item in backpack inside body bag" ) {
            guy.unwield();
            guy.clear_worn();

            item smart_phone( itype_test_smart_phone );
            item backpack( itype_test_backpack );
            item body_bag( itype_test_waterproof_bag );

            backpack.put_in( smart_phone, pocket_type::CONTAINER );
            body_bag.put_in( backpack, pocket_type::CONTAINER );

            REQUIRE( guy.wield( body_bag ) );
            item *test_item = &guy.get_wielded_item()->only_item().only_item();

            THEN( "should not be broken by water" ) {
                g->water_affect_items( guy );
                CHECK( test_item->faults.empty() );
                CHECK_FALSE( test_item->is_broken() );
            }
        }
    }

    GIVEN( "an item with flag WATER_BREAK_ACTIVE" ) {

        REQUIRE( itype_test_mp3->has_flag( flag_WATER_BREAK_ACTIVE ) );

        WHEN( "item in hand" ) {
            guy.unwield();
            guy.clear_worn();

            item mp3( itype_test_mp3 );

            REQUIRE( guy.wield( mp3 ) );

            THEN( "should get wet from water" ) {
                g->water_affect_items( guy );
                CHECK( guy.get_wielded_item()->wetness > 0 );
            }
        }

        WHEN( "item in backpack" ) {
            guy.unwield();
            guy.clear_worn();

            item mp3( itype_test_mp3 );
            item backpack( itype_test_backpack );

            backpack.put_in( mp3, pocket_type::CONTAINER );

            REQUIRE( guy.wield( backpack ) );

            THEN( "should get wet from water" ) {
                g->water_affect_items( guy );
                const item *test_item = guy.get_wielded_item()->all_items_top().front();
                REQUIRE( test_item->typeId() == itype_test_mp3 );
                CHECK( test_item->wetness > 0 );
            }
        }

        WHEN( "item in body bag" ) {
            guy.unwield();
            guy.clear_worn();

            item mp3( itype_test_mp3 );
            item body_bag( itype_test_waterproof_bag );

            body_bag.put_in( mp3, pocket_type::CONTAINER );

            REQUIRE( guy.wield( body_bag ) );

            THEN( "should not be broken by water" ) {
                g->water_affect_items( guy );
                const item *test_item = guy.get_wielded_item()->all_items_top().front();
                REQUIRE( test_item->typeId() == itype_test_mp3 );
                CHECK( test_item->wetness == 0 );
            }
        }

        WHEN( "item in backpack inside duffel bag" ) {
            guy.unwield();
            guy.clear_worn();

            item mp3( itype_test_mp3 );
            item backpack( itype_test_backpack );
            item duffelbag( itype_test_duffelbag );

            backpack.put_in( mp3, pocket_type::CONTAINER );
            duffelbag.put_in( backpack, pocket_type::CONTAINER );

            REQUIRE( guy.wield( duffelbag ) );

            THEN( "should get wet from water" ) {
                g->water_affect_items( guy );
                const item *test_item = guy.get_wielded_item()->all_items_top().front()->all_items_top().front();
                REQUIRE( test_item->typeId() == itype_test_mp3 );
                CHECK( test_item->wetness > 0 );
            }
        }

        WHEN( "item in backpack inside body bag" ) {
            guy.unwield();
            guy.clear_worn();

            item mp3( itype_test_mp3 );
            item backpack( itype_test_backpack );
            item body_bag( itype_test_waterproof_bag );

            backpack.put_in( mp3, pocket_type::CONTAINER );
            body_bag.put_in( backpack, pocket_type::CONTAINER );

            REQUIRE( guy.wield( body_bag ) );

            THEN( "should not be broken by water" ) {
                g->water_affect_items( guy );
                const item *test_item = guy.get_wielded_item()->all_items_top().front()->all_items_top().front();
                REQUIRE( test_item->typeId() == itype_test_mp3 );
                CHECK( test_item->wetness == 0 );
            }
        }

        WHEN( "item in hand" ) {
            guy.unwield();
            guy.clear_worn();

            item mp3( itype_test_mp3 );

            REQUIRE( guy.wield( mp3 ) );

            THEN( "should be wet for around 9562 seconds" ) {
                g->water_affect_items( guy );
                CHECK( guy.get_wielded_item()->wetness == Approx( 9562 ).margin( 20 ) );
            }
        }

        WHEN( "item in hand" ) {
            guy.unwield();
            guy.clear_worn();

            item mp3( itype_test_mp3 );

            REQUIRE( guy.wield( mp3 ) );

            THEN( "gets wet five times in a row " ) {
                g->water_affect_items( guy );
                g->water_affect_items( guy );
                g->water_affect_items( guy );
                g->water_affect_items( guy );
                g->water_affect_items( guy );
                AND_THEN( "should be wet for around 47810 seconds" ) {
                    CHECK( guy.get_wielded_item()->wetness == Approx( 47810 ).margin( 100 ) );
                }
            }
        }
    }

    GIVEN( "a towel" ) {

        WHEN( "item in hand" ) {
            guy.unwield();
            guy.clear_worn();

            item towel( itype_towel );

            REQUIRE( guy.wield( towel ) );

            THEN( "should get wet in water" ) {
                g->water_affect_items( guy );
                CHECK( guy.has_item_with_flag( flag_WET ) );
            }
        }

        WHEN( "wearing item" ) {
            guy.unwield();
            guy.clear_worn();

            item towel( itype_towel );

            REQUIRE( guy.wear_item( towel ) );

            THEN( "should get wet in water" ) {
                g->water_affect_items( guy );
                CHECK( guy.has_item_with_flag( flag_WET ) );
            }
        }

        WHEN( "inside a backpack" ) {
            guy.unwield();
            guy.clear_worn();

            item towel( itype_towel );
            item backpack( itype_backpack );

            backpack.put_in( towel, pocket_type::CONTAINER );

            REQUIRE( guy.wield( backpack ) );

            THEN( "should get wet in water" ) {
                g->water_affect_items( guy );
                CHECK( guy.has_item_with_flag( flag_WET ) );
            }
        }

        WHEN( "inside a body bag" ) {
            guy.unwield();
            guy.clear_worn();

            item towel( itype_towel );
            item body_bag( itype_test_waterproof_bag );

            body_bag.put_in( towel, pocket_type::CONTAINER );

            REQUIRE( guy.wield( body_bag ) );

            THEN( "should not get wet in water" ) {
                g->water_affect_items( guy );
                CHECK_FALSE( guy.has_item_with_flag( flag_WET ) );
            }
        }
    }
}


TEST_CASE( "item_new_to_hit_enforcement", "[item]" )
{
    std::vector<const itype *> all_items = item_controller->all();
    const std::set<itype_id> &blacklist = test_data::legacy_to_hit;
    std::string msg_enforce;
    std::string msg_prune;
    for( const itype *type : all_items ) {
        const bool on_blacklist = blacklist.find( type->get_id() ) != blacklist.end();
        if( type->using_legacy_to_hit ) {
            if( !on_blacklist ) {
                msg_enforce += msg_enforce.empty() ? string_format( "\n[\n  \"%s\"", type->get_id().str() ) :
                               string_format( ",\n  \"%s\"", type->get_id().str() );
            }
        } else if( on_blacklist ) {
            msg_prune += msg_prune.empty() ? string_format( "\n[\n  \"%s\"", type->get_id().str() ) :
                         string_format( ",\n  \"%s\"", type->get_id().str() );
        }
    }
    if( !msg_enforce.empty() ) {
        msg_enforce +=
            "\n]\nThe item(s) above use legacy to_hit, please change them to the newer object method (see /docs/design-balance-lore/GAME_BALANCE.md#to-hit-value) or remove the to_hit field if the item(s) aren't intended to be used as weapons.";
    }
    if( !msg_prune.empty() ) {
        msg_prune +=
            "\n]\nThe item(s) above should be removed from the blacklist at /data/mods/TEST_DATA/legacy_to_hit.json.";
    }
    CAPTURE( msg_enforce );
    REQUIRE( msg_enforce.empty() );
    CAPTURE( msg_prune );
    REQUIRE( msg_prune.empty() );
}

static float max_density_for_mats( const std::map<material_id, int> &mats, float total_size )
{
    REQUIRE( !mats.empty() );

    float max_density = 0.f;

    for( const auto &m : mats ) {
        max_density += m.first->density() * ( m.second  / total_size );
    }

    return max_density;
}

static float item_density( const item &target )
{
    return static_cast<float>( to_milligram( target.weight() ) / 1000.0f ) / static_cast<float>
           ( to_milliliter( target.volume() ) );
}

static void assert_maximum_density_for_material( const item &target )
{
    if( to_milliliter( target.volume() ) == 0 ) {
        return;
    }
    const std::map<material_id, int> &mats = target.made_of();
    if( !mats.empty() && test_data::known_bad.count( target.typeId() ) == 0 ) {
        const float max_density = max_density_for_mats( mats, target.type->mat_portion_total );
        CAPTURE( target.typeId(), target.weight(), target.volume() );
        CHECK( item_density( target ) <= max_density );
    }
}

TEST_CASE( "item_material_density_sanity_check", "[item]" )
{
    std::vector<const itype *> all_items = item_controller->all();

    for( const itype *type : all_items ) {
        const item sample( type, calendar::turn_zero, item::solitary_tag{} );
        assert_maximum_density_for_material( sample );
    }
}

TEST_CASE( "item_material_density_blacklist_is_pruned", "[item]" )
{
    for( const itype_id &bad : test_data::known_bad ) {
        if( !bad.is_valid() ) {
            continue;
        }
        const item target( bad, calendar::turn_zero, item::solitary_tag{} );
        if( to_milliliter( target.volume() ) == 0 ) {
            continue;
        }
        const std::map<material_id, int> &mats = target.made_of();
        if( !mats.empty() ) {
            INFO( string_format( "%s had its density fixed, remove it from the list in data/mods/TEST_DATA/known_bad_density.json",
                                 bad.str() ) );
            const float max_density = max_density_for_mats( mats, bad->mat_portion_total );
            CHECK( item_density( target ) > max_density );
        }
    }
}

TEST_CASE( "armor_entry_consolidate_check", "[item][armor]" )
{
    item test_consolidate( itype_test_consolidate );

    //check this item has a single armor entry, not 3 like is written in the json explicitly

    CHECK( test_consolidate.find_armor_data()->sub_data.size() == 1 );
}

TEST_CASE( "module_inheritance", "[item][armor]" )
{
    avatar &guy = get_avatar();
    clear_avatar();
    guy.set_body();
    guy.clear_mutations();
    guy.clear_worn();

    item test_exo( itype_test_modular_exosuit );
    item test_module( itype_test_exo_lense_module );

    test_exo.force_insert_item( test_module, pocket_type::CONTAINER );

    guy.worn.wear_item( guy, test_exo, false, false, false );

    CHECK( guy.worn.worn_with_flag( json_flag_FIX_NEARSIGHT ) );

    clear_avatar();
    item hat_hard( itype_hat_hard );
    item ear_muffs( itype_attachable_ear_muffs );
    REQUIRE( hat_hard.put_in( ear_muffs, pocket_type::CONTAINER ).success() );
    REQUIRE( !hat_hard.has_flag( json_flag_DEAF ) );
    guy.wear_item( hat_hard );
    item_location worn_hat = guy.worn.top_items_loc( guy ).front();
    item_location worn_muffs( worn_hat, &worn_hat->only_item() );
    avatar_action::use_item( guy, worn_muffs, "transform" );
    CHECK( worn_hat->has_flag( json_flag_DEAF ) );
}

TEST_CASE( "worn_exoskeleton_transform_refreshes_encumbrance", "[item][armor][transform]" )
{
    clear_avatar();
    avatar &guy = get_avatar();
    const std::string suit = GENERATE( std::string( "combat_exoskeleton_heavy" ),
                                       std::string( "combat_exoskeleton_medium" ),
                                       std::string( "combat_exoskeleton_light" ) );
    CAPTURE( suit );
    guy.wear_item( item( itype_id( suit ) ) );
    REQUIRE( guy.worn.top_items_loc( guy ).size() == 1 );
    item_location worn_suit = guy.worn.top_items_loc( guy ).front();
    const bodypart_id torso( "torso" );
    const int inactive_encumbrance = guy.get_part_encumbrance( torso );

    item_transformation turn_on;
    turn_on.target = itype_id( suit + "_on" );
    // Activated transformations must retain the worn item for their caller.
    turn_on.transform( &guy, *worn_suit, true );
    REQUIRE( guy.is_worn( *worn_suit ) );
    const int active_encumbrance = guy.get_part_encumbrance( torso );
    CHECK( active_encumbrance < inactive_encumbrance );
    guy.calc_encumbrance();
    CHECK( guy.get_part_encumbrance( torso ) == active_encumbrance );

    item_transformation turn_off;
    turn_off.target = itype_id( suit );
    turn_off.transform( &guy, *worn_suit, true );
    CHECK( guy.get_part_encumbrance( torso ) == inactive_encumbrance );
}

TEST_CASE( "rigid_armor_compliance", "[item][armor]" )
{
    avatar &guy = get_avatar();
    clear_avatar();
    // check if you can swap a rigid armor
    item test_armguard( itype_test_armguard );
    REQUIRE( guy.wield( test_armguard ) );

    REQUIRE( guy.wear( guy.used_weapon(), false ) );

    CHECK( guy.worn.top_items_loc( guy ).front().get_item()->get_side() == side::LEFT );

    guy.change_side( *guy.worn.top_items_loc( guy ).front().get_item() );

    CHECK( guy.worn.top_items_loc( guy ).front().get_item()->get_side() == side::RIGHT );

    // check if you can't wear 3 rigid armors
    clear_avatar();

    item first_test_armguard( itype_test_armguard );
    REQUIRE( guy.wield( first_test_armguard ) );
    REQUIRE( guy.wear( guy.used_weapon(), false ) );

    item second_test_armguard( itype_test_armguard );
    REQUIRE( guy.wield( second_test_armguard ) );
    REQUIRE( guy.wear( guy.used_weapon(), false ) );

    item third_test_armguard( itype_test_armguard );
    REQUIRE( guy.wield( third_test_armguard ) );
    REQUIRE( !guy.wear( guy.used_weapon(), false ) );
}

TEST_CASE( "one_per_layer_sided_armor_compliance", "[item][armor]" )
{
    avatar &guy = get_avatar();
    clear_avatar();

    item first_ring( itype_test_one_per_layer_ring_a );
    REQUIRE( guy.wield( first_ring ) );
    REQUIRE( guy.wear( guy.used_weapon(), false ) );
    CHECK( guy.worn.is_wearing_on_bp( first_ring.typeId(), bodypart_id( "hand_l" ) ) );
    CHECK_FALSE( guy.worn.is_wearing_on_bp( first_ring.typeId(), bodypart_id( "hand_r" ) ) );

    item &worn_first_ring = *guy.worn.top_items_loc( guy ).front();
    REQUIRE( guy.change_side( worn_first_ring, false ) );
    CHECK( worn_first_ring.get_side() == side::RIGHT );
    REQUIRE( guy.change_side( worn_first_ring, false ) );
    CHECK( worn_first_ring.get_side() == side::LEFT );

    item second_ring( itype_test_one_per_layer_ring_b );
    REQUIRE( guy.wield( second_ring ) );
    REQUIRE( guy.wear( guy.used_weapon(), false ) );
    CHECK( guy.worn.is_wearing_on_bp( second_ring.typeId(), bodypart_id( "hand_r" ) ) );
    CHECK_FALSE( guy.worn.is_wearing_on_bp( second_ring.typeId(), bodypart_id( "hand_l" ) ) );

    item third_ring( itype_test_one_per_layer_ring_c );
    REQUIRE( guy.wield( third_ring ) );
    REQUIRE( !guy.wear( guy.used_weapon(), false ) );
}

TEST_CASE( "rigid_splint_compliance", "[item][armor]" )
{
    avatar &guy = get_avatar();
    clear_avatar();

    item test_armguard( itype_test_armguard );
    item second_test_armguard( itype_test_armguard );
    item splint( itype_arm_splint );
    item second_splint( itype_arm_splint );
    item third_splint( itype_arm_splint );

    // check if you can wear a splint
    clear_avatar();

    guy.set_part_hp_cur( bodypart_id( "arm_r" ), 0 );
    REQUIRE( guy.wield( splint ) );
    REQUIRE( guy.wear( guy.used_weapon(), false ) );

    // check if you cannot wear a splint if something rigid is on that arm
    clear_avatar();

    REQUIRE( guy.wield( test_armguard ) );
    guy.set_part_hp_cur( bodypart_id( "arm_r" ), 0 );
    REQUIRE( guy.wear( guy.used_weapon(), false ) );

    CHECK( guy.worn.top_items_loc( guy ).front().get_item()->get_side() == side::LEFT );
    // swap side to the broken arm side
    guy.change_side( *guy.worn.top_items_loc( guy ).front().get_item() );
    // should fail to wear
    REQUIRE( guy.wield( second_splint ) );
    REQUIRE( !guy.wear( guy.used_weapon(), false ) );

    // check if you can wear a splint if nothing rigid is on that arm
    clear_avatar();

    REQUIRE( guy.wield( second_test_armguard ) );
    guy.set_part_hp_cur( bodypart_id( "arm_r" ), 0 );
    REQUIRE( guy.wear( guy.used_weapon(), false ) );

    CHECK( guy.worn.top_items_loc( guy ).front().get_item()->get_side() == side::LEFT );

    // should be able to wear the arm is open
    REQUIRE( guy.wield( third_splint ) );
    REQUIRE( guy.wear( guy.used_weapon(), false ) );
}

TEST_CASE( "item_single_type_contents", "[item]" )
{
    item rock( itype_test_rock );
    std::array<std::string, 2> const variants = { "test_rock_blue", "test_rock_green" };
    item walnut( itype_walnut );
    item bag( itype_bag_plastic );
    REQUIRE( bag.get_category_of_contents().id == item_category_container );
    int const num = GENERATE( 1, 2 );
    bool ret = true;
    for( int i = 0; i < num; i++ ) {
        rock.set_itype_variant( variants[i] );
        ret &= bag.put_in( rock, pocket_type::CONTAINER ).success();
    }
    REQUIRE( ret );
    CAPTURE( num, bag.display_name() );
    CHECK( bag.get_category_of_contents() == *item_category_spare_parts );
    REQUIRE( walnut.get_category_of_contents().id != rock.get_category_of_contents().id );
    REQUIRE( bag.put_in( walnut, pocket_type::CONTAINER ).success() );
    if( num == 1 ) {
        // 1 rock and 1 walnut - nothing dominates
        CHECK( bag.get_category_of_contents().id == item_category_container );
    } else {
        // 2 rock and 1 walnuts - rocks dominate
        CHECK( bag.get_category_of_contents().id == item_category_spare_parts );
        REQUIRE( bag.put_in( walnut, pocket_type::CONTAINER ).success() );
        item hammer( itype_hammer );
        REQUIRE( hammer.get_category_of_contents().id != rock.get_category_of_contents().id );
        REQUIRE( hammer.get_category_of_contents().id != walnut.get_category_of_contents().id );
        REQUIRE( bag.put_in( hammer, pocket_type::CONTAINER ).success() );
        // no dominant category anymore - revert to container
        CHECK( bag.get_category_of_contents().id == item_category_container );
    }

    SECTION( "clothing" ) {
        item jeans( itype_jeans );
        REQUIRE( jeans.get_category_of_contents().id == item_category_clothing );
        REQUIRE( walnut.get_category_of_contents().id == item_category_food );
        REQUIRE( jeans.put_in( walnut, pocket_type::CONTAINER ).success() );
        CHECK( jeans.get_category_of_contents().id == item_category_clothing );
    }

    SECTION( "software" ) {
        item usb_drive( itype_usb_drive );
        item software_hacking( itype_software_hacking );
        REQUIRE( usb_drive.get_category_of_contents().id == item_category_tools );
        REQUIRE( usb_drive.put_in( software_hacking, pocket_type::E_FILE_STORAGE ).success() );
        CHECK( usb_drive.get_category_of_contents().id == item_category_tools );
    }
}

TEST_CASE( "item_nested_contents", "[item]" )
{
    item walnut( itype_walnut );
    item outer_bag( itype_bag_plastic );
    item inner_bag1( itype_bag_plastic );
    item inner_bag2( itype_bag_plastic );

    REQUIRE( inner_bag1.put_in( walnut, pocket_type::CONTAINER ).success() );
    REQUIRE( inner_bag1.put_in( walnut, pocket_type::CONTAINER ).success() );
    CHECK( inner_bag1.get_category_of_contents().id == item_category_food );

    REQUIRE( inner_bag2.put_in( walnut, pocket_type::CONTAINER ).success() );
    CHECK( inner_bag2.get_category_of_contents().id == item_category_food );

    REQUIRE( outer_bag.put_in( inner_bag1, pocket_type::CONTAINER ).success() );
    REQUIRE( outer_bag.put_in( inner_bag2, pocket_type::CONTAINER ).success() );
    CAPTURE( outer_bag.display_name() );
    // outer_bag
    //   inner_bag1
    //     walnut
    //     walnut
    //   inner_bag2
    //     walnut
    CHECK( outer_bag.get_category_of_contents().id == item_category_food );
}

TEST_CASE( "item_rotten_contents", "[item]" )
{
    item wrapper( itype_wrapper );
    REQUIRE( wrapper.get_category_of_contents().id == item_category_container );

    item butter_rotten( itype_butter );
    butter_rotten.set_relative_rot( 1.01 );
    REQUIRE( wrapper.put_in( butter_rotten, pocket_type::CONTAINER ).success() );
    REQUIRE( wrapper.put_in( butter_rotten, pocket_type::CONTAINER ).success() );
    CAPTURE( wrapper.display_name() );
    CHECK( wrapper.get_category_of_contents().id == item_category_food );

    item butter( itype_butter );
    butter.set_relative_rot( 0.5 );
    REQUIRE( wrapper.put_in( butter, pocket_type::CONTAINER ).success() );
    CAPTURE( wrapper.display_name() );
    // wrapper
    //   butter (rotten)
    //   butter (rotten)
    //   butter
    CHECK( wrapper.get_category_of_contents().id == item_category_food );
}

TEST_CASE( "item_relative_rot_after_is_non_mutating", "[item][rot]" )
{
    item butter( itype_butter );
    butter.set_relative_rot( 0.5 );
    const double initial_rot = butter.get_relative_rot();

    const double simulated_rot = butter.get_relative_rot_after( temperatures::normal, 1.0f,
        1_hours );

    CHECK( butter.get_relative_rot() == initial_rot );
    CHECK( simulated_rot > initial_rot );
}

static bool uncraft_need_to_be_checked( const item &it )
{
    // skip items that do not have uncraft
    if( it.get_uncraft_components().empty() ) {
        return false;
    }

    // skip specifically these mod stuff
    if( it.type->src.back().second == MOD_INFORMATION_test_data ) {
        return false;
    }

    // ethereal, technical, mutation related item etc stuff are skipped even if have uncraft
    if( it.type->weight == 0_gram ||
        it.type->volume == 0_ml ||
        it.type->has_flag( flag_INTEGRATED ) ||
        it.type->has_flag( flag_NO_TAKEOFF ) ||
        it.type->has_flag( flag_AURA ) ||
        it.type->has_flag( flag_PERSONAL ) ) {
        return false;
    }
    return true;
}

// checks only items that have some uncraft, either manually defined or reversible craft
TEST_CASE( "uncraft_sanity_check", "[item]" )
{
    std::vector<const itype *> all_items = item_controller->all();

    // this specifies the precision of a crafting test
    // 0.1 means 1000 g item can drop from 900 g to 1100 g of resources
    const float tolerance = 0.1f;

    for( const itype *type : all_items ) {

        // skip if already know it's bad
        const bool in_list = test_data::known_bad_uncraft.count( type->id ) != 0;
        if( in_list ) {
            continue;
        }

        const item target( type, calendar::turn_zero, item::solitary_tag{} );

        if( !uncraft_need_to_be_checked( target ) ) {
            continue;
        }

        units::mass sum_of_components_weight;
        for( const item_comp &c : target.get_uncraft_components() ) {
            sum_of_components_weight += c.type->weight * c.count;
        }

        const units::mass item_weight = target.type->weight;
        const units::mass weight_difference = units::abs( sum_of_components_weight - item_weight );
        const units::mass weight_tolerance = tolerance * item_weight;
        const bool is_within_tolerance = weight_difference <= weight_tolerance;

        if( !is_within_tolerance ) {
            INFO( string_format( "Item %s weight %d gram, but it's uncrafting recipe (including crafting with 'reversible: true') has components with total weight of %d gram.  It should be within %.0f%%.",
                                 target.typeId().str(), to_gram( item_weight ),
                                 to_gram( sum_of_components_weight ), tolerance * 100.f ) );
            CHECK( is_within_tolerance );
        }
    }
}

TEST_CASE( "repaired_uncraft_recipes_conserve_mass", "[item][recipe]" )
{
    for( const itype_id &type : {
             itype_tire_repair_kit, itype_down_mattress
         } ) {
        CAPTURE( type );
        REQUIRE( type.is_valid() );
        REQUIRE( test_data::known_bad_uncraft.count( type ) == 0 );
        const item target( type );
        const std::vector<item_comp> components = target.get_uncraft_components();
        REQUIRE_FALSE( components.empty() );
        units::mass component_mass;
        for( const item_comp &component : components ) {
            component_mass += component.type->weight * component.count;
        }
        REQUIRE( component_mass > 0_gram );
        CHECK( units::abs( component_mass - type->weight ) <= type->weight * 0.1f );
    }
}

TEST_CASE( "uncraft_blacklist_is_pruned", "[item]" )
{
    std::string list;
    // this specifies the precision of a crafting test
    // 0.1 means 1000 g item can drop from 900 g to 1100 g of resources
    const float tolerance = 0.1f;

    for( const itype_id &bad : test_data::known_bad_uncraft ) {

        if( !bad.is_valid() ) {
            continue;
        }

        const units::mass item_weight = bad->weight;
        const item target( bad, calendar::turn_zero, item::solitary_tag{} );

        if( target.get_uncraft_components().empty() ) {
            INFO( string_format( "Item '%s' do not have uncraft anymore, remove it from data/mods/TEST_DATA/known_bad_uncrafts.json",
                                 bad.str() ) );
            CHECK( false );
            continue;
        }

        units::mass sum_of_components_weight;
        for( const item_comp &c : target.get_uncraft_components() ) {
            sum_of_components_weight += c.type->weight * c.count;
        }
        const units::mass weight_difference = units::abs( sum_of_components_weight - item_weight );
        const units::mass weight_tolerance = tolerance * item_weight;
        const bool is_within_tolerance = weight_difference <= weight_tolerance;

        if( is_within_tolerance ) {
            INFO( string_format( "%s had its uncrafting recipe fixed, remove it from the list in data/mods/TEST_DATA/known_bad_uncrafts.json",
                                 bad.str() ) );
            CHECK_FALSE( is_within_tolerance );
        }
    }
}

namespace merged_item_action_keybindings_test
{

TEST_CASE( "item_action_info_scroll_bindings", "[input][keybindings][upstream_ports]" )
{
    input_context ctxt( "UILIST" );
    ctxt.register_action( "SCROLL_ITEM_INFO_UP" );
    ctxt.register_action( "SCROLL_ITEM_INFO_DOWN" );
    const bool down = GENERATE( false, true );
    const std::string action = down ? "SCROLL_ITEM_INFO_DOWN" : "SCROLL_ITEM_INFO_UP";
    CHECK( ctxt.input_to_action( input_event( down ? '}' : '{',
            input_event_t::keyboard_char ) ) == action );
    CHECK( ctxt.input_to_action( input_event( { keymod_t::shift }, down ? ']' : '[',
            input_event_t::keyboard_code ) ) == action );
    CHECK( ctxt.input_to_action( input_event( down ? JOY_ALT_DOWN : JOY_ALT_UP,
            input_event_t::gamepad ) ) == action );
}

} // namespace merged_item_action_keybindings_test

namespace merged_item_charge_merge_test
{

static const itype_id itype_copper( "copper" );
static const itype_id itype_lead( "lead" );
static const itype_id itype_string_6( "string_6" );

TEST_CASE( "inventory_restack_preserves_unmergeable_charge_stacks", "[item][stacking][charges]" )
{
    clear_avatar();
    Character &character = get_player_character();
    inventory &inv = *character.inv;
    item lhs( itype_string_6, calendar::turn, 10 );
    item rhs = lhs;
    SECTION( "different_damage_in_same_display_bucket" ) {
        lhs.force_set_damage( 1001 );
        rhs.force_set_damage( 1002 );
    }
    SECTION( "different_crafting_components" ) {
        item lead( itype_lead, calendar::turn, 1 );
        item copper( itype_copper, calendar::turn, 1 );
        lhs.components.add( lead );
        rhs.components.add( copper );
    }
    REQUIRE( lhs.stacks_with( rhs ) );
    REQUIRE_FALSE( lhs.merge_charges( rhs ) );
    inv.add_item( lhs, false, true, false );
    inv.add_item( rhs, false, true, false );
    REQUIRE( inv.size() == 2 );

    inv.restack( character );

    REQUIRE( inv.size() == 2 );
    int total_charges = 0;
    for( const std::list<item> *stack : inv.const_slice() ) {
        REQUIRE( stack->size() == 1 );
        const item &remaining = stack->front();
        CHECK( remaining.charges == 10 );
        CHECK( ( remaining.damage() == lhs.damage() || remaining.damage() == rhs.damage() ) );
        total_charges += remaining.charges;
    }
    CHECK( total_charges == 20 );
}

TEST_CASE( "physical_stack_merging_preserves_item_state", "[item][stacking][charges]" )
{
    item lhs( itype_string_6, calendar::turn, 10 );
    REQUIRE( lhs.count_by_charges() );
    REQUIRE( lhs.max_damage() > 1002 );
    item rhs = lhs;
    SECTION( "different_damage_in_same_display_bucket" ) {
        lhs.force_set_damage( 1001 );
        rhs.force_set_damage( 1002 );
        REQUIRE( lhs.damage() != rhs.damage() );
        REQUIRE( lhs.damage_level() == rhs.damage_level() );
    }
    SECTION( "different_crafting_components" ) {
        item lead( itype_lead, calendar::turn, 1 );
        item copper( itype_copper, calendar::turn, 1 );
        lhs.components.add( lead );
        rhs.components.add( copper );
        REQUIRE( lhs.get_uncraft_components() != rhs.get_uncraft_components() );
    }
    SECTION( "identical_items_split_and_merge_without_quantity_loss" ) {
        item part = lhs.split( 3 );
        REQUIRE( part.charges == 3 );
        REQUIRE( lhs.charges == 7 );
        REQUIRE( lhs.merge_charges( part ) );
        CHECK( lhs.charges == 10 );
        return;
    }
    REQUIRE( lhs.stacks_with( rhs ) );
    CHECK_FALSE( lhs.merge_charges( rhs ) );
    CHECK_FALSE( lhs.combine( rhs ) );
    CHECK( lhs.charges == 10 );
    CHECK( rhs.charges == 10 );
}

} // namespace merged_item_charge_merge_test

namespace merged_item_pocket_restore_test
{

static const itype_id itype_battery( "battery" );
static const itype_id itype_light_battery_cell( "light_battery_cell" );

TEST_CASE( "battery_restore_remaps_pockets_without_losing_state", "[item][pocket][save]" )
{
    const itype_id battery_id( GENERATE( "heavy_battery_cell", "heavy_plus_battery_cell" ) );
    pocket_data heavy( pocket_type::MAGAZINE_WELL );
    heavy.item_id_restriction.insert( battery_id );
    heavy.max_item_length = 1_meter;
    const std::vector<pocket_data> old_pockets = { heavy };
    item_contents original( old_pockets );
    item battery( battery_id );
    battery.ammo_set( itype_battery, 123 );
    battery.set_var( "item_label", "saved battery" );
    battery.set_favorite( true );
    REQUIRE( original.insert_item( battery, pocket_type::MAGAZINE_WELL ).success() );
    std::ostringstream stream;
    JsonOut json( stream );
    original.serialize( json );
    item_contents loaded;
    loaded.deserialize( json_loader::from_string( stream.str() ).get_object() );

    pocket_data light( pocket_type::MAGAZINE_WELL );
    light.item_id_restriction.insert( itype_light_battery_cell );
    light.max_item_length = 1_meter;
    std::vector<pocket_data> new_pockets;
    bool compatible = false;
    SECTION( "same_type_pockets_have_changed_order" ) {
        new_pockets = { light, heavy };
        compatible = true;
    }
    SECTION( "removed_battery_well_preserves_the_battery_for_migration" ) {
        new_pockets = { pocket_data( pocket_type::CONTAINER ) };
    }
    new_pockets.emplace_back( pocket_type::MIGRATION );
    item_contents restored( new_pockets );
    const std::string diagnostics = capture_debugmsg_during( [&restored, &loaded]() {
        restored.combine( std::move( loaded ), false, true, false, true );
    } );
    CHECK( diagnostics.empty() );
    const auto batteries = restored.all_items_top( compatible ? pocket_type::MAGAZINE_WELL :
        pocket_type::MIGRATION );
    REQUIRE( batteries.size() == 1 );
    CHECK( batteries.front()->typeId() == battery_id );
    CHECK( batteries.front()->ammo_remaining() == 123 );
    CHECK( batteries.front()->get_var( "item_label" ) == "saved battery" );
    CHECK( batteries.front()->is_favorite );
    CHECK( batteries.front()->uid() ==
           original.all_items_top( pocket_type::MAGAZINE_WELL ).front()->uid() );
    CHECK( restored.all_items_top( pocket_type::MAGAZINE_WELL ).size() +
           restored.all_items_top( pocket_type::MIGRATION ).size() == 1 );
}

} // namespace merged_item_pocket_restore_test

namespace merged_item_rng_test
{

TEST_CASE( "item_reconstruction_does_not_advance_gameplay_rng", "[item_rng][regression]" )
{
    const item source( itype_id( "rock" ) );
    std::ostringstream text;
    JsonOut out( text );
    source.serialize( out );
    const auto before = rng_get_engine();
    item replica;
    CHECK( rng_get_engine() == before );
    JsonValue value = json_loader::from_string( text.str() );
    replica.deserialize( value.get_object() );
    CHECK( rng_get_engine() == before );
    CHECK( replica.typeId() == source.typeId() );
    CHECK( replica.uid().get_value() == source.uid().get_value() );
    CHECK( replica.charges == source.charges );
}

TEST_CASE( "visual_choices_do_not_advance_gameplay_rng", "[item_rng][regression]" )
{
    const auto before = rng_get_engine();
    for( int i = 0; i < 16; ++i ) {
        const int choice = rng_visual( 7, -2 );
        CHECK( ( choice >= -2 && choice <= 7 ) );
    }
    CHECK( rng_visual( 11, 11 ) == 11 );
    CHECK( rng_get_engine() == before );
}

} // namespace merged_item_rng_test

namespace merged_item_stackable_test
{

TEST_CASE( "non-solid-comestibles-are-stackable", "[item]" )
{
    for( const itype *t :  item_controller->all() ) {
        if( t->comestible && t->phase != phase_id::SOLID ) {
            INFO( "liquid: " << t->get_id().str() )
            CHECK( t->count_by_charges() );
        }
    }
}

} // namespace merged_item_stackable_test

namespace merged_item_tick_action_test
{

static const itype_id itype_chainsaw_off( "chainsaw_off" );
static const itype_id itype_chainsaw_on( "chainsaw_on" );

TEST_CASE( "tick_action_triggering", "[item]" )
{
    item chainsaw( itype_chainsaw_on );
    chainsaw.active = true;

    // The chainsaw has no fuel and turns off via its tick_action

    chainsaw.process( get_map(), nullptr, tripoint_bub_ms::zero );
    CHECK( chainsaw.typeId() == itype_chainsaw_off );
    CHECK( chainsaw.active == false );
}

} // namespace merged_item_tick_action_test
