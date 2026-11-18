local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_FORGE_ALCHEMIST_clothes", kind = "collection" }
    group:item("boxer_briefs")
    group:item("socks")
    group:item("tshirt")
    group:item("apron_plastic")
    group:item("boots_rubber")
    group:item("gloves_medical")
    group:item("goggles_chem")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_STORE_POTION_SHOP", kind = "collection" }
    group:entry { group = "NC_FORGE_LORD_STORE_ALCHEMIST", count = { 15, 24 } }
    group:entry { item = "denarius", count = { 5, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LIBRARIAN_clothes", kind = "collection" }
    group:item("sundress")
    group:item("heels")
    group:item("sweater")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_STORE_LIBRARY_SHOP", kind = "collection" }
    group:entry { group = "NC_FORGE_LORD_STORE_LIBRARY", count = { 15, 24 } }
    group:entry { item = "denarius", count = { 5, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_STORE_LIBRARY", kind = "collection" }
    group:entry { group = "spellcraft_books", count = { 1, 3 }, probability = 30 }
    group:entry { group = "dragon_books", count = { 0, 1 }, probability = 20 }
    group:entry { group = "religious_books", count = { 4, 8 }, probability = 80 }
    group:entry { group = "magic_recipe_basic", count = { 0, 2 }, probability = 10 }
    group:entry { group = "magic_recipe_advanced", count = { 0, 2 }, probability = 10 }
    group:entry { group = "magic_shop_books", count = { 3, 12 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_REAGENT_clothes", kind = "collection" }
    group:entry {
        item = "baldric_holster",
        contents = {
            { group = "pirate_loadout" },
        },
    }
    group:entry { item = "cavalry_sabre_plus_one", container = "scabbard" }
    group:item("bandana")
    group:item("mboots_escape")
    group:item("parabolan_enchanted_breeches")
    group:item("enchanted_pirate_blouse")
    group:entry {
        item = "flintlock_pouch",
        contents = {
            { group = "flintlock_pouch_reenactor" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_REAGENT_wield", kind = "collection" }
    group:entry { item = "enchanted_blackpowder_pistol", charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_STORE_REAGENT_SHOP", kind = "collection" }
    group:entry { group = "NC_FORGE_LORD_STORE_REAGENT", count = { 10, 20 } }
    group:entry { group = "NC_FORGE_PIRATE_wield", count = { 10, 10 }, probability = 20 }
    group:entry { item = "denarius", count = { 5, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_STORE_REAGENT", kind = "collection" }
    group:entry { group = "organic_materials", count = { 13, 18 } }
    group:entry { group = "alchemy_monster_loot", count = { 1, 3 } }
    group:entry { item = "crystallized_mana", count = { 2, 6 }, charges = { 1, 10 } }
    group:entry { item = "small_mana_crystal", count = { 1, 5 }, charges = { 5, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_clothes", kind = "collection" }
    group:item("mbelt_pockets_greater")
    group:item("cloak_morthylla")
    group:item("mboots_escape")
    group:item("breeches")
    group:item("polo_shirt")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_STORE", kind = "collection" }
    group:entry { group = "enchanted_combat_items_non_wearable", count = { 3, 8 }, probability = 40 }
    group:entry { group = "enchanted_misc", count = { 1, 3 }, probability = 50 }
    group:entry { group = "enchanted_rings_unusual", count = { 1, 2 }, probability = 20 }
    group:entry { group = "enchanted_rings_rare", count = { 1, 2 }, probability = 30 }
    group:entry { group = "enchanted_wands_greater", count = { 1, 2 }, probability = 30 }
    group:entry { group = "enchanted_wands_lesser", count = { 5, 8 }, probability = 20 }
    group:group("enchanted_melee_weapons_plus2", 20)
    group:group("enchanted_rings_common", 20)
    group:group("enchanted_rings_uncommon", 5)
    group:entry { group = "enchanted_arrows", count = { 1, 2 }, probability = 15 }
    group:group("enchanted_bracelets", 4)
    group:group("enchanted_belts", 2)
    group:group("items_of_elvenkind", 1)
    group:entry { group = "spellbook_loot_1", count = { 1, 3 }, probability = 35 }
    group:group("group_forge_warp_items", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_SHOP", kind = "collection" }
    group:entry { group = "NC_FORGE_LORD_STORE", count = { 20, 32 } }
    group:entry { item = "denarius", count = { 20, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_LORD_ACCEPTED_BOOKS", kind = "collection" }
    group:item("book_fict_soft_pulp_venus")
    group:item("book_fict_soft_pulp_wtmrw")
    group:item("book_fict_soft_pulp_nogod")
    group:item("book_fict_soft_pulp_ddive")
    group:item("book_fict_soft_pulp_squids")
    group:item("book_fict_soft_pulp_gcapes")
    group:item("book_fict_soft_pulp_yesmurd")
    group:item("book_fict_soft_pulp_flashcc")
    group:item("novel_scifi")
    group:item("book_fict_soft_pulp_venus")
    group:item("book_fict_soft_scifi_dune")
    group:item("book_fict_hard_scifi_dune")
    group:item("book_fict_hard_scifi_talnt")
    group:item("book_fict_hard_scifi_fifth")
    group:item("book_fict_hard_scifi_zamwe")
    group:item("book_fict_soft_scifi_zamwe")
    group:item("book_fict_soft_scifi_cybrd")
    group:item("book_fict_soft_scifi_brave")
    group:item("book_fict_soft_scifi_f451")
    group:item("book_anthology_htloop", 1)
    group:item("book_anthology_an", 1)
    group:item("book_anthology_sunvault", 1)
    group:item("book_anthology_moataatgb", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_PIRATE_clothes", kind = "collection" }
    group:entry { item = "cavalry_sabre_plus_one", container = "scabbard" }
    group:item("bandana")
    group:item("boots")
    group:item("parabolan_enchanted_breeches")
    group:item("enchanted_pirate_blouse")
    group:entry {
        item = "flintlock_pouch",
        contents = {
            { group = "flintlock_pouch_reenactor" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FORGE_PIRATE_wield", kind = "collection" }
    group:entry { item = "enchanted_blackpowder_pistol", charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OLD_MAGUS_worn", kind = "collection" }
    group:item("socks")
    group:item("tunic")
    group:item("long_underpants")
    group:item("undershirt")
    group:item("slippers")
    group:item("robe")
    content.add(group)
end
