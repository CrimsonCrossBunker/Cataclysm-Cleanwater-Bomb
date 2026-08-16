local ccb = require("ccb")
local tutorial_ui = require("runtime.tutorial_ui")
local tasks_mod = require("runtime.tasks_and_state")
local combat_mod = require("runtime.combat_and_hooks")

local behaviour = {}

function behaviour.use_charm(context)
    local uses = ccb.state.character.get("cleanwater_charm_uses", 0) + 1
    ccb.state.character.set("cleanwater_charm_uses", uses)
    context:message("护符发出柔和的微鸣。当前 Lua 触发计数: " .. uses .. " 次。")
    return 0
end

function behaviour.world_ready(event)
    local dimension = ccb.services.gameplay.environment.dimension()
    assert(ccb.services.gameplay.strings.all_equal({ dimension, dimension }))
    assert(ccb.services.random.int(1, 1) == 1)
    if not ccb.state.world.get("cleanwater_example_initialized", false) then
        ccb.state.world.set("cleanwater_example_initialized", true)
        ccb.tasks.after(10, "lua_first_example_reminder", {
            text = "【纯水护符】已将当前世界状态永久写入本地存档侧车数据库。",
        }, 1, "world")
    end
    if event.new_game then
        ccb.services.message(
            "纯 Lua 内置范例 MOD 已在维度 '" .. dimension .. "' 中成功激活生效。")
    end
end

function behaviour.remind(task)
    local reminders = ccb.state.world.get("cleanwater_example_reminders", 0) + 1
    ccb.state.world.set("cleanwater_example_reminders", reminders)
    if task and task.payload and task.payload.text then
        ccb.services.message(task.payload.text)
    end
end

function behaviour.use_codex(context)
    return tutorial_ui.open_codex_menu(context)
end

function behaviour.use_omnitool(context)
    local modes = { "标准拆解切削 (Standard Salvage)", "高频振荡破甲 (High-Frequency Vibro)", "纳米共振微滤 (Nanofilter Pruning)" }
    local cur_idx = ccb.state.character.get("omnitool_mode_idx", 1)
    local next_idx = (cur_idx % #modes) + 1
    ccb.state.character.set("omnitool_mode_idx", next_idx)
    context:message("振波刃内部动力核心快速震荡：已切换为【" .. modes[next_idx] .. "】模式。")
    return 0
end

function behaviour.use_nano_tonic(context)
    local ticks = ccb.state.character.get("lua_first_tonic_ticks", 0) + 1
    ccb.state.character.set("lua_first_tonic_ticks", ticks)
    context:message("你将净化纳米针剂注入体内。微型纳米机器人开始在全身细胞间循环作业。")
    ccb.tasks.after(3, "lua_first_task_tonic_tick", {}, 1, "character")
    return 0
end

-- Exported task and policy callbacks
behaviour.monster_attack_pulse = tasks_mod.monster_attack_pulse
behaviour.ai_should_patrol = tasks_mod.ai_should_patrol
behaviour.ai_combat_utility = tasks_mod.ai_combat_utility
behaviour.eval_craft_speed = tasks_mod.eval_craft_speed
behaviour.magic_level_for_exp = tasks_mod.magic_level_for_exp
behaviour.magic_exp_for_level = tasks_mod.magic_exp_for_level
behaviour.magic_cast_exp = tasks_mod.magic_cast_exp
behaviour.magic_fail_chance = tasks_mod.magic_fail_chance
behaviour.magic_on_failure = tasks_mod.magic_on_failure
behaviour.dynamic_mist_profile = tasks_mod.dynamic_mist_profile
behaviour.task_tonic_tick = tasks_mod.tonic_tick

-- Exported hook callbacks
behaviour.on_craft_result = combat_mod.on_craft_result
behaviour.on_melee_attacked = combat_mod.on_melee_attacked

return behaviour
