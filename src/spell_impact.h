#pragma once
#ifndef CATA_SRC_SPELL_IMPACT_H
#define CATA_SRC_SPELL_IMPACT_H

#include <functional>
#include <string_view>

#include "coordinates.h"

class Creature;
class spell;

namespace spell_effect
{
void for_each_impact( const spell &sp, Creature &caster, const tripoint_bub_ms &target,
                      const std::function<void( const tripoint_bub_ms &, Creature * )> &callback );
}

namespace cata::lua_platform::detail
{
void invoke_spell_impact_handler( std::string_view mod, std::string_view handler,
                                  const spell &cast_spell, Creature &caster,
                                  const tripoint_bub_ms &target );
}

#endif // CATA_SRC_SPELL_IMPACT_H
