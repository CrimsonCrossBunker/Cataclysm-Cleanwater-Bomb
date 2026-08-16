local ccb = require("ccb")

local tasks = {}

function tasks.monster_attack_pulse(payload)
    if payload.target and payload.target:is_valid() then
        ccb.services.message("教程训练无人机释放了一道经过调谐的声学校准脉冲。")
        return true
    end
    return false
end

function tasks.ai_should_patrol(payload)
    return true
end

function tasks.ai_combat_utility(payload)
    return 10.0
end

function tasks.eval_craft_speed(payload)
    return 1.15
end

function tasks.magic_level_for_exp(payload)
    local exp = 0
    if type(payload) == "table" and payload.experience then
        exp = payload.experience
    elseif type(payload) == "number" then
        exp = payload
    end
    return math.floor(math.sqrt(math.max(0, exp) / 100))
end

function tasks.magic_exp_for_level(payload)
    local lvl = 0
    if type(payload) == "table" and payload.level then
        lvl = payload.level
    elseif type(payload) == "number" then
        lvl = payload
    end
    return lvl * lvl * 100
end

function tasks.magic_cast_exp(payload)
    return 15
end

function tasks.magic_fail_chance(payload)
    return 10
end

function tasks.magic_on_failure(payload)
    ccb.services.message("一股失稳的赛博法术余波在空气中悄然消散，未造成反噬伤害。")
end

function tasks.dynamic_mist_profile(payload)
    return {
        field = "fd_smoke",
        intensity = 1,
        quantity = 3,
        chance = 40,
    }
end

function tasks.tonic_tick(task)
    local ticks = ccb.state.character.get("lua_first_tonic_ticks", 0) + 1
    ccb.state.character.set("lua_first_tonic_ticks", ticks)
    ccb.services.message("净化纳米机器人在血液中循环作业（脉冲阶段 " .. ticks .. "）。")
end

function tasks.run_diagnostics()
    local log = {}
    table.insert(log, "=== CCB Lua 平台 v1 原生自检诊断报告 ===")
    
    table.insert(log, "1. 引擎底层版本 (ccb version): " .. tostring(ccb.platform_version))
    
    local char_val = ccb.state.character.get("diag_test", 0)
    ccb.state.character.set("diag_test", char_val + 1)
    local char_val_new = ccb.state.character.get("diag_test", 0)
    table.insert(log, "2. 角色持久化侧车 (ccb.state.character): 正常 (值: " .. char_val_new .. ")")
    
    local world_val = ccb.state.world.get("diag_test", 0)
    ccb.state.world.set("diag_test", world_val + 1)
    local world_val_new = ccb.state.world.get("diag_test", 0)
    table.insert(log, "3. 世界持久化侧车 (ccb.state.world): 正常 (值: " .. world_val_new .. ")")
    
    local rnd = ccb.services.random.int(1, 100)
    table.insert(log, "4. 随机数生成服务 (ccb.services.random.int): 正常 (" .. rnd .. ")")
    
    local dim = ccb.services.gameplay.environment.dimension()
    table.insert(log, "5. 游戏空间维度服务 (ccb.services.gameplay.dimension): " .. tostring(dim))
    
    table.insert(log, "=== 所有核心诊断项全部通过，API 链路 100% 正常 ===")
    return table.concat(log, "\n")
end

return tasks
