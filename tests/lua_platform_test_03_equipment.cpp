#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

namespace
{

struct platform_equipment_fixture {
    explicit platform_equipment_fixture( const std::size_t runtime_number,
                                         const std::size_t world_number,
                                         const int actor_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        actor.normalize();
        actor.setID( character_id( actor_number ), true );
        actor_handle = cata::lua_platform::game_handle::from_creature(
                           actor,
                           { "avatar", actor.getID().get_value(), 0, 0, 0, {} },
                           runtime, active_world_generation );

        services = lua.create_table();
        cata::lua_platform::install_game_handle_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_item_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
    }

    sol::table holder( const cata::lua_platform::game_handle &character,
                       const std::string &slot = "inventory" ) {
        sol::table result = lua.create_table();
        result["kind"] = "character";
        result["character"] = character;
        result["slot"] = slot;
        return result;
    }

    item *add_item( const itype_id &id ) {
        item value( id, calendar::turn_zero );
        return &actor.inv->add_item(
                   std::move( value ), false, false, false );
    }

    item *add_worn_item( const itype_id &id ) {
        item value( id, calendar::turn_zero );
        const auto worn = actor.wear_item(
                              value, false, false, true, true );
        if( !worn ) {
            return nullptr;
        }
        const auto worn_iterator = *worn;
        return std::addressof( *worn_iterator );
    }

