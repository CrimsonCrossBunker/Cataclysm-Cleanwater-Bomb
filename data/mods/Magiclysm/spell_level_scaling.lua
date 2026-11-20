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

scale_with_level("scaled_animist_do_psionic_damage_to_head_min_damage", "animist_do_psionic_damage_to_head",
    function(level) return 10 + level * 2.5 end)
scale_with_level("scaled_animist_do_psionic_damage_to_head_max_damage", "animist_do_psionic_damage_to_head",
    function(level) return 25 + level * 6 end)
scale_with_level("scaled_animist_do_psionic_damage_to_head_min_duration", "animist_do_psionic_damage_to_head",
    function(level) return 150 + level * 10 end)
scale_with_level("scaled_animist_do_psionic_damage_to_head_max_duration", "animist_do_psionic_damage_to_head",
    function(level) return 250 + level * 25 end)

scale_with_level("scaled_animist_magic_fissile_min_damage", "animist_magic_fissile",
    function(level) return level * 0.75 + 0 end)
scale_with_level("scaled_animist_magic_fissile_max_damage", "animist_magic_fissile",
    function(level) return level * 1 + 3 end)

scale_with_level("scaled_animist_mass_hiding_self_min_duration", "animist_mass_hiding_aoe",
    function(level) return level * 3000 + 3000 end)

scale_with_level("scaled_assassin_strike_min_damage", "assassin_strike",
    function(level) return level * 4.6 + 14 end)
scale_with_level("scaled_assassin_strike_max_damage", "assassin_strike",
    function(level) return level * 10.4 + 21 end)

scale_with_level("scaled_auroral_wave_min_damage", "auroral_wave",
    function(level) return level * 1.1 + 25 end)
scale_with_level("scaled_auroral_wave_max_damage", "auroral_wave",
    function(level) return level * 2.4 + 45 end)
scale_with_level("scaled_auroral_wave_cold_min_damage", "auroral_wave",
    function(level) return level * 0.8 + 11 end)
scale_with_level("scaled_auroral_wave_cold_max_damage", "auroral_wave",
    function(level) return level * 1.4 + 23 end)

scale_with_level("scaled_bio_acidicspray_min_damage", "bio_acidicspray",
    function(level) return level * 1.5 + 0 end)
scale_with_level("scaled_bio_acidicspray_max_damage", "bio_acidicspray",
    function(level) return level * 3 + 3 end)

scale_with_level("scaled_biomancer_paralytic_dart_min_damage", "biomancer_paralytic_dart",
    function(level) return level * 0.8 + 0 end)
scale_with_level("scaled_biomancer_paralytic_dart_max_damage", "biomancer_paralytic_dart",
    function(level) return level * 1.3 + 4 end)

scale_with_level("scaled_biomancer_pull_items_from_distance_min_damage", "biomancer_pull_items_from_distance",
    function(level) return 350 - level * 12 end)

scale_with_level("scaled_biotek_healing_min_damage", "biotek_healing",
    function(level) return level * -0.4 - 2 end)
scale_with_level("scaled_biotek_healing_max_damage", "biotek_healing",
    function(level) return level * -0.85 - 5 end)

scale_with_level("scaled_bleed_min_dot", "bleed",
    function(level) return level * 0.3 + 0.2 end)

scale_with_level("scaled_blinding_flash_min_damage", "blinding_flash",
    function(level) return level * 0.1 + 1 end)
scale_with_level("scaled_blinding_flash_max_damage", "blinding_flash",
    function(level) return level * 0.4 + 2 end)

scale_with_level("scaled_burn_at_both_ends_min_damage", "burn_at_both_ends",
    function(level) return level * 4.2 + 11 end)
scale_with_level("scaled_burn_at_both_ends_max_damage", "burn_at_both_ends",
    function(level) return level * 8.1 + 19 end)

scale_with_level("scaled_burning_hands_min_damage", "burning_hands",
    function(level) return level * 1 + 2 end)
scale_with_level("scaled_burning_hands_max_damage", "burning_hands",
    function(level) return level * 2.6 + 8 end)

scale_with_level("scaled_chilling_touch_min_damage", "chilling_touch",
    function(level) return level * 0.75 + 1 end)
