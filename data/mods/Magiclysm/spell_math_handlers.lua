local ccb = require("ccb")
local services = ccb.services

local function truthy(v)
    return v ~= false and v ~= nil and v ~= 0
end

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

local function char_proficiency_pct(actor, prof_id)
    if not actor then
        return 0
    end
    local gid = safe_id("proficiency", prof_id)
    if not gid then
        return 0
    end
    local r = services.proficiencies.get(actor, gid)
    if not r.ok or not r.value then
        return 0
    end
    return (r.value.practice or 0) * 100
end

local function char_has_proficiency(actor, prof_id)
    if not actor then
        return 0
    end
    local r = services.proficiencies.has_id_text(actor, prof_id)
    if not r.ok or not r.value then
        return 0
    end
    return 1
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

local function char_near_om_location(actor, loc_id, radius)
    if not actor then
        return false
    end
    local r = services.creatures.snapshot(actor)
    if not r.ok then
        return false
    end
    return services.overmap.matches_location_near(r.value.position:project_to("omt"), loc_id, radius)
end

local function jmath_magiclysm_spell_failure_transformation_proficiency_adjustments_damage(payload)
    return (((1 + ((truthy(char_has_proficiency(payload.speaker, "prof_magic_transformation_beginner"))) and (0.1) or (0))) + ((truthy(char_has_proficiency(payload.speaker, "prof_magic_transformation_apprentice"))) and (0.15) or (0))) + ((truthy(char_has_proficiency(payload.speaker, "prof_magic_transformation_master"))) and (0.2) or (0)))
end

local function jmath_summoning_proficiency_modifier(payload)
    return (1 + (((char_proficiency_pct(payload.speaker, "prof_magic_summon_beginner") / 1000) + (char_proficiency_pct(payload.speaker, "prof_magic_summon_apprentice") / 1000)) + (char_proficiency_pct(payload.speaker, "prof_magic_summon_master") / 1000)))
end

local function jmath_evocation_proficiency_modifier(payload)
    return (1 + (((char_proficiency_pct(payload.speaker, "prof_magic_evocation_beginner") / 1000) + (char_proficiency_pct(payload.speaker, "prof_magic_evocation_apprentice") / 1000)) + (char_proficiency_pct(payload.speaker, "prof_magic_evocation_master") / 1000)))
end

local function jmath_enhancement_proficiency_modifier(payload)
    return (1 + (((char_proficiency_pct(payload.speaker, "prof_magic_enhancement_beginner") / 1000) + (char_proficiency_pct(payload.speaker, "prof_magic_enhancement_apprentice") / 1000)) + (char_proficiency_pct(payload.speaker, "prof_magic_enhancement_master") / 1000)))
end

local function jmath_channeling_proficiency_modifier(payload)
    return (1 + (((char_proficiency_pct(payload.speaker, "prof_magic_channel_beginner") / 1000) + (char_proficiency_pct(payload.speaker, "prof_magic_channel_apprentice") / 1000)) + (char_proficiency_pct(payload.speaker, "prof_magic_channel_master") / 1000)))
end

ccb.runtime.handler("wave14a_magiclysm_stat_1", function(payload)
    return (((char_spell_level(payload.speaker, "biomancer_baleful_polymorph") * 1.5) + 10) * jmath_magiclysm_spell_failure_transformation_proficiency_adjustments_damage(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_2", function(payload)
    return (((char_spell_level(payload.speaker, "biomancer_baleful_polymorph") * 3.6) + 25) * jmath_magiclysm_spell_failure_transformation_proficiency_adjustments_damage(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_3", function(payload)
    return (1 + math.max(((char_spell_level(payload.speaker, "biomancer_baleful_polymorph") - 10) * 0.25), 0))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_4", function(payload)
    return (((char_spell_level(payload.speaker, "druid_naturebow1") * 24000) + 24000) * jmath_summoning_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_5", function(payload)
    return (((char_spell_level(payload.speaker, "druid_naturebow1") * 3) + 15) * jmath_summoning_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_6", function(payload)
    return (((char_spell_level(payload.speaker, "druid_naturebow1_plus") * 72000) + 360000) * jmath_summoning_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_7", function(payload)
    return (((char_spell_level(payload.speaker, "druid_naturebow1_plus") * 4) + 30) * jmath_summoning_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_cond_1", function(payload)
    return (creature_is_outside(payload.speaker) and (creature_on_terrain_flag(payload.speaker, "SHRUB") or creature_on_terrain_flag(payload.speaker, "DIGGABLE") or creature_on_terrain_flag(payload.speaker, "YOUNG")) and (not char_near_om_location(payload.speaker, "road", 1)))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_8", function(payload)
    return ((char_spell_level(payload.speaker, "eshaper_shardspray") * 0.8) + 10)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_9", function(payload)
    return ((char_spell_level(payload.speaker, "eshaper_shardspray") * 2) + 25)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_10", function(payload)
    return services.random.native_float(3, 8)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_11", function(payload)
    return (100 + ((char_spell_level(payload.speaker, "frost_armor") * 2) + (char_spell_level(payload.speaker, "frost_armor_plus") * 4)))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_12", function(payload)
    return (250 + ((char_spell_level(payload.speaker, "frost_armor") * 5) + (char_spell_level(payload.speaker, "frost_armor_plus") * 8)))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_13", function(payload)
    return ((get_actor_var_num(payload.speaker, "kelvinist_explosion_level") * 4) + 25)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_14", function(payload)
    return ((get_actor_var_num(payload.speaker, "kelvinist_explosion_level") * 10) + 45)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_15", function(payload)
    return ((get_actor_var_num(payload.speaker, "kelvinist_explosion_level") * 0.333) + 0)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_16", function(payload)
    return ((char_spell_level(payload.speaker, "technomancer_robot_shutdown") * (-15)) * jmath_evocation_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_17", function(payload)
    return ((char_spell_level(payload.speaker, "technomancer_robot_shutdown") * (-25)) * jmath_evocation_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_18", function(payload)
    return math.max((1500 + (char_spell_level(payload.speaker, "soul_afterburner") * 200)), 7500)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_19", function(payload)
    return math.max((1080000 - (char_spell_level(payload.speaker, "soul_afterburner") * 30000)), 540000)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_20", function(payload)
    return ((char_spell_level(payload.speaker, "voidmage_horizon_vortex") * 0.6) + 5)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_21", function(payload)
    return ((char_spell_level(payload.speaker, "voidmage_horizon_vortex") * 1.5) + 12)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_22", function(payload)
    return ((char_spell_level(payload.speaker, "lava_bomb_main") * 1.1) + 1)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_23", function(payload)
    return ((char_spell_level(payload.speaker, "lava_bomb_main") * 2.9) + 5)
end)

ccb.runtime.handler("wave14a_magiclysm_stat_24", function(payload)
    return ((char_spell_level(payload.speaker, "druid_water_walking") * 30000) * jmath_enhancement_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_25", function(payload)
    return ((char_spell_level(payload.speaker, "druid_water_walking") * 30000) + jmath_enhancement_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_magiclysm_stat_26", function(payload)
    return (((char_spell_level(payload.speaker, "druid_renew_forest_spell") * services.random.native_float(0.8, 1.2)) + services.random.native_float(1.5, 4)) * jmath_channeling_proficiency_modifier(payload))
end)
