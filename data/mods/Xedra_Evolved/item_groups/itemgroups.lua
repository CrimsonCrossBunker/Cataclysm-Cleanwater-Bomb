local content = require("ccb").content

do
    local group = content.ItemGroup { id = "scientist_xe_base_CBM_harvest", kind = "distribution" }
    group:item("null", 80)
    group:group("Zomborg_CBM_harvest_utility", 1)
    group:item("xe_bio_data_shunt", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "scientist_xe_base_CBM_power_harvest", kind = "distribution" }
    group:item("null", 40)
    group:group("Zomborg_CBM_harvest_power", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zombie_oa_agent_CBM_harvest", kind = "collection" }
    group:group("Zomborg_CBM_harvest_utility", 2)
    group:group("Zomborg_CBM_harvest_structural", 3)
    group:group("Zomborg_CBM_harvest_combat", 2)
    group:item("xe_bio_data_shunt", 2)
    content.add(group)
end

do
    -- Dreamer artifact creation itemgroup.
    local group = content.ItemGroup { id = "dreamer_artifacts", kind = "distribution" }
    group:item("xe_art_clock")
    group:item("xe_art_rod")
    group:item("xe_art_monitor")
    group:item("xe_art_mess")
    group:item("xe_art_sculpture")
    group:item("xe_art_disc")
    group:item("xe_art_instrument")
    group:item("xe_art_napkin")
    group:item("xe_art_urchin")
    group:item("xe_art_jelly")
    group:item("xe_art_spiral")
    group:item("xe_art_pin")
    group:item("xe_art_tube")
    group:item("xe_art_pyramid")
    group:item("xe_art_crystal")
    group:item("xe_art_knot")
    group:item("xe_art_crescent")
    content.add(group)
end

do
    -- Dreamsmith artifact creation itemgroup.
    local group = content.ItemGroup { id = "dreamsmith_artifact", kind = "distribution" }
    group:group("dreamforged_boots_ench")
    group:group("dreamforged_armguard_plate_ench")
    group:group("dreamforged_plate_armor_ench")
    group:group("dreamforged_helmet_ench")
    group:group("dreamforged_fullhelmet_ench")
    group:group("dreamforged_knuckle_ench")
    group:group("dreamforged_lucerne_ench")
    group:group("dreamforged_khopesh_ench")
    group:group("dreamforged_zweihander_ench")
    group:group("dreamforged_wakizashi_ench")
    group:group("dreamforged_tanto_ench")
    group:group("dreamforged_rapier_ench")
    group:group("dreamforged_nodachi_ench")
    group:group("dreamforged_kukri_ench")
    group:group("dreamforged_kris_ench")
    group:group("dreamforged_knife_combat_ench")
    group:group("dreamforged_katana_ench")
    group:group("dreamforged_battleaxe_ench")
    group:group("dreamforged_broadsword_ench")
    group:group("dreamforged_arming_sword_ench")
    group:group("dreamforged_estoc_ench")
    group:group("dreamforged_morningstar_ench")
    group:group("dreamforged_mace_ench")
    group:group("dreamforged_naginata_ench")
    group:group("dreamforged_glaive_ench")
    group:group("dreamforged_halberd_ench")
    group:group("dreamforged_spear_ench")
    group:group("dreamforged_warhammer_ench")
    group:group("dreamforged_longsword_ench")
    group:group("dreamforged_q_staff_ench")
    content.add(group)
end

do
    -- Contains all goblin fruits except for the cloudy fruit, which is noble-exclusive.
    -- Using copy_from to not recopy the entire list multiple times is desired, but currently cause errors.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_wild_travel_boost", 1)
    group:item("goblin_fruit_slowing_armor", 1)
    group:item("goblin_fruit_social_boost", 1)
    group:item("goblin_fruit_heat_blast", 1)
    group:item("goblin_fruit_altitude_speed", 1)
    group:item("goblin_fruit_cold_resist", 1)
    group:item("goblin_fruit_craft_speed_boost", 1)
    group:item("goblin_fruit_call_rain", 1)
    group:item("goblin_fruit_animal_ignore", 1)
    group:item("goblin_fruit_mend_bone", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Ierde's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_ierde", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_slowing_armor", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Arvore's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_arvore", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_wild_travel_boost", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Homullus' exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_homullus", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_social_boost", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Salamander's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_salamander", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_heat_blast", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Sylph's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_sylph", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_altitude_speed", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Undine's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_undine", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_cold_resist", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Brownie's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_brownie", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_craft_speed_boost", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Selkie's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_selkie", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_call_rain", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Pooka's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_pooka", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_animal_ignore", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Trow's exlusive fruits.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_trow", kind = "distribution" }
    group:item("goblin_fruit_healing", 1)
    group:item("goblin_fruit_illness", 1)
    group:item("goblin_fruit_attack_speed", 1)
    group:item("goblin_fruit_pain", 1)
    group:item("goblin_fruit_awake", 1)
    group:item("goblin_fruit_water", 1)
    group:item("goblin_fruit_purge_blood", 1)
    group:item("goblin_fruit_dodge", 1)
    group:item("goblin_fruit_night_vision", 1)
    group:item("goblin_fruit_no_bleed", 1)
    group:item("goblin_fruit_perception", 1)
    group:item("goblin_fruit_no_drunk", 1)
    group:item("goblin_fruit_no_rotten_food", 1)
    group:item("goblin_fruit_feather_fall", 1)
    group:item("goblin_fruit_super_clairvoyance", 1)
    group:item("goblin_fruit_water_breathing", 1)
    group:item("goblin_fruit_giant_growth", 1)
    group:item("goblin_fruit_mana_restore", 1)
    group:item("goblin_fruit_stealth", 1)
    group:item("goblin_fruit_food", 1)
    group:item("goblin_fruit_soothing", 1)
    group:item("goblin_fruit_music", 1)
    group:item("goblin_fruit_combat_skill_boost", 1)
    group:item("goblin_fruit_craft_skill_boost", 1)
    group:item("goblin_fruit_immovable", 1)
    group:item("goblin_fruit_dodge_instant", 1)
    group:item("goblin_fruit_blood_gain", 1)
    group:item("goblin_fruit_blind_flash", 1)
    group:item("goblin_fruit_map", 1)
    group:item("goblin_fruit_adrenaline", 1)
    group:item("goblin_fruit_focus_boost", 1)
    group:item("goblin_fruit_spawn_more_fruits", 1)
    group:item("goblin_fruit_fun", 1)
    group:item("goblin_fruit_no_spoil", 1)
    group:item("goblin_fruit_numbing", 1)
    group:item("goblin_fruit_spawn_shadows", 1)
    group:item("goblin_fruit_heal_after_sleep", 1)
    group:item("goblin_fruit_teleport", 1)
    group:item("goblin_fruit_climb", 1)
    group:item("goblin_fruit_amplification_instant", 1)
    group:item("goblin_fruit_carry_boost", 1)
    group:item("goblin_fruit_mood_clear", 1)
    group:item("goblin_fruit_mend_bone", 1)
    content.add(group)
end

do
    -- Contains all non-exclusive goblin fruits and the Noble's exlusive fruits.
    -- Can't use copy_from as the cloudy fruit needs to be much more rare than the rest.
    local group = content.ItemGroup { id = "spell_spawned_goblin_fruit_noble", kind = "distribution" }
    group:item("goblin_fruit_healing", 3)
    group:item("goblin_fruit_illness", 3)
    group:item("goblin_fruit_attack_speed", 3)
    group:item("goblin_fruit_pain", 3)
    group:item("goblin_fruit_awake", 3)
    group:item("goblin_fruit_water", 3)
    group:item("goblin_fruit_purge_blood", 3)
    group:item("goblin_fruit_dodge", 3)
    group:item("goblin_fruit_night_vision", 3)
    group:item("goblin_fruit_no_bleed", 3)
    group:item("goblin_fruit_perception", 3)
    group:item("goblin_fruit_no_drunk", 3)
    group:item("goblin_fruit_no_rotten_food", 3)
    group:item("goblin_fruit_feather_fall", 3)
    group:item("goblin_fruit_super_clairvoyance", 3)
    group:item("goblin_fruit_water_breathing", 3)
    group:item("goblin_fruit_giant_growth", 3)
    group:item("goblin_fruit_mana_restore", 3)
    group:item("goblin_fruit_stealth", 3)
    group:item("goblin_fruit_food", 3)
    group:item("goblin_fruit_soothing", 3)
    group:item("goblin_fruit_music", 3)
    group:item("goblin_fruit_combat_skill_boost", 3)
    group:item("goblin_fruit_craft_skill_boost", 3)
    group:item("goblin_fruit_immovable", 3)
    group:item("goblin_fruit_dodge_instant", 3)
    group:item("goblin_fruit_blood_gain", 3)
    group:item("goblin_fruit_blind_flash", 3)
    group:item("goblin_fruit_map", 3)
    group:item("goblin_fruit_adrenaline", 3)
    group:item("goblin_fruit_focus_boost", 3)
    group:item("goblin_fruit_spawn_more_fruits", 3)
    group:item("goblin_fruit_fun", 3)
    group:item("goblin_fruit_no_spoil", 3)
    group:item("goblin_fruit_numbing", 3)
    group:item("goblin_fruit_spawn_shadows", 3)
    group:item("goblin_fruit_heal_after_sleep", 3)
    group:item("goblin_fruit_teleport", 3)
    group:item("goblin_fruit_climb", 3)
    group:item("goblin_fruit_amplification_instant", 3)
    group:item("goblin_fruit_carry_boost", 3)
    group:item("goblin_fruit_mood_clear", 3)
    group:item("goblin_fruit_cure_dreamless", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ierde_sample_single", kind = "collection" }
    group:item("ierde_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ierde_sample_small", kind = "collection" }
    group:entry { item = "ierde_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ierde_sample_large", kind = "collection" }
    group:entry { item = "ierde_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ierde_sample_huge", kind = "collection" }
    group:entry { item = "ierde_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arvore_sample_single", kind = "collection" }
    group:item("arvore_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arvore_sample_small", kind = "collection" }
    group:entry { item = "arvore_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arvore_sample_large", kind = "collection" }
    group:entry { item = "arvore_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arvore_sample_huge", kind = "collection" }
    group:entry { item = "arvore_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "undine_sample_single", kind = "collection" }
    group:item("undine_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "undine_sample_small", kind = "collection" }
    group:entry { item = "undine_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "undine_sample_large", kind = "collection" }
    group:entry { item = "undine_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "undine_sample_huge", kind = "collection" }
    group:entry { item = "undine_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salamander_sample_single", kind = "collection" }
    group:item("salamander_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salamander_sample_small", kind = "collection" }
    group:entry { item = "salamander_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salamander_sample_large", kind = "collection" }
    group:entry { item = "salamander_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salamander_sample_huge", kind = "collection" }
    group:entry { item = "salamander_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sylph_sample_single", kind = "collection" }
    group:item("sylph_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sylph_sample_small", kind = "collection" }
    group:entry { item = "sylph_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sylph_sample_large", kind = "collection" }
    group:entry { item = "sylph_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sylph_sample_huge", kind = "collection" }
    group:entry { item = "sylph_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "homullus_sample_single", kind = "collection" }
    group:item("homullus_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "homullus_sample_small", kind = "collection" }
    group:entry { item = "homullus_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "homullus_sample_large", kind = "collection" }
    group:entry { item = "homullus_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "homullus_sample_huge", kind = "collection" }
    group:entry { item = "homullus_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xed_office_dreamdross", kind = "distribution" }
    group:entry { item = "scrap_dreamdross", count = { 3, 20 }, probability = 250 }
    group:entry { item = "dreamdross_lump", count = { 1, 2 }, probability = 25 }
    group:item("forged_dreamstuff_ingot", 1)
    content.add(group)
end

do
    -- Lies should only spawn by hand in specific mapgen, not randomly
    local group = content.ItemGroup { id = "deduction_books", kind = "distribution" }
    group:item("mag_deduction", 25)
    group:item("mag_deduction_tabloid", 20)
    group:item("book_teens_deduction", 15)
    group:item("book_deduction_black_iron_prison", 10)
    group:item("book_deduction_out_of_place", 5)
    content.add(group)
end

do
    -- Itemgroup for lore snippet items in Xedra Offices and Labs.
    local group = content.ItemGroup { id = "xed_notes", kind = "distribution" }
    group:item("report_march_lord", 10)
    group:item("report_red_twilight_34", 10)
    group:item("border_patrol_files", 10)
    group:item("green_postit_field_agent", 40)
    group:item("agent_postit_gray", 50)
    group:item("agent_postit_migo", 20)
    content.add(group)
end

do
    -- Itemgroup for datacore items in Xedra Offices and Labs.
    local group = content.ItemGroup { id = "xe_datacores", kind = "distribution" }
    group:item("xe_bio_dataslot_giant_hunter", 1)
    group:item("xe_bio_dataslot_cyborg_hunting", 2)
    group:item("xe_bio_dataslot_migo_weakpoints", 3)
    group:item("xe_bio_dataslot_lockpicking", 4)
    group:item("xe_bio_dataslot_game_ui", 5)
    group:item("xe_bio_dataslot_parkour", 3)
    group:item("xe_bio_dataslot_helicopter_pilot", 4)
    group:item("xe_bio_dataslot_muay_thai", 1)
    group:item("xe_bio_dataslot_EOD", 2)
    content.add(group)
end

do
    -- Itemgroup for crafting recipes in Xedra Offices and Labs.
    local group = content.ItemGroup { id = "xed_books_crafting", kind = "distribution" }
    group:item("book_moons_tears_ingot", 10)
    content.add(group)
end

do
    -- a large pile of trash, made for monster lairs.
    local group = content.ItemGroup { id = "fae_meat_and_bones", kind = "collection" }
    group:item("fae_organs", 10)
    group:item("fae_fur", 10)
    group:item("fae_meat", 10)
    group:item("fae_meat_scrap", 40)
    group:item("fae_blood", 40)
    content.add(group)
end

do
    -- a large pile of trash, made for monster lairs.
    local group = content.ItemGroup { id = "dead_fae_gear", kind = "collection" }
    group:group("fae_furs", 20)
    group:group("bannerman_armor", 15)
    group:group("bannerman_weapons", 20)
    group:group("redcap_armor", 5)
    group:group("redcap_weapons", 5)
    group:group("pooka_armor", 5)
    group:group("pooka_weapons", 5)
    group:group("gossamer_upper_body", 10)
    group:group("gossamer_lower_body", 10)
    group:group("gossamer_outerwear", 10)
    group:group("gossamer_socks", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bannerman_armor", kind = "collection" }
    group:item("mt_chainmail_arms", 50)
    group:group("banner_group", 20)
    group:item("mt_chainmail_hood", 50)
    group:item("mt_chainmail_hands", 50)
    group:item("mt_chainmail_legs", 50)
    group:item("mt_chainmail_vest", 50)
    group:item("mt_chainmail_feet", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bannerman_weapons", kind = "distribution" }
    group:item("mirror_march_estoc", 5)
    group:item("moons_tears_mace", 20)
    group:item("moons_tears_scimitar", 20)
    group:item("moons_tears_broadsword", 20)
    group:item("moons_tears_arming_sword", 20)
    group:item("moons_tears_estoc", 20)
    group:item("moons_tears_spear", 30)
    group:item("moons_tears_battleaxe", 20)
    group:item("moons_tears_katana", 20)
    group:item("treesung_spear", 3)
    group:item("treesung_pike", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "banner_group", kind = "distribution" }
    group:item("banner_dark_forest", 20)
    group:item("banner_butterfly_knight", 20)
    group:item("banner_angry_darkness", 20)
    group:item("banner_starry_wisdom", 20)
    group:item("banner_thunderous_rush", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bannerlord_armor", kind = "collection" }
    group:item("mt_chainmail_arms", 45)
    group:item("mt_chainmail_hood", 45)
    group:item("mt_chainmail_hands", 45)
    group:item("mt_chainmail_legs", 45)
    group:item("mt_chainmail_vest", 45)
    group:item("mt_chainmail_feet", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "redcap_armor", kind = "distribution" }
    group:item("xl_mt_chainmail_arms", 20)
    group:group("redcap_headgear", 20)
    group:item("xl_mt_chainmail_hands", 20)
    group:item("xl_mt_chainmail_legs", 20)
    group:item("xl_mt_chainmail_vest", 20)
    group:item("xl_mt_chainmail_feet", 20)
    group:item("xl_boots_glimmer_fur", 20)
    group:item("xl_coat_glimmer_fur", 20)
    group:item("xl_duster_glimmer_fur", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "redcap_weapons", kind = "distribution" }
    group:item("redcap_club", 20)
    group:item("moons_tears_mace", 20)
    group:item("moons_tears_scimitar", 20)
    group:item("moons_tears_spear", 20)
    group:item("moons_tears_battleaxe", 20)
    group:item("treesung_mace", 3)
    group:item("treesung_warhammer", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "redcap_headgear", kind = "distribution" }
    group:item("xl_mt_chainmail_hood", 20)
    group:item("theredcap", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spy_map", kind = "collection" }
    group:entry { item = "permanent_marker", charges = { 0, 500 }, probability = 50 }
    group:item("spy_note", 90)
    group:item("spy_map")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pooka_armor", kind = "distribution" }
    group:item("xs_mt_chainmail_arms", 20)
    group:item("xs_mt_chainmail_feet", 20)
    group:item("xs_mt_chainmail_hood", 20)
    group:item("xs_mt_chainmail_hands", 20)
    group:item("xs_mt_chainmail_legs", 20)
    group:item("xs_mt_chainmail_vest", 20)
    group:item("xs_boots_glimmer_fur", 20)
    group:item("xs_coat_glimmer_fur", 20)
    group:item("xs_duster_glimmer_fur", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pooka_weapons", kind = "distribution" }
    group:item("pooka_gladius", 20)
    group:item("moons_tears_scimitar", 20)
    group:item("moons_tears_broadsword", 20)
    group:item("moons_tears_arming_sword", 20)
    group:item("moons_tears_estoc", 20)
    group:item("moons_tears_katana", 20)
    group:item("treesung_mace", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gossamer_upper_body", kind = "distribution" }
    group:item("tunic_gossamer", 20)
    group:item("sleeveless_tunic_gossamer", 20)
    group:item("doublet_gossamer", 20)
    group:item("dress_gossamer", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gossamer_outerwear", kind = "distribution" }
    group:item("cloak_gossamer", 20)
    group:item("robe_wizard_gossamer", 20)
    group:item("jacket_light_gossamer", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gossamer_lower_body", kind = "distribution" }
    group:item("pants_gossamer", 20)
    group:item("pants_no_pocket_gossamer", 20)
    group:item("skirt_gossamer", 20)
    group:item("skirt_long_gossamer", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gossamer_socks", kind = "distribution" }
    group:item("socks_gossamer", 20)
    group:item("stockings_gossamer", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hedge_magic_books", kind = "distribution" }
    group:item("spellbook_hedge_farm", 4)
    group:item("spellbook_hedge_ward_demons", 1)
    group:item("spellbook_hedge_doctor_book", 3)
    group:item("spellbook_hedge_blood_book", 2)
    group:item("spellbook_hedge_ward_dreams", 3)
    group:item("spellbook_hedge_psychic_defense", 3)
    group:item("spellbook_hedge_snare_changelings", 1)
    group:item("spellbook_hedge_bathhouse_midnight", 1)
    group:item("spellbook_hedge_abramelin_the_mage", 1)
    group:item("spellbook_hedge_book_of_raziel", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nether_sorcery_books", kind = "distribution" }
    group:item("nether_sorcery_grimoire_xe_nether_sorcery_cold_damage_over_time", 1)
    group:item("nether_sorcery_grimoire_xe_nether_sorcery_summon_kreck_pack", 1)
    group:item("nether_sorcery_grimoire_xe_nether_sorcery_cause_withering_damage", 1)
    group:item("nether_sorcery_grimoire_xe_nether_sorcery_wind_dodge_shell", 1)
    content.add(group)
end

do
    -- Magazine item group for vampire servants.
    local group = content.ItemGroup { id = "renfield_glock_mags", kind = "distribution" }
    group:entry { item = "glockmag", charges = { 0, 15 }, probability = 20 }
    group:entry { item = "glockbigmag", charges = { 0, 30 }, probability = 10 }
    group:entry { item = "glock40bigmag", charges = { 0, 40 }, probability = 10 }
    group:entry { item = "glock17_17", charges = { 0, 17 }, probability = 5 }
    group:entry { item = "glock17_22", charges = { 0, 22 }, probability = 10 }
    group:entry { item = "glock_drum_50rd", charges = { 0, 50 }, probability = 20 }
    group:entry { item = "glock_drum_100rd", charges = { 0, 100 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wyld_candy_wrapper_wyld_20", kind = "collection", container = "wrapper_wyld" }
    group:entry { item = "wyld_candy", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nether_cabin_ritual_prep_clothes", kind = "distribution" }
    group:item("robe", 10)
    group:item("footrags_leather", 10)
    group:item("robe_wizard", 5)
    group:item("dress", 3, "white")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nether_cabin_ritual_cult_meeting_room", kind = "distribution" }
    group:group("soda_in_small_container", 60)
    group:item("file", 190)
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 50 }
    group:item("instant_coffee", 50)
    group:item("strange_coffee", 10)
    group:item("survnote", 1)
    group:group("hedge_magic_books", 3)
    group:entry { group = "wyld_candy_wrapper_wyld_20", sealed = false, probability = 15 }
    content.add(group)
end

do
    -- a large pile of trash, made for monster lairs.
    local group = content.ItemGroup { id = "xe_midden_heap", kind = "collection" }
    group:group("SUS_trash_floor")
    group:group("SUS_trash_forest_manmade", 95)
    group:group("remains_human_generic", 80)
    group:group("SUS_trash_forest_manmade", 70)
    group:group("remains_soldier", 50)
    group:group("remains_pilot", 5)
    group:group("dead_fae_gear", 10)
    group:group("xe_all_spells_mid", 1)
    content.add(group)
end

do
    -- Drugdealer with access to fae drugs.
    local group = content.ItemGroup { id = "map_extra_fae", kind = "collection" }
    group:group("drugdealer", 75)
    group:entry {
        distribution = {
            { item = "lsd", count = { 20, 30 }, wrapper = "bag_zipper", container = "null", probability = 10 },
            { item = "faewild", count = { 10, 20 }, wrapper = "bag_zipper", container = "null", probability = 40 },
            { item = "lotus_blossom", count = { 8, 14 }, wrapper = "bag_zipper", container = "null", probability = 30 },
        },
        probability = 50,
    }
    group:entry { group = "clothing_outdoor_pants", damage = { 1, 4 } }
    group:entry { group = "socks_unisex", damage = { 1, 4 } }
    group:entry { group = "lab_shoes", damage = { 1, 4 }, probability = 50 }
    group:entry { group = "shirts", damage = { 1, 4 }, probability = 50 }
    group:entry { group = "jackets", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "underwear", damage = { 1, 3 } }
    group:entry { item = "corpse", damage = { 4, 4 } }
    content.add(group)
end

do
    -- Inventor artifact creation itemgroup.
    local group = content.ItemGroup { id = "minor_spark_artifacts", kind = "distribution" }
    group:item("xe_art_clock")
    group:item("xe_art_rod")
    group:item("xe_art_monitor")
    group:item("xe_art_mess")
    group:item("xe_art_sculpture")
    group:item("xe_art_disc")
    group:item("xe_art_instrument")
    group:item("art_napkin")
    group:item("art_urchin")
    group:item("art_jelly")
    group:item("art_spiral")
    group:item("art_pin")
    group:item("art_tube")
    group:item("art_pyramid")
    group:item("art_crystal")
    group:item("art_knot")
    group:item("art_crescent")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "changeling_lord_spring_death_drops", kind = "collection" }
    group:group("changeling_lord_death_drops")
    group:entry { item = "spring_lord_estoc", damage = { 1, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "changeling_lord_summer_death_drops", kind = "collection" }
    group:group("changeling_lord_death_drops")
    group:entry { item = "summer_lord_estoc", damage = { 1, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "changeling_lord_autumn_death_drops", kind = "collection" }
    group:group("changeling_lord_death_drops")
    group:entry { item = "autumn_lord_estoc", damage = { 1, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "changeling_lord_winter_death_drops", kind = "collection" }
    group:group("changeling_lord_death_drops")
    group:entry { item = "winter_lord_estoc", damage = { 1, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "changeling_wild_hunt_death_drops", kind = "collection" }
    group:entry {
        collection = {
            { group = "gossamer_upper_body", damage = { 1, 4 }, probability = 70 },
            { group = "gossamer_lower_body", damage = { 1, 4 }, probability = 70 },
            { group = "gossamer_outerwear", damage = { 1, 4 }, probability = 25 },
            { item = "loincloth_gossamer", damage = { 1, 4 } },
            { group = "gossamer_socks", damage = { 1, 4 }, probability = 25 },
            { group = "fae_furs", damage = { 0, 4 }, probability = 10 },
        },
    }
    group:entry { group = "bannerlord_armor", damage = { 0, 4 }, probability = 50 }
    group:entry { item = "wild_huntsman_hunting_blade", damage = { 0, 5 }, probability = 25 }
    group:item("baldric")
    group:entry { item = "scrap_dreamdross", count = { 12, 24 }, probability = 75 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "revenant_death_drops", kind = "collection" }
    group:entry { group = "default_zombie_clothes", damage = { 1, 3 } }
    group:entry { group = "default_zombie_items", count = { 1, 3 }, damage = { 1, 3 }, probability = 30 }
    group:entry { item = "bone_human", count = { 1, 1 }, damage = { 1, 3 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "renfield_9mm_death_drops", kind = "collection" }
    group:entry {
        collection = {
            { item = "glock17_17", damage = { 1, 3 } },
            { group = "renfield_glock_mags", probability = 40 },
            { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 },
        },
    }
    group:group("blood_containers", 15)
    group:group("default_zombie_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "renfield_shotgun_death_drops", kind = "collection" }
    group:entry {
        collection = {
            { item = "mossberg_500", damage = { 1, 3 } },
            { item = "shot_00", count = { 1, 6 }, probability = 40 },
            { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 },
        },
    }
    group:group("default_zombie_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "renfield_flamethrower_death_drops", kind = "collection" }
    group:entry {
        collection = {
            { item = "rm451_flamethrower", damage = { 1, 3 } },
            { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 },
        },
    }
    group:group("blood_containers", 15)
    group:group("default_zombie_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_renfield_abomination_death_drops", kind = "collection" }
    group:entry { item = "cotton_patchwork", count = { 1, 4 }, damage = { 1, 4 } }
    group:entry { item = "pants", damage = { 2, 3 } }
    content.add(group)
end

do
    -- Cyborg vampire servant cbm harvest list.
    local group = content.ItemGroup { id = "bionic_renfield_harvest", kind = "distribution" }
    group:item("bio_dis_shock", 1)
    group:item("bio_dis_acid", 1)
    group:item("bio_drain", 1)
    group:item("bio_noise", 1)
    group:item("bio_power_weakness", 1)
    group:item("bio_itchy", 1)
    group:item("bio_nostril", 1)
    group:item("bio_thumbs", 1)
    group:item("bio_spasm", 1)
    group:item("bio_shakes", 1)
    group:item("bio_leaky", 1)
    group:item("bio_sleepy", 1)
    group:item("bio_deformity", 1)
    group:item("bio_voice", 1)
    group:item("bio_pokedeye", 1)
    group:item("bio_ankles", 1)
    group:item("bio_trip", 1)
    group:item("bio_stiff", 1)
    group:item("bio_flesh_roots", 3)
    group:item("xe_bio_chiropteran_signal", 3)
    group:item("xe_bio_xl_chiropteran_signal", 1)
    group:item("xe_bio_spore_enhancer", 3)
    group:item("bio_ears", 3)
    group:item("bio_claws", 3)
    group:item("bio_power_storage", 2)
    group:item("bio_betavoltaic", 2)
    group:item("bio_fuel_cell_vamp_blood", 4)
    group:item("bio_glowy", 1)
    group:item("bio_sleep_shutdown", 1)
    group:item("bio_faulty_electromagnetic_leak", 1)
    group:item("bio_faulty_grossfood", 1)
    group:item("bio_radleak", 1)
    group:item("bio_ar", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "combat_cyborg_harvest", kind = "distribution" }
    group:item("bio_dis_shock", 1)
    group:item("bio_dis_acid", 1)
    group:item("bio_drain", 1)
    group:item("bio_noise", 1)
    group:item("bio_power_weakness", 1)
    group:item("bio_itchy", 1)
    group:item("bio_nostril", 1)
    group:item("bio_thumbs", 1)
    group:item("bio_spasm", 1)
    group:item("bio_shakes", 1)
    group:item("bio_leaky", 1)
    group:item("bio_sleepy", 1)
    group:item("bio_deformity", 1)
    group:item("bio_voice", 1)
    group:item("bio_pokedeye", 1)
    group:item("bio_ankles", 1)
    group:item("bio_trip", 1)
    group:item("bio_stiff", 1)
    group:item("bio_armor_torso", 3)
    group:item("bio_armor_arms", 6)
    group:item("bio_armor_legs", 6)
    group:item("bio_armor_eyes", 3)
    group:item("bio_alarm", 3)
    group:item("bio_power_storage", 2)
    group:item("bio_glowy", 1)
    group:item("bio_chain_lightning", 1)
    group:item("bio_hydraulics", 1)
    group:item("bio_sleep_shutdown", 1)
    group:item("bio_targeting", 1)
    group:item("bio_weight", 1)
    group:item("bio_faulty_electromagnetic_leak", 1)
    group:item("bio_faulty_grossfood", 1)
    group:item("bio_radleak", 1)
    group:item("bio_ar", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_salamagman_death_drops", kind = "collection" }
    group:entry { item = "salamagman_handaxe", damage = { 1, 4 } }
    group:entry { item = "skirt", damage = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_salamagman_champion_death_drops", kind = "collection" }
    group:entry { item = "salamagman_battleaxe", damage = { 1, 4 } }
    group:entry { item = "skirt", damage = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_salamagman_warlord_death_drops", kind = "collection" }
    group:entry { item = "salamagman_macuahuitl", damage = { 1, 4 } }
    group:entry { item = "skirt", damage = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_dream_shadow_death_drops", kind = "collection" }
    group:entry { item = "scrap_dreamdross", count = { 0, 3 }, probability = 80 }
    group:entry { item = "scrap_shadowstuff", count = { 0, 2 }, probability = 60 }
    group:entry { item = "chunk_shadowstuff", count = { 0, 1 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_dream_shadowbeast_death_drops", kind = "collection" }
    group:entry { item = "scrap_dreamdross", count = { 0, 4 }, probability = 60 }
    group:entry { item = "scrap_shadowstuff", count = { 0, 4 }, probability = 80 }
    group:entry { item = "chunk_shadowstuff", count = { 0, 2 }, probability = 70 }
    group:entry { item = "shadow_fruit", count = { 0, 1 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_dream_shadowman_death_drops", kind = "collection" }
    group:entry { item = "scrap_dreamdross", count = { 0, 4 } }
    group:entry { item = "scrap_shadowstuff", count = { 0, 4 } }
    group:entry { item = "chunk_shadowstuff", count = { 0, 2 } }
    group:entry { group = "xe_shadowman_spell_drops", count = { 1, 1 } }
    content.add(group)
end

do
    -- Spell drops for shadow wounds
    local group = content.ItemGroup { id = "xe_shadowman_spell_drops", kind = "distribution" }
    group:group("xe_dreamer_spell_group0", 6)
    group:group("xe_dreamer_spell_group1", 12)
    group:group("xe_dreamer_spell_group2", 25)
    group:group("xe_dreamer_spell_group3")
    group:group("xe_dreamer_spell_group4", 50)
    group:group("xe_eater_spell_group0", 6)
    group:group("xe_eater_spell_group1", 12)
    group:group("xe_eater_spell_group2", 25)
    group:group("xe_eater_spell_group3")
    group:group("xe_eater_spell_group4", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sevenoclock_death_drops", kind = "collection" }
    group:item("hat_fur")
    group:item("sevenoclock_coat")
    group:item("swag_bag")
    group:item("cane")
    group:entry { item = "bone_human", count = { 3, 15 } }
    group:entry { item = "human_meat_scrap", count = { 10, 40 } }
    group:item("pants", 100, "pants_black")
    group:item("dress_shoes")
    group:item("union_suit")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vampire_anathema_death_drops", kind = "collection" }
    group:item("vampire_anathema_book")
    group:item("blood_camel")
    group:item("salamagman_battleaxe")
    group:entry { item = "hc_helm_close", damage = { 1, 4 } }
    group:entry { item = "armor_hc_plate", damage = { 1, 4 } }
    group:entry { item = "gloves_plate", damage = { 1, 4 } }
    group:entry { item = "pants", damage = { 1, 4 }, variant = "pants_black" }
    group:entry { item = "tshirt", damage = { 1, 4 }, variant = "generic_tshirt" }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry { item = "boots_plate", damage = { 1, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_oa_agent_death_drops",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry {
        distribution = {
            { group = "clothing_soldier_set", damage = { 1, 4 }, probability = 65 },
            { group = "clothing_soldier_winter_set", damage = { 1, 4 }, probability = 35 },
        },
    }
    group:entry { item = "xedra_jumpsuit", damage = { 1, 4 }, variant = "xedra_jumpsuit_offworld" }
    group:entry {
        distribution = {
            {
                group = "military_standard_assault_rifles",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { group = "sopmod" },
                },
                probability = 75,
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 4,
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                    { item = "acog_scope" },
                },
                probability = 6,
            },
            {
                group = "military_standard_shotguns",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 5,
            },
        },
        probability = 10,
    }
    group:group("infantry_common_gear")
    group:group("xe_datacores", 5)
    group:entry {
        distribution = {
            { group = "military_standard_grenades", count = { 1, 3 }, probability = 80 },
            { item = "40x46mm_m433", charges = { 1, 3 }, probability = 20 },
        },
        probability = 20,
    }
    group:group("military_patrol_food")
    group:entry {
        collection = {
            { group = "infantry_officer_gear", probability = 90 },
            { group = "infantry_medical_gear", probability = 80 },
        },
    }
    group:group("wallets", 10)
    group:item("dog_tag", 40)
    content.add(group)
end

do
    -- This should only contain samples that are actually used in alchemy recipes
    local group = content.ItemGroup { id = "alchemy_mutagen_samples", kind = "distribution" }
    group:item("rabbit_sample", 40)
    group:item("rat_sample", 40)
    group:item("fish_sample", 40)
    group:item("batrachian_sample", 40)
    group:item("insect_sample", 40)
    group:item("cattle_sample", 40)
    group:item("spider_sample", 40)
    group:item("ursine_sample", 40)
    group:item("beast_sample", 40)
    group:item("cephalopod_sample", 40)
    group:item("lupine_sample", 40)
    group:item("feline_sample", 40)
    group:item("plant_sample", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alchemical_recipes", kind = "distribution" }
    group:group("alchemical_recipes_tier_one", 16)
    group:group("alchemical_recipes_tier_two", 8)
    group:group("alchemical_recipes_tier_three", 4)
    group:group("alchemical_recipes_tier_four", 2)
    group:group("alchemical_recipes_tier_five", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alchemical_recipes_tier_one", kind = "distribution" }
    group:item("alchemy_recipe_extra_str_aspirin", 1)
    group:item("alchemy_recipe_small_blessing_brigit", 1)
    group:item("alchemy_recipe_blackout_rage_drink", 1)
    group:item("alchemy_recipe_sixdust", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alchemical_recipes_tier_two", kind = "distribution" }
    group:item("alchemy_recipe_prophets_lsd", 1)
    group:item("alchemy_recipe_gold_from_lead", 1)
    group:item("alchemy_recipe_truckers_stamina_pills", 1)
    group:item("alchemy_recipe_charm_of_marzanna", 1)
    group:item("alchemy_recipe_spiritshow_dust", 1)
    group:item("alchemy_recipe_abyssal_coffee", 1)
    group:item("alchemy_recipe_väinämöinens_kantele_imitation", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alchemical_recipes_tier_three", kind = "distribution" }
    group:item("alchemy_recipe_feline_periapta", 1)
    group:item("alchemy_recipe_lupine_periapta", 1)
    group:item("alchemy_recipe_cephalopod_periapta", 1)
    group:item("alchemy_recipe_plant_periapta", 1)
    group:item("alchemy_recipe_scorpion_periapta", 1)
    group:item("alchemy_recipe_butterfly_periapta", 1)
    group:item("alchemy_recipe_spider_periapta", 1)
    group:item("alchemy_recipe_cold_iron_ingot", 1)
    group:item("alchemy_recipe_powder_of_revelation", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alchemical_recipes_tier_four", kind = "distribution" }
    group:item("alchemy_recipe_life_extension_potion", 1)
    group:item("alchemy_recipe_potion_strength", 1)
    group:item("alchemy_recipe_potion_dex", 1)
    group:item("alchemy_recipe_hares_leap_potion", 1)
    group:item("alchemy_recipe_nether_snare", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alchemical_recipes_tier_five", kind = "distribution" }
    group:item("alchemy_recipe_plant_imbuement", 1)
    group:item("alchemy_recipe_doll_imbuement", 1)
    group:item("alchemy_recipe_fire_imbuement", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_vampire_nest_dead_bodies", kind = "distribution" }
    group:entry { group = "corpses", count = { 1, 3 }, probability = 1 }
    group:entry { group = "default_zombie_death_drops", count = { 1, 3 }, probability = 1 }
    content.add(group)
end

do
    -- The body is too damaged to count as a corpse.  This group spawns severely damaged human parts to represent that.
    local group = content.ItemGroup { id = "book_lies_dead_body", kind = "collection" }
    group:item("book_deduction_lies")
    group:entry { item = "skull_human", damage = { 3, 4 } }
    group:entry { item = "human_flesh", count = { 23, 28 }, damage = { 3, 4 } }
    group:entry { item = "human_meat_scrap", count = { 11, 15 }, damage = { 3, 4 } }
    group:entry { item = "hstomach", damage = { 3, 4 } }
    group:entry { item = "human_liver", count = { 11, 15 }, damage = { 3, 4 } }
    group:entry { item = "human_heart", count = { 8, 12 }, damage = { 3, 4 } }
    group:entry { item = "human_lung", count = { 2, 4 }, damage = { 3, 4 } }
    group:entry { item = "human_brain", count = { 3, 5 }, damage = { 3, 4 } }
    group:entry { item = "human_sweetbread", count = { 1, 3 }, damage = { 3, 4 } }
    group:entry { item = "human_kidney", count = { 2, 4 }, damage = { 3, 4 } }
    group:entry { item = "human_fat", count = { 14, 18 }, damage = { 3, 4 } }
    group:entry { item = "bone_human", count = { 24, 28 }, damage = { 3, 4 } }
    group:entry { item = "human_marrow", count = { 5, 7 }, damage = { 3, 4 } }
    group:entry { item = "raw_hleather", count = { 1, 3 }, damage = { 3, 4 } }
    group:entry { item = "ruined_chunks", count = { 120, 130 }, damage = { 3, 4 } }
    group:entry { group = "default_zombie_death_drops", damage = { 3, 4 } }
    content.add(group)
end

do
    -- Overall group for classless spells, if you don't need a precise tier of items. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_classless_spells_low", kind = "distribution" }
    group:group("xe_classless_spell_group0")
    group:group("xe_classless_spell_group1", 50)
    group:group("xe_classless_spell_group2", 25)
    group:group("xe_classless_spell_group3", 12)
    group:group("xe_classless_spell_group4", 6)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_classless_spells_mid", kind = "distribution" }
    group:group("xe_classless_spell_group0", 25)
    group:group("xe_classless_spell_group1", 50)
    group:group("xe_classless_spell_group2")
    group:group("xe_classless_spell_group3", 50)
    group:group("xe_classless_spell_group4", 25)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_classless_spells_high", kind = "distribution" }
    group:group("xe_classless_spell_group0", 6)
    group:group("xe_classless_spell_group1", 12)
    group:group("xe_classless_spell_group2", 25)
    group:group("xe_classless_spell_group3")
    group:group("xe_classless_spell_group4", 50)
    content.add(group)
end

do
    -- Each group contain artifacts of his tier, plus spells of +1 and -1 tier with lower probability. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_classless_spell_group0", kind = "distribution" }
    group:group("xe_classless_spell_tier0")
    group:group("xe_classless_spell_tier1", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_group1", kind = "distribution" }
    group:group("xe_classless_spell_tier0", 50)
    group:group("xe_classless_spell_tier1")
    group:group("xe_classless_spell_tier2", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_group2", kind = "distribution" }
    group:group("xe_classless_spell_tier1", 50)
    group:group("xe_classless_spell_tier2")
    group:group("xe_classless_spell_tier3", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_group3", kind = "distribution" }
    group:group("xe_classless_spell_tier2", 50)
    group:group("xe_classless_spell_tier3")
    group:group("xe_classless_spell_tier4", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_group4", kind = "distribution" }
    group:group("xe_classless_spell_tier3", 50)
    group:group("xe_classless_spell_tier4")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_tier0", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_tier1", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_tier2", kind = "distribution" }
    group:item("magicians_hat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_tier3", kind = "distribution" }
    group:item("fire_ball", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_classless_spell_tier4", kind = "distribution" }
    content.add(group)
end

do
    -- Overall group for dreamer spells, if you don't need a precise tier of items. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_dreamer_spells_low", kind = "distribution" }
    group:group("xe_dreamer_spell_group0")
    group:group("xe_dreamer_spell_group1", 50)
    group:group("xe_dreamer_spell_group2", 25)
    group:group("xe_dreamer_spell_group3", 12)
    group:group("xe_dreamer_spell_group4", 6)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_dreamer_spells_mid", kind = "distribution" }
    group:group("xe_dreamer_spell_group0", 25)
    group:group("xe_dreamer_spell_group1", 50)
    group:group("xe_dreamer_spell_group2")
    group:group("xe_dreamer_spell_group3", 50)
    group:group("xe_dreamer_spell_group4", 25)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_dreamer_spells_high", kind = "distribution" }
    group:group("xe_dreamer_spell_group0", 6)
    group:group("xe_dreamer_spell_group1", 12)
    group:group("xe_dreamer_spell_group2", 25)
    group:group("xe_dreamer_spell_group3")
    group:group("xe_dreamer_spell_group4", 50)
    content.add(group)
end

do
    -- Each group contain artifacts of his tier, plus spells of +1 and -1 tier with lower probability. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_dreamer_spell_group0", kind = "distribution" }
    group:group("xe_dreamer_spell_tier0")
    group:group("xe_dreamer_spell_tier1", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_group1", kind = "distribution" }
    group:group("xe_dreamer_spell_tier0", 50)
    group:group("xe_dreamer_spell_tier1")
    group:group("xe_dreamer_spell_tier2", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_group2", kind = "distribution" }
    group:group("xe_dreamer_spell_tier1", 50)
    group:group("xe_dreamer_spell_tier2")
    group:group("xe_dreamer_spell_tier3", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_group3", kind = "distribution" }
    group:group("xe_dreamer_spell_tier2", 50)
    group:group("xe_dreamer_spell_tier3")
    group:group("xe_dreamer_spell_tier4", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_group4", kind = "distribution" }
    group:group("xe_dreamer_spell_tier3", 50)
    group:group("xe_dreamer_spell_tier4")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_tier0", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_tier1", kind = "distribution" }
    group:item("magick_8_ball", 50)
    group:item("glass_dagger_paperweight")
    group:item("artifact_dreamer_clairvoyance", 30)
    group:item("artifact_dreamer_clairvoyance_eff", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_tier2", kind = "distribution" }
    group:item("caravaggio_self_portrait", 50)
    group:item("artifact_shifter", 40)
    group:item("artifact_constructed_hammer", 50)
    group:item("dreamer_coin_artifact", 50)
    group:item("artifact_stalker_eyes", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_tier3", kind = "distribution" }
    group:item("mirror_artifact", 50)
    group:item("artifact_amber", 50)
    group:item("artifact_sapient_light", 50)
    group:item("artifact_bubble", 50)
    group:item("artifact_ophanim", 50)
    group:item("artifact_winch", 50)
    group:item("artifact_devil_tail", 50)
    group:item("artifact_ethereal_wings", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamer_spell_tier4", kind = "distribution" }
    group:item("artifact_karma_arms", 50)
    group:item("artifact_dreamer_accelerated_time", 50)
    content.add(group)
end

do
    -- Overall group for dreamsmith spells, if you don't need a precise tier of items. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_dreamsmith_spells_low", kind = "distribution" }
    group:group("xe_dreamsmith_spell_group0")
    group:group("xe_dreamsmith_spell_group1", 50)
    group:group("xe_dreamsmith_spell_group2", 25)
    group:group("xe_dreamsmith_spell_group3", 12)
    group:group("xe_dreamsmith_spell_group4", 6)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_dreamsmith_spells_mid", kind = "distribution" }
    group:group("xe_dreamsmith_spell_group0", 25)
    group:group("xe_dreamsmith_spell_group1", 50)
    group:group("xe_dreamsmith_spell_group2")
    group:group("xe_dreamsmith_spell_group3", 50)
    group:group("xe_dreamsmith_spell_group4", 25)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_dreamsmith_spells_high", kind = "distribution" }
    group:group("xe_dreamsmith_spell_group0", 6)
    group:group("xe_dreamsmith_spell_group1", 12)
    group:group("xe_dreamsmith_spell_group2", 25)
    group:group("xe_dreamsmith_spell_group3")
    group:group("xe_dreamsmith_spell_group4", 50)
    content.add(group)
end

do
    -- Each group contain artifacts of his tier, plus spells of +1 and -1 tier with lower probability. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_group0", kind = "distribution" }
    group:group("xe_dreamsmith_spell_tier0")
    group:group("xe_dreamsmith_spell_tier1", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_group1", kind = "distribution" }
    group:group("xe_dreamsmith_spell_tier0", 50)
    group:group("xe_dreamsmith_spell_tier1")
    group:group("xe_dreamsmith_spell_tier2", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_group2", kind = "distribution" }
    group:group("xe_dreamsmith_spell_tier1", 50)
    group:group("xe_dreamsmith_spell_tier2")
    group:group("xe_dreamsmith_spell_tier3", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_group3", kind = "distribution" }
    group:group("xe_dreamsmith_spell_tier2", 50)
    group:group("xe_dreamsmith_spell_tier3")
    group:group("xe_dreamsmith_spell_tier4", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_group4", kind = "distribution" }
    group:group("xe_dreamsmith_spell_tier3", 50)
    group:group("xe_dreamsmith_spell_tier4")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_tier0", kind = "distribution" }
    group:item("brass_cylinders", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_tier1", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_tier2", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_tier3", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_dreamsmith_spell_tier4", kind = "distribution" }
    content.add(group)
end

do
    -- Overall group for eater spells, if you don't need a precise tier of items. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_eater_spells_low", kind = "distribution" }
    group:group("xe_eater_spell_group0")
    group:group("xe_eater_spell_group1", 50)
    group:group("xe_eater_spell_group2", 25)
    group:group("xe_eater_spell_group3", 12)
    group:group("xe_eater_spell_group4", 6)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_eater_spells_mid", kind = "distribution" }
    group:group("xe_eater_spell_group0", 25)
    group:group("xe_eater_spell_group1", 50)
    group:group("xe_eater_spell_group2")
    group:group("xe_eater_spell_group3", 50)
    group:group("xe_eater_spell_group4", 25)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_eater_spells_high", kind = "distribution" }
    group:group("xe_eater_spell_group0", 6)
    group:group("xe_eater_spell_group1", 12)
    group:group("xe_eater_spell_group2", 25)
    group:group("xe_eater_spell_group3")
    group:group("xe_eater_spell_group4", 50)
    content.add(group)
end

do
    -- Each group contain artifacts of his tier, plus spells of +1 and -1 tier with lower probability. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_eater_spell_group0", kind = "distribution" }
    group:group("xe_eater_spell_tier0")
    group:group("xe_eater_spell_tier1", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_group1", kind = "distribution" }
    group:group("xe_eater_spell_tier0", 50)
    group:group("xe_eater_spell_tier1")
    group:group("xe_eater_spell_tier2", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_group2", kind = "distribution" }
    group:group("xe_eater_spell_tier1", 50)
    group:group("xe_eater_spell_tier2")
    group:group("xe_eater_spell_tier3", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_group3", kind = "distribution" }
    group:group("xe_eater_spell_tier2", 50)
    group:group("xe_eater_spell_tier3")
    group:group("xe_eater_spell_tier4", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_group4", kind = "distribution" }
    group:group("xe_eater_spell_tier3", 50)
    group:group("xe_eater_spell_tier4")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_tier0", kind = "distribution" }
    group:item("deck_of_tarot_cards_xe", 50)
    group:item("hurricane_lamp_thorns")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_tier1", kind = "distribution" }
    group:item("occult_seal", 50)
    group:item("glass_berries")
    group:item("strange_coffee", 50)
    group:item("artifact_horn", 50)
    group:item("artifact_unbreakable", 50)
    group:item("artifact_weakening", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_tier2", kind = "distribution" }
    group:item("polaroid_of_missing_person", 50)
    group:item("blindfold_artifact")
    group:item("artifact_cerebellum", 50)
    group:item("artifact_point_blank", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_tier3", kind = "distribution" }
    group:item("artifact_heart", 50)
    group:item("artifact_skull")
    group:item("artifact_eye_left", 50)
    group:item("eater_book_artifact", 50)
    group:item("artifact_muscle", 50)
    group:item("artifact_anchor", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_eater_spell_tier4", kind = "distribution" }
    group:item("artifact_eye_right")
    group:item("ring_artifact", 50)
    group:item("artifact_sand", 50)
    content.add(group)
end

do
    -- Overall group for inventor spells, if you don't need a precise tier of items. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_inventor_spells_low", kind = "distribution" }
    group:group("xe_inventor_spell_group0")
    group:group("xe_inventor_spell_group1", 50)
    group:group("xe_inventor_spell_group2", 25)
    group:group("xe_inventor_spell_group3", 12)
    group:group("xe_inventor_spell_group4", 6)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_inventor_spells_mid", kind = "distribution" }
    group:group("xe_inventor_spell_group0", 25)
    group:group("xe_inventor_spell_group1", 50)
    group:group("xe_inventor_spell_group2")
    group:group("xe_inventor_spell_group3", 50)
    group:group("xe_inventor_spell_group4", 25)
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_inventor_spells_high", kind = "distribution" }
    group:group("xe_inventor_spell_group0", 6)
    group:group("xe_inventor_spell_group1", 12)
    group:group("xe_inventor_spell_group2", 25)
    group:group("xe_inventor_spell_group3")
    group:group("xe_inventor_spell_group4", 50)
    content.add(group)
end

do
    -- Each group contain artifacts of his tier, plus spells of +1 and -1 tier with lower probability. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_inventor_spell_group0", kind = "distribution" }
    group:group("xe_inventor_spell_tier0")
    group:group("xe_inventor_spell_tier1", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_group1", kind = "distribution" }
    group:group("xe_inventor_spell_tier0", 50)
    group:group("xe_inventor_spell_tier1")
    group:group("xe_inventor_spell_tier2", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_group2", kind = "distribution" }
    group:group("xe_inventor_spell_tier1", 50)
    group:group("xe_inventor_spell_tier2")
    group:group("xe_inventor_spell_tier3", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_group3", kind = "distribution" }
    group:group("xe_inventor_spell_tier2", 50)
    group:group("xe_inventor_spell_tier3")
    group:group("xe_inventor_spell_tier4", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_group4", kind = "distribution" }
    group:group("xe_inventor_spell_tier3", 50)
    group:group("xe_inventor_spell_tier4")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_tier0", kind = "distribution" }
    group:item("firmament_driver_book", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_tier1", kind = "distribution" }
    group:item("artifact_cable_whip", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_tier2", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_tier3", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_inventor_spell_tier4", kind = "distribution" }
    content.add(group)
end

do
    -- Overall group for all spells, if you don't need a precise tier of items. Groups are used in mapgen
    local group = content.ItemGroup { id = "xe_all_spells_low", kind = "distribution" }
    group:group("xe_classless_spells_low")
    group:group("xe_dreamer_spells_low")
    group:group("xe_dreamsmith_spells_low")
    group:group("xe_eater_spells_low")
    group:group("xe_inventor_spells_low")
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_all_spells_mid", kind = "distribution" }
    group:group("xe_classless_spells_mid")
    group:group("xe_dreamer_spells_mid")
    group:group("xe_dreamsmith_spells_mid")
    group:group("xe_eater_spells_mid")
    group:group("xe_inventor_spells_mid")
    content.add(group)
end

do
    -- Same as before, but with higher tier spells
    local group = content.ItemGroup { id = "xe_all_spells_high", kind = "distribution" }
    group:group("xe_classless_spells_high")
    group:group("xe_dreamer_spells_high")
    group:group("xe_dreamsmith_spells_high")
    group:group("xe_eater_spells_high")
    group:group("xe_inventor_spells_high")
    content.add(group)
end

do
    -- Inventor created items itemgroup.
    local group = content.ItemGroup { id = "inventor_creations", kind = "distribution" }
    group:item("helmet_inventor")
    group:item("inventor_backpack")
    group:item("inventor_leg_weight")
    group:item("inventor_jump_boots")
    group:item("aura_force")
    group:item("vision_halo")
    group:item("inventor_fists")
    group:item("wolf_mask")
    group:item("magnetic_holster")
    group:item("battery_gun")
    group:item("ray_gun", 50)
    group:item("ray_rifle", 10)
    group:item("ion_gun")
    group:item("inventor_shotgun")
    group:item("sonic_gun")
    group:item("heater_gun")
    group:item("inventor_pistol")
    group:item("combatsaw_spear_off")
    group:item("inventor_light_minus_cell")
    group:item("inventor_light_cell")
    group:item("inventor_medium_cell", 50)
    group:item("inventor_heavy_cell", 10)
    group:item("inventor_welder", 5)
    group:item("heater_tool")
    content.add(group)
end

do
    -- Itemgroup for Border Patrol Evidence rooms
    local group = content.ItemGroup { id = "xe_border_patrol_evidence", kind = "distribution" }
    group:group("xe_all_spells_low", 400)
    group:group("xe_all_spells_mid", 200)
    group:group("xe_all_spells_high")
    group:group("dreamer_artifact", 50)
    group:group("dreamsmith_artifact", 50)
    group:group("inventor_creations", 50)
    group:group("nether_sorcery_books", 25)
    group:group("xe_nether_cult_artifact", 25)
    group:item("hammer_fey_smith", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alt_shirts", kind = "distribution" }
    group:item("alt_tshirt", 80)
    content.add(group)
end

do
    -- Group for museum of Curiosities display case items.
    local group = content.ItemGroup { id = "display_case_items", kind = "distribution" }
    group:group("museum_primitive")
    group:group("museum_misc", 50)
    group:group("xe_dreamer_spells_low", 12)
    group:group("xe_classless_spells_low", 25)
    group:group("xe_dreamsmith_spells_low", 12)
    group:group("xe_eater_spells_low", 12)
    group:group("xe_inventor_spells_low", 12)
    group:group("xe_dreamer_spells_mid", 6)
    group:group("xe_classless_spells_mid", 12)
    group:group("xe_dreamsmith_spells_mid", 6)
    group:group("xe_eater_spells_mid", 6)
    group:group("xe_inventor_spells_mid", 6)
    content.add(group)
end

do
    -- Group for museum of Curiosities mannequin items.
    local group = content.ItemGroup { id = "otherworld_gear", kind = "distribution" }
    group:group("museum_primitive", 20)
    group:group("museum_misc", 15)
    group:group("fae_furs", 12)
    group:group("bannerman_armor", 6)
    group:group("dreamer_artifact", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_plaques_visitors", kind = "distribution" }
    group:item("museum_plaques_visitors", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_plaques_items", kind = "distribution" }
    group:item("museum_plaques_items", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamer_artifact", kind = "distribution" }
    group:entry {
        group = "dreamer_artifacts",
        artifact = { preset = "dreamer_artifacts", power_level = 500, max_attributes = 1, resonant = false },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_q_staff_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_q_staff",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_longsword_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_longsword",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_warhammer_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_warhammer",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_spear_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_spear",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_halberd_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_halberd",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_glaive_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_glaive",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_naginata_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_naginata",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_mace_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_mace",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_morningstar_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_morningstar",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_estoc_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_estoc",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_arming_sword_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_arming_sword",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_broadsword_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_broadsword",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_battleaxe_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_battleaxe",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_katana_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_katana",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_knife_combat_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_knife_combat",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_kris_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_kris",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_kukri_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_kukri",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_nodachi_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_nodachi",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_rapier_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_rapier",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_tanto_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_tanto",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_wakizashi_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_wakizashi",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_zweihander_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_zweihander",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_khopesh_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_khopesh",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_lucerne_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_lucerne",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_knuckle_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_knuckle",
        artifact = {
            preset = "dreamsmith_lottery_atk",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_fullhelmet_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_fullhelmet",
        flags = {
            "FIT",
        },
        artifact = {
            preset = "dreamsmith_lottery_def_head",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_helmet_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_helmet",
        flags = {
            "FIT",
        },
        artifact = {
            preset = "dreamsmith_lottery_def_head",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_plate_armor_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_plate_armor",
        flags = {
            "FIT",
        },
        artifact = {
            preset = "dreamsmith_lottery_def_body",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_armguard_plate_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_armguard_plate",
        flags = {
            "FIT",
        },
        artifact = {
            preset = "dreamsmith_lottery_def_hands",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dreamforged_boots_ench", kind = "distribution" }
    group:entry {
        item = "dreamforged_boots",
        flags = {
            "FIT",
        },
        artifact = {
            preset = "dreamsmith_lottery_def_feet",
            power_level = 5000,
            max_attributes = 4,
            max_negative_power = 0,
            resonant = false,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zebra_pistol_cache", kind = "collection" }
    group:entry { item = "fn57mag", charges = { 20, 20 }, ammo = { item = "57mm_ss" } }
    group:entry { item = "fn57mag", charges = { 20, 20 }, ammo = { item = "57mm_ss" } }
    group:item("fn57_sup")
    content.add(group)
end

do
    -- Foreign agent safehouse pistol group.
    local group = content.ItemGroup { id = "vektor_pistol_cache", kind = "collection" }
    group:entry { item = "sr1vektor_mag_18rd", charges = { 18, 18 }, ammo = { item = "9x21mm" } }
    group:entry { item = "sr1vektor_mag_18rd", charges = { 18, 18 }, ammo = { item = "9x21mm" } }
    group:item("sr1vektor_9x21mm")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "portable_non_flashlight_light_sources", kind = "distribution" }
    group:entry { item = "candle", charges = { 5, 50 }, probability = 3 }
    group:entry { item = "gasoline_lantern", charges = { 0, -1 }, probability = 5 }
    group:entry { item = "electric_lantern", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "oil_lamp", charges = { 0, -1 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nether_cabin_ritual_ingredients", kind = "distribution" }
    group:group("hedge_magick_materials", 200)
    group:entry { item = "lotus_blossom", count = { 8, 14 }, wrapper = "bag_zipper", container = "null", probability = 30 }
    group:entry { item = "candle", charges = { 10, -1 }, probability = 75 }
    group:entry { item = "corpse_yugg_jade_fragments", count = { 1, 3 }, probability = 15 }
    group:entry { item = "blank_blood", container = "bottle_plastic", probability = 15 }
    group:item("kreck_loot_star_stone", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "minor_spark_artifact", kind = "distribution" }
    group:entry {
        group = "minor_spark_artifacts",
        artifact = {
            preset = "spark_items",
            power_level = 500,
            max_attributes = 2,
            max_negative_power = -250,
            resonant = true,
        },
    }
    content.add(group)
end

do
    -- Very small chance of a powerful, non-resonant artifact
    local group = content.ItemGroup { id = "xe_nether_cult_artifact", kind = "distribution" }
    group:entry {
        group = "nether_cult_items_wielded",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "nether_cult_items_wielded",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "nether_cult_items_wielded",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = false,
        },
        probability = 1,
    }
    group:entry {
        group = "nether_cult_items_worn",
        artifact = {
            preset = "nether_cult_worn",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "nether_cult_items_worn",
        artifact = {
            preset = "nether_cult_worn",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "nether_cult_items_worn",
        artifact = {
            preset = "nether_cult_worn",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = false,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "changeling_troll_death_drops", kind = "collection" }
    group:entry {
        item = "footrags_leather",
        damage = { 1, 4 },
        flags = {
            "OVERSIZE",
            "PREFIX_XL",
        },
        probability = 70,
    }
    group:entry {
        item = "loincloth",
        damage = { 1, 4 },
        flags = {
            "OVERSIZE",
            "PREFIX_XL",
        },
        probability = 70,
    }
    group:entry {
        item = "pants_leather",
        damage = { 1, 4 },
        flags = {
            "OVERSIZE",
            "PREFIX_XL",
        },
        probability = 55,
    }
    group:entry { item = "xe_troll_club", damage = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "changeling_troll_manbreaker_death_drops", kind = "collection" }
    group:entry {
        item = "footrags_leather",
        damage = { 1, 4 },
        flags = {
            "OVERSIZE",
            "PREFIX_XL",
        },
        probability = 70,
    }
    group:entry {
        item = "loincloth",
        damage = { 1, 4 },
        flags = {
            "OVERSIZE",
            "PREFIX_XL",
        },
        probability = 70,
    }
    group:entry {
        item = "pants_leather",
        damage = { 1, 4 },
        flags = {
            "OVERSIZE",
            "PREFIX_XL",
        },
        probability = 55,
    }
    group:entry {
        item = "chestwrap",
        damage = { 1, 4 },
        flags = {
            "OVERSIZE",
            "PREFIX_XL",
        },
        probability = 55,
    }
    group:entry { item = "xl_armor_troll_moons_tears", damage = { 1, 3 } }
    group:entry { item = "xl_helm_troll_moons_tears", damage = { 1, 3 }, probability = 75 }
    group:entry { item = "xl_gauntlets_troll_moons_tears", damage = { 1, 3 }, probability = 75 }
    group:entry { item = "xl_boots_troll_moons_tears", damage = { 1, 3 }, probability = 75 }
    group:entry { item = "xe_troll_giant_mace", damage = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_agent_death_drops", kind = "collection", with_ammo = 20, with_magazine = 100 }
    group:entry {
        distribution = {
            { item = "fn57_sup", damage = { 2, 4 } },
            { item = "fn57", damage = { 2, 4 }, variant = "fn57" },
        },
    }
    group:entry { group = "security_armor", damage = { 0, 2 }, probability = 30 }
    group:entry { group = "security_gear", damage = { 0, 2 }, probability = 50 }
    group:entry { group = "cop_gloves", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "pants", damage = { 1, 4 } }
    group:entry { item = "dress_shoes", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "security_torso", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    group:entry { group = "wallets", damage = { 1, 4 } }
    group:entry { item = "fn57mag", charges = { 0, 10 }, ammo = { item = "57mm" }, probability = 50 }
    group:entry { item = "fn57mag", charges = { 0, 15 }, ammo = { item = "57mm" }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "feral_agent_p90_death_drops",
        kind = "collection",
        with_ammo = 20,
        with_magazine = 100,
    }
    group:entry { item = "fn_p90", damage = { 2, 4 } }
    group:entry { group = "security_armor", damage = { 0, 2 }, probability = 30 }
    group:entry { group = "security_gear", damage = { 0, 2 }, probability = 50 }
    group:entry { group = "cop_gloves", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "pants", damage = { 1, 4 } }
    group:entry { item = "dress_shoes", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "security_torso", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    group:entry { group = "wallets", damage = { 1, 4 } }
    group:entry { item = "fnp90mag", charges = { 0, 50 }, ammo = { item = "57mm" }, probability = 50 }
    group:entry { item = "fnp90mag", charges = { 0, 50 }, ammo = { item = "57mm" }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alchemical_materials", kind = "distribution" }
    group:item("chemistry_set", 25)
    group:item("mortar_pestle", 40)
    group:entry { item = "faewild", count = { 3, 12 }, wrapper = "bag_zipper", container = "null", probability = 15 }
    group:entry { item = "wyld_candy", sealed = false, wrapper = "wrapper_wyld", container = "null", probability = 15 }
    group:entry { item = "lotus_blossom", count = { 2, 16 }, wrapper = "bag_zipper", container = "null", probability = 15 }
    group:entry { item = "corpse_ash", count = { 5, 10 }, wrapper = "jug_plastic", container = "null", probability = 15 }
    group:entry { item = "wild_herbs", count = { 20, 80 }, wrapper = "bag_zipper", container = "null", probability = 75 }
    group:entry { item = "poppy_bud", count = { 2, 16 }, wrapper = "bag_zipper", container = "null", probability = 15 }
    group:group("lye_powder_bottle_part", 50)
    group:entry { group = "oxy_powder_bottle_part", charges = { 100, -1 }, probability = 50 }
    group:entry { item = "scrap_copper", count = { 5, 15 }, probability = 40 }
    group:group("jewelry_safe", 2)
    group:group("alchemy_mutagen_samples", 5)
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 50 }
    group:entry { item = "water_clean", charges = { 1, -1 }, sealed = false, container = "bottle_plastic", probability = 90 }
    group:group("bleach_jug_part", 20)
    group:entry { item = "chem_washing_soda", count = { 1, -1 }, probability = 15 }
    group:entry { item = "chem_baking_soda", count = { 1, -1 }, probability = 25 }
    group:group("ethanol_bottle_liter_part", 40)
    group:entry { item = "chem_nitric_acid", charges = { 1, -1 }, probability = 5 }
    group:group("manganesedioxide_small_bottle_part", 5)
    group:entry { item = "chem_sulphur", count = { 1, -1 }, probability = 25 }
    group:entry { item = "chem_sulphuric_acid", charges = { 1, -1 }, probability = 5 }
    group:entry { item = "chem_muriatic_acid", charges = { 1, -1 }, probability = 5 }
    group:entry { item = "chem_hexamine", charges = { 1, -1 }, probability = 5 }
    group:entry { item = "denat_alcohol", charges = { 250, -1 }, probability = 10 }
    group:entry { item = "methed_alcohol", charges = { 250, -1 }, probability = 1 }
    group:group("jewelry_safe", 5)
    group:item("xe_elder_ginseng", 1)
    content.add(group)
end