scale_with_level("scaled_chilling_touch_max_damage", "chilling_touch",
    function(level) return level * 2.3 + 6 end)

scale_with_level("scaled_classless_restore_crystal_mana_min_damage", "classless_restore_crystal_mana",
    function(level) return level * 10 + 50 end)
scale_with_level("scaled_classless_restore_crystal_mana_max_damage", "classless_restore_crystal_mana",
    function(level) return level * 30 + 150 end)

scale_with_level("scaled_cleansingflame_hermes_heal_min_damage", "cleansingflame_hermes_heal",
    function(level) return level * -1.1 - 8 end)
scale_with_level("scaled_cleansingflame_hermes_heal_max_damage", "cleansingflame_hermes_heal",
    function(level) return level * -2.2 - 15 end)

scale_with_level("scaled_cold_heart_min_damage", "cold_heart",
    function(level) return level * 0.5 + 5 end)
scale_with_level("scaled_cold_heart_max_damage", "cold_heart",
    function(level) return level * 1.3 + 12 end)

scale_with_level("scaled_cold_snap_min_damage", "cold_snap",
    function(level) return level * 1.9 + 8 end)
scale_with_level("scaled_cold_snap_max_damage", "cold_snap",
    function(level) return level * 3.2 + 14 end)

scale_with_level("scaled_cone_cold_min_damage", "cone_cold",
    function(level) return level * 0.8 + 6 end)
scale_with_level("scaled_cone_cold_max_damage", "cone_cold",
    function(level) return level * 2 + 12 end)

scale_with_level("scaled_demonic_possession_real_min_duration", "demonic_possession",
    function(level) return level * 30900 + 360000 end)

scale_with_level("scaled_disruption_bolt_min_damage", "disruption_bolt",
    function(level) return level * 0.5 + 5 end)
scale_with_level("scaled_disruption_bolt_max_damage", "disruption_bolt",
    function(level) return level * 1.5 + 10 end)

scale_with_level("scaled_druid_harvest_hunter_min_damage", "druid_harvest_hunter",
    function(level) return level * 1 + 2 end)
scale_with_level("scaled_druid_harvest_hunter_max_damage", "druid_harvest_hunter",
    function(level) return level * 3 + 6 end)

scale_with_level("scaled_druid_healing_herb_min_damage", "druid_healing_herb",
    function(level) return level * -0.7 - 2 end)
scale_with_level("scaled_druid_healing_herb_max_damage", "druid_healing_herb",
    function(level) return level * -1.5 - 5 end)

scale_with_level("scaled_druid_rootstrike_min_damage", "druid_rootstrike",
    function(level) return level * 0.8 + 8 end)
scale_with_level("scaled_druid_rootstrike_max_damage", "druid_rootstrike",
    function(level) return level * 1.5 + 14 end)

scale_with_level("scaled_druid_woodshaft_min_damage", "druid_woodshaft",
    function(level) return level * 0.333 + 1 end)
scale_with_level("scaled_druid_woodshaft_max_damage", "druid_woodshaft",
    function(level) return level * 0.9 + 3 end)

scale_with_level("scaled_druidic_healing_min_damage", "druidic_healing",
    function(level) return level * -1 - 2 end)
scale_with_level("scaled_druidic_healing_max_damage", "druidic_healing",
    function(level) return level * -2 - 5 end)

scale_with_level("scaled_earthshaper_map_real_min_aoe", "earthshaper_reveal_world_map",
    function(level) return 7 + level * 2.2 end)

scale_with_level("scaled_electric_waves_damage_min_damage", "electric_waves",
    function(level) return level * 0.4 + 1 end)
scale_with_level("scaled_electric_waves_damage_max_damage", "electric_waves",
    function(level) return level * 0.75 + 6 end)

scale_with_level("scaled_eshaper_impalement_min_damage", "eshaper_impalement",
    function(level) return level * 1.5 + 4 end)
scale_with_level("scaled_eshaper_impalement_max_damage", "eshaper_impalement",
    function(level) return level * 3.2 + 8 end)

scale_with_level("scaled_eshaper_piercing_bolt_min_damage", "eshaper_piercing_bolt",
    function(level) return level * 1 + 4 end)
scale_with_level("scaled_eshaper_piercing_bolt_max_damage", "eshaper_piercing_bolt",
    function(level) return level * 2.2 + 8 end)

