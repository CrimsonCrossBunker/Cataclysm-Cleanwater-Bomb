local content = require("ccb").content

do
    -- Adding spell learning items to standard itemgroups
    local group = content.ItemGroup { id = "costume_misc_items", kind = "distribution" }
    group:item("magicians_hat", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "religious_books", kind = "distribution" }
    group:item("book_deduction_black_iron_prison", 1)
    group:item("book_deduction_out_of_place", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "kids_books", kind = "distribution" }
    group:item("book_teens_deduction", 4)
    content.extend_item_group(group)
end

do
    -- Adding spell learning items to standard itemgroups
    local group = content.ItemGroup { id = "homebooks", kind = "distribution" }
    group:item("book_deduction_out_of_place", 1)
    group:item("manual_deduction", 1)
    group:item("mag_deduction", 10)
    group:item("mag_deduction_tabloid", 40)
    group:item("firmament_driver_book", 1)
    group:item("eater_book_artifact", 1)
    group:group("hedge_magic_books", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mansion_books", kind = "distribution" }
    group:group("hedge_magic_books", 5)
    group:group("nether_sorcery_books", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "esoteric_books", kind = "distribution" }
    group:group("hedge_magic_books", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "book_mag_gen", kind = "distribution" }
    group:item("mag_deduction_tabloid", 40)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "newspaper", kind = "distribution" }
    group:item("mag_deduction_tabloid", 40)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "xe_lab_dreamsmith_dreamdross", kind = "distribution" }
    group:entry { item = "scrap_dreamdross", count = { 3, 20 }, probability = 50 }
    group:entry { item = "dreamdross_lump", count = { 1, 2 }, probability = 25 }
    group:item("forged_dreamstuff_ingot", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_lab_dreamsmith_dream_gear", kind = "distribution" }
    group:group("xe_lab_dreamsmith_dream_weapons", 1)
    group:group("xe_lab_dreamsmith_dream_armor", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_lab_dreamsmith_dream_weapons", kind = "distribution" }
    group:group("dreamforged_q_staff_ench", 1)
    group:group("dreamforged_longsword_ench", 1)
    group:group("dreamforged_warhammer_ench", 1)
    group:group("dreamforged_spear_ench", 1)
    group:group("dreamforged_halberd_ench", 1)
    group:group("dreamforged_glaive_ench", 1)
    group:group("dreamforged_naginata_ench", 1)
    group:group("dreamforged_mace_ench", 1)
    group:group("dreamforged_morningstar_ench", 1)
    group:group("dreamforged_estoc_ench", 1)
    group:group("dreamforged_arming_sword_ench", 1)
    group:group("dreamforged_arming_sword_ench", 1)
    group:group("dreamforged_battleaxe_ench", 1)
    group:group("dreamforged_knife_combat_ench", 1)
    group:group("dreamforged_kris_ench", 1)
    group:group("dreamforged_kukri_ench", 1)
    group:group("dreamforged_nodachi_ench", 1)
    group:group("dreamforged_rapier_ench", 1)
    group:group("dreamforged_tanto_ench", 1)
    group:group("dreamforged_wakizashi_ench", 1)
    group:group("dreamforged_zweihander_ench", 1)
    group:group("dreamforged_khopesh_ench", 1)
    group:group("dreamforged_lucerne_ench", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_lab_dreamsmith_dream_armor", kind = "distribution" }
    group:group("dreamforged_fullhelmet_ench", 1)
    group:group("dreamforged_helmet_ench", 1)
    group:group("dreamforged_plate_armor_ench", 1)
    group:group("dreamforged_armguard_plate_ench", 1)
    group:group("dreamforged_boots_ench", 1)
    group:group("dreamforged_khopesh_ench", 1)
    group:group("dreamforged_khopesh_ench", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fae_furs", kind = "distribution" }
    group:item("hat_fur", 30)
    group:item("hat_faux_fur", 30)
    group:item("sleeveless_trenchcoat_fur", 10)
    group:item("sleeveless_duster_fur", 10)
    group:item("sleeveless_trenchcoat_faux_fur", 10)
    group:item("coat_faux_fur", 30)
    group:item("coat_fur", 30)
    group:item("gloves_fur", 30)
    group:item("boots_fur", 20)
    group:item("trenchcoat_faux_fur", 10)
    group:item("duster_faux_fur", 10)
    group:item("pants_faux_fur", 10)
    group:item("boots_glimmer_fur", 8)
    group:item("cloak_glimmer_fur", 10)
    group:item("coat_glimmer_fur", 1)
    group:item("duster_glimmer_fur", 1)
    group:item("sleeveless_duster_glimmer_fur", 1)
    group:item("sleeveless_trenchcoat_glimmer_fur", 1)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "blood_containers", kind = "distribution" }
    group:item("flask_hip")
    group:item("bowl_skull")
    group:entry { item = "blood", container = "flask_hip", probability = 40 }
    group:entry { item = "blood", container = "2lcanteen", probability = 20 }
    group:entry { item = "blood", container = "bag_iv", probability = 40 }
    group:entry { item = "blood", container = "bottle_glass", probability = 40 }
    group:entry { item = "blood", container = "bottle_plastic", probability = 30 }
    group:entry { item = "blood", container = "bottle_plastic_small", probability = 20 }
    group:entry { item = "blood", container = "camelbak", probability = 20 }
    group:entry { item = "blood", container = "canteen", probability = 20 }
    group:entry { item = "blood", container = "thermos", probability = 10 }
    group:entry { item = "blood", container = "blood_camel", probability = 5 }
    group:entry { item = "blood", container = "blood_bank", probability = 1 }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "softdrugs", kind = "distribution" }
    group:item("truckstop_viagra", 15)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "xed_cubical_office", kind = "distribution" }
    group:group("soda_in_small_container", 560)
    group:group("zebra_pistol_cache", 60)
    group:item("file", 90)
    group:group("magazines", 365)
    group:item("glassblowing_book", 1)
    group:item("trappers_companion", 1)
    group:item("manual_bashing", 1)
    group:item("textbook_speech", 6)
    group:item("survival_book", 4)
    group:item("fun_survival", 10)
    group:item("recipe_augs", 1)
    group:item("decoy_anarch", 10)
    group:entry {
        item = "aspirin",
        count = { 1, 20 },
        wrapper = "bottle_plastic_pill_painkiller",
        container = "null",
        probability = 85,
    }
    group:item("maltballs", 30)
    group:group("cigar_box_opened", 20)
    group:group("cigar_box_unopened", 5)
    group:group("tobacco_products", 151)
    group:entry { item = "contacts", count = { 6, 6 }, probability = 15 }
    group:group("clothing_glasses", 80)
    group:item("fan", 10)
    group:item("briefcase", 40)
    group:item("purse", 40)
    group:item("mbag", 20)
    group:group("ammo_pocket_batteries", 50)
    group:item("manual_business", 40)
    group:item("textbook_business", 12)
    group:item("manual_computer", 20)
    group:item("howto_computer", 10)
    group:item("textbook_computer", 8)
    group:item("computer_science", 8)
    group:item("howto_computer", 6)
    group:group("xed_books_crafting", 3)
    group:entry { item = "matches", charges = { 1, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 60 }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:item("bubblewrap", 50)
    group:group("toy_makerspace_kit", 1)
    group:group("toy_robot_kit", 1)
    group:group("toy_engine_kit", 1)
    group:item("instant_coffee", 15)
    group:item("strange_coffee", 5)
    group:item("usb_drive", 15)
    group:item("coat_rain", 50)
    group:item("hood_rain", 10)
    group:item("poncho", 15)
    group:item("folding_poncho", 5)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 60 }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 5 }
    group:entry { item = "matches", charges = { 0, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 0, 32 }, probability = 60 }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 6 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "game_watch", charges = { 0, 50 }, probability = 2 }
    group:item("umbrella", 5)
    group:item("teleumbrella", 2)
    group:item("mag_tailor", 5)
    group:group("chewing_gum_used", 20)
    group:group("chewing_gum_used_caff", 7)
    group:group("chewing_gum_used_nic", 5)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:item("pocketwatch", 2)
    group:item("knitting_needles", 1)
    group:item("survnote", 1)
    group:item("eclipse_glasses", 1)
    group:group("writing_utensils", 20)
    group:group("softdrugs", 20)
    group:entry { group = "wyld_candy_wrapper_wyld_20", sealed = false, probability = 15 }
    group:item("laptop_xedra", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xed_office", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:group("soda_in_small_container", 370)
    group:group("zebra_pistol_cache", 10)
    group:item("file", 90)
    group:group("magazines", 130)
    group:item("survival_book", 1)
    group:item("fun_survival", 5)
    group:item("howto_traps", 10)
    group:item("decoy_anarch", 8)
    group:item("recipe_augs", 8)
    group:entry {
        item = "aspirin",
        count = { 1, 20 },
        wrapper = "bottle_plastic_pill_painkiller",
        container = "null",
        probability = 85,
    }
    group:item("junk_burrito", 25)
    group:group("tobacco_products", 31)
    group:entry { item = "contacts", count = { 6, 6 }, probability = 15 }
    group:group("clothing_glasses", 80)
    group:item("briefcase", 40)
    group:item("purse", 40)
    group:item("mbag", 20)
    group:group("ammo_pocket_batteries", 50)
    group:item("manual_business", 40)
    group:item("textbook_business", 12)
    group:item("textbook_speech", 8)
    group:item("recipe_caseless", 1)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 60 }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 5 }
    group:entry { item = "matches", charges = { 0, 20 }, probability = 60 }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:item("bubblewrap", 50)
    group:item("instant_coffee", 15)
    group:item("strange_coffee", 5)
    group:item("usb_drive", 5)
    group:item("software_useless", 10)
    group:item("software_electronics_reference", 2)
    group:item("umbrella", 5)
    group:item("teleumbrella", 2)
    group:group("chewing_gum_used", 10)
    group:group("chewing_gum_used_caff", 4)
    group:group("chewing_gum_used_nic", 2)
    group:item("fan", 10)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:item("pocketwatch", 2)
    group:item("gold_watch", 2)
    group:item("sf_watch", 1)
    group:item("silver_watch", 5)
    group:item("survnote", 1)
    group:item("magnifying_glass", 8)
    group:item("camera_control", 2)
    group:item("eclipse_glasses", 1)
    group:group("writing_utensils", 20)
    group:entry { group = "wyld_candy_wrapper_wyld_20", sealed = false, probability = 15 }
    group:item("laptop_xedra", 3)
    content.add(group)
end
