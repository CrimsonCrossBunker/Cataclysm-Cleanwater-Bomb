#pragma once
#ifndef CATA_SRC_MP_MAGIC_H
#define CATA_SRC_MP_MAGIC_H

#include <string>

#include "coords_fwd.h"
#include "type_id.h"

class Creature;
class JsonObject;
class monster;
class spell;
class time_duration;

namespace cata_mp
{
// Narrow adapters for resolved monster spells and a client's attack on the
// host.  Other spell effects, costs, EOCs and mod compatibility are unchanged.
void mp_on_monster_spell_op( monster &mon, const Creature &caster, const char *op,
                             int prior_hp = -1 );
int mp_client_monster_prior_hp( const monster &mon );
void mp_on_spell_effect_applied( Creature &target, const Creature &caster,
                                 const efftype_id &eff, const time_duration &dur );
bool mp_dispatch_spell_at_partner( const spell &sp, Creature &caster, Creature &target );
void mp_spell_hit_single_target( const spell &sp, Creature &caster,
                                 const tripoint_bub_ms &target );
void mp_handle_spell_message( const std::string &msg );

// Volatile generation/sequence guards: reconnect, world exit and clock rollback
// invalidate queued non-idempotent effects; nothing is restored from a save.
void mp_magic_reset( bool request_resync = false );
std::string mp_magic_host_generation();
bool mp_magic_client_state( const JsonObject &state );

std::string mp_monster_effects_wire( const monster &mon );
void mp_apply_monster_effects( monster &mon, const JsonObject &record );
} // namespace cata_mp

#endif // CATA_SRC_MP_MAGIC_H