scale_with_level("scaled_eshaper_rockbolt_min_damage", "eshaper_rockbolt",
    function(level) return level * 0.4 + 2 end)
scale_with_level("scaled_eshaper_rockbolt_max_damage", "eshaper_rockbolt",
    function(level) return level * 1.2 + 4 end)

scale_with_level("scaled_eshaper_shardstorm_min_damage", "eshaper_shardstorm",
    function(level) return level * 0.5 + 6 end)
scale_with_level("scaled_eshaper_shardstorm_max_damage", "eshaper_shardstorm",
    function(level) return level * 1.5 + 12 end)

scale_with_level("scaled_eshaper_spawn_hammer_min_duration", "eshaper_spawn_tools",
    function(level) return level * 576000 end)
scale_with_level("scaled_eshaper_spawn_pickaxe_max_duration", "eshaper_spawn_tools",
    function(level) return level * 576000 end)
scale_with_level("scaled_eshaper_spawn_shovel_min_duration", "eshaper_spawn_tools",
    function(level) return level * 576000 end)

scale_with_level("scaled_explosive_decompression_min_damage", "explosive_decompression",
    function(level) return level * 1.2 + 12 end)
scale_with_level("scaled_explosive_decompression_max_damage", "explosive_decompression",
    function(level) return level * 3 + 22 end)

scale_with_level("scaled_fireball_min_damage", "fireball",
    function(level) return level * 0.8 + 6 end)
scale_with_level("scaled_fireball_max_damage", "fireball",
    function(level) return level * 2 + 12 end)

scale_with_level("scaled_flareup_min_damage", "flareup",
    function(level) return level * 4.1 + 8 end)
scale_with_level("scaled_flareup_max_damage", "flareup",
    function(level) return level * 6.9 + 20 end)

scale_with_level("scaled_focused_bolt_min_damage", "focused_bolt",
    function(level) return level * 1 + 1 end)
scale_with_level("scaled_focused_bolt_max_damage", "focused_bolt",
    function(level) return level * 3 + 4 end)

scale_with_level("scaled_force_blade_min_damage", "force_blade",
    function(level) return level * 4.5 + 31 end)
scale_with_level("scaled_force_blade_max_damage", "force_blade",
    function(level) return level * 8.6 + 49 end)

scale_with_level("scaled_freezing_touch_min_damage", "freezing_touch",
    function(level) return level * 1.2 + 12 end)
scale_with_level("scaled_freezing_touch_max_damage", "freezing_touch",
    function(level) return level * 4.1 + 22 end)

scale_with_level("scaled_frost_spray_min_damage", "frost_spray",
    function(level) return level * 1 + 2 end)
scale_with_level("scaled_frost_spray_max_damage", "frost_spray",
    function(level) return level * 2.6 + 8 end)

scale_with_level("scaled_frozen_winds_min_damage", "frozen_winds",
    function(level) return level * 0.4 + 9 end)
scale_with_level("scaled_frozen_winds_max_damage", "frozen_winds",
    function(level) return level * 1.3 + 16 end)

scale_with_level("scaled_gaiaschosen_samsara_min_damage", "gaiaschosen_samsara",
    function(level) return level * -1.6 - 5 end)
scale_with_level("scaled_gaiaschosen_samsara_max_damage", "gaiaschosen_samsara",
    function(level) return level * -4 - 12 end)

scale_with_level("scaled_gravitymage_graviton_damage_min_damage", "gravitymage_graviton",
    function(level) return level * 0.4 + 10 end)
scale_with_level("scaled_gravitymage_graviton_damage_max_damage", "gravitymage_graviton",
    function(level) return level * 0.7 + 17 end)
scale_with_level("scaled_gravitymage_graviton_centerdamage_min_damage", "gravitymage_graviton",
    function(level) return level * 0.8 + 14 end)
scale_with_level("scaled_gravitymage_graviton_centerdamage_max_damage", "gravitymage_graviton",
    function(level) return level * 1.5 + 26 end)

scale_with_level("scaled_hoary_blast_min_damage", "hoary_blast",
    function(level) return level * 0.6 + 6 end)
scale_with_level("scaled_hoary_blast_max_damage", "hoary_blast",
    function(level) return level * 2 + 12 end)

