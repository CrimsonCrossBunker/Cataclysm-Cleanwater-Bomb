local ccb = require("ccb")
local services = ccb.services

local function safe_id(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then
        return nil
    end
    return gid
end

local function char_spell_level(actor, spell_id)
    if not actor then
        return -1
    end
    local r = services.spells.effective_level(actor, spell_id)
    if not r.ok or r.value == nil then
        return -1
    end
    return r.value
end

local function creature_effect_intensity(actor, effect_id, body_part)
    if not actor then
        return -1
    end
    local gid = safe_id("effect", effect_id)
    if not gid then
        return -1
    end
    local r
    if body_part then
        local bp_gid = safe_id("body_part", body_part)
        if not bp_gid then
            return -1
        end
        r = services.effects.exact_intensity(actor, gid, bp_gid)
    else
        r = services.effects.exact_intensity(actor, gid)
    end
    if not r.ok or r.value == nil then
        return -1
    end
    return r.value
end

ccb.runtime.handler("wave14a_isolation_protocol_stat_1", function(payload)
    return (((char_spell_level(payload.speaker, "iso_eldritch_mass_aoe_zombie_destruction") * 3) + 25) * (1 + creature_effect_intensity(payload.speaker, "magic_channeling")))
end)

ccb.runtime.handler("wave14a_isolation_protocol_stat_2", function(payload)
    return (((char_spell_level(payload.speaker, "iso_eldritch_mass_aoe_zombie_destruction") * 6) + 75) * (1 + (creature_effect_intensity(payload.speaker, "magic_channeling") / 10)))
end)

ccb.runtime.handler("wave14a_isolation_protocol_stat_3", function(payload)
    return (3 + math.min((char_spell_level(payload.speaker, "iso_eldritch_mass_aoe_zombie_destruction") * 2), creature_effect_intensity(payload.speaker, "magic_channeling")))
end)
