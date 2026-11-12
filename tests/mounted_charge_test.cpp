#include <algorithm>
#include <bodypart.h>
#include <coordinates.h>
#include <cstdint>
#include <initializer_list>
#include <item_location.h>
#include <item_uid.h>
#include <memory>
#include <monster_uid.h>
#include <optional>
#include <pimpl.h>
#include <player_activity.h>
#include <point.h>
#include <ret_val.h>
#include <sstream>
#include <string>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "avatar_action.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "character_martial_arts.h"
#include "creature.h"
#include "damage.h"
#include "faction.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_loader.h"
#include "lua_platform_runtime_internal.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "martialarts.h"
#include "mod_manager.h"
#include "monster.h"
#include "mounted_charge.h"
#include "mtype.h"
#include "npc.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"

static const damage_type_id damage_bash( "bash" );
static const damage_type_id damage_cut( "cut" );
static const damage_type_id damage_stab( "stab" );
static const efftype_id effect_pet( "pet" );
static const itype_id itype_mc_cavalry_sabre( "mc_cavalry_sabre" );
static const itype_id itype_mounted_lance( "spear_steel" );
static const itype_id itype_mounted_saber( "mc_cavalry_sabre" );
static const move_mode_id move_mode_run( "run" );
static const move_mode_id move_mode_walk( "walk" );
static const skill_id skill_cutting( "cutting" );
static const skill_id skill_melee( "melee" );
static const skill_id skill_stabbing( "stabbing" );
static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_wall( "t_wall" );

#include <utility>
#include "item_factory.h"
#include "melee.h"
#include "worldfactory.h"

namespace
{

monster &setup_mounted_weapon( avatar &player, const itype_id &weapon_type )
{
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    const std::string runtime_mod = tec_mounted_charge->lua_platform_mod;
    if( !cata::lua_platform::detail::find_active_runtime( runtime_mod ) ) {
        const mod_id core( runtime_mod );
        REQUIRE( core.is_valid() );
        const MOD_INFORMATION &mod = *core;
        const cata::lua_platform::mod_source source = {
            mod.ident.str(), mod.mod_root_path.get_unrelative_path(),
            mod.lua_platform_entry.get_unrelative_path()
        };
        std::string error;
        INFO( error );
        REQUIRE( cata::lua_platform::prepare_mods( { source }, error ) );
        REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
        REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
        cata::lua_platform::commit_prepared_mods();
    }
    cata::lua_platform::on_world_ready( true );
#endif
    clear_avatar();
    clear_map_without_vision();
    clear_creatures();

    monster &horse = spawn_test_monster( "mon_horse_police", player.pos_bub() + tripoint::east );
    horse.friendly = -1;
    player.mount_creature( horse );
    player.set_wielded_item( item( weapon_type ) );
    player.set_moves( 1000 );
    return horse;
}

monster &setup_mounted_lance( avatar &player )
{
    return setup_mounted_weapon( player, itype_id( "spear_steel" ) );
}

void start_mounted_charge( avatar &player, monster &horse )
{
    const item_location lance = player.get_wielded_item();
    REQUIRE( lance );
    player.set_moves( 10000 );
    player.assign_activity( mounted_charge_activity_actor(
                                player.pos_abs() + tripoint( 4, 0, 0 ),
                                horse.uid().get_value(), lance->uid().get_value(),
                                player.pos_abs(), lance->typeId() ) );
}

} // namespace