scale_with_level("scaled_ice_clave_min_damage", "ice_clave",
    function(level) return level * 0.5 + 12 end)
scale_with_level("scaled_ice_clave_max_damage", "ice_clave",
    function(level) return level * 1.4 + 20 end)

scale_with_level("scaled_ice_spike_min_damage", "ice_spike",
    function(level) return level * 1.5 + 9 end)
scale_with_level("scaled_ice_spike_max_damage", "ice_spike",
    function(level) return level * 3 + 18 end)

scale_with_level("scaled_immolate_min_damage", "immolate",
    function(level) return level * 2.6 + 61 end)
scale_with_level("scaled_immolate_max_damage", "immolate",
    function(level) return level * 4.1 + 79 end)

scale_with_level("scaled_jolt_min_damage", "jolt",
    function(level) return level * 1.2 + 2 end)
scale_with_level("scaled_jolt_max_damage", "jolt",
    function(level) return level * 2.3 + 6 end)

scale_with_level("scaled_kelvinist_firebolt_min_damage", "kelvinist_firebolt",
    function(level) return level * 0.4 + 3 end)
scale_with_level("scaled_kelvinist_firebolt_max_damage", "kelvinist_firebolt",
    function(level) return level * 0.8 + 8 end)

scale_with_level("scaled_kelvinist_flamebreath_min_damage", "kelvinist_flamebreath",
    function(level) return level * 0.6 + 6 end)
scale_with_level("scaled_kelvinist_flamebreath_max_damage", "kelvinist_flamebreath",
    function(level) return level * 1.8 + 12 end)

scale_with_level("scaled_lava_bomb_main_min_damage", "lava_bomb_main",
    function(level) return level * 1.3 + 6 end)
scale_with_level("scaled_lava_bomb_main_max_damage", "lava_bomb_main",
    function(level) return level * 3.1 + 14 end)
scale_with_level("scaled_lava_bomb_heat_min_damage", "lava_bomb_main",
    function(level) return level * 0.9 + 1 end)
scale_with_level("scaled_lava_bomb_heat_max_damage", "lava_bomb_main",
    function(level) return level * 2.5 + 5 end)

scale_with_level("scaled_laze_min_damage", "laze",
    function(level) return level * 0.8 + 4 end)
scale_with_level("scaled_laze_max_damage", "laze",
    function(level) return level * 2 + 10 end)

scale_with_level("scaled_life_drain_min_damage", "life_drain",
    function(level) return level * 0.3 + 4 end)
scale_with_level("scaled_life_drain_max_damage", "life_drain",
    function(level) return level * 1 + 9 end)

scale_with_level("scaled_light_healing_min_damage", "light_healing",
    function(level) return level * -0.5 - 1 end)
scale_with_level("scaled_light_healing_max_damage", "light_healing",
    function(level) return level * -1.1 - 4 end)

scale_with_level("scaled_lightning_blast_min_damage", "lightning_blast",
    function(level) return level * 0.9 + 2 end)
scale_with_level("scaled_lightning_blast_max_damage", "lightning_blast",
    function(level) return level * 2.1 + 8 end)

scale_with_level("scaled_lightning_bolt_min_damage", "lightning_bolt",
    function(level) return level * 1.5 + 4 end)
scale_with_level("scaled_lightning_bolt_max_damage", "lightning_bolt",
    function(level) return level * 4 + 8 end)

scale_with_level("scaled_lightning_storm_min_damage", "lightning_storm",
    function(level) return level * 1.1 + 4 end)
scale_with_level("scaled_lightning_storm_max_damage", "lightning_storm",
    function(level) return level * 3.3 + 12 end)
scale_with_level("scaled_lightning_blast_from_storm_min_damage", "lightning_storm",
    function(level) return level * 0.9 + 2 end)
scale_with_level("scaled_lightning_blast_from_storm_max_damage", "lightning_storm",
    function(level) return level * 2.1 + 8 end)

scale_with_level("scaled_mag_summon_mushrooms_min_damage", "mag_summon_mushrooms",
    function(level) return level + 3 end)
scale_with_level("scaled_mag_summon_mushrooms_max_damage", "mag_summon_mushrooms",
    function(level) return level + 8 end)

scale_with_level("scaled_magic_missile_min_damage", "magic_missile",
    function(level) return level * 0.75 + 0 end)
