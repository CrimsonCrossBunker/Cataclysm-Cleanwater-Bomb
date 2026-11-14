# CCB Lua-first Platform

CCB has one supported Lua runtime: Platform v1.  A Platform Mod is discovered
from its root `main.lua`; optional metadata is returned by `mod.lua` through
`ccb.ModDefinition`.  Mods do not use JSON manifests, an authored `lua/`
subdirectory, EOCs, or the former `game.*` API.

The architecture and authoring contract are documented in
[LUA_FIRST_PLATFORM.md](LUA_FIRST_PLATFORM.md). The short current goal and
progress page is [LUA_FIRST_EOC_WORKFLOW.md](LUA_FIRST_EOC_WORKFLOW.md).

LuaLS declarations are in `types/ccb_platform_v1.d.lua`.  Contract and
inventory checks are documented in
[tools/lua_api/README.md](../../tools/lua_api/README.md).

## Martial techniques

Core grappling, position actions, and the expanded combat library are authored
in `data/mods/dda/grappling.lua`, `position_techniques.lua`, and
`combat_techniques.lua`. Brawling includes grips, dragging, a body-lock trip,
basic strikes, and category-restricted weapon actions. Specialist styles retain
their existing buffs, requirements, and techniques when Lua appends membership.
The library uses recognizable boxing, kicking, clinching, staff, spear, sword,
knife, baton, mace, axe, and polearm actions as gameplay abstractions, not as
claims of historical reconstruction. Damage, accuracy, recovery, repetition,
skill requirements, and Lua eligibility distinguish the moves. Human joint
controls require an owned grip and appropriate anatomy; low hooks and push
kicks exclude flying, downed, or oversized targets.

Reference points include the International Judo Federation's
[O-goshi catalogue entry](https://judo.ijf.org/techniques/O-goshi) for the hip
throw, and the transcribed sword and spear plays in
[Fiore dei Liberi's manuscripts](https://wiktenauer.com/wiki/Fiore_de%27i_Liberi).
The numeric bonuses, targeting restrictions, and recovery times are game
balance choices, not measurements of real combat performance.

`Technique:weapon_category`, `damage_multiplier`, `move_cost_multiplier`, and
`accuracy_bonus` author native requirements and bonuses without accepting raw
JSON. `active_when` receives detached actor/target state, including non-hostile
targets. Manual primary targets may be friendly monsters or NPCs, with an
attack confirmation; automatic AI and secondary AoE faction filters do not
change. Critical-only techniques and counters remain automatic-only.
`active_when` gates manual selection/execution and automatic candidate
eligibility; a critical-only move still requires an actual critical hit.

`position_plan` names a handler returning an allowed flag, total stamina/move
costs, and normal terrain-bash power. It is mutually exclusive with creature
effects, reach, grappling, and `on_apply`. Selection may preview repeatedly;
handlers should be pure. Execution recalculates the plan and fails closed on
Lua errors, invalid numbers, missing runtimes, insufficient stamina, or native
targeting failures, without a fallback melee attack. Native code validates a
visible adjacent non-self position, attack-vector anatomy, style/weapon
requirements, and cooldown. Occupied tiles and vehicles are excluded.

Rapid Window Break targets ordinary windows with a heel kick; reinforced glass
retains its normal resistance. Committed Breaching Blow uses substantial blunt
weapons against bashable terrain/furniture. Shadow Combination targets clear
space, costs time/stamina, and grants no combat experience. Terrain bashing
retains normal sound, debris, and other native consequences; it never forcibly
replaces terrain. Cancellation precedes costs and cooldowns.

## Mounted charge

`MOUNTED_CHARGE` is bound to suitable existing spears, swords, axes, clubs,
maces, and staves through item JSON. Material variants inherit their base
weapon's profile; replicas, short blades, and unwieldy weapons are excluded.
The `mounted_charge` profile selects stab, cut, or bash weapon damage for the
momentum bonus; strength bonuses and other damage types remain unchanged. A
child item can set `mounted_charge` to `null` to remove an inherited profile,
and must also remove `MOUNTED_CHARGE` from its techniques.

The Lua handler `ccb_mounted_charge_available` in `data/mods/dda/main.lua`
controls activation eligibility. Native code handles movement, collision,
damage, and activity persistence. The redundant `mounted_lance` and
`mounted_saber` items migrate to `spear_steel` and `mc_cavalry_sabre`, respectively,
including weapon references in saved charge activities. The existing
`cavalry_sabre` family remains available.
