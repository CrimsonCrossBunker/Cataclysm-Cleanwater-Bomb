local ccb = require("ccb")

local content_charm = require("content.cleanwater_charm")
local content_items = require("content.items_and_tools")
local content_crafting = require("content.recipes_and_crafting")
local content_monsters = require("content.monsters_and_ai")
local content_mutations = require("content.mutations_and_traits")
local content_magic = require("content.magic_and_spells")
local content_env = require("content.environment_and_emissions")

local behaviour = require("runtime.behaviour")

-- Register runtime handlers
ccb.runtime.handler("use_cleanwater_charm", behaviour.use_charm, 1)
ccb.runtime.handler("lua_first_example_ready", behaviour.world_ready, 1)
ccb.runtime.handler("lua_first_example_reminder", behaviour.remind, 1)

ccb.runtime.handler("lua_first_open_dev_codex", behaviour.use_codex, 1)
ccb.runtime.handler("lua_first_use_omnitool", behaviour.use_omnitool, 1)
ccb.runtime.handler("lua_first_use_nano_tonic", behaviour.use_nano_tonic, 1)
ccb.runtime.handler("lua_first_task_tonic_tick", behaviour.task_tonic_tick, 1)

ccb.runtime.handler("lua_first_monster_attack_pulse", behaviour.monster_attack_pulse, 1)
ccb.runtime.handler("lua_first_ai_should_patrol", behaviour.ai_should_patrol, 1)
ccb.runtime.handler("lua_first_ai_combat_utility", behaviour.ai_combat_utility, 1)
ccb.runtime.handler("lua_first_eval_craft_speed", behaviour.eval_craft_speed, 1)

ccb.runtime.handler("lua_first_magic_level_for_exp", behaviour.magic_level_for_exp, 1)
ccb.runtime.handler("lua_first_magic_exp_for_level", behaviour.magic_exp_for_level, 1)
ccb.runtime.handler("lua_first_magic_cast_exp", behaviour.magic_cast_exp, 1)
ccb.runtime.handler("lua_first_magic_fail_chance", behaviour.magic_fail_chance, 1)
ccb.runtime.handler("lua_first_magic_on_failure", behaviour.magic_on_failure, 1)

ccb.runtime.handler("lua_first_dynamic_mist_profile", behaviour.dynamic_mist_profile, 1)

ccb.runtime.handler("lua_first_hook_craft_result", behaviour.on_craft_result, 1)
ccb.runtime.handler("lua_first_hook_melee_attack", behaviour.on_melee_attacked, 1)

-- Register lifecycle events and native hooks
ccb.runtime.on("world_ready", "lua_first_example_ready")
ccb.runtime.hook("on_craft_result", "lua_first_hook_craft_result")
ccb.runtime.hook("on_creature_melee_attacked", "lua_first_hook_melee_attack")

-- Register content systems
content_charm.register(ccb)
content_items.register(ccb)
content_crafting.register(ccb)
content_monsters.register(ccb)
content_mutations.register(ccb)
content_magic.register(ccb)
content_env.register(ccb)
