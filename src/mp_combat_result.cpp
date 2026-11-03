#include "mp_combat_result.h"

#include <sstream>
#include <vector>

#include "cata_scope_helpers.h"
#include "character.h"
#include "effect.h"
#include "json.h"
#include "mp_pickup.h"
#include "rng.h"
#include "skill.h"
#include "units.h"

namespace cata_mp
{
std::string make_combat_result( const Character &actor, pickup_host_state &state )
{
    const std::string inventory = make_inventory_update( actor, state );
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "combat_result" );
    out.member( "inventory" );
    *out.get_stream() << inventory;
    out.set_need_separator();
    out.member( "stamina", actor.get_stamina() );
    out.member( "focus", actor.get_focus_pool() );
    out.member( "recoil", actor.recoil );
    out.member( "pain", actor.get_pain() );
    out.member( "power_mj", units::to_millijoule( actor.get_power_level() ) );
    out.member( "skills" );
    out.start_object();
    for( const auto &entry : actor.get_all_skills() ) {
        out.member( entry.first.str(), entry.second );
    }
    out.end_object();
    out.member( "effects" );
    out.start_array();
    for( const effect &eff : actor.get_effects() ) {
        out.write( eff );
    }
    out.end_array();
    out.end_object();
    return text.str();
}

bool apply_combat_result( Character &actor, const JsonObject &message, pickup_client_state &state )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const int stamina = message.get_int( "stamina" );
    const int focus = message.get_int( "focus" );
    const double recoil = message.get_float( "recoil" );
    const int pain = message.get_int( "pain" );
    const units::energy power = units::from_millijoule( message.get_int64( "power_mj" ) );
    SkillLevelMap skills;
    for( const JsonMember &entry : message.get_object( "skills" ) ) {
        const skill_id id( entry.name() );
        if( !id.is_valid() ) {
            message.throw_error_at( "skills", "Unknown skill in melee result" );
        }
        skills[id].deserialize( entry.get_object() );
    }
    std::vector<effect> effects;
    for( JsonObject entry : message.get_array( "effects" ) ) {
        effect eff;
        eff.deserialize( entry );
        effects.push_back( eff );
    }
    JsonObject inventory = message.get_object( "inventory" );
    inventory.allow_omitted_members();
    if( !apply_inventory_update( actor, inventory, state ) ) {
        return false;
    }
    actor.set_stamina( stamina );
    actor.set_focus_pool( focus );
    actor.recoil = recoil;
    actor.set_pain( pain );
    actor.set_power_level( power );
    for( const auto &entry : skills ) {
        actor.get_skill_level_object( entry.first ) = entry.second;
    }
    actor.restore_effects_snapshot( effects );
    return true;
}

std::string make_player_resume_result( const Character &actor, pickup_host_state &state )
{
    const std::string combat = make_combat_result( actor, state );
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "player_resume" );
    out.member( "combat" );
    *out.get_stream() << combat;
    out.set_need_separator();
    out.member( "needs" );
    actor.store_needs_state( out );
    out.end_object();
    return text.str();
}

bool apply_player_resume_result( Character &actor, const JsonObject &message,
                                 pickup_client_state &state )
{
    JsonObject combat = message.get_object( "combat" );
    combat.allow_omitted_members();
    if( !apply_combat_result( actor, combat, state ) ) {
        return false;
    }
    actor.load_needs_state( message.get_object( "needs" ) );
    return true;
}
} // namespace cata_mp