    cata::lua_platform::game_handle item_handle(
        item &value, const std::string &scope = "character_inventory" ) const {
        return cata::lua_platform::game_handle::from_item(
                   value,
                   { scope, value.uid().get_value(), 0, 0, 0, {} },
                   runtime, active_world_generation );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    avatar actor;
    cata::lua_platform::game_handle actor_handle;
    sol::state lua;
    sol::table services;
    bool write_called = false;
};

TEST_CASE( "lua_platform_equipment_wield_inventory_to_wield",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 201, 1, 6201 );
    item *source_item = fixture.add_item( itype_id( "rock" ) );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::protected_function_result result = wield(
            fixture.actor_handle, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    CHECK( envelope["value"].get<sol::table>()["operation"].get<std::string>() ==
           "wield" );
    CHECK( fixture.actor.has_weapon() );
    CHECK( source_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_wear_inventory_to_worn",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 202, 1, 6202 );
    item *source_item = fixture.add_item( itype_id( "backpack" ) );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wear =
        fixture.services["equipment"]["wear"];

    const sol::protected_function_result result = wear(
            fixture.actor_handle, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    const cata::lua_platform::game_handle worn_handle =
        value["handle"].get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> worn =
        worn_handle.resolve_item( fixture.active_runtime,
                                  fixture.active_world_generation );
    REQUIRE( static_cast<bool>( worn ) );
    CHECK( fixture.actor.is_worn( *worn.value ) );
    CHECK( source_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_takeoff_to_explicit_holder",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 203, 1, 6203 );
    item *worn_item = fixture.add_worn_item( itype_id( "backpack" ) );
    REQUIRE( worn_item != nullptr );
    const cata::lua_platform::game_handle worn_handle =
        fixture.item_handle( *worn_item, "character_worn" );
    const sol::protected_function unequip =
        fixture.services["equipment"]["unequip"];

    const sol::protected_function_result result = unequip(
            fixture.actor_handle, worn_handle,
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const cata::lua_platform::game_handle moved_handle =
        envelope["value"].get<sol::table>()["handle"]
        .get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> moved =
        moved_handle.resolve_item( fixture.active_runtime,
                                   fixture.active_world_generation );
    REQUIRE( static_cast<bool>( moved ) );
    CHECK( !fixture.actor.is_wearing( itype_id( "backpack" ) ) );
    CHECK( fixture.actor.has_item( *moved.value ) );
    CHECK( worn_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_unwield_to_explicit_holder",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 204, 1, 6204 );
    item wielded_value( itype_id( "rock" ), calendar::turn_zero );
    REQUIRE( fixture.actor.Character::wield( wielded_value, std::nullopt, false ) );
    item_location wielded_location = fixture.actor.get_wielded_item();
    REQUIRE( wielded_location );
    item *wielded_item = wielded_location.get_item();
    REQUIRE( wielded_item != nullptr );
    const cata::lua_platform::game_handle wielded_handle =
        fixture.item_handle( *wielded_item, "character_wielded" );
    const sol::protected_function unequip =
        fixture.services["equipment"]["unequip"];

    const sol::protected_function_result result = unequip(
            fixture.actor_handle, wielded_handle,
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const cata::lua_platform::game_handle moved_handle =
        envelope["value"].get<sol::table>()["handle"]
        .get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> moved =
        moved_handle.resolve_item( fixture.active_runtime,
                                   fixture.active_world_generation );
    REQUIRE( static_cast<bool>( moved ) );
    CHECK_FALSE( fixture.actor.has_weapon() );
    CHECK( fixture.actor.has_item( *moved.value ) );
    CHECK( wielded_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_atomic_swap",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 205, 1, 6205 );
    item old_value( itype_id( "rock" ), calendar::turn_zero );
    REQUIRE( fixture.actor.Character::wield( old_value, std::nullopt, false ) );
    item_location old_location = fixture.actor.get_wielded_item();
    REQUIRE( old_location );
    const std::int64_t old_uid = old_location->uid().get_value();
    item *next_item = fixture.add_item( itype_id( "stick" ) );
    REQUIRE( next_item != nullptr );
    const cata::lua_platform::game_handle next_handle =
        fixture.item_handle( *next_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::protected_function_result result = wield(
            fixture.actor_handle, next_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( fixture.actor.has_weapon() );
    CHECK( fixture.actor.get_wielded_item()->typeId() == itype_id( "stick" ) );
    CHECK( value["displaced_count"].get<std::size_t>() == 1 );
    const sol::table displaced = value["displaced"].get<sol::table>()[1];
    CHECK( displaced["source_uid"].get<std::int64_t>() == old_uid );
    const cata::lua_platform::game_handle displaced_handle =
        displaced["handle"].get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> displaced_item =
        displaced_handle.resolve_item( fixture.active_runtime,
                                       fixture.active_world_generation );
    REQUIRE( static_cast<bool>( displaced_item ) );
    CHECK( displaced_item.value->typeId() == itype_id( "rock" ) );
    CHECK( fixture.actor.has_item( *displaced_item.value ) );
    CHECK( next_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_conflict_destination_rollback",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 206, 1, 6206 );
    const itype_id single_worn_pack( "backpack_hiking" );
    item *existing = fixture.add_worn_item( single_worn_pack );
    REQUIRE( existing != nullptr );
    item *source_item = fixture.add_item( single_worn_pack );
    REQUIRE( source_item != nullptr );
    item *destination_blocker = fixture.add_item( single_worn_pack );
    REQUIRE( destination_blocker != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wear =
        fixture.services["equipment"]["wear"];

    const sol::protected_function_result result = wear(
            fixture.actor_handle, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "destination_rejected" );
    CHECK( fixture.actor.is_wearing( single_worn_pack ) );
    CHECK( fixture.actor.has_item( *source_item ) );
    CHECK( fixture.actor.has_item( *destination_blocker ) );
}

TEST_CASE( "lua_platform_equipment_stale_actor_item",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 207, 1, 6207 );
    item *source_item = fixture.add_item( itype_id( "rock" ) );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];
    cata::lua_platform::retire_item_handle_identity( *source_item );

    const sol::protected_function_result stale_item_result = wield(
            fixture.actor_handle, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( stale_item_result.valid() );
    CHECK_FALSE( stale_item_result.get<sol::table>()["ok"].get<bool>() );
    CHECK( stale_item_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_item" );

    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 207 );
    const cata::lua_platform::game_handle stale_actor =
        cata::lua_platform::game_handle::from_creature(
            fixture.actor, { "character", fixture.actor.getID().get_value(), 0, 0, 0, {} },
            other_runtime, fixture.active_world_generation );
    const sol::protected_function_result stale_actor_result = wield(
            stale_actor, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( stale_actor_result.valid() );
    CHECK_FALSE( stale_actor_result.get<sol::table>()["ok"].get<bool>() );
    CHECK( stale_actor_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_runtime" );
}

TEST_CASE( "lua_platform_equipment_wrong_owner",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 208, 1, 6208 );
    avatar owner;
    owner.normalize();
    owner.setID( character_id( 7208 ), true );
    item *foreign_item = &owner.inv->add_item(
                             item( itype_id( "rock" ), calendar::turn_zero ),
                             false, false, false );
    REQUIRE( foreign_item != nullptr );
    const cata::lua_platform::game_handle foreign_handle =
        cata::lua_platform::game_handle::from_item(
            *foreign_item,
            { "character_inventory", foreign_item->uid().get_value(), 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::protected_function_result result = wield(
            fixture.actor_handle, foreign_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_holder" );
    CHECK( owner.has_item( *foreign_item ) );
    CHECK_FALSE( fixture.actor.has_weapon() );
}

TEST_CASE( "lua_platform_equipment_participant_death",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 209, 1, 6209 );
    npc dying;
    dying.normalize();
    dying.setID( character_id( 7209 ), true );
    cata::lua_platform::register_npc_handle_identity( dying );
    item *source_item = &dying.inv->add_item(
                            item( itype_id( "rock" ), calendar::turn_zero ),
                            false, false, false );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle dying_handle =
        cata::lua_platform::game_handle::from_creature(
            dying, { "npc", dying.getID().get_value(), 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );
    const cata::lua_platform::game_handle source_handle =
        cata::lua_platform::game_handle::from_item(
            *source_item,
            { "character_inventory", source_item->uid().get_value(), 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];
    cata::lua_platform::retire_npc_handle_identity( dying );

    fixture.write_called = false;
    const sol::protected_function_result result = wield(
            dying_handle, source_handle,
            fixture.holder( dying_handle ), fixture.holder( dying_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( fixture.write_called );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_identity" );
}

TEST_CASE( "lua_platform_equipment_public_surface_has_no_legacy_helpers",
           "[lua][platform][equipment][contract]" )
{
    platform_equipment_fixture fixture( 210, 1, 6210 );
    const sol::table equipment = fixture.services["equipment"];
    REQUIRE( equipment.valid() );
    const std::set<std::string> expected = { "unequip", "wear", "wield" };
    std::set<std::string> exposed;
    for( const auto &entry : equipment ) {
        REQUIRE( entry.first.is<std::string>() );
        exposed.insert( entry.first.as<std::string>() );
    }
    CHECK( exposed == expected );
    CHECK( equipment["wield"].valid() );
    CHECK( equipment["wear"].valid() );
    CHECK( equipment["unequip"].valid() );

    const sol::table inventory = fixture.services["inventory"];
    CHECK_FALSE( inventory["remove"].valid() );
    CHECK_FALSE( inventory["wield"].valid() );
    CHECK_FALSE( inventory["wear"].valid() );

    cata::lua_platform::install_npc_api(
        fixture.services,
        [fixture_ptr = &fixture]() {
        return fixture_ptr->active_runtime;
    },
    [fixture_ptr = &fixture]() {
        return fixture_ptr->active_world_generation;
    },
    []() {}, []() {}, []() {} );
    const sol::table npcs = fixture.services["npcs"];
    REQUIRE( npcs.valid() );
    CHECK_FALSE( npcs["equipment"].valid() );
}

} // namespace

#endif // CATA_ENABLE_LUA_PLATFORM