TEST_CASE( "mounted_charge_cooldown_commits_once_and_does_not_cancel_its_activity",
           "[mounted][charge][active_technique][cooldown]" )
{
    restore_on_out_of_scope restore_time( calendar::turn );
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    start_mounted_charge( player, horse );
    CHECK( player.martial_arts_data->technique_cooldown_remaining( tec_mounted_charge ) == 0_turns );
    player.activity.do_turn( player );
    const time_duration cooldown = player.martial_arts_data->technique_cooldown_remaining(
                                       tec_mounted_charge );
    REQUIRE( cooldown == tec_mounted_charge->cooldown );
    REQUIRE( cooldown > 0_turns );
    REQUIRE_FALSE( player.activity.is_null() );
    calendar::turn += 1_seconds;
    player.set_moves( 10000 );
    player.activity.do_turn( player );
    CHECK_FALSE( player.activity.is_null() );
    CHECK( player.martial_arts_data->technique_cooldown_remaining( tec_mounted_charge ) ==
           cooldown - 1_seconds );
    std::ostringstream output;
    JsonOut writer( output );
    player.activity.serialize( writer );
    JsonObject activity = json_loader::from_string( output.str() ).get_object();
    activity.allow_omitted_members();
    JsonObject actor = activity.get_object( "actor" );
    actor.allow_omitted_members();
    JsonObject actor_data = actor.get_object( "actor_data" );
    actor_data.allow_omitted_members();
    CHECK( actor_data.get_bool( "cooldown_started" ) );
    player.activity.deserialize( json_loader::from_string( output.str() ).get_object() );
    player.set_moves( 10000 );
    player.activity.do_turn( player );
    CHECK_FALSE( player.activity.is_null() );
    CHECK( player.martial_arts_data->technique_cooldown_remaining( tec_mounted_charge ) ==
           cooldown - 1_seconds );
    player.cancel_activity();
    start_mounted_charge( player, horse );
    CHECK( player.activity.is_null() );
    calendar::turn += cooldown;
    start_mounted_charge( player, horse );
    CHECK_FALSE( player.activity.is_null() );
    player.cancel_activity();
    CHECK( player.martial_arts_data->technique_cooldown_remaining( tec_mounted_charge ) == 0_turns );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_combat_mount_does_not_refuse_hostile_approach",
           "[mounted][charge][regression]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    REQUIRE( horse.has_flag( mon_flag_COMBAT_MOUNT ) );
    REQUIRE( horse.type->has_fear_trigger( mon_trigger::HOSTILE_CLOSE ) );
    map &here = get_map();
    monster &threat = spawn_test_monster( "mon_zombie_hulk",
                                          player.pos_bub() + tripoint::east );
    here.build_map_cache( player.pos_bub().z() );
    REQUIRE( player.sees( here, threat ) );
    REQUIRE( threat.attitude_to( player ) == Creature::Attitude::HOSTILE );
    CHECK( player.mount_move_refusal_chance( threat ) == 0.0 );
    CHECK( player.check_mount_will_move( threat.pos_bub() ) );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_profile_has_bounded_momentum", "[mounted][charge]" )
{
    mounted_charge_profile profile;
    CHECK_FALSE( profile.valid() );

    profile.max_steps = 15;
    CHECK( profile.valid() );
    CHECK( mounted_charge_stab_multiplier( profile, 0, 300 ) == 1.0f );
    CHECK( mounted_charge_multiplier( profile, 1, 100 ) == Approx( 1.0f + 0.1f / 3 ) );
    CHECK( mounted_charge_multiplier( profile, 1, 200 ) == Approx( 1.0f + 0.2f / 3 ) );
    CHECK( mounted_charge_multiplier( profile, 4, 300 ) == Approx( 1.40f ) );
    CHECK( mounted_charge_multiplier( profile, 4, 40 ) == Approx( 1.0f + 0.4f * 40 / 300 ) );
    CHECK( mounted_charge_multiplier( profile, 15, 100 ) == Approx( 1.0f + 0.5f / 3 ) );
    CHECK( mounted_charge_multiplier( profile, 15, 200 ) == Approx( 1.0f + 1.0f / 3 ) );
    CHECK( mounted_charge_multiplier( profile, 15, 0 ) == 1.0f );
    CHECK( mounted_charge_multiplier( profile, 15, -100 ) == 1.0f );
    CHECK( mounted_charge_multiplier( profile, 15, 10000 ) == Approx( 1.50f ) );

    profile.max_multiplier = 2.1f;
    CHECK_FALSE( profile.valid() );

    profile.max_multiplier = 1.5f;
    profile.max_steps = 16;
    CHECK( profile.valid() );

    JsonObject charge_data = json_loader::from_string( R"({
        "max_steps": 30,
        "damage_type": "stab",
        "multiplier_per_step": 0.1,
        "max_multiplier": 1.5
    })" ).get_object();
    mounted_charge_profile loaded_profile;
    loaded_profile.deserialize( charge_data );
    CHECK( loaded_profile.max_steps == 30 );
    CHECK( loaded_profile.valid() );
}

TEST_CASE( "mounted_charge_weapon_catalog_has_consistent_profiles_and_techniques",
           "[mounted][charge][json]" )
{
    int supported = 0;
    for( const itype *type : item_controller->all() ) {
        const item weapon( type->get_id() );
        const bool has_technique = weapon.has_technique( tec_mounted_charge );
        if( !has_technique && !type->mounted_charge ) {
            continue;
        }
        CAPTURE( type->get_id().str() );
        CHECK( has_technique );
        REQUIRE( type->mounted_charge.has_value() );
        CHECK( type->mounted_charge->valid() );
        CHECK( weapon.damage_melee( damage_type_id( type->mounted_charge->damage_type ) ) > 0 );
        ++supported;
    }
    CHECK( supported >= 200 );
}

