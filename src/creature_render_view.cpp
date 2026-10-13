#include "creature_render_view.h"

#include "avatar.h"
#include "character.h"
#include "creature_tracker.h"
#include "dialogue.h"
#include "effect.h"
#include "magic_enchantment.h"
#include "map.h"
#include "mapdata.h"
#include "mtype.h"
#include "creature.h"
#include "monster.h"
#include "mutation.h"
#include "npc.h"

namespace
{
int rotation_for( FacingDirection facing )
{
    return facing == FacingDirection::RIGHT ? 0 : facing == FacingDirection::LEFT ? -1 : -2;
}
} // namespace

entity_render_view capture_character_render_view( const Character &ch,
        FacingDirection facing_override )
{
    entity_render_view view;
    view.male = ch.male;
    view.rotation = rotation_for( facing_override == FacingDirection::NONE ? ch.facing :
                                  facing_override );
    const std::vector<trait_id> mutations = ch.get_functioning_mutations( true,
    false, []( const mutation_branch & mut ) {
        return mut.override_look.has_value();
    } );
    if( mutations.empty() ) {
        view.body = ch.is_npc() ? ( ch.male ? "npc_male" : "npc_female" ) :
                    ( ch.male ? "player_male" : "player_female" );
        view.category = "none";
        view.overlays = ch.get_overlay_ids();
    } else {
        const mutation_branch::OverrideLook &look = *mutations.front().obj().override_look;
        view.body = look.id;
        view.category = look.tile_category;
        view.overlays = ch.get_overlay_ids_when_override_look();
    }
    return view;
}

entity_render_view capture_monster_overlay_view( const monster &mon )
{
    entity_render_view view;
    view.rotation = rotation_for( mon.facing );
    view.stack_overlays = true;
    view.overlays = mon.get_overlay_ids();
    return view;
}

std::optional<creature_render_view> capture_creature_render_view( const map &here,
        Character &you, const Creature *critter, const tripoint_bub_ms &p, bool invisible )
{
    if( critter && critter->is_underwater() &&
        here.has_flag( ter_furn_flag::TFLAG_SWIM_UNDER, p ) && !you.is_underwater() ) {
        critter = you.pos_bub() == p ? &you : get_creature_tracker().creature_at<npc>( p );
    }
    creature_render_view view;
    if( !critter ) {
        return std::nullopt;
    }
    const bool always_visible = critter->has_flag( mon_flag_ALWAYS_VISIBLE );
    const bool visible_branch = !invisible || always_visible;
    if( !visible_branch || !you.sees( here, *critter ) ) {
        const_dialogue d( get_const_talker_for( you ), get_const_talker_for( *critter ) );
        const enchant_cache::special_vision vision = you.enchantment_cache->get_vision( d );
        if( vision.is_empty() || ( !visible_branch && you.is_avatar() &&
                                   ( you.as_avatar()->cant_see( p ) || vision.ignores_aiming_cone ) ) ) {
            return std::nullopt;
        }
        view.special = true;
        view.body = you.enchantment_cache->get_vision_description_struct( vision, d ).id;
        return view;
    }
    if( const monster *mon = dynamic_cast<const monster *>( critter ) ) {
        view.rotation = mon->facing == FacingDirection::RIGHT ? 0 :
                        mon->facing == FacingDirection::LEFT ? -1 : -2;
        if( view.rotation < -1 ) {
            return view;
        }
        view.body = mon->type->id.str();
        view.species = mon->type->species.empty() ? std::string{} :
                       mon->type->species.begin()->str();
        if( mon->has_effect( efftype_id( "ridden" ) ) ) {
            view.ridden_body = "rid_" + view.body;
            if( mon->mounted_player ) {
                view.rider = capture_character_render_view( *mon->mounted_player, FacingDirection::NONE );
            }
        }
        Creature *summoner = mon->has_flag( mon_flag_COPY_SUMMONER_LOOK ) ? mon->get_summoner() : nullptr;
        if( summoner ) {
            view.body.clear();
            if( const Character *ch = summoner->as_character() ) {
                view.character = capture_character_render_view( *ch, mon->facing );
                view.character_result = true;
            }
            if( const monster *other = summoner->as_monster() ) {
                view.body = other->type->id.str();
            }
            view.ridden_body.clear();
        } else if( mon->has_flag( mon_flag_COPY_AVATAR_LOOK ) ) {
            view.body.clear();
            view.ridden_body.clear();
            view.character = capture_character_render_view( *get_avatar().as_character(), mon->facing );
            // Retain the legacy copy-avatar branch's false result after drawing.
        }
        view.monster_overlays = capture_monster_overlay_view( *mon );
        view.disposition = capture_creature_disposition( here, you, *mon );
    }
    if( const Character *ch = dynamic_cast<const Character *>( critter ) ) {
        view.character = capture_character_render_view( *ch, FacingDirection::NONE );
        view.character_result = true;
        view.disposition = capture_creature_disposition( here, you, *ch );
    }
    return view;
}

std::string capture_creature_disposition( const map &here, Character &you, const Creature &actor )
{
    bool player = false;
    bool sees = false;
    Creature::Attitude attitude = Creature::Attitude::ANY;
    if( const monster *mon = dynamic_cast<const monster *>( &actor ) ) {
        sees = mon->sees( here, you );
        attitude = mon->attitude_to( you );
    }
    if( const Character *ch = dynamic_cast<const Character *>( &actor ) ) {
        player = ch->is_avatar();
        if( !player ) {
            sees = ch->sees( here, you );
            attitude = ch->attitude_to( you );
        }
    }
    if( player ) {
        return {};
    }
    std::string id = "overlay_" + Creature::attitude_raw_string( attitude );
    if( sees && !you.has_trait( trait_id( "INATTENTIVE" ) ) ) {
        id += "_sees_player";
    }
    return id;
}
