local content = require("ccb").content

do
    -- Scattered reward items in passcode 0 room, 'thief's pass', themed around cheating/infiltration
    local group = content.ItemGroup { id = "LS_Rewardroom_Scatter_Passcode0", kind = "distribution" }
    group:item("bio_power_storage", 10)
    group:item("bio_batteries", 10)
    group:item("bio_lockpick", 10)
    group:item("bio_watch", 10)
    group:item("bio_alarm", 10)
    group:item("bio_sunglasses", 10)
    group:item("bio_meteorologist", 10)
    group:item("bio_pitch_perfect", 10)
    group:item("bio_fitnessband", 10)
    group:item("bio_radio", 10)
    group:item("bio_torsionratchet", 10)
    group:item("bio_fingerhack", 10)
    content.add(group)
end

do
    -- Special primary reward items in passcode 0 room, 'thief's pass', themed around cheating/infiltration
    local group = content.ItemGroup { id = "LS_Rewardroom_Primary_Passcode0", kind = "distribution" }
    group:item("bio_scent_mask", 10)
    group:item("bio_remote", 10)
    group:item("bio_gills", 10)
    group:item("bio_taste_blocker", 10)
    group:item("bio_speed", 1)
    group:item("bio_membrane", 10)
    content.add(group)
end

do
    -- Scattered reward items in passcode 1 room, 'circle of wings', themed around healing/movement
    local group = content.ItemGroup { id = "LS_Rewardroom_Scatter_Passcode1", kind = "distribution" }
    group:item("bio_power_storage", 10)
    group:item("bio_power_storage_mkII", 3)
    group:item("bio_batteries", 10)
    group:item("bio_lockpick", 10)
    group:item("bio_watch", 10)
    group:item("bio_alarm", 10)
    group:item("bio_sunglasses", 10)
    group:item("bio_meteorologist", 10)
    group:item("bio_pitch_perfect", 10)
    group:item("bio_fitnessband", 10)
    group:item("bio_radio", 10)
    group:item("bio_syringe", 10)
    content.add(group)
end

do
    -- Special primary reward items in passcode 1 room, 'circle of wings', themed around healing/movement
    local group = content.ItemGroup { id = "LS_Rewardroom_Primary_Passcode1", kind = "distribution" }
    group:item("bio_jointservo", 10)
    group:item("bio_heatsink", 10)
    group:item("bio_painkiller", 10)
    group:item("bio_digestion", 10)
    group:item("bio_water_extractor", 10)
    group:item("bio_ads", 1)
    group:item("bio_synlungs", 2)
    group:item("bio_recycler", 3)
    content.add(group)
end

do
    -- Scattered reward items in passcode 2 room, 'hard nails', themed around damage/armour
    local group = content.ItemGroup { id = "LS_Rewardroom_Scatter_Passcode2", kind = "distribution" }
    group:item("bio_power_storage", 10)
    group:item("bio_batteries", 10)
    group:item("bio_lockpick", 10)
    group:item("bio_watch", 10)
    group:item("bio_alarm", 10)
    group:item("bio_sunglasses", 10)
    group:item("bio_meteorologist", 10)
    group:item("bio_pitch_perfect", 10)
    group:item("bio_fitnessband", 10)
    group:item("bio_radio", 10)
    group:item("bio_geiger", 5)
    group:item("bio_flashlight", 10)
    group:item("bio_radscrubber", 10)
    content.add(group)
end

do
    -- Special primary reward items in passcode 2 room, 'hard nails', themed around damage/armour
    local group = content.ItemGroup { id = "LS_Rewardroom_Primary_Passcode2", kind = "distribution" }
    group:item("bio_armor_arms", 8)
    group:item("bio_armor_eyes", 5)
    group:item("bio_armor_head", 8)
    group:item("bio_armor_legs", 8)
    group:item("bio_armor_torso", 5)
    group:item("bio_blade", 10)
    group:item("bio_claws", 15)
    group:item("bio_cqb", 10)
    group:item("bio_flashbang", 10)
    group:item("bio_razors", 15)
    group:item("bio_resonator", 5)
    group:item("bio_targeting", 7)
    group:item("bio_shotgun", 10)
    group:item("bio_laser", 2)
    group:item("bio_shock", 5)
    group:item("bio_recoil", 7)
    group:item("bio_taser", 2)
    group:item("bio_ods", 1)
    content.add(group)
end

do
    -- Scattered reward items in passcode 3 room, 'laughing man', themed around manipulation/perception
    local group = content.ItemGroup { id = "LS_Rewardroom_Scatter_Passcode3", kind = "distribution" }
    group:item("bio_batteries", 10)
    group:item("bio_lockpick", 10)
    group:item("bio_watch", 10)
    group:item("bio_alarm", 10)
    group:item("bio_sunglasses", 10)
    group:item("bio_meteorologist", 10)
    group:item("bio_pitch_perfect", 10)
    group:item("bio_fitnessband", 10)
    group:item("bio_radio", 10)
    group:item("bio_geiger", 5)
    content.add(group)
end

do
    -- Special primary items in passcode 3 room, 'laughing man', themed around manipulation/perception
    local group = content.ItemGroup { id = "LS_Rewardroom_Primary_Passcode3", kind = "distribution" }
    group:item("bio_eye_optic", 10)
    group:item("bio_eye_enhancer", 10)
    group:item("bio_dex_enhancer", 10)
    group:item("bio_str_enhancer", 10)
    group:item("bio_int_enhancer", 10)
    group:item("bio_night_vision", 10)
    group:item("bio_infrared", 10)
    group:item("bio_ground_sonar", 10)
    content.add(group)
end

do
    -- Labyrinth only bionics, not tuned to specific encounters
    local group = content.ItemGroup { id = "LS_bionics", kind = "distribution" }
    group:item("bio_nl_dimensional_anchor", 10)
    group:item("bio_nl_laser_reader", 10)
    group:item("bio_nl_psyshield", 10)
    group:item("bio_nl_hair", 10)
    group:item("bio_nl_blood_factory", 10)
    group:item("bio_nl_antigravity_jump", 10)
    content.add(group)
end