TEST_CASE( "mounted_charge_supports_existing_weapon_families_and_material_variants",
           "[mounted][charge][json][active_technique]" )
{
    const std::string weapon_type = GENERATE( "spear_wood", "spear_steel", "lc_spear_steel",
                                    "qt_spear_steel", "qiang", "pike", "javelin_iron", "pitchfork",
                                    "cavalry_sabre", "mc_cavalry_sabre", "qt_cavalry_sabre",
                                    "mc_scimitar", "mc_talwar", "mc_kilij", "mc_arming_sword",
                                    "mc_longsword", "mc_katana", "mc_estoc", "rapier", "machete",
                                    "mc_battleaxe", "ax", "mace", "qt_mace", "morningstar",
                                    "warhammer", "bo", "i_staff", "bat", "stick", "stick_common",
                                    "aztec_spear_scrap", "aztec_spear_glass", "sword_nail",
                                    "brush_pole", "bronze_brush_pole", "jade_nagamaki", "art_trident" );
    CAPTURE( weapon_type );
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_id( weapon_type ) );
    const item &weapon = *player.get_wielded_item();
    REQUIRE( weapon.has_technique( tec_mounted_charge ) );
    REQUIRE( weapon.type->mounted_charge );
    CHECK( avatar_action::mounted_charge_available( player ) );
    const std::vector<matec_id> available = player.active_techniques();
    CHECK( std::find( available.begin(), available.end(), tec_mounted_charge ) != available.end() );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_bundled_mod_variants_remain_usable",
           "[mounted][charge][json][active_technique][mods]" )
{
    using mod_weapon = std::pair<std::string, std::string>;
    const auto [mod_name, weapon_type] = GENERATE(
            mod_weapon{ "xedra_evolved", "dreamdross_bo" },
            mod_weapon{ "xedra_evolved_innawoods", "q_staff_of_the_wise" },
            mod_weapon{ "magiclysm", "rune_biomancer_weapon" },
            mod_weapon{ "magiclysm", "rune_biomancer_weapon_adept" },
            mod_weapon{ "magiclysm", "rune_magus_weapon" },
            mod_weapon{ "magiclysm", "rune_magus_weapon_adept" },
            mod_weapon{ "magiclysm", "rune_druid_nature_staff" },
            mod_weapon{ "magiclysm", "rune_kelvinist_weapon" },
            mod_weapon{ "magiclysm", "rune_kelvinist_ice_adept_weapon" },
            mod_weapon{ "magiclysm", "stormhammer" },
            mod_weapon{ "magiclysm", "mjolnir" },
            mod_weapon{ "magiclysm", "gungnir" },
            mod_weapon{ "magiclysm", "gram" },
            mod_weapon{ "magiclysm", "laevateinn" },
            mod_weapon{ "magiclysm", "wolfsbane" },
            mod_weapon{ "magiclysm", "lizardfolk_trident" },
            mod_weapon{ "Isolation_Protocol", "iso_sorcerers_staff" } );
    CAPTURE( mod_name, weapon_type );
    REQUIRE( world_generator->active_world );
    const std::vector<mod_id> &mods = world_generator->active_world->active_mod_order;
    if( std::find( mods.begin(), mods.end(), mod_id( mod_name ) ) == mods.end() ) {
        SUCCEED( "The optional mod is not loaded" );
        return;
    }
    const itype_id weapon_id( weapon_type );
    REQUIRE( item::type_is_defined( weapon_id ) );
    avatar &player = get_avatar();
    setup_mounted_weapon( player, weapon_id );
    const item &weapon = *player.get_wielded_item();
    REQUIRE( weapon.has_technique( tec_mounted_charge ) );
    REQUIRE( weapon.type->mounted_charge );
    const mounted_charge_profile &profile = *weapon.type->mounted_charge;
    CHECK( profile.valid() );
    CHECK( weapon.damage_melee( damage_type_id( profile.damage_type ) ) > 0 );
    CHECK( avatar_action::mounted_charge_available( player ) );
    const std::vector<matec_id> available = player.active_techniques();
    CHECK( std::find( available.begin(), available.end(), tec_mounted_charge ) != available.end() );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_folded_mod_weapons_do_not_inherit_profiles",
           "[mounted][charge][json][mods]" )
{
    const itype_id folded_type( "megachette_folded" );
    if( !item::type_is_defined( folded_type ) ) {
        SUCCEED( "The optional mod providing this weapon is not loaded" );
        return;
    }
    const item folded( folded_type );
    CHECK_FALSE( folded.has_technique( tec_mounted_charge ) );
    CHECK_FALSE( folded.type->mounted_charge );
}

TEST_CASE( "mounted_charge_excludes_replicas_short_blades_and_unwieldy_weapons",
           "[mounted][charge][json]" )
{
    const std::string weapon_type = GENERATE( "cavalry_sabre_fake", "katana_fake", "mace_fake",
                                    "pike_fake", "halberd_fake", "warhammer_fake", "fencing_foil",
                                    "fencing_epee", "fencing_sabre", "kukri", "knife_combat_marine",
                                    "hatchet", "hammer", "hammer_sledge", "mc_zweihander",
                                    "simple_pike_pipe", "pool_cue", "hollow_cane", "makeshift_crowbar" );
    CAPTURE( weapon_type );
    const item weapon{ itype_id( weapon_type ) };
    CHECK_FALSE( weapon.has_technique( tec_mounted_charge ) );
    CHECK_FALSE( weapon.type->mounted_charge );
}

TEST_CASE( "retired_mounted_weapons_migrate_without_losing_item_state",
           "[mounted][charge][migration][save]" )
{
    const bool saber = GENERATE( false, true );
    const itype_id current( saber ? "mc_cavalry_sabre" : "spear_steel" );
    const itype_id retired( saber ? "mounted_saber" : "mounted_lance" );
    CHECK_FALSE( item::type_is_defined( retired ) );
    CHECK( item_controller->migrate_id( retired ) == current );
    item original( current );
    original.set_var( "item_label", "saved charge weapon" );
    original.set_favorite( true );
    std::ostringstream serialized;
    JsonOut output( serialized );
    original.serialize( output );
    std::string saved = serialized.str();
    const size_t position = saved.find( current.str() );
    REQUIRE( position != std::string::npos );
    saved.replace( position, current.str().size(), retired.str() );
    item loaded;
    loaded.deserialize( json_loader::from_string( saved ).get_object() );
    CHECK( loaded.typeId() == current );
    CHECK( loaded.uid() == original.uid() );
    CHECK( loaded.get_var( "item_label" ) == "saved charge weapon" );
    CHECK( loaded.is_favorite );
    CHECK( loaded.has_technique( tec_mounted_charge ) );
    REQUIRE( loaded.type->mounted_charge );
    CHECK( loaded.type->mounted_charge->valid() );
}

