local content = require("ccb").content

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_structural", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bio_armor_eyes", probability = 30 },
            { item = "bio_armor_torso", probability = 10 },
            { item = "bio_armor_head" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "bio_armor_torso", probability = 30 },
            { item = "bio_armor_legs" },
            { item = "bio_armor_head", probability = 10 },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "bio_armor_arms" },
            { item = "bio_armor_torso", probability = 60 },
            { item = "bio_armor_head", probability = 30 },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "bio_armor_legs" },
            { item = "bio_weight", probability = 50 },
        },
        probability = 60,
    }
    group:item("bio_armor_arms", 60)
    group:item("bio_armor_head", 30)
    group:item("bio_armor_torso", 20)
    group:item("bio_weight", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_utility", kind = "collection" }
    group:entry {
        distribution = {
            { item = "bio_alarm", probability = 20 },
            { item = "bio_flashlight", probability = 30 },
            { item = "bio_geiger", probability = 10 },
            { item = "bio_jointservo", probability = 15 },
            { item = "bio_lockpick", probability = 30 },
            { item = "bio_tattoo_led", probability = 40 },
            { item = "burnt_out_bionic", probability = 30 },
        },
        probability = 90,
    }
    group:entry {
        distribution = {
            { item = "bio_tools", probability = 15 },
            { item = "bio_electrokit", probability = 15 },
            { item = "bio_magnet", probability = 15 },
            { item = "bio_soporific", probability = 20 },
            { item = "bio_sunglasses", probability = 25 },
            { item = "bio_syringe", probability = 10 },
            { item = "bio_tattoo_led", probability = 40 },
            { item = "burnt_out_bionic", probability = 30 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { group = "Zomborg_CBM_harvest_stat_enhancements", probability = 50 },
            { group = "Zomborg_CBM_harvest_sensors", probability = 20 },
            { group = "Zomborg_CBM_harvest_expensive_utilities", probability = 1 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { group = "Zomborg_CBM_harvest_stat_enhancements", probability = 30 },
            { group = "Zomborg_CBM_harvest_sensors", probability = 60 },
        },
        probability = 20,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_charging_tools", kind = "distribution" }
    group:item("bio_ethanol", 50)
    group:item("bio_fuel_cell_gasoline", 50)
    group:item("bio_torsionratchet", 200)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_expensive_combat_systems", kind = "distribution" }
    group:item("bio_cqb", 15)
    group:item("bio_heat_absorb", 5)
    group:item("bio_targeting", 5)
    group:item("bio_adrenaline", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_expensive_utilities", kind = "distribution" }
    group:item("bio_climate", 5)
    group:item("bio_digestion", 15)
    group:item("bio_evap", 15)
    group:item("bio_fingerhack", 20)
    group:item("bio_gills", 10)
    group:item("bio_purifier", 10)
    group:item("bio_radscrubber", 20)
    group:item("bio_recycler", 20)
    group:item("bio_tools", 30)
    group:item("bio_electrokit", 20)
    group:item("bio_ar", 30)
    group:item("bio_taste_blocker", 50)
    group:item("bio_water_extractor", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_fancy_defense", kind = "distribution" }
    group:item("bio_heatsink", 20)
    group:item("bio_painkiller", 5)
    group:item("bio_scent_mask", 30)
    group:item("bio_shock", 5)
    group:item("bio_carbon", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_melee_weapons", kind = "distribution" }
    group:item("bio_blade", 1)
    group:item("bio_claws", 30)
    group:item("bio_razors", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_ranged_weapons", kind = "distribution" }
    group:item("bio_flashbang", 50)
    group:item("bio_pitch_perfect", 10)
    group:item("bio_laser", 20)
    group:item("bio_shotgun", 50)
    group:item("bio_shockwave", 1)
    group:item("bio_emp", 3)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_sensors", kind = "distribution" }
    group:item("bio_blood_anal", 20)
    group:item("bio_ears", 20)
    group:item("bio_eye_optic", 20)
    group:item("bio_membrane", 15)
    group:item("bio_meteorologist", 10)
    group:item("bio_night_vision", 1)
    group:item("bio_ground_sonar", 2)
    group:item("bio_infrared", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_stat_enhancements", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "bio_speed", probability = 50 },
            { item = "bio_hydraulics", probability = 50 },
        },
        probability = 1,
    }
    group:item("bio_dex_enhancer", 40)
    group:item("bio_int_enhancer", 30)
    group:item("bio_memory", 20)
    group:item("bio_eye_enhancer", 40)
    group:item("bio_str_enhancer", 30)
    content.add(group)
end