scale_with_level("scaled_magic_missile_max_damage", "magic_missile",
    function(level) return level * 1 + 3 end)

scale_with_level("scaled_magnetismmage_electrolaser_min_damage", "magnetismmage_electrolaser",
    function(level) return level * 0.5 + 5 end)
scale_with_level("scaled_magnetismmage_electrolaser_max_damage", "magnetismmage_electrolaser",
    function(level) return level * 1.3 + 12 end)
scale_with_level("scaled_magnetismmage_electrolaser_electro_min_damage", "magnetismmage_electrolaser",
    function(level) return level * 1 + 5 end)
scale_with_level("scaled_magnetismmage_electrolaser_electro_max_damage", "magnetismmage_electrolaser",
    function(level) return level * 2.9 + 12 end)

scale_with_level("scaled_magus_far_hand_pull_creatures_min_damage", "magus_far_hand_pull",
    function(level) return level * -1 end)
scale_with_level("scaled_magus_far_hand_pull_creatures_min_range", "magus_far_hand_pull",
    function(level) return level * 1 + 3 end)
scale_with_level("scaled_magus_far_hand_pull_items_min_damage", "magus_far_hand_pull",
    function(level) return 250 - level * 10 end)

scale_with_level("scaled_magus_mana_beam_min_damage", "magus_mana_beam",
    function(level) return level * 1.2 + 6 end)
scale_with_level("scaled_magus_mana_beam_max_damage", "magus_mana_beam",
    function(level) return level * 2 + 11 end)

scale_with_level("scaled_magus_mana_blast_min_damage", "magus_mana_blast",
    function(level) return level * 1.1 + 12 end)
scale_with_level("scaled_magus_mana_blast_max_damage", "magus_mana_blast",
    function(level) return level * 2.4 + 18 end)

scale_with_level("scaled_magus_mana_bolt_min_damage", "magus_mana_bolt",
    function(level) return level * 2 + 12 end)
scale_with_level("scaled_magus_mana_bolt_max_damage", "magus_mana_bolt",
    function(level) return level * 4.1 + 24 end)

scale_with_level("scaled_manatouched_seeker_bolts_min_damage", "manatouched_seeker_bolts",
    function(level) return level * 0.4 + 1 end)
scale_with_level("scaled_manatouched_seeker_bolts_max_damage", "manatouched_seeker_bolts",
    function(level) return level * 0.8 + 3 end)

scale_with_level("scaled_megablast_min_damage", "megablast",
    function(level) return level * 1.2 + 3 end)
scale_with_level("scaled_megablast_max_damage", "megablast",
    function(level) return level * 3 + 10 end)

scale_with_level("scaled_necrotic_gaze_min_damage", "necrotic_gaze",
    function(level) return level * 2 + 4 end)
scale_with_level("scaled_necrotic_gaze_max_damage", "necrotic_gaze",
    function(level) return level * 5 + 8 end)

scale_with_level("scaled_nitro_boost_min_damage", "nitro_boost",
    function(level) return level * 4 + 0 end)
scale_with_level("scaled_nitro_boost_max_damage", "nitro_boost",
    function(level) return level * 8.3 + 10 end)

scale_with_level("scaled_nova_flare_min_damage", "nova_flare",
    function(level) return level * 2 + 15 end)
scale_with_level("scaled_nova_flare_max_damage", "nova_flare",
    function(level) return level * 4.5 + 28 end)

scale_with_level("scaled_overcharge_eyes_min_damage", "overcharge_eyes",
    function(level) return level * 1.8 + 50 end)
scale_with_level("scaled_overcharge_eyes_max_damage", "overcharge_eyes",
    function(level) return level * 3.8 + 70 end)

scale_with_level("scaled_permafrost_mage_ice_age_min_damage", "permafrost_mage_ice_age",
    function(level) return level * 0.9 + 5 end)
scale_with_level("scaled_permafrost_mage_ice_age_max_damage", "permafrost_mage_ice_age",
    function(level) return level * 2.1 + 12 end)

scale_with_level("scaled_point_flare_min_damage", "point_flare",
    function(level) return level * 1.4 + 4 end)
scale_with_level("scaled_point_flare_max_damage", "point_flare",
    function(level) return level * 3.3 + 8 end)