TEST_CASE( "mounted_charge_activity_resumes_with_a_migrated_weapon_type",
           "[mounted][charge][migration][save][activity]" )
{
    const bool saber = GENERATE( false, true );
    const itype_id current( saber ? "mc_cavalry_sabre" : "spear_steel" );
    const std::string retired = saber ? "mounted_saber" : "mounted_lance";
    avatar &player = get_avatar();
    monster &horse = setup_mounted_weapon( player, current );
    const tripoint_abs_ms origin = player.pos_abs();
    get_map().ter_set( player.pos_bub() + tripoint::east, ter_id( "t_floor" ) );
    const mounted_charge_activity_actor original( origin + tripoint( 4, 0, 0 ),
            horse.uid().get_value(), player.get_wielded_item()->uid().get_value(), origin, current );
    std::ostringstream serialized;
    JsonOut output( serialized );
    original.serialize( output );
    std::string saved = serialized.str();
    const size_t position = saved.find( current.str() );
    REQUIRE( position != std::string::npos );
    saved.replace( position, current.str().size(), retired );
    JsonValue actor_data = json_loader::from_string( saved );
    const std::unique_ptr<activity_actor> restored = mounted_charge_activity_actor::deserialize(
                actor_data );
    REQUIRE( restored );
    player.assign_activity( *restored );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    CHECK( player.pos_abs() == origin + tripoint::east );
    CHECK( horse.pos_abs() == player.pos_abs() );
    CHECK( player.technique_cooldown_remaining( tec_mounted_charge ) == 10_seconds );
    player.cancel_activity();
    player.forced_dismount();
}

TEST_CASE( "steel_spear_loads_an_explicit_charge_profile", "[mounted][charge][json]" )
{
    const item lance( itype_id( "spear_steel" ) );
    REQUIRE( lance.type != nullptr );
    REQUIRE( lance.type->mounted_charge.has_value() );
    CHECK( lance.type->mounted_charge->max_steps == 15 );
    CHECK( lance.type->mounted_charge->damage_type == "stab" );
    CHECK( lance.type->mounted_charge->multiplier_per_step == Approx( 0.10f ) );
    CHECK( lance.type->mounted_charge->max_multiplier == Approx( 1.50f ) );
    CHECK( lance.has_flag( flag_REACH_ATTACK ) );
    CHECK( !lance.has_flag( flag_POLEARM ) );
}

TEST_CASE( "cavalry_saber_loads_a_cut_profile", "[mounted][charge][json]" )
{
    const item saber( itype_id( "mc_cavalry_sabre" ) );
    REQUIRE( saber.type != nullptr );
    REQUIRE( saber.type->mounted_charge.has_value() );
    CHECK( saber.type->mounted_charge->max_steps == 15 );
    CHECK( saber.type->mounted_charge->damage_type == "cut" );
    CHECK( saber.type->mounted_charge->multiplier_per_step == Approx( 0.08f ) );
    CHECK( saber.type->mounted_charge->max_multiplier == Approx( 1.30f ) );
    CHECK( !saber.has_flag( flag_POLEARM ) );
}

TEST_CASE( "mounted_charge_is_available_only_as_a_usable_weapon_technique",
           "[mounted][charge][active_technique]" )
{
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_id( "mc_cavalry_sabre" ) );
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    REQUIRE( tec_mounted_charge.is_valid() );
    CHECK( tec_mounted_charge->lua_platform_mod == "ccb" );
    CHECK( tec_mounted_charge->lua_platform_condition_handler ==
           "ccb_mounted_charge_available" );
#endif
    CHECK( avatar_action::mounted_charge_available( player ) );

    player.set_moves( 0 );
    CHECK_FALSE( avatar_action::mounted_charge_available( player ) );
    player.set_moves( 1000 );

    player.set_wielded_item( item( itype_id( "cavalry_sabre_fake" ) ) );
    CHECK_FALSE( avatar_action::mounted_charge_available( player ) );

    player.set_wielded_item( item( itype_id( "spear_steel" ) ) );
    CHECK( avatar_action::mounted_charge_available( player ) );
    player.forced_dismount();
    CHECK_FALSE( avatar_action::mounted_charge_available( player ) );
}

