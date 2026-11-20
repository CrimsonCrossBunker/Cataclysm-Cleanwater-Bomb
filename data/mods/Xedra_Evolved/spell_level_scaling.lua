local ccb = require("ccb")
local spells = ccb.services.spells

local function scale_with_level(handler, source_spell, compute)
    ccb.runtime.handler(handler, function(context)
        local actor = context.speaker
        if actor == nil or (actor.subtype ~= "avatar" and actor.subtype ~= "npc" and actor.subtype ~= "character") then
            return compute(0)
        end
        local result = spells.effective_level(actor, source_spell)
        if not result.ok then error(result.error.message) end
        return compute(result.value)
    end)
end

scale_with_level("scaled_sylph_reveal_overmap_spell_real_min_aoe", "sylph_reveal_overmap_spell",
    function(level) return 10 + level * 3 end)

scale_with_level("scaled_vampire_map_real_min_aoe", "vampire_reveal_world_map",
    function(level) return 7 + level * 2.2 end)

scale_with_level("scaled_xe_nether_sorcery_cause_withering_damage_min_damage", "xe_nether_sorcery_cause_withering_damage",
    function(level) return level * 3 + 25 end)
scale_with_level("scaled_xe_nether_sorcery_cause_withering_damage_max_damage", "xe_nether_sorcery_cause_withering_damage",
    function(level) return level * 7.5 + 55 end)
scale_with_level("scaled_xe_nether_sorcery_cause_withering_damage_min_duration", "xe_nether_sorcery_cause_withering_damage",
    function(level) return level * 350 + 1200 end)
scale_with_level("scaled_xe_nether_sorcery_cause_withering_damage_max_duration", "xe_nether_sorcery_cause_withering_damage",
    function(level) return level * 1200 + 6000 end)

scale_with_level("scaled_xe_nether_sorcery_cold_damage_over_time_min_dot", "xe_nether_sorcery_cold_damage_over_time",
    function(level) return level * 0.03 + 0.3 end)
scale_with_level("scaled_xe_nether_sorcery_cold_damage_over_time_max_dot", "xe_nether_sorcery_cold_damage_over_time",
    function(level) return level * 0.06 + 0.8 end)
scale_with_level("scaled_xe_nether_sorcery_cold_damage_over_time_min_duration", "xe_nether_sorcery_cold_damage_over_time",
    function(level) return level * 150 + 800 end)
scale_with_level("scaled_xe_nether_sorcery_cold_damage_over_time_max_duration", "xe_nether_sorcery_cold_damage_over_time",
    function(level) return level * 350 + 2000 end)

scale_with_level("scaled_xe_nether_sorcery_wind_dodge_shell_min_duration", "xe_nether_sorcery_wind_dodge_shell",
    function(level) return level * 2132 + 15243 end)
scale_with_level("scaled_xe_nether_sorcery_wind_dodge_shell_max_duration", "xe_nether_sorcery_wind_dodge_shell",
    function(level) return level * 8167 + 38216 end)

scale_with_level("scaled_xedra_eater_erosion_attack_min_dot", "xedra_eater_erosion",
    function(level) return 1 + level / 10 end)
scale_with_level("scaled_xedra_eater_erosion_attack_min_duration", "xedra_eater_erosion",
    function(level) return level * 100 end)
