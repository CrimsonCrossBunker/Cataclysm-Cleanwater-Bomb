local ccb = require("ccb")
local services = ccb.services

local function char_skill(actor, skill_id)
    if not actor then
        return 0
    end
    local r = services.skills.level(actor, skill_id)
    if not r.ok then
        return 0
    end
    return r.value or 0
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

local function creature_is_outside(actor)
    if not actor then
        return false
    end
    local r = services.creatures.snapshot(actor)
    return r.ok and r.value.outside == true
end

local function creature_on_terrain_flag(actor, flag_id)
    if not actor then
        return false
    end
    local r = services.creatures.snapshot(actor)
    if not r.ok then
        return false
    end
    return services.gameplay.environment.terrain_has_flag(r.value.position, flag_id)
end

local function char_at_om_location(actor, loc_id)
    if not actor then
        return false
    end
    local r = services.creatures.snapshot(actor)
    if not r.ok then
        return false
    end
    return services.overmap.matches_location(r.value.position:project_to("omt"), loc_id)
end

local function jmath_xedrawood_forest_magic_modifiers(payload)
    return 1
end

ccb.runtime.handler("wave14a_xedrawood_stat_1", function(payload)
    return math.min((((8 + (char_spell_level(payload.speaker, "forest_commanding_grasses") * 0.85)) + (char_skill(payload.speaker, "deduction") * 1.2)) * jmath_xedrawood_forest_magic_modifiers(payload)), 35)
end)

ccb.runtime.handler("wave14a_xedrawood_stat_2", function(payload)
    return math.min((((3 + (char_spell_level(payload.speaker, "forest_commanding_grasses") * 0.5)) + (char_skill(payload.speaker, "deduction") * 0.75)) * jmath_xedrawood_forest_magic_modifiers(payload)), 35)
end)

ccb.runtime.handler("wave14a_xedrawood_stat_3", function(payload)
    return (((12182 + (char_spell_level(payload.speaker, "forest_bramble_spear") * 11826)) + (char_skill(payload.speaker, "deduction") * 21915)) * jmath_xedrawood_forest_magic_modifiers(payload))
end)

ccb.runtime.handler("wave14a_xedrawood_stat_4", function(payload)
    return (((26182 + (char_spell_level(payload.speaker, "forest_bramble_spear") * 23185)) + (char_skill(payload.speaker, "deduction") * 40952)) * jmath_xedrawood_forest_magic_modifiers(payload))
end)

ccb.runtime.handler("wave14a_xedrawood_stat_5", function(payload)
    return (((51384 + (char_spell_level(payload.speaker, "forest_unity_nature") * 14095)) + (char_skill(payload.speaker, "deduction") * 29813)) * jmath_xedrawood_forest_magic_modifiers(payload))
end)

ccb.runtime.handler("wave14a_xedrawood_stat_6", function(payload)
    return (((98045 + (char_spell_level(payload.speaker, "forest_unity_nature") * 44825)) + (char_skill(payload.speaker, "deduction") * 71805)) * jmath_xedrawood_forest_magic_modifiers(payload))
end)

ccb.runtime.handler("wave14a_xedrawood_cond_1", function(payload)
    return (creature_is_outside(payload.speaker) and (creature_on_terrain_flag(payload.speaker, "SHRUB") or creature_on_terrain_flag(payload.speaker, "DIGGABLE") or creature_on_terrain_flag(payload.speaker, "YOUNG")) and (char_at_om_location(payload.speaker, "forest") or char_at_om_location(payload.speaker, "forest_thick") or char_at_om_location(payload.speaker, "great_tree_z0_nw") or char_at_om_location(payload.speaker, "great_tree_z0_ne") or char_at_om_location(payload.speaker, "great_tree_z0_sw") or char_at_om_location(payload.speaker, "great_tree_z0_se")))
end)