TEST_CASE( "cavalry_saber_charge_scales_cut_damage_only", "[mounted][charge][damage]" )
{
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_id( "mc_cavalry_sabre" ) );
    const item &saber = *player.get_wielded_item();
    REQUIRE( saber.type->mounted_charge.has_value() );

    const auto roll = [&]() {
        damage_instance result;
        player.roll_all_damage( false, result, true, saber, attack_vector_id::NULL_ID(),
                                sub_bodypart_str_id::NULL_ID(), nullptr, bodypart_id( "torso" ) );
        return result;
    };
    const damage_instance ordinary = roll();
    REQUIRE( ordinary.type_damage( damage_type_id( "cut" ) ) > 0.0f );
    player.set_mounted_charge_damage_multiplier( damage_type_id( "cut" ),
            mounted_charge_multiplier( *saber.type->mounted_charge, 1, 300 ) );
    const damage_instance charged = roll();
    player.clear_mounted_charge_stab_multiplier();
    const damage_instance restored = roll();

    CHECK( charged.type_damage( damage_type_id( "cut" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "cut" ) ) * 1.12f ) );
    CHECK( charged.type_damage( damage_type_id( "bash" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "bash" ) ) ) );
    CHECK( charged.type_damage( damage_type_id( "stab" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "stab" ) ) ) );
    CHECK( restored.type_damage( damage_type_id( "cut" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "cut" ) ) ) );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_is_provided_by_the_weapon_technique_list",
           "[mounted][charge][martial_arts]" )
{
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_id( "mc_cavalry_sabre" ) );

    const item_location weapon = player.get_wielded_item();
    REQUIRE( weapon );
    CHECK( weapon->has_technique( tec_mounted_charge ) );

    const std::vector<matec_id> mounted_techniques = player.active_techniques();
    CHECK( std::find( mounted_techniques.begin(), mounted_techniques.end(), tec_mounted_charge ) !=
           mounted_techniques.end() );

    player.forced_dismount();
    const std::vector<matec_id> unmounted_techniques = player.active_techniques();
    CHECK( std::find( unmounted_techniques.begin(), unmounted_techniques.end(), tec_mounted_charge ) ==
           unmounted_techniques.end() );
    const std::vector<matec_id> visible = player.active_techniques( true );
    CHECK( std::find( visible.begin(), visible.end(), tec_mounted_charge ) != visible.end() );
    CHECK_FALSE( player.active_technique_availability( tec_mounted_charge ).success() );
}

