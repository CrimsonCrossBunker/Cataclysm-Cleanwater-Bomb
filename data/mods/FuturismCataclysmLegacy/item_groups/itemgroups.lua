local content = require("ccb").content

do
    -- This group is for rare spawns of Rivtech matched sets.
    local group = content.ItemGroup { id = "SUS_rivtech_5x50", kind = "collection" }
    group:entry {
        distribution = {
            { item = "fcl_5x50dart", count = { 1, 3 }, probability = 80 },
            { item = "fcl_5x50heavy", count = { 1, 3 }, probability = 20 },
        },
    }
    group:entry {
        distribution = {
            { item = "fcl_needlegun", charges = { 0, 100 }, probability = 50 },
            { item = "fcl_needlepistol", charges = { 0, 50 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "fcl_5x50_50_mag", probability = 80 },
            { item = "fcl_5x50_100_mag", probability = 20 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "molebot", kind = "distribution" }
    group:item("spiked_plate", 15)
    group:item("hard_plate", 30)
    group:item("robot_controls", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_fusion_pellet", kind = "collection" }
    group:entry { item = "fcl_fusion_pellet", charges = { 0, 25 } }
    group:group("fcl_fusion_pack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_fusion_pack", kind = "collection" }
    group:entry { item = "fcl_fusion_pack", charges = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_fusion_ftk29_mag", kind = "collection" }
    group:entry { item = "medium_battery_cell", charges = { 0, 56 } }
    group:entry { item = "fcl_fusion_10_mag", charges = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_fusion_ftk07_mag", kind = "collection" }
    group:entry { item = "heavy_battery_cell", charges = { 0, 259 } }
    group:entry { item = "fcl_fusion_20_mag", charges = { 0, 20 } }
    content.add(group)
end

do
    -- A collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "fcl_on_hand_5x50", kind = "distribution" }
    group:entry { item = "fcl_5x50dart", charges = { 1, 100 } }
    group:entry { item = "fcl_5x50dart", charges = { 110, 200 }, probability = 75 }
    group:entry { item = "fcl_5x50dart", charges = { 220, 400 }, probability = 30 }
    group:entry { item = "fcl_5x50heavy", charges = { 1, 100 }, probability = 30 }
    content.add(group)
end

do
    -- This is a distribution for the gun, backup magazines, and ammo to repack.
    local group = content.ItemGroup { id = "fcl_nested_needlepistol", kind = "collection" }
    group:entry { item = "fcl_needlepistol", charges = { 0, 50 } }
    group:item("fcl_5x50_50_mag")
    group:item("fcl_5x50_50_mag", 50)
    group:group("fcl_on_hand_5x50")
    content.add(group)
end

do
    -- This is a distribution for the gun, backup magazines, and ammo to repack.
    local group = content.ItemGroup { id = "fcl_nested_needlegun", kind = "collection", with_ammo = 100 }
    group:entry { item = "fcl_needlegun", charges = { 0, 50 } }
    group:item("fcl_5x50_50_mag")
    group:item("fcl_5x50_50_mag", 50)
    group:group("fcl_on_hand_5x50")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "fcl_nested_rm298", kind = "collection", with_ammo = 100 }
    group:entry { item = "fcl_rm298", charges = { 0, 100 } }
    group:item("fcl_8x40_250_mag")
    group:item("fcl_8x40_250_mag", 50)
    group:group("on_hand_8x40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "fcl_nested_rm614_lmg", kind = "collection", with_ammo = 100 }
    group:entry { item = "fcl_rm614_lmg", charges = { 0, 100 } }
    group:item("fcl_8x40_250_mag")
    group:item("fcl_8x40_250_mag", 50)
    group:group("on_hand_8x40")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bionics_retail", kind = "distribution" }
    group:item("bio_power_storage", 20)
    group:item("bio_tools", 10)
    group:item("bio_multimeter", 10)
    group:item("bio_electrokit", 10)
    group:item("bio_flashlight", 10)
    group:item("bio_tattoo_led", 10)
    group:item("bio_lighter", 10)
    group:item("bio_magnet", 10)
    group:item("bio_alarm", 10)
    group:item("bio_meteorologist", 10)
    group:item("bio_batteries", 10)
    group:item("bio_armor_eyes", 8)
    group:item("bio_metabolics", 8)
    group:item("bio_watch", 10)
    group:item("bio_radio", 5)
    group:item("bio_torsionratchet", 10)
    group:item("bio_cable", 10)
    group:item("bio_ears", 2)
    group:item("bio_fitnessband", 10)
    group:item("bio_taser", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_bionics_power", kind = "distribution" }
    group:item("bio_power_storage_mkII", 1)
    group:item("bio_power_storage", 14)
    group:item("bio_betavoltaic", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_mealgrub_procesing", kind = "collection" }
    group:entry { item = "fcl_mealgrub_jelly", count = { 5, 20 } }
    group:entry { group = "fcl_mealgrubs_foil_bag_5", count = { 5, 25 }, probability = 15 }
    group:entry { group = "fcl_mealgrubs_foil_bag_5", count = { 5, 25 }, probability = 5 }
    group:entry { item = "water", charges = { 20, 40 }, container = "jerrycan", probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_mealgrub_precursor", kind = "collection" }
    group:entry { item = "fcl_mealgrub_spores", count = { 1, 6 } }
    group:entry { item = "fcl_mealgrub_medium", count = { 2, 6 }, probability = 80 }
    group:entry { item = "fcl_mealgrub_medium", count = { 2, 6 }, probability = 33 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_mealgrubs_foil_bag_5", kind = "collection", container = "foil_bag" }
    group:entry { item = "fcl_mealgrubs", count = { 5, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_mealgrub_farm_locker", kind = "distribution" }
    group:group("hazmat_suits", 15)
    group:entry { item = "gloves_medical", count = { 1, 3 }, probability = 35 }
    group:group("hazmat_masks", 20)
    group:entry { group = "jackets", count = { 1, 2 }, probability = 35 }
    group:item("coat_lab", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_hydroponics_lab_documents", kind = "collection" }
    group:item("fcl_helixwirl_hydroponics_manual")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_hydrop_deconstruct_results", kind = "collection" }
    group:entry { item = "fcl_hydroponics_core", count = { 1, 1 } }
    group:entry { item = "pipe", count = { 5, 6 } }
    group:entry { item = "plastic_chunk", count = { 10, 10 } }
    group:entry { item = "metal_tank_little", count = { 2, 2 } }
    group:entry { item = "cu_pipe", count = { 4, 4 } }
    group:entry { item = "e_scrap", count = { 2, 2 } }
    group:entry { item = "lightstrip_inactive", count = { 2, 2 } }
    group:entry { item = "circuit", count = { 1, 1 } }
    group:item("small_storage_battery")
    group:entry { item = "scrap", count = { 1, 2 } }
    group:entry { item = "fertilizer_commercial", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_hydrop_bash_results", kind = "collection" }
    group:entry { item = "fcl_hydroponics_core", count = { 0, 1 } }
    group:entry { item = "pipe", count = { 2, 4 } }
    group:entry { item = "plastic_chunk", count = { 8, 10 } }
    group:entry { item = "metal_tank_little", count = { 0, 2 }, damage = { 1, 3 } }
    group:entry { item = "cu_pipe", count = { 0, 2 } }
    group:entry { item = "e_scrap", count = { 2, 2 } }
    group:entry { item = "lightstrip_inactive", count = { 2, 2 } }
    group:entry { item = "circuit", count = { 0, 1 } }
    group:entry { item = "small_storage_battery", count = { 0, 1 }, damage = { 1, 3 } }
    group:entry { item = "scrap", count = { 3, 6 } }
    group:entry { item = "fertilizer_commercial", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fcl_vending_medicine", kind = "collection" }
    group:entry { group = "drugs_pharmacy", count = { 5, 20 } }
    group:entry { group = "drugs_soldier", count = { 5, 25 }, probability = 40 }
    group:entry { group = "drugs_soldier", count = { 5, 25 }, probability = 40 }
    group:entry { group = "drugs_morphine", count = { 5, 10 }, probability = 10 }
    group:entry { group = "hospital_medical_items", count = { 5, 10 }, probability = 50 }
    content.add(group)
end
