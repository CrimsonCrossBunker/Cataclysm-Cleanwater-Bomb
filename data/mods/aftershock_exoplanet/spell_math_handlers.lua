local ccb = require("ccb")
local services = ccb.services

local function char_stat(actor, field)
    if not actor then
        return 0
    end
    local r = services.characters.snapshot(actor)
    if not r.ok then
        return 0
    end
    return r.value.stats[field] or 0
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

local function jmath_scaling_factor(payload, _0)
    return ((_0 + 10) / 20)
end

local function jmath_int_to_level(payload, _0)
    return ((char_stat(payload.speaker, "intelligence") * 1.5) * _0)
end

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_1", function(payload)
    return (((char_spell_level(payload.speaker, "afs_electrokinetic_shock_touch") * 1) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_2", function(payload)
    return (((char_spell_level(payload.speaker, "afs_electrokinetic_shock_touch") * 1.5) + 7) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_3", function(payload)
    return jmath_int_to_level(payload, 1)
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_4", function(payload)
    return (((char_spell_level(payload.speaker, "afs_electrokinetic_zap_enemies") * 8000) + 30000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_5", function(payload)
    return (((char_spell_level(payload.speaker, "afs_electrokinetic_zap_enemies") * 22500) + 80000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_6", function(payload)
    return (((char_spell_level(payload.speaker, "afs_electrokinetic_recharge_vehicle") * 125) + 250) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_7", function(payload)
    return (((char_spell_level(payload.speaker, "afs_electrokinetic_recharge_vehicle") * 250) + 500) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_8", function(payload)
    return (((char_spell_level(payload.speaker, "afs_electrokinetic_zap_enemies") / 4) + 1) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_9", function(payload)
    return (((char_spell_level(payload.speaker, "afs_electrokinetic_zap_enemies") / 2) + 5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_10", function(payload)
    return (((char_spell_level(payload.speaker, "afs_precog_damage_foresee") * 3000) + 30000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_11", function(payload)
    return (((char_spell_level(payload.speaker, "afs_precog_damage_foresee") * 5500) + 60000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_12", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telekinetic_hammer") * 1.25) + 18) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_13", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telekinetic_hammer") * 3.5) + 55) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_14", function(payload)
    return math.min((((char_spell_level(payload.speaker, "afs_telekinetic_hammer") * 0.9) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 70)
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_15", function(payload)
    return math.min((((char_spell_level(payload.speaker, "afs_telekinetic_move_item") * 0.4) + 1) * (jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")) * (-1))), 40)
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_16", function(payload)
    return math.min((((char_spell_level(payload.speaker, "afs_telekinetic_move_item") * 0.9) + 4) * (jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")) * (-1))), 40)
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_17", function(payload)
    return math.min((((char_spell_level(payload.speaker, "afs_telekinetic_move_item") * 0.9) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 40)
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_18", function(payload)
    return math.min((((char_spell_level(payload.speaker, "afs_telekinetic_move_item") * 0.4) + 1) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 40)
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_19", function(payload)
    return math.min((((char_spell_level(payload.speaker, "afs_telekinetic_move_item") * 0.9) + 4) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 40)
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_20", function(payload)
    return math.min((((char_spell_level(payload.speaker, "afs_telepathic_confusion") * 1.1) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 80)
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_21", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telepathic_confusion") * 50) + 200) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_22", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telepathic_confusion") * 150) + 800) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_23", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telepathic_confusion") * 2) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_24", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telepathic_confusion") * 100) + 400) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_25", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telepathic_confusion") * 100) + 2000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_26", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telepathic_blast") * 1.5) + 5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_27", function(payload)
    return (((char_spell_level(payload.speaker, "afs_telepathic_blast") * 3) + 5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_aftershock_exoplanet_stat_28", function(payload)
    return math.min((((char_spell_level(payload.speaker, "afs_telepathic_blast") * 1.1) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 80)
end)