TEST_CASE( "mounted_charge_blunt_weapons_scale_only_their_bash_damage",
           "[mounted][charge][damage]" )
{
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_id( "morningstar" ) );
    player.set_str_base( 30 );
    player.set_skill_level( skill_id( "bashing" ), 10 );
    const item &weapon = *player.get_wielded_item();
    REQUIRE( weapon.type->mounted_charge );
    const mounted_charge_profile &profile = *weapon.type->mounted_charge;
    REQUIRE( profile.damage_type == "bash" );
    const auto roll = [&]() {
        damage_instance result;
        player.roll_all_damage( false, result, true, weapon, attack_vector_id::NULL_ID(),
                                sub_bodypart_str_id::NULL_ID(), nullptr, bodypart_id( "torso" ) );
        return result;
    };
    const damage_instance ordinary = roll();
    REQUIRE( ordinary.type_damage( damage_type_id( "bash" ) ) > 0 );
    REQUIRE( ordinary.type_damage( damage_type_id( "stab" ) ) > 0 );
    const float multiplier = mounted_charge_multiplier( profile, 3, 300 );
    player.set_mounted_charge_damage_multiplier( damage_type_id( "bash" ), multiplier );
    const damage_instance charged = roll();
    player.clear_mounted_charge_stab_multiplier();
    const damage_instance restored = roll();
    const float weapon_bash = weapon.damage_melee( damage_type_id( "bash" ) );
    const float strength_bonus = player.bonus_damage( false );
    const float expected_ratio = ( weapon_bash * multiplier + strength_bonus ) /
                                 ( weapon_bash + strength_bonus );
    CHECK( charged.type_damage( damage_type_id( "bash" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "bash" ) ) * expected_ratio ) );
    CHECK( charged.type_damage( damage_type_id( "stab" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "stab" ) ) ) );
    CHECK( restored.type_damage( damage_type_id( "bash" ) ) ==
           Approx( ordinary.type_damage( damage_type_id( "bash" ) ) ) );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_stops_at_heavy_monster", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_weapon( player, itype_id( "mc_cavalry_sabre" ) );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "cutting" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    here.ter_set( start + tripoint::east, ter_id( "t_floor" ) );
    here.ter_set( start + tripoint( 2, 0, 0 ), ter_id( "t_floor" ) );
    monster &target = spawn_test_monster( "mon_zombie_hulk", start + tripoint( 2, 0, 0 ) );
    melee::clear_stats();

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    REQUIRE( player.pos_bub() == start + tripoint::east );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK_FALSE( player.activity );
    CHECK( player.pos_bub() == start + tripoint::east );
    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( target.has_effect( efftype_id( "hit_by_player" ) ) );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_uses_the_weapon_with_a_force_unarmed_style",
           "[mounted][charge][activity][damage]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    player.martial_arts_data->add_martialart( matype_id( "style_taekwondo" ) );
    player.martial_arts_data->set_style( matype_id( "style_taekwondo" ) );
    REQUIRE_FALSE( player.used_weapon() );
    REQUIRE( player.get_wielded_item()->typeId() == itype_id( "spear_steel" ) );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    for( int distance = 1; distance <= 3; ++distance ) {
        here.ter_set( start + tripoint( distance, 0, 0 ), ter_id( "t_floor" ) );
    }
    monster &target = spawn_test_monster( "mon_zombie", start + tripoint( 2, 0, 0 ) );
    target.set_hp( 500 );
    melee::clear_stats();

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( melee::get_stats().damage_amount > 20 );
    CHECK( target.get_hp() < 480 );
    CHECK_FALSE( player.used_weapon() );
    player.cancel_activity();
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_knocks_light_survivor_aside_and_continues",
           "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    for( int x = 1; x <= 4; ++x ) {
        here.ter_set( start + tripoint( x, 0, 0 ), ter_id( "t_floor" ) );
    }
    here.ter_set( start + tripoint( 2, 1, 0 ), ter_id( "t_floor" ) );
    here.ter_set( start + tripoint( 2, -1, 0 ), ter_id( "t_floor" ) );
    monster &target = spawn_test_monster( "mon_zombie", start + tripoint( 2, 0, 0 ) );
    target.set_hp( 500 );

    start_mounted_charge( player, horse );
    player.activity.do_turn( player );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( target.get_hp() < 500 );
    CHECK_FALSE( target.is_dead() );
    CHECK( ( target.pos_bub( here ) == start + tripoint( 2, 1, 0 ) ||
             target.pos_bub( here ) == start + tripoint( 2, -1, 0 ) ) );
    CHECK( player.pos_bub() == start + tripoint( 2, 0, 0 ) );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    CHECK( player.pos_bub() == start + tripoint( 3, 0, 0 ) );
    player.cancel_activity();
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_does_not_fling_heavy_corpse", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    monster &target = spawn_test_monster( "mon_moose", start + tripoint::east );
    target.set_hp( 1 );

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( target.is_dead() );
    CHECK( player.pos_bub() == start );
    CHECK_FALSE( player.activity );
    bool corpse_at_impact = false;
    for( const item &ground_item : here.i_at( start + tripoint::east ) ) {
        corpse_at_impact |= ground_item.is_corpse() && ground_item.get_corpse_mon() == target.type;
    }
    CHECK( corpse_at_impact );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_fling_light_corpse_and_hits_next_monster",
           "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    for( int x = 1; x <= 4; ++x ) {
        here.ter_set( start + tripoint( x, 0, 0 ), ter_id( "t_floor" ) );
    }
    here.ter_set( start + tripoint( 2, 1, 0 ), ter_id( "t_floor" ) );
    here.ter_set( start + tripoint( 2, -1, 0 ), ter_id( "t_floor" ) );
    monster &first = spawn_test_monster( "mon_zombie", start + tripoint( 2, 0, 0 ) );
    first.set_hp( 1 );
    monster &second = spawn_test_monster( "mon_zombie_hulk", start + tripoint( 3, 0, 0 ) );
    const int second_hp = second.get_hp();

    start_mounted_charge( player, horse );
    player.activity.do_turn( player );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    REQUIRE( first.is_dead() );
    CHECK( player.pos_bub() == start + tripoint( 2, 0, 0 ) );
    bool corpse_aside = false;
    for( const int dy : {
             -1, 1
             } ) {
        for( const item &ground_item : here.i_at( start + tripoint( 2, dy, 0 ) ) ) {
            corpse_aside |= ground_item.is_corpse() && ground_item.get_corpse_mon() == first.type;
        }
    }
    CHECK( corpse_aside );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    CHECK( second.get_hp() < second_hp );
    CHECK_FALSE( player.activity );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_moves_one_tile_and_stops_at_wall", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    here.ter_set( start + tripoint::east, ter_id( "t_floor" ) );
    here.ter_set( start + tripoint( 2, 0, 0 ), ter_id( "t_wall" ) );

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    CHECK( player.pos_bub() == start + tripoint::east );
    CHECK( horse.pos_bub( here ) == player.pos_bub() );
    REQUIRE( player.activity );

    player.activity.do_turn( player );
    CHECK( player.pos_bub() == start + tripoint::east );
    CHECK_FALSE( player.activity );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_reaches_selected_endpoint", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    const tripoint_bub_ms endpoint = start + tripoint( 15, 0, 0 );
    for( const tripoint_bub_ms &point : line_to( start, endpoint ) ) {
        here.ter_set( point, ter_id( "t_floor" ) );
    }
    const tripoint_abs_ms endpoint_abs = here.get_abs( endpoint );

    const item_location lance = player.get_wielded_item();
    REQUIRE( lance );
    player.set_moves( 100000 );
    player.assign_activity( mounted_charge_activity_actor(
                                here.get_abs( endpoint ), horse.uid().get_value(), lance->uid().get_value(),
                                player.pos_abs(), lance->typeId() ) );
    REQUIRE( player.activity );

    for( int step = 0; step < 15 && player.activity; ++step ) {
        player.activity.do_turn( player );
    }

    CHECK_FALSE( player.activity );
    CHECK( player.pos_abs() == endpoint_abs );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_attacks_friendly_creature", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_dex_base( 30 );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    map &here = get_map();
    const tripoint_bub_ms start = player.pos_bub();
    monster &pet = spawn_test_monster( "mon_dog", start + tripoint::east );
    pet.friendly = 1;
    pet.add_effect( efftype_id( "pet" ), 1_turns, true );
    melee::clear_stats();

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( player.pos_bub() == start + tripoint::east );
    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( pet.has_effect( efftype_id( "hit_by_player" ) ) );
    CHECK( player.activity );
    player.cancel_activity();
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_attacks_non_hostile_npc", "[mounted][charge][activity]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    player.set_skill_level( skill_id( "melee" ), 10 );
    player.set_skill_level( skill_id( "stabbing" ), 10 );
    const tripoint_bub_ms start = player.pos_bub();
    npc &target = spawn_npc( ( start + tripoint::east ).xy(), "test_talker" );
    REQUIRE_FALSE( target.is_enemy() );
    melee::clear_stats();

    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );

    CHECK( player.pos_bub() == start );
    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( target.is_enemy() );
    CHECK_FALSE( player.activity );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_cooldown_starts_only_after_execution", "[mounted][charge][cooldown]" )
{
    restore_on_out_of_scope restore_time( calendar::turn );
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    map &here = get_map();
    const tripoint_bub_ms origin = player.pos_bub();
    for( int step = 1; step <= 4; ++step ) {
        here.ter_set( origin + tripoint( step, 0, 0 ), ter_id( "t_floor" ) );
    }
    REQUIRE( tec_mounted_charge->cooldown == 10_seconds );
    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    CHECK( player.technique_cooldown_remaining( tec_mounted_charge ) == 0_turns );

    SECTION( "canceling before movement does not start cooldown" ) {
        player.cancel_activity();
        CHECK( player.technique_cooldown_remaining( tec_mounted_charge ) == 0_turns );
    }
    SECTION( "blocked first step does not start cooldown" ) {
        here.ter_set( origin + tripoint::east, ter_id( "t_wall" ) );
        player.activity.do_turn( player );
        CHECK_FALSE( player.activity );
        CHECK( player.technique_cooldown_remaining( tec_mounted_charge ) == 0_turns );
    }
    SECTION( "movement starts one cooldown without interrupting the charge" ) {
        player.activity.do_turn( player );
        REQUIRE( player.activity );
        CHECK( player.pos_bub() == origin + tripoint::east );
        CHECK( player.technique_cooldown_remaining( tec_mounted_charge ) == 10_seconds );
        CHECK_FALSE( avatar_action::mounted_charge_available( player ) );
        calendar::turn += 2_seconds;

        std::ostringstream serialized;
        JsonOut output( serialized );
        player.activity.serialize( output );
        player.activity.deserialize( json_loader::from_string( serialized.str() ).get_object() );
        REQUIRE( player.activity );
        player.activity.actor->start( player.activity, player );
        REQUIRE( player.activity );
        player.activity.do_turn( player );
        CHECK( player.pos_bub() == origin + tripoint( 2, 0, 0 ) );
        CHECK( player.technique_cooldown_remaining( tec_mounted_charge ) == 8_seconds );
        player.cancel_activity();
        CHECK( player.technique_cooldown_remaining( tec_mounted_charge ) == 8_seconds );
        start_mounted_charge( player, horse );
        CHECK_FALSE( player.activity );
        calendar::turn += 8_seconds;
        CHECK( avatar_action::mounted_charge_available( player ) );
    }
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_attack_starts_cooldown_without_a_movement_step",
           "[mounted][charge][cooldown]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    const tripoint_bub_ms origin = player.pos_bub();
    get_map().ter_set( origin + tripoint::east, ter_id( "t_floor" ) );
    spawn_test_monster( "mon_zombie_hulk", origin + tripoint::east );
    start_mounted_charge( player, horse );
    REQUIRE( player.activity );
    player.activity.do_turn( player );
    CHECK_FALSE( player.activity );
    CHECK( player.pos_bub() == origin );
    CHECK( player.technique_cooldown_remaining( tec_mounted_charge ) == 10_seconds );
    player.forced_dismount();
}

