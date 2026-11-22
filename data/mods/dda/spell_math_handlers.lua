local ccb = require("ccb")
local services = ccb.services

local function char_artifact_resonance(actor)
    if not actor then
        return 0
    end
    local r = services.characters.snapshot(actor)
    if not r.ok then
        return 0
    end
    return r.value.combat.artifact_resonance or 0
end

local function get_actor_var_num(actor, key)
    if not actor then
        return 0
    end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then
        return 0
    end
    return r.value.value
end

local function jmath_scaling_factor(payload, _0)
    return ((_0 + 10) / 20)
end

ccb.runtime.handler("wave14a_dda_stat_1", function(payload)
    return ((char_artifact_resonance(payload.speaker) / 20) + 10)
end)

ccb.runtime.handler("wave14a_dda_stat_2", function(payload)
    return ((char_artifact_resonance(payload.speaker) / 15) + 30)
end)

ccb.runtime.handler("wave14a_dda_stat_3", function(payload)
    return ((char_artifact_resonance(payload.speaker) / 60) + 5)
end)

ccb.runtime.handler("wave14a_dda_stat_4", function(payload)
    return ((char_artifact_resonance(payload.speaker) / 40) + 15)
end)

ccb.runtime.handler("wave14a_dda_stat_5", function(payload)
    return ((char_artifact_resonance(payload.speaker) / 200) + 2)
end)

ccb.runtime.handler("wave14a_dda_stat_6", function(payload)
    return ((char_artifact_resonance(payload.speaker) / 100) + 8)
end)

ccb.runtime.handler("wave14a_dda_stat_7", function(payload)
    return (2 * jmath_scaling_factor(payload, (get_actor_var_num(payload.speaker, "grappled") * 4)))
end)

ccb.runtime.handler("wave14a_dda_stat_8", function(payload)
    return (2 * jmath_scaling_factor(payload, (get_actor_var_num(payload.speaker, "grappled") * 6)))
end)
