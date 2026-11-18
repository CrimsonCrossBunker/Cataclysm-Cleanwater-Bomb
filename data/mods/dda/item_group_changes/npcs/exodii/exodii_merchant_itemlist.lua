local content = require("ccb").content

do
    local group = content.ItemGroup { id = "EXODII_Shop_Guns_Tier2", kind = "collection" }
    group:entry {
        item = "273x44thermobaric",
        count = { 1, 2 },
        sealed = true,
        container = "box_small_wood",
        probability = 10,
    }
    group:entry { item = "273x110slugmedium", count = { 2, 4 }, sealed = true, container = "box_small", probability = 30 }
    group:entry {
        collection = {
            { item = "ree_33", count = { 1, 3 } },
            { item = "ree_33_4_mag", count = { 2, 4 } },
            { item = "ree_33_53_mag", count = { 1, 3 }, probability = 20 },
            { item = "33naval_ball", charges = { 200, 200 }, sealed = true, container = "box_medium_wood" },
            {
                item = "33naval_ball",
                charges = { 200, 200 },
                sealed = true,
                container = "box_medium_wood",
                probability = 50,
            },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "khuunaofaai", count = { 1, 2 } },
            { item = "exodii_khuunaofaai_mag_firework", count = { 3, 4 } },
            { item = "exodii_khuunaofaai_mag_incendiary", count = { 1, 2 }, probability = 50 },
            { item = "exodii_khuunaofaai_mag_corrosive", count = { 1, 2 }, probability = 50 },
            { item = "exodii_khuunaofaai_mag_adhesive", count = { 1, 2 }, probability = 50 },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- To get items from this group in the Exodii CBM store requires finishing missions for their faction and earning their trust
    local group = content.ItemGroup { id = "EXODII_CBM_unlocks_weapons_heavy", kind = "distribution" }
    group:item("bio_chain_lightning", 15)
    group:item("bio_emp", 1)
    group:item("bio_emp_armgun", 1)
    group:item("bio_shockwave", 10)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_Magiclysm_no_spell_scrolls", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_dreamdross_items", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_fair_folk_items", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_spell_items", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    content.add(group)
end

do
    -- Spawn extra tier 1 CBMs and a bonus tier 2 if the Exodii don't dislike you.
    local group = content.ItemGroup { id = "EXODII_CBM_Store_tier1_extra", kind = "collection" }
    group:entry { group = "EXODII_CBM_Store_Tier1", count = { 2, 4 } }
    group:entry { group = "EXODII_CBM_Store_Tier2", count = { 1, 1 }, probability = 25 }
    content.add(group)
end

do
    -- These CBMs should be available in the Exodii store from the start.
    local group = content.ItemGroup { id = "EXODII_CBM_Store_Tier1", kind = "collection" }
    group:group("EXODII_CBM_tier1_utility")
    group:group("EXODII_CBM_tier1_tools", 80)
    group:group("EXODII_CBM_tier1_power", 50)
    group:group("EXODII_CBM_tier1_fun")
    content.add(group)
end

do
    -- These CBMs should be available in the Exodii store after at least 2 weeks.
    local group = content.ItemGroup { id = "EXODII_CBM_Store_Tier2", kind = "distribution" }
    group:item("bio_tools", 10)
    group:item("bio_electrokit", 10)
    group:item("bio_ethanol", 10)
    group:item("bio_eye_optic", 10)
    group:item("bio_remote", 10)
    group:item("bio_torsionratchet", 10)
    group:item("bio_ears", 10)
    group:item("bio_fuel_cell_gasoline", 10)
    group:item("bio_lampoil", 10)
    group:item("bio_armor_arms", 10)
    group:item("bio_armor_eyes", 10)
    group:item("bio_armor_head", 10)
    group:item("bio_armor_legs", 10)
    group:item("bio_armor_torso", 10)
    group:item("bio_digestion", 10)
    group:item("bio_infrared", 10)
    group:item("bio_lockpick", 10)
    group:item("bio_night_vision", 10)
    group:item("bio_sonar", 10)
    group:item("bio_power_storage_mkII", 10)
    group:item("bio_scent_mask", 10)
    group:item("bio_jointservo", 10)
    group:item("bio_taste_blocker", 10)
    group:item("bio_betavoltaic", 10)
    group:item("bio_ar", 10)
    content.upsert_item_group(group)
end

do
    -- These CBMs should be available in the Exodii store after at least 4 weeks.
    local group = content.ItemGroup { id = "EXODII_CBM_Store_Tier3", kind = "distribution" }
    group:item("bio_blood_filter", 10)
    group:item("bio_purifier", 10)
    group:item("bio_heatsink", 10)
    group:item("bio_climate", 10)
    group:item("bio_leukocyte", 10)
    group:item("bio_adrenaline", 10)
    group:item("bio_blood_anal", 10)
    group:item("bio_carbon", 10)
    group:item("bio_evap", 10)
    group:item("bio_face_mask", 10)
    group:item("bio_gills", 10)
    group:item("bio_hydraulics", 10)
    group:item("bio_membrane", 10)
    group:item("bio_painkiller", 10)
    group:item("bio_radscrubber", 10)
    group:item("bio_weight", 10)
    group:item("bio_synlungs", 10)
    content.upsert_item_group(group)
end

do
    -- These CBMs should be available in the Exodii store after at least 8 weeks.
    local group = content.ItemGroup { id = "EXODII_CBM_Store_Tier4", kind = "distribution" }
    group:item("bio_surgical_razor", 10)
    group:item("bio_faraday", 10)
    group:item("bio_metabolics", 10)
    group:item("bio_ground_sonar", 10)
    group:item("bio_recycler", 10)
    group:item("bio_uncanny_dodge", 10)
    group:item("bio_eye_enhancer", 10)
    group:item("bio_dex_enhancer", 10)
    group:item("bio_heat_absorb", 10)
    group:item("bio_int_enhancer", 10)
    group:item("bio_memory", 10)
    group:item("bio_speed", 10)
    group:item("bio_str_enhancer", 10)
    group:item("bio_water_extractor", 10)
    group:item("bio_synaptic_regen", 10)
    content.add(group)
end