TEST_CASE( "mounted_charge_activity_serializes_route_identity", "[mounted][charge][save]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    start_mounted_charge( player, horse );
    REQUIRE( player.activity );

    std::ostringstream serialized;
    JsonOut output( serialized );
    player.activity.serialize( output );
    JsonObject activity = json_loader::from_string( serialized.str() ).get_object();
    activity.allow_omitted_members();
    CHECK( activity.get_string( "type" ) == "ACT_MOUNTED_CHARGE" );

    JsonObject actor = activity.get_object( "actor" );
    actor.allow_omitted_members();
    CHECK( actor.get_string( "actor_type" ) == "ACT_MOUNTED_CHARGE" );
    JsonObject actor_data = actor.get_object( "actor_data" );
    actor_data.allow_omitted_members();
    tripoint_abs_ms destination;
    int completed_steps = -1;
    int64_t mount_uid = 0;
    int64_t weapon_uid = 0;
    itype_id item_type;
    actor_data.read( "destination", destination );
    actor_data.read( "completed_steps", completed_steps );
    actor_data.read( "mount_uid", mount_uid );
    actor_data.read( "weapon_uid", weapon_uid );
    actor_data.read( "charge_item_type", item_type );

    CHECK( destination == player.pos_abs() + tripoint( 4, 0, 0 ) );
    CHECK( completed_steps == 0 );
    CHECK( mount_uid == horse.uid().get_value() );
    CHECK( weapon_uid == player.get_wielded_item()->uid().get_value() );
    CHECK( item_type == itype_id( "spear_steel" ) );
    player.cancel_activity();
    player.forced_dismount();
}