scale_with_level("scaled_quake_min_damage", "quake",
    function(level) return level * 1.9 + 6 end)
scale_with_level("scaled_quake_max_damage", "quake",
    function(level) return level * 3.1 + 14 end)

scale_with_level("scaled_railgun_min_damage", "railgun",
    function(level) return level * 4.7 + 65 end)
scale_with_level("scaled_railgun_max_damage", "railgun",
    function(level) return level * 8.3 + 80 end)

scale_with_level("scaled_reactive_armor_min_damage", "reactive_armor",
    function(level) return level * 3 + 8 end)
scale_with_level("scaled_reactive_armor_max_damage", "reactive_armor",
    function(level) return level * 7 + 15 end)

scale_with_level("scaled_recover_bionic_power_min_damage", "recover_bionic_power",
    function(level) return level * 80 + 125 end)
scale_with_level("scaled_recover_bionic_power_max_damage", "recover_bionic_power",
    function(level) return level * 200 + 300 end)

scale_with_level("scaled_recover_mana_min_damage", "recover_mana",
    function(level) return level * 10 + 30 end)
scale_with_level("scaled_recover_mana_max_damage", "recover_mana",
    function(level) return level * 20 + 70 end)

scale_with_level("scaled_recover_pain_min_damage", "recover_pain",
    function(level) return level * 1 + 5 end)
scale_with_level("scaled_recover_pain_max_damage", "recover_pain",
    function(level) return level * 2 + 10 end)

scale_with_level("scaled_recover_sleepiness_min_damage", "recover_sleepiness",
    function(level) return level * 4 + 10 end)
scale_with_level("scaled_recover_sleepiness_max_damage", "recover_sleepiness",
    function(level) return level * 8 + 25 end)

scale_with_level("scaled_recover_stamina_min_damage", "recover_stamina",
    function(level) return level * 350 + 500 end)
scale_with_level("scaled_recover_stamina_max_damage", "recover_stamina",
    function(level) return level * 650 + 850 end)

scale_with_level("scaled_robot_disabler_explosion_min_damage", "robot_disabler_explosion",
    function(level) return level * 3.1 + 5 end)
scale_with_level("scaled_robot_disabler_explosion_max_damage", "robot_disabler_explosion",
    function(level) return level * 7.9 + 12 end)

scale_with_level("scaled_rock_blast_min_damage", "rock_blast",
    function(level) return level * 1.7 + 6 end)
scale_with_level("scaled_rock_blast_max_damage", "rock_blast",
    function(level) return level * 3.8 + 14 end)

scale_with_level("scaled_rupture_min_damage", "rupture",
    function(level) return level * 0.5 + 0 end)
scale_with_level("scaled_rupture_max_damage", "rupture",
    function(level) return level * 2 + 10 end)

scale_with_level("scaled_shapeshifter_alkahest_min_damage", "shapeshifter_alkahest",
    function(level) return level * 0.5 + 1 end)
scale_with_level("scaled_shapeshifter_alkahest_max_damage", "shapeshifter_alkahest",
    function(level) return level * 1.2 + 4 end)

scale_with_level("scaled_shocking_lash_base_min_damage", "shocking_lash",
    function(level) return level * 0.3 + 1 end)
scale_with_level("scaled_shocking_lash_base_max_damage", "shocking_lash",
    function(level) return level * 1.1 + 1 end)

scale_with_level("scaled_shocking_teleport_damage_min_damage", "shocking_teleport",
    function(level) return level * 1.2 + 2 end)
scale_with_level("scaled_shocking_teleport_damage_max_damage", "shocking_teleport",
    function(level) return level * 2.2 + 14 end)

scale_with_level("scaled_shortwave_2_min_damage", "shortwave",
    function(level) return level * 3.7 + 26 end)
scale_with_level("scaled_shortwave_2_max_damage", "shortwave",
    function(level) return level * 8.4 + 51 end)

scale_with_level("scaled_smite_min_damage", "smite",
    function(level) return level * 5 + 5 end)
scale_with_level("scaled_smite_max_damage", "smite",
    function(level) return level * 9 + 10 end)

scale_with_level("scaled_solar_beam_min_damage", "solar_beam",
    function(level) return level * 3.4 + 8 end)
