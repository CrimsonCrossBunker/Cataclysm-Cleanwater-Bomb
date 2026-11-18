local content = require("ccb").content

do
    local group = content.ItemGroup { id = "starterkit_items", kind = "collection" }
    group:entry { item = "mbag", count = { 5, 5 } }
    group:entry { item = "pants", count = { 5, 5 }, variant = "generic_pants" }
    group:entry { item = "tshirt", count = { 5, 5 }, variant = "generic_tshirt" }
    group:entry { item = "socks", count = { 5, 5 } }
    group:entry { item = "sneakers", count = { 5, 5 } }
    group:entry { item = "tent_kit", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "si_trash_heap", kind = "collection" }
    group:entry { group = "SUS_trash_floor", count = { 55, 70 } }
    group:entry { group = "SUS_trash_forest_no_manmade", count = { 80, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "random_artifact_pool", kind = "distribution" }
    group:entry { group = "ps_artifact_weak", probability = 80, count = { 1, 1 } }
    group:entry { group = "ps_artifact_medium", probability = 15, count = { 1, 1 } }
    group:entry { group = "ps_artifact_strong", probability = 5, count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "warp_mission_goal", kind = "distribution" }
    group:entry { item = "warptoken", probability = 100, count = { 1, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "si_exodii_cbm_merchant_wield", kind = "collection" }
    group:item("exodii_plasma_projectile")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "si_exodii_cbm_merchant_carried", kind = "collection" }
    group:item("caotel_plasma_ring")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "si_human_ammo_merchant_wield", kind = "collection" }
    group:item("si_human_ammo_merchant_phrasebook")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "si_human_ammo_merchant_worn", kind = "collection" }
    group:item("gloves_fingerless")
    group:item("leather_belt")
    group:item("cowboy_hat")
    group:item("trenchcoat_faux_fur")
    group:item("dress_shirt")
    group:item("pants_leather")
    group:item("boots")
    group:item("holy_symbol_wood")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SI_HUMAN_AMMO_Store", kind = "collection" }
    group:entry { group = "9mm_loose", probability = 100, count = { 10, 20 } }
    group:entry { group = "223_loose", probability = 100, count = { 10, 20 } }
    group:entry { group = "45_loose", probability = 100, count = { 6, 12 } }
    group:entry { group = "40_loose", probability = 90, count = { 6, 12 } }
    group:entry { group = "12_loose", probability = 90, count = { 6, 12 } }
    group:entry { group = "762_loose", probability = 70, count = { 5, 10 } }
    group:entry { group = "357_loose", probability = 70, count = { 5, 10 } }
    group:entry { group = "38_loose", probability = 70, count = { 5, 10 } }
    group:entry { group = "44_loose", probability = 70, count = { 5, 10 } }
    group:entry { group = "3006_loose", probability = 50, count = { 4, 8 } }
    group:entry { group = "45colt_loose", probability = 50, count = { 4, 8 } }
    group:entry { group = "410_loose", probability = 40, count = { 4, 8 } }
    group:entry { group = "10mm_loose", probability = 40, count = { 4, 8 } }
    group:entry { group = "303_loose", probability = 40, count = { 4, 8 } }
    group:entry { group = "30carbine_loose", probability = 40, count = { 4, 8 } }
    group:entry { group = "38super_loose", probability = 40, count = { 4, 8 } }
    group:entry { group = "4570_loose", probability = 40, count = { 4, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SI_HUMAN_AMMO_Store_Tier3", kind = "collection" }
    group:entry { group = "50beowulf_loose", probability = 40, count = { 4, 8 } }
    group:entry { group = "50AE_loose", probability = 40, count = { 4, 8 } }
    group:entry { item = "77mm_arisaka_jsp", probability = 40, charges = { 10, 25 } }
    group:entry { item = "458wm", probability = 40, charges = { 10, 25 } }
    group:entry { item = "500_Magnum", probability = 40, charges = { 10, 25 } }
    group:entry { item = "545", probability = 40, charges = { 10, 25 } }
    group:entry { item = "57mm_lf", probability = 40, charges = { 10, 25 } }
    group:entry { item = "762_25", probability = 40, charges = { 10, 25 } }
    group:entry { item = "300blk", probability = 40, charges = { 10, 25 } }
    group:entry { item = "9x18mm", probability = 40, charges = { 10, 25 } }
    group:entry { group = "ammo_swat", probability = 40, count = { 8, 16 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SI_HUMAN_AMMO_Store_Tier4", kind = "collection" }
    group:entry { item = "m235tpa", probability = 5, count = { 1, 2 } }
    group:entry { group = "ammo_launcher_grenade", probability = 5, count = { 4, 8 } }
    group:item("LAW", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "si_triffid_decor_merchant_wield", kind = "collection" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "si_triffid_decor_merchant_worn", kind = "collection" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SI_TRIFFID_DECOR_MERCHANT_CARPETS", kind = "collection" }
    group:entry { item = "p_carpet", probability = 90, count = { 5, 12 } }
    group:entry { item = "y_carpet", probability = 90, count = { 5, 12 } }
    group:entry { item = "g_carpet", probability = 90, count = { 5, 12 } }
    group:entry { item = "g_carpet", probability = 90, count = { 5, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SI_TRIFFID_DECOR_Store", kind = "collection" }
    group:entry { item = "p_carpet", probability = 90, count = { 5, 12 } }
    group:entry { item = "y_carpet", probability = 90, count = { 5, 12 } }
    group:entry { item = "g_carpet", probability = 90, count = { 5, 12 } }
    group:entry { item = "g_carpet", probability = 90, count = { 5, 12 } }
    group:entry { item = "birdbath_token", probability = 80, count = { 1, 2 } }
    group:entry { item = "display_case_token", probability = 80, count = { 1, 2 } }
    group:entry { item = "planter_token", probability = 80, count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SI_TRIFFID_DECOR_Store_Tier3", kind = "collection" }
    group:entry { item = "statue_token", probability = 90, count = { 1, 2 } }
    group:entry { item = "glass_door_token", probability = 70, count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SI_TRIFFID_DECOR_Store_Tier4", kind = "collection" }
    group:entry { item = "corpse_yugg_jade", probability = 5, count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "si_exodii_cbms_high_value", kind = "distribution" }
    group:group("Zomborg_CBM_harvest_stat_enhancements", 60)
    group:group("Zomborg_CBM_harvest_fancy_defense", 50)
    group:group("Zomborg_CBM_harvest_expensive_utilities", 30)
    group:group("Zomborg_CBM_harvest_expensive_combat_systems", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_exodii_storage_lowvalue", kind = "distribution" }
    group:group("si_exodii_cbms_low_value", 20)
    content.extend_item_group(group)
end
