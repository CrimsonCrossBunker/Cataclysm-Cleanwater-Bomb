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