TEST_CASE( "mounted_lance_loads_an_explicit_charge_profile", "[mounted][charge][json]" )
{
    const item lance( itype_mounted_lance );
    REQUIRE( lance.type != nullptr );
    REQUIRE( lance.type->mounted_charge.has_value() );
    CHECK( lance.type->mounted_charge->max_steps == 15 );
    CHECK( lance.type->mounted_charge->damage_type == "stab" );
    CHECK( lance.type->mounted_charge->multiplier_per_step == Approx( 0.10f ) );
    CHECK( lance.type->mounted_charge->max_multiplier == Approx( 1.50f ) );
    CHECK( !lance.has_flag( flag_REACH_ATTACK ) );
    CHECK( !lance.has_flag( flag_POLEARM ) );
}

TEST_CASE( "mounted_charge_damage_tracks_mount_speed_and_gait_after_full_runup",
           "[mounted][charge][damage][lua]" )
{
    avatar &player = get_avatar();
    monster &horse = setup_mounted_lance( player );
    const mounted_charge_profile &profile = *player.get_wielded_item()->type->mounted_charge;
    REQUIRE( tec_mounted_charge.is_valid() );
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    CHECK( tec_mounted_charge->lua_platform_charge_damage_handler == "ccb_mounted_charge_damage" );
#endif
    player.set_movement_mode( move_mode_walk );
    const float walking = tec_mounted_charge->charge_damage_multiplier( player, profile, 15 );
    CHECK( walking == Approx( mounted_charge_multiplier( profile, 15, player.mount_speed() ) ) );

    player.set_movement_mode( move_mode_run );
    const float trotting = tec_mounted_charge->charge_damage_multiplier( player, profile, 15 );
    CHECK( trotting > walking );
    CHECK( trotting < profile.max_multiplier );
    CHECK( trotting == Approx( mounted_charge_multiplier( profile, 15, player.mount_speed() ) ) );
    CHECK( tec_mounted_charge->charge_damage_multiplier( player, profile, 0 ) == 1.0f );

    horse.set_speed_base( horse.get_speed_base() / 2 );
    CHECK( tec_mounted_charge->charge_damage_multiplier( player, profile, 15 ) < walking );
    CHECK( tec_mounted_charge->charge_damage_multiplier( player, profile, 15 ) ==
           Approx( mounted_charge_multiplier( profile, 15, player.mount_speed() ) ) );

    ma_technique fallback_technique = *tec_mounted_charge;
    fallback_technique.lua_platform_mod = "missing-charge-damage-owner";
    fallback_technique.lua_platform_charge_damage_handler = "missing";
    CHECK( fallback_technique.charge_damage_multiplier( player, profile, 15 ) ==
           Approx( mounted_charge_multiplier( profile, 15, player.mount_speed() ) ) );
}

TEST_CASE( "mounted_saber_loads_a_short_cut_profile", "[mounted][charge][json]" )
{
    const item saber( itype_mounted_saber );
    REQUIRE( saber.type != nullptr );
    REQUIRE( saber.type->mounted_charge.has_value() );
    CHECK( saber.type->mounted_charge->max_steps == 15 );
    CHECK( saber.type->mounted_charge->damage_type == "cut" );
    CHECK( saber.type->mounted_charge->multiplier_per_step == Approx( 0.08f ) );
    CHECK( saber.type->mounted_charge->max_multiplier == Approx( 1.30f ) );
    CHECK( !saber.has_flag( flag_POLEARM ) );
}

TEST_CASE( "mounted_saber_charge_scales_cut_damage_only", "[mounted][charge][damage]" )
{
    avatar &player = get_avatar();
    setup_mounted_weapon( player, itype_mounted_saber );
    const item &saber = *player.get_wielded_item();
    REQUIRE( saber.type->mounted_charge.has_value() );

    const auto roll = [&]() {
        damage_instance result;
        player.roll_all_damage( false, result, true, saber, attack_vector_id::NULL_ID(),
                                sub_bodypart_str_id::NULL_ID(), nullptr, bodypart_id( "torso" ) );
        return result;
    };
    const damage_instance ordinary = roll();
    REQUIRE( ordinary.type_damage( damage_cut ) > 0.0f );
    player.set_mounted_charge_damage_multiplier( damage_cut,
            mounted_charge_multiplier( *saber.type->mounted_charge, 1, 300 ) );
    const damage_instance charged = roll();
    player.clear_mounted_charge_stab_multiplier();
    const damage_instance restored = roll();

    CHECK( charged.type_damage( damage_cut ) ==
           Approx( ordinary.type_damage( damage_cut ) * 1.08f ) );
    CHECK( charged.type_damage( damage_bash ) ==
           Approx( ordinary.type_damage( damage_bash ) ) );
    CHECK( charged.type_damage( damage_stab ) ==
           Approx( ordinary.type_damage( damage_stab ) ) );
    CHECK( restored.type_damage( damage_cut ) ==
           Approx( ordinary.type_damage( damage_cut ) ) );
    player.forced_dismount();
}
