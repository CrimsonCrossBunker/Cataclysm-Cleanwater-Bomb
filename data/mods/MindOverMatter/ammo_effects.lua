local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function apply_stun(target, effect)
    local turns = math.floor(services.random.native_float(15, 60))
    local result = services.effects.add(target, id("effect", effect), services.time.duration(turns, "turn"))
    if not result.ok then
        error(result.error.message)
    end
end

local function has_flag(target, flag)
    if target.subtype == "monster" then
        local monster_flag = id("monster_flag", flag)
        if monster_flag:is_valid() then
            return services.creatures.has_flag(target, monster_flag).value
        end
    end
    local json_flag = id("json_flag", flag)
    return json_flag:is_valid() and services.creatures.has_flag(target, json_flag).value
end

ccb.runtime.handler("neural_stungun", function(impact)
    if impact.target then
        apply_stun(impact.target, "effect_electrokin_paralysis")
    end
end)

ccb.runtime.handler("exodii_neural_stungun", function(impact)
    local target = impact.target
    if not target then
        return
    end
    local character = target.subtype ~= "monster"
    if not character and not has_flag(target, "HUMAN") and not has_flag(target, "HAS_MIND") then
        return
    end
    if (character and services.mutations.has_id_text(target, "NPC_TELEPATHY_IMMUNE").value)
        or has_flag(target, "TEEPSHIELD") or has_flag(target, "TEEP_IMMUNE") then
        return
    end
    apply_stun(target, "psi_stunned")
end)

content.add(content.AmmoEffect { id = "NEURAL_STUNGUN" }
    :impact_policy("neural_stungun"))

content.add(content.AmmoEffect { id = "EXODII_NEURAL_STUNGUN" }
    :impact_policy("exodii_neural_stungun"))

-- Creates a trail of lightning plasma
content.add(content.AmmoEffect { id = "LIGHTNING_TRAIL" }
    :field_burst{ field = "fd_electricity", intensity_min = 6, intensity_max = 10, chance = 25 }
    :trail{ field = "fd_electricity", intensity_min = 1, intensity_max = 2, chance = 65 })
