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

scale_with_level("scaled_iso_eldritch_basic_attack_min_damage", "iso_eldritch_basic_attack",
    function(level) return (level * 1.8 + 5) / 2 end)
scale_with_level("scaled_iso_eldritch_basic_attack_max_damage", "iso_eldritch_basic_attack",
    function(level) return (level * 3.6 + 10) / 2 end)
scale_with_level("scaled_iso_eldritch_imprisonment_min_duration", "iso_eldritch_basic_attack",
    function(level) return level * 75 + 300 end)
scale_with_level("scaled_iso_eldritch_imprisonment_max_duration", "iso_eldritch_basic_attack",
    function(level) return level * 150 + 1200 end)

scale_with_level("scaled_iso_eldritch_cold_damage_over_time_min_damage", "iso_eldritch_cold_damage_over_time",
    function(level) return level * 0.6 + 4 end)
scale_with_level("scaled_iso_eldritch_cold_damage_over_time_max_damage", "iso_eldritch_cold_damage_over_time",
    function(level) return level * 1.1 + 9 end)
scale_with_level("scaled_iso_eldritch_cold_damage_over_time_min_dot", "iso_eldritch_cold_damage_over_time",
    function(level) return level * 0.03 + 0.3 end)
scale_with_level("scaled_iso_eldritch_cold_damage_over_time_max_dot", "iso_eldritch_cold_damage_over_time",
    function(level) return level * 0.06 + 0.8 end)
scale_with_level("scaled_iso_eldritch_cold_damage_over_time_min_duration", "iso_eldritch_cold_damage_over_time",
    function(level) return level * 150 + 1000 end)
scale_with_level("scaled_iso_eldritch_cold_damage_over_time_max_duration", "iso_eldritch_cold_damage_over_time",
    function(level) return level * 250 + 2500 end)

scale_with_level("scaled_iso_eldritch_cone_lightning_min_damage", "iso_eldritch_cone_lightning",
    function(level) return level * 1.1 + 8 end)
scale_with_level("scaled_iso_eldritch_cone_lightning_max_damage", "iso_eldritch_cone_lightning",
    function(level) return level * 2.7 + 20 end)
scale_with_level("scaled_iso_eldritch_cold_damage_blast_min_damage", "iso_eldritch_cone_lightning",
    function(level) return level * 1.9 + 20 end)
scale_with_level("scaled_iso_eldritch_cold_damage_blast_max_damage", "iso_eldritch_cone_lightning",
    function(level) return level * 4.1 + 45 end)

scale_with_level("scaled_iso_eldritch_cure_poison_disease_gas_min_duration", "iso_eldritch_cure_poison_disease_gas",
    function(level) return level * 1185 + 1532 end)
scale_with_level("scaled_iso_eldritch_cure_poison_disease_gas_max_duration", "iso_eldritch_cure_poison_disease_gas",
    function(level) return level * 2218 + 3420 end)

scale_with_level("scaled_iso_eldritch_line_biting_acid_min_damage", "iso_eldritch_line_biting_acid",
    function(level) return level * 1.4 + 14 end)
scale_with_level("scaled_iso_eldritch_line_biting_acid_max_damage", "iso_eldritch_line_biting_acid",
    function(level) return level * 3.3 + 35 end)

scale_with_level("scaled_iso_eldritch_mass_aoe_zombie_destruction_min_damage", "iso_eldritch_mass_aoe_zombie_destruction",
    function(level) return level * 3 + 25 end)
scale_with_level("scaled_iso_eldritch_mass_aoe_zombie_destruction_max_damage", "iso_eldritch_mass_aoe_zombie_destruction",
    function(level) return level * 6 + 75 end)

scale_with_level("scaled_iso_eldritch_polymorph_min_damage", "iso_eldritch_polymorph",
    function(level) return level * 3.1 + 30 end)
scale_with_level("scaled_iso_eldritch_polymorph_max_damage", "iso_eldritch_polymorph",
    function(level) return level * 7.1 + 70 end)