scale_with_level("scaled_solar_beam_max_damage", "solar_beam",
    function(level) return level * 5.9 + 14 end)

scale_with_level("scaled_spear_of_light_min_damage", "spear_of_light",
    function(level) return level * 4.2 + 12 end)
scale_with_level("scaled_spear_of_light_max_damage", "spear_of_light",
    function(level) return level * 7.4 + 25 end)

scale_with_level("scaled_storm_chain_master_min_damage", "storm_chain_master",
    function(level) return level * 0.5 + 1 end)
scale_with_level("scaled_storm_chain_master_max_damage", "storm_chain_master",
    function(level) return level * 1.4 + 6 end)

scale_with_level("scaled_storm_shipwrecker_min_damage", "storm_shipwrecker",
    function(level) return level * 1.8 + 12 end)
scale_with_level("scaled_storm_shipwrecker_max_damage", "storm_shipwrecker",
    function(level) return level * 3.5 + 22 end)

scale_with_level("scaled_storm_superconductor_min_damage", "storm_superconductor",
    function(level) return level * 1.8 + 10 end)
scale_with_level("scaled_storm_superconductor_max_damage", "storm_superconductor",
    function(level) return level * 4.6 + 25 end)

scale_with_level("scaled_stormshaper_air_blast_min_damage", "stormshaper_air_blast",
    function(level) return level * 0.5 - 2 end)
scale_with_level("scaled_stormshaper_air_blast_max_damage", "stormshaper_air_blast",
    function(level) return level * 1 + 1 end)

scale_with_level("scaled_stormshaper_cloak_fog_wonder_min_damage", "stormshaper_cloak_of_fog",
    function(level) return level * 0.5 + 2 end)

scale_with_level("scaled_stormshaper_cloak_frog_summon_wonder_min_damage", "stormshaper_cloak_of_frog",
    function(level) return level * 1 + 1 end)
scale_with_level("scaled_stormshaper_cloak_frog_summon_min_duration", "stormshaper_cloak_of_frog",
    function(level) return level * 3750 + 15000 end)

scale_with_level("scaled_stormshaper_heart_of_hurricane_throw_max_damage", "stormshaper_heart_of_hurricane",
    function(level) return level / 2 + 1 end)

scale_with_level("scaled_stormshaper_ionization_min_damage", "stormshaper_ionization",
    function(level) return level * 0.6 + 2 end)
scale_with_level("scaled_stormshaper_ionization_max_damage", "stormshaper_ionization",
    function(level) return level * 1.1 + 8 end)

scale_with_level("scaled_taze_min_damage", "taze",
    function(level) return level * 0.3 + 3 end)
scale_with_level("scaled_taze_max_damage", "taze",
    function(level) return level * 0.75 + 8 end)

scale_with_level("scaled_technomancer_knifeshot_min_damage", "technomancer_knifeshot",
    function(level) return level * 0.6 + 9 end)
scale_with_level("scaled_technomancer_knifeshot_max_damage", "technomancer_knifeshot",
    function(level) return level * 1.6 + 19 end)

scale_with_level("scaled_technomancer_recharge_vehicle_min_damage", "technomancer_recharge_vehicle",
    function(level) return level * 1650 + 1500 end)
scale_with_level("scaled_technomancer_recharge_vehicle_max_damage", "technomancer_recharge_vehicle",
    function(level) return level * 2400 + 2500 end)

scale_with_level("scaled_vacuum_decompression_min_damage", "vacuum_decompression",
    function(level) return level * 1.5 + 12 end)
scale_with_level("scaled_vacuum_decompression_max_damage", "vacuum_decompression",
    function(level) return level * 3.8 + 22 end)

scale_with_level("scaled_vulcanist_pyroclastic_flow_min_damage", "vulcanist_pyroclastic_flow",
    function(level) return level * 1.3 + 21 end)
scale_with_level("scaled_vulcanist_pyroclastic_flow_max_damage", "vulcanist_pyroclastic_flow",
    function(level) return level * 3.8 + 34 end)

scale_with_level("scaled_windstrike_min_damage", "windstrike",
    function(level) return level * 0.9 + 8 end)
scale_with_level("scaled_windstrike_max_damage", "windstrike",
    function(level) return level * 2.1 + 18 end)
