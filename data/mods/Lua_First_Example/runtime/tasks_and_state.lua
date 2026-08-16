local ccb = require("ccb")

local tasks = {}

function tasks.monster_attack_pulse(payload)
    if payload.target and payload.target:is_valid() then
        ccb.services.message("The tutorial drone emits a calibrating acoustic pulse.")
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
    ccb.services.message("A wave of destabilized cybermantic energy dissipates harmlessly.")
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
    ccb.services.message("The nano-tonic circulates through your bloodstream (pulse " .. ticks .. ").")
end

function tasks.run_diagnostics()
    local log = {}
    table.insert(log, "=== Lua Platform v1 Self-Diagnostics ===")
    
    table.insert(log, "1. ccb version: " .. tostring(ccb.platform_version))
    
    local char_val = ccb.state.character.get("diag_test", 0)
    ccb.state.character.set("diag_test", char_val + 1)
    local char_val_new = ccb.state.character.get("diag_test", 0)
    table.insert(log, "2. ccb.state.character: OK (stored: " .. char_val_new .. ")")
    
    local world_val = ccb.state.world.get("diag_test", 0)
    ccb.state.world.set("diag_test", world_val + 1)
    local world_val_new = ccb.state.world.get("diag_test", 0)
    table.insert(log, "3. ccb.state.world: OK (stored: " .. world_val_new .. ")")
    
    local rnd = ccb.services.random.int(1, 100)
    table.insert(log, "4. ccb.services.random.int: OK (" .. rnd .. ")")
    
    local dim = ccb.services.gameplay.environment.dimension()
    table.insert(log, "5. ccb.services.gameplay.dimension: " .. tostring(dim))
    
    table.insert(log, "=== All diagnostics completed successfully ===")
    return table.concat(log, "\n")
end

return tasks
