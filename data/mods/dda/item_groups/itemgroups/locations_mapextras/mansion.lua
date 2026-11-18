local content = require("ccb").content

do
    local group = content.ItemGroup { id = "corpse_mansion", kind = "distribution" }
    group:group("cm_maid", 30)
    group:group("cm_butler", 30)
    group:group("cm_fancy", 23)
    group:group("everyday_corpse", 17)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cm_maid", kind = "collection" }
    group:group("cleaning", 40)
    group:entry { group = "female_underwear", damage = { 0, 4 }, probability = 90 }
    group:entry { group = "shoes_maid", damage = { 0, 4 }, probability = 30 }
    group:entry { item = "maid_hat", damage = { 0, 4 }, probability = 50 }
    group:entry { group = "mansion_maid_dress", damage = { 0, 4 } }
    group:group("corpse_female")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cm_butler", kind = "collection" }
    group:group("gear_butler", 40)
    group:entry { item = "socks", damage = { 0, 4 }, probability = 30 }
    group:entry { group = "male_underwear", damage = { 0, 4 }, probability = 90 }
    group:entry { item = "dress_shoes", damage = { 0, 4 }, probability = 30 }
    group:entry { item = "dress_shirt", damage = { 0, 4 }, probability = 50 }
    group:entry { item = "suit", damage = { 0, 4 } }
    group:entry { item = "glasses_monocle", damage = { 0, 4 }, probability = 40 }
    group:entry { item = "pocketwatch", damage = { 0, 4 }, probability = 35 }
    group:group("corpse_male")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cm_fancy", kind = "collection" }
    group:group("jewelry_front", 40)
    group:group("mansion_guns", 40)
    group:entry { group = "shoestore_shoes", damage = { 0, 4 }, probability = 30 }
    group:entry { group = "suits", damage = { 0, 4 }, probability = 90 }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "male_underwear", damage = { 0, 4 }, probability = 90 },
                    { group = "corpse_male" },
                },
            },
            {
                collection = {
                    { group = "female_underwear", damage = { 0, 4 }, probability = 90 },
                    { group = "corpse_female" },
                },
            },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tool_common_stack", kind = "collection" }
    group:group("tools_common", 15)
    group:group("tools_common", 5)
    group:group("tools_lighting", 5)
    group:group("tools_entry", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mansion_safe", kind = "collection" }
    group:item("diamond", 20)
    group:entry { item = "money_bundle_twenty", count = { 1, 5 }, probability = 50 }
    group:entry { item = "money_bundle_fifty", count = { 1, 5 }, probability = 50 }
    group:entry { item = "money_bundle_hundred", count = { 1, 2 }, probability = 20 }
    group:group("stash_drugs", 5)
    group:item("file", 70)
    group:group("jewelry_front", 40)
    group:group("costume_jewelry_vampire", 5)
    group:group("costume_jewelry_dark", 5)
    group:group("mansion_exotic_weapons", 5)
    group:group("mansion_guns", 95)
    group:group("mansion_guns", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mansion_safe_nogun", kind = "collection" }
    group:item("diamond", 20)
    group:entry { item = "money_bundle_twenty", count = { 1, 5 }, probability = 50 }
    group:entry { item = "money_bundle_fifty", count = { 1, 5 }, probability = 50 }
    group:entry { item = "money_bundle_hundred", count = { 1, 2 }, probability = 20 }
    group:group("stash_drugs", 5)
    group:item("file", 70)
    group:group("jewelry_front", 40)
    group:group("costume_jewelry_vampire", 5)
    group:group("costume_jewelry_dark", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mansion_gunsafe", kind = "collection" }
    group:entry { item = "money_strap_twenty", count = { 1, 5 }, probability = 20 }
    group:group("mansion_ammo", 60)
    group:group("mansion_guns", 40)
    group:group("mansion_guns", 80)
    group:group("mansion_guns", 95)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mansion_exotic_weapons", kind = "distribution" }
    group:group("rapiers", 50)
    group:group("estocs", 50)
    group:group("cavalry_sabres", 25)
    group:group("longswords", 25)
    group:group("arming_swords", 25)
    group:group("broadswords", 25)
    group:group("katanas", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_stack", kind = "distribution" }
    group:item("null")
    group:group("crate_clothes", 30)
    group:group("crate_linens", 25)
    group:group("crate_kitchen", 20)
    group:group("crate_winter", 20)
    group:group("crate_toys", 10)
    group:group("crate_wine", 5)
    group:group("crate_sports", 5)
    group:group("crate_parts", 4)
    group:group("crate_creepy", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_clothes", kind = "collection" }
    group:group("underwear", 40)
    group:group("pants", 70)
    group:group("shirts", 90)
    group:group("shoestore_shoes", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_winter", kind = "collection" }
    group:group("winter", 90)
    group:group("winter", 70)
    group:group("winter", 40)
    group:group("winter", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_linens", kind = "collection" }
    group:group("bed", 90)
    group:group("bed", 40)
    group:group("bed", 10)
    group:group("bath_linens", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_kitchen", kind = "collection" }
    group:group("kitchen_nonfood", 10)
    group:group("kitchen_nonfood", 70)
    group:group("SUS_oven", 90)
    group:group("SUS_oven", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_toys", kind = "collection" }
    group:group("toy_box", 90)
    group:group("toy_box", 70)
    group:group("toy_box", 40)
    group:group("toy_box", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_parts", kind = "collection" }
    group:group("hardware_bulk", 40)
    group:group("supplies_electronics", 90)
    group:group("supplies_electronics", 10)
    group:group("supplies_spares_vehicle", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_cleaning", kind = "collection" }
    group:group("cleaning_bulk", 90)
    group:group("cleaning_bulk", 70)
    group:group("cleaning_bulk", 10)
    group:group("cleaning", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_creepy", kind = "collection" }
    group:group("creepy", 90)
    group:group("creepy", 70)
    group:group("creepy", 40)
    group:group("creepy", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wine_glasses", kind = "distribution" }
    group:item("glass", 75)
    group:item("tin_cup", 20)
    group:item("bottle_glass", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crate_wine", kind = "distribution" }
    group:item("null")
    group:entry { item = "glass_shard", count = { 8, 100 }, probability = 50 }
    group:entry { item = "bottle_glass", count = { 1, 6 }, probability = 50 }
    group:entry { item = "wine_cabernet", count = { 1, 12 }, probability = 14 }
    group:entry { item = "wine_riesling", count = { 1, 12 }, probability = 12 }
    group:entry { item = "wine_chardonnay", count = { 1, 12 }, probability = 10 }
    group:entry { item = "wine_marsala", count = { 1, 12 }, probability = 8 }
    group:entry { item = "wine_vermouth", count = { 1, 12 }, probability = 13 }
    group:entry { item = "single_pot_whiskey", count = { 1, 12 }, probability = 10 }
    group:entry { item = "canadian_whiskey", count = { 1, 12 }, probability = 10 }
    group:entry { item = "sherry", count = { 1, 12 }, probability = 10 }
    group:entry { item = "bristol_sherry", count = { 1, 12 }, probability = 10 }
    group:entry { item = "madeira", count = { 1, 12 }, probability = 10 }
    group:entry { item = "wine_noir", count = { 1, 12 }, probability = 8 }
    group:entry { item = "fruit_wine", count = { 1, 12 }, probability = 6 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "keg_wine", kind = "distribution" }
    group:item("null", 20)
    group:group("keg_wine_smashed", 70)
    group:group("keg_wine_intact", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "keg_wine_smashed", kind = "collection" }
    group:item("scrap", 30)
    group:item("splinter")
    group:item("2x4", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "keg_wine_intact", kind = "distribution" }
    group:item("wooden_barrel")
    group:entry { item = "wine_cabernet", container = "wooden_barrel", probability = 40 }
    group:entry { item = "wine_riesling", container = "wooden_barrel", probability = 30 }
    group:entry { item = "wine_chardonnay", container = "wooden_barrel", probability = 20 }
    group:entry { item = "wine_marsala", container = "wooden_barrel", probability = 15 }
    group:entry { item = "wine_noir", container = "wooden_barrel", probability = 10 }
    group:entry { item = "fruit_wine", container = "wooden_barrel", probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wetbar_stack", kind = "collection" }
    group:group("glass_set", 30)
    group:group("wines_worthy", 20)
    group:group("alcohol", 40)
    group:group("alcohol", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glass_set", kind = "collection" }
    group:item("glass")
    group:item("glass")
    group:item("glass")
    group:item("glass", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser_stack", kind = "distribution" }
    group:item("null", 80)
    group:group("dresser_male", 40)
    group:group("dresser_female", 40)
    group:group("dresser_winter", 20)
    group:group("dresser_shoes", 10)
    group:group("dresser_shabby", 5)
    group:group("dresser_fancy", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser_male", kind = "collection" }
    group:group("male_underwear", 40)
    group:group("clothing_male", 70)
    group:group("clothing_male", 50)
    group:group("clothing_male", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser_female", kind = "collection" }
    group:group("female_underwear", 40)
    group:group("clothing_female", 70)
    group:group("clothing_female", 50)
    group:group("clothing_female", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser_winter", kind = "collection" }
    group:group("winter", 70)
    group:group("winter", 50)
    group:group("winter", 40)
    group:group("winter", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser_shoes", kind = "collection" }
    group:group("shoes", 70)
    group:group("shoes", 50)
    group:group("shoes", 40)
    group:group("shoes", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser_shabby", kind = "collection" }
    group:group("harddrugs_residential", 10)
    group:group("clothing_shabby", 70)
    group:group("clothing_shabby", 50)
    group:group("clothing_shabby", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser_fancy", kind = "collection" }
    group:group("clothing_fancy", 70)
    group:group("clothing_fancy", 50)
    group:group("clothing_fancy", 40)
    group:group("clothing_fancy", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mansion_bookcase", kind = "collection" }
    group:group("novels", 40)
    group:group("mansion_books", 48)
    group:group("memorial_mansion", 2)
    group:group("homebooks", 30)
    group:group("manuals", 10)
    group:group("textbooks", 5)
    group:group("exotic_books", 5)
    group:item("necronomicon", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "suit_of_armor", kind = "distribution" }
    group:item("null", 7)
    group:group("soa_decor", 3)
    group:group("soa_plate", 2)
    group:group("soa_mail", 1)
    group:group("soa_samurai", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_decor", kind = "collection" }
    group:group("soa_weapons_decor")
    group:entry {
        distribution = {
            { item = "armor_junk_plate" },
            { item = "chainmail_junk_hauberk" },
        },
    }
    group:item("helmet_plate")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_weapons_decor", kind = "distribution" }
    group:group("soa_fake_weapon_decor", 3)
    group:group("soa_poor_weapon_decor", 3)
    group:group("soa_real_weapon_decor", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_plate", kind = "collection" }
    group:group("soa_weapons_plate")
    group:item("armor_junk_lightplate")
    group:item("helmet_barbute")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_weapons_plate", kind = "distribution" }
    group:group("soa_fake_weapon_plate", 3)
    group:group("soa_poor_weapon_plate", 3)
    group:group("soa_real_weapon_plate", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_mail", kind = "collection" }
    group:group("soa_weapons_mail")
    group:item("chainmail_junk_suit")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_weapons_mail", kind = "distribution" }
    group:group("soa_fake_weapon_mail", 3)
    group:group("soa_poor_weapon_mail", 3)
    group:group("soa_real_weapon_mail", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_samurai", kind = "collection" }
    group:group("soa_weapons_samurai")
    group:item("scabbard", 50)
    group:item("armor_samurai")
    group:item("helmet_kabuto")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_weapons_samurai", kind = "distribution" }
    group:group("soa_fake_weapon_samurai", 3)
    group:group("soa_poor_weapon_samurai", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "broadsword_fake+scabbard", kind = "collection" }
    group:item("broadsword_fake")
    group:item("scabbard")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "broadsword_inferior+scabbard", kind = "collection" }
    group:item("broadsword_inferior")
    group:item("scabbard")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "samurai_sword_set_fake", kind = "collection" }
    group:item("katana_fake")
    group:item("wakizashi_fake", 34)
    group:item("tanto_fake", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "samurai_sword_set_inferior", kind = "collection" }
    group:item("katana_inferior")
    group:item("wakizashi_inferior", 34)
    group:item("tanto_inferior", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_fake_weapon_decor", kind = "distribution" }
    group:item("pike_fake", 50)
    group:group("broadsword_fake+scabbard", 17)
    group:item("mace_fake", 6)
    group:item("morningstar_fake", 5)
    group:item("shillelagh_fake", 5)
    group:item("scythe_toy", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_poor_weapon_decor", kind = "distribution" }
    group:item("pike_inferior", 50)
    group:group("broadsword_inferior+scabbard", 17)
    group:item("mace_inferior", 6)
    group:item("morningstar_inferior", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_real_weapon_decor", kind = "distribution" }
    group:item("pike", 50)
    group:group("broadsword_inferior+scabbard", 17)
    group:item("mace", 6)
    group:item("morningstar", 5)
    group:item("shillelagh", 5)
    group:item("shillelagh_weighted", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_fake_weapon_plate", kind = "distribution" }
    group:item("pike_fake", 17)
    group:group("broadsword_fake+scabbard", 5)
    group:item("mace_fake", 50)
    group:item("morningstar_fake", 6)
    group:item("shillelagh_fake", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_poor_weapon_plate", kind = "distribution" }
    group:item("pike_inferior", 17)
    group:group("broadsword_inferior+scabbard", 5)
    group:item("mace_inferior", 50)
    group:item("morningstar_inferior", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_real_weapon_plate", kind = "distribution" }
    group:item("pike", 17)
    group:group("broadsword_inferior+scabbard", 5)
    group:item("mace", 50)
    group:item("morningstar", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_fake_weapon_mail", kind = "distribution" }
    group:item("pike_fake", 17)
    group:group("broadsword_fake+scabbard", 5)
    group:item("mace_fake", 50)
    group:item("battleaxe_fake", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_poor_weapon_mail", kind = "distribution" }
    group:item("pike_inferior", 50)
    group:group("broadsword_inferior+scabbard", 5)
    group:item("mace_inferior", 50)
    group:item("battleaxe_inferior", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_real_weapon_mail", kind = "distribution" }
    group:item("pike", 50)
    group:group("broadsword_inferior+scabbard", 5)
    group:item("mace", 50)
    group:item("battleaxe", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_fake_weapon_samurai", kind = "distribution" }
    group:group("samurai_sword_set_fake", 7)
    group:item("bokken_fake", 6)
    group:item("nodachi_fake", 5)
    group:item("naginata_fake", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soa_poor_weapon_samurai", kind = "distribution" }
    group:group("samurai_sword_set_inferior", 7)
    group:item("bokken_inferior", 6)
    group:item("nodachi_inferior", 5)
    group:item("naginata_inferior", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toy_box", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("bat_nerf", 70)
    group:entry { item = "marble", charges = { 1, 20 }, probability = 50 }
    group:item("talking_doll", 50)
    group:item("basketball", 30)
    group:item("fc_hairpin", 30)
    group:entry { group = "kids_books", count = { 1, 4 }, probability = 170 }
    group:entry { group = "games", count = { 1, 2 }, probability = 170 }
    group:item("backpack_small", 20)
    group:item("backpack_denim", 5)
    group:item("pom_poms", 30)
    group:item("shuttlecock", 5)
    group:item("baseball", 30)
    group:item("football", 20)
    group:item("frisbee", 40)
    group:item("disc_golf", 20)
    group:item("shark_plushie", 20)
    group:group("toy_radio_car", 10)
    group:group("toy_makerspace_kit", 8)
    group:group("toy_robot_kit", 8)
    group:group("toy_engine_kit", 8)
    group:item("air_launcher", 5)
    group:item("orangesoda", 30)
    group:item("magic_8_ball", 10)
    group:item("hairpin", 30)
    group:group("soda_in_container", 20)
    group:item("candy", 20)
    group:item("slingshot", 10)
    group:item("rock", 10)
    group:item("bat", 10)
    group:entry { item = "creepy_doll", charges = { 0, 100 }, probability = 3 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 5 }
    group:item("whistle", 3)
    group:entry { item = "wizard_cane_cheap", charges = { 0, 100 }, probability = 5 }
    group:entry { item = "wizard_cane", charges = { 50, 100 }, probability = 10 }
    group:item("sinister_cane", 10)
    group:item("scythe_toy", 10)
    group:item("aim_game", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bath_linens", kind = "distribution" }
    group:item("sheet", 40)
    group:item("towel", 30)
    group:item("cotton_patchwork", 20)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 5 }
    group:group("adhesive_bandages_box_used", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sex_lair", kind = "distribution" }
    group:entry { item = "candle", charges = { 0, 100 }, probability = 50 }
    group:item("rope_6", 50)
    group:group("sex_accessories_domestic", 40)
    group:item("camisole", 40)
    group:item("panties", 40)
    group:item("bra", 40)
    group:item("hot_pants_leather", 30)
    group:item("boxer_shorts", 30)
    group:item("mag_porn", 30)
    group:item("briefs", 30)
    group:item("swim_briefs", 10)
    group:item("speedo", 10)
    group:entry { item = "cooking_oil", sealed = false, container = "bottle_plastic", probability = 20 }
    group:group("stash_drugs", 20)
    group:group("bikini", 30)
    group:entry {
        collection = {
            { item = "bikini_top", variant = "maid_bikini_top" },
            { item = "bikini_bottom", variant = "maid_bikini_bottom" },
        },
        probability = 15,
    }
    group:item("skirt_leather", 20)
    group:item("honey_bottled", 20)
    group:item("nanoskirt", 20)
    group:item("mag_dude", 20)
    group:item("chaps_leather", 10)
    group:item("novel_romance", 10)
    group:item("novel_erotic", 10)
    group:item("bondage_suit", 10)
    group:item("bondage_mask", 10)
    group:item("bodysuit_lycra", 10, "bondage_suit")
    group:item("bodysuit_lycra", 5)
    group:item("zentai", 2)
    group:item("bullwhip", 10)
    group:item("bullwhip_razor", 10)
    group:item("leather_cat_ears", 5)
    group:item("leather_cat_tail", 5)
    group:item("leather_collar", 5)
    group:item("priest_collar", 2)
    group:item("rope_30", 5)
    group:entry { item = "fog_machine", charges = { 0, 56 }, probability = 5 }
    group:group("costume_undergarments_women", 20)
    group:group("costume_suits", 20)
    group:group("costume_skirts", 10)
    group:group("costume_pants", 2)
    group:group("costume_masks", 15)
    group:group("costume_jewelry", 5)
    group:group("costume_hats_hoods", 2)
    group:group("costume_gloves", 2)
    group:group("costume_dresses", 10)
    group:group("costume_cloacks", 1)
    group:item("tank_top", 10, "tank_top_cheerleader")
    group:item("cheerleader_top_short", 15)
    group:item("leotard", 5)
    group:item("cheerleader_skirt", 10)
    group:item("cheerleader_skirt_short", 15)
    group:item("santa_dress", 10)
    group:item("santa_dress_short", 15)
    group:item("cheerleader_dress", 5)
    group:item("ninja_dress_sleeveless", 2)
    group:item("short_dress", 5, "sinister")
    group:item("short_dress_sleeved", 5, "witch_black")
    group:item("maid_dress_short", 25)
    group:item("apron_cotton", 25, "maid_apron")
    group:item("apron_cotton", 15, "gothic_apron")
    group:item("waist_apron_short", 25, "maid_apron")
    group:item("waist_apron_short", 15, "gothic_apron")
    group:item("apron_leather", 20)
    group:item("sinister_cane", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sports_bulk", kind = "distribution" }
    group:item("bat", 60)
    group:item("bat_metal", 60)
    group:item("boxing_gloves", 40)
    group:item("shuttlecock", 10)
    group:item("baseball", 60)
    group:item("pom_poms", 30)
    group:item("tank_top", 15, "tank_top_cheerleader")
    group:item("cheerleader_top_short", 15)
    group:item("cheerleader_skirt", 15)
    group:item("cheerleader_skirt_short", 15)
    group:item("football_armor", 30)
    group:item("helmet_football", 10)
    group:item("football", 60)
    group:item("basketball", 50)
    group:item("beach_volleyball", 40)
    group:item("indoor_volleyball", 40)
    group:item("helmet_bike", 15)
    group:group("helmet_bike_modified", 10)
    group:item("plastic_chin_guard", 10)
    group:item("shield_visor", 5)
    group:item("helmet_ball", 25)
    group:item("headgear", 20)
    group:item("mask_hockey", 25)
    group:item("hockey_stick", 45)
    group:item("throat_guard_nylon", 5)
    group:item("throat_guard_canvas", 5)
    group:item("throat_guard_plastic", 2)
    group:item("throat_guard_cut_resistant", 1)
    group:item("puck", 30)
    group:item("golf_club", 80)
    group:item("roller_blades", 20)
    group:item("rollerskates", 10)
    group:item("folded_skateboard_generic", 10)
    group:item("javelin_bag", 1)
    group:item("longbow", 5)
    group:item("compbow", 1)
    group:item("shortbow", 5)
    group:item("recurbow", 2)
    group:item("takedown_recurbow", 1)
    group:item("quiver_takedown_bow", 1)
    group:item("reflexbow", 2)
    group:group("archery_loaded_quivers", 1)
    group:item("nylon_quiver", 2)
    group:item("quiver", 3)
    group:item("fencing_jacket", 10)
    group:item("fencing_mask", 10)
    group:item("fencing_pants", 10)
    group:item("lame_foil", 10)
    group:item("lame_saber", 10)
    group:item("plastron_cotton", 10)
    group:item("plastron_plastic", 10)
    group:item("gauntlet_fencing", 9)
    group:item("gauntlet_fencing_l", 1)
    group:item("iceaxe", 4)
    group:item("aim_game", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sauna", kind = "distribution" }
    group:item("towel", 90)
    group:item("water_mineral", 50)
    group:item("house_coat", 50)
    group:item("water_clean", 30)
    group:item("sports_drink", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kitchen_nonfood", kind = "distribution" }
    group:item("aluminum_foil", 25)
    group:item("toaster", 20)
    group:item("microwave", 20)
    group:item("apron_cotton", 10)
    group:item("waist_apron_long", 10)
    group:item("waist_apron_short", 1)
    group:item("hat_chef", 2)
    group:item("pastaextruder", 10)
    group:item("knife_butter", 90)
    group:item("knife_small", 85, "knife_steak")
    group:item("fork", 90)
    group:item("spoon", 90)
    group:item("glass", 20)
    group:item("shot_glass", 8)
    group:item("glass_plate", 20)
    group:item("glass_bowl", 20)
    group:item("bowl_wood", 5)
    group:item("ceramic_plate", 10)
    group:item("ceramic_bowl", 10)
    group:item("ceramic_cup", 10)
    group:group("tinware", 10)
    group:item("knife_huge", 10, "knife_butcher")
    group:item("funnel", 50)
    group:item("jar_glass_sealed", 50)
    group:item("jar_3l_glass_sealed", 40)
    group:item("tongs", 25)
    group:item("coffeemaker", 10)
    group:item("cookbook_daintydishes", 40)
    group:item("cookbook_indian", 10)
    group:item("cookbook_native", 10)
    group:item("cookbook_foodfashions", 18)
    group:item("cookbook_mexican", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "table_sideboard", kind = "distribution" }
    group:item("ceramic_bowl", 30)
    group:group("glass_of_wine", 50)
    group:group("wines_worthy", 20)
    group:group("glass_set", 20)
    group:group("tinware", 20)
    group:item("candlestick", 30)
    group:item("spiral_stone", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clutter_basement", kind = "distribution" }
    group:item("shot_hull", 40)
    group:item("sinew", 40)
    group:entry { item = "rolling_paper", charges = { 1, 30 }, probability = 20 }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:item("9mm_casing", 20)
    group:item("38_casing", 20)
    group:item("45_casing", 20)
    group:group("SUS_trash_floor", 5)
    group:group("corpse_mansion", 5)
    group:item("survnote", 1)
    group:entry { item = "inflatable_dragon", charges = { 0, 56 }, probability = 1 }
    group:entry { item = "inflatable_ghost", charges = { 0, 56 }, probability = 1 }
    group:entry { item = "fog_machine", charges = { 0, 56 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clutter_mansion", kind = "distribution" }
    group:item("shot_hull", 40)
    group:item("sinew", 40)
    group:item("9mm_casing", 20)
    group:item("38_casing", 20)
    group:item("45_casing", 20)
    group:item("bone_tainted", 5)
    group:group("SUS_trash_floor", 5)
    group:group("corpse_mansion", 5)
    group:group("writing_utensils", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "table_ballroom", kind = "distribution" }
    group:group("glass_of_wine", 75)
    group:item("bottle_glass", 50)
    group:item("glass", 50)
    group:item("sandwich_cucumber", 40)
    group:entry { item = "coffee", container = "ceramic_cup", probability = 30 }
    group:group("tinware", 20)
    group:item("cake2", 20)
    group:group("wines_worthy", 10)
    group:item("jihelucake", 10)
    group:item("purse", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "table_foyer", kind = "distribution" }
    group:item("gloves_light", 40)
    group:item("gloves_leather", 30)
    group:item("flyer", 30)
    group:group("book_mag_gen", 60)
    group:item("purse", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireplace_fill", kind = "distribution" }
    group:item("stick", 60)
    group:item("log", 40)
    group:item("splinter", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "table_livingroom", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:group("beer_selection", 30)
    group:group("glass_of_wine", 30)
    group:group("book_mag_gen", 120)
    group:group("tobacco_products", 50)
    group:group("cigar_box_opened", 50)
    group:item("novel_pulp", 30)
    group:group("chewing_gum_used", 30)
    group:item("glass", 20)
    group:item("bandana", 10)
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 6 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 5 }
    group:group("civilian_phones", 6)
    group:item("phonebook", 5)
    group:item("hairpin", 5)
    group:group("tinware", 5)
    group:group("newspaper", 15)
    group:item("news_regional", 2)
    group:item("magnifying_glass", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "table_card", kind = "distribution" }
    group:entry { item = "beer", container = "glass", probability = 40 }
    group:group("beer_selection", 40)
    group:group("glass_of_wine", 40)
    group:item("glass", 20)
    group:group("tobacco_products", 75)
    group:group("cigar_box_opened", 50)
    group:item("money_bundle_ten", 10)
    group:item("pretzels", 5)
    group:item("chips", 5)
    group:group("wallet_stylish_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wetbar_counter", kind = "distribution" }
    group:entry { item = "beer", container = "glass", probability = 40 }
    group:group("beer_selection", 40)
    group:group("glass_of_wine", 40)
    group:item("glass", 40)
    group:item("shot_glass", 10)
    group:group("cig_box_cigarette_1_20", 30)
    group:entry { item = "cigar", count = { 1, 10 }, probability = 20 }
    group:entry { item = "case_cigar", count = { 1, 2 }, probability = 10 }
    group:entry { group = "cigar_box_unopened", count = { 1, 5 }, probability = 25 }
    group:item("towel", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wetbar_fridge", kind = "distribution" }
    group:group("beer_selection", 70)
    group:group("chilled_wine", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beer_selection", kind = "distribution" }
    group:item("beer", 80)
    group:item("drink_hard_seltzer", 20)
    group:item("european_pilsner", 20)
    group:item("imperial_stout", 20)
    group:item("india_pale_ale", 20)
    group:item("belgian_ale", 20)
    group:item("pale_ale", 20)
    group:item("wine_barley", 20)
    group:item("stout", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chilled_wine", kind = "distribution" }
    group:item("wine_riesling", 40)
    group:item("fruit_wine", 30)
    group:item("wine_chardonnay", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pool_side", kind = "distribution" }
    group:group("swimmer_accessories", 10)
    group:group("swimmer_glasses", 25)
    group:group("swimmer_torso", 20)
    group:group("swimmer_pants", 20)
    group:group("swimmer_head", 20)
    group:group("swimmer_shoes", 30)
    group:group("swimmer_gloves", 5)
    group:group("swimmer_wetsuit", 5)
    group:group("swimmer_items", 10)
    group:group("magazines", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "a_television", kind = "collection" }
    group:item("television")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clothing_male", kind = "distribution" }
    group:item("jeans", 90)
    group:item("jeans_ripped", 10)
    group:item("jeans_skinny", 30)
    group:item("jeans_vintage", 1)
    group:item("pants_checkered", 5)
    group:item("shorts", 70)
    group:item("shorts_denim", 35)
    group:item("pants", 75)
    group:item("leather_belt", 30)
    group:item("pants_leather", 60)
    group:item("pants_cargo", 70)
    group:item("shorts_cargo", 50)
    group:item("tshirt", 70)
    group:item("tshirt_cropped", 4)
    group:item("longshirt", 80)
    group:item("polo_shirt", 65)
    group:item("dress_shirt", 60)
    group:item("denim_shirt", 10)
    group:item("tank_top", 50)
    group:item("undershirt", 30)
    group:item("boxer_shorts", 30)
    group:item("briefs", 15)
    group:item("rashguard", 20)
    group:item("swim_briefs", 10)
    group:item("speedo", 5)
    group:item("boxer_briefs", 20)
    group:item("sweatshirt", 75)
    group:item("sweater", 75)
    group:item("hoodie", 65)
    group:item("hoodie_cropped", 6)
    group:item("under_armor", 20)
    group:item("under_armor_shorts", 20)
    group:item("leotard", 5)
    group:item("unitard", 5)
    group:item("long_underpants", 40)
    group:item("long_undertop", 40)
    group:item("union_suit", 20)
    group:item("pants_army", 10)
    group:item("jersey", 40)
    group:item("kilt", 3)
    group:item("gloves_white", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clothing_female", kind = "distribution" }
    group:entry { item = "jeans", damage = { 0, 2 }, probability = 50 }
    group:item("jeans", 90)
    group:entry { item = "jeans_ripped", damage = { 0, 2 }, probability = 5 }
    group:item("jeans_ripped", 10)
    group:entry { item = "jeans_skinny", damage = { 0, 2 }, probability = 20 }
    group:item("jeans_skinny", 20)
    group:item("jeans_vintage", 1)
    group:item("shorts", 70)
    group:item("shorts_denim", 35)
    group:item("pants", 75)
    group:item("leather_belt", 30)
    group:item("pants_leather", 60)
    group:item("pants_cargo", 70)
    group:item("shorts_cargo", 50)
    group:item("skirt", 75)
    group:item("skirt_long", 60)
    group:item("skirt_denim", 10)
    group:item("skirt_leather", 5)
    group:item("tshirt", 70)
    group:item("tshirt_cropped", 7)
    group:item("longshirt", 80)
    group:item("polo_shirt", 65)
    group:item("dress_shirt", 60)
    group:item("denim_shirt", 10)
    group:item("tank_top", 50)
    group:item("camisole", 30)
    group:item("bra", 30)
    group:item("panties", 30)
    group:item("boy_shorts", 25)
    group:item("sweatshirt", 75)
    group:item("sweater", 75)
    group:item("hoodie", 65)
    group:item("hoodie_cropped", 6)
    group:item("under_armor", 20)
    group:item("under_armor_shorts", 20)
    group:item("tights", 20)
    group:item("leggings", 20)
    group:item("stockings", 20)
    group:item("garter_belt", 10)
    group:item("long_underpants", 40)
    group:item("long_undertop", 40)
    group:item("union_suit", 20)
    group:item("leotard", 5)
    group:item("unitard", 5)
    group:item("corset", 10)
    group:item("corset_waist", 10)
    group:item("halter_top", 50)
    group:item("santa_dress_long", 1)
    group:item("long_dress_sleeved", 1, "sinister")
    group:item("gown_sleeved", 1, "sinister")
    group:item("long_dress_sleeved", 1, "witch_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clothing_shabby", kind = "distribution" }
    group:entry { item = "jeans", damage = { 1, 3 }, probability = 90 }
    group:entry { item = "jeans", damage = { 1, 3 }, probability = 10 }
    group:entry { item = "jeans_skinny", damage = { 1, 3 }, probability = 30 }
    group:entry { item = "jeans_ripped", damage = { 1, 3 }, probability = 10 }
    group:item("pants_checkered", 5)
    group:item("shorts", 70)
    group:entry { item = "shorts_denim", damage = { 1, 3 }, probability = 35 }
    group:entry { item = "pants_leather", damage = { 1, 3 }, probability = 35 }
    group:entry { item = "pants_cargo", damage = { 1, 3 }, probability = 70 }
    group:entry { item = "shorts_cargo", damage = { 1, 3 }, probability = 50 }
    group:item("skirt_leather", 10)
    group:item("tshirt", 70)
    group:item("tshirt_cropped", 7)
    group:item("tank_top", 50)
    group:item("hoodie", 90)
    group:item("jacket_light", 20)
    group:item("jacket_varsity", 10)
    group:entry { item = "jacket_jean", damage = { 1, 3 }, probability = 50 }
    group:entry { item = "vest_jean", damage = { 1, 3 }, probability = 20 }
    group:entry { item = "jacket_leather", damage = { 1, 3 }, probability = 50 }
    group:item("tacjacket", 75)
    group:item("bandana", 35)
    group:item("hat_cotton", 45)
    group:item("hat_knit", 25)
    group:entry { item = "tights", damage = { 1, 3 }, probability = 30 }
    group:entry { item = "leggings", damage = { 1, 3 }, probability = 30 }
    group:entry { item = "stockings", damage = { 1, 3 }, probability = 30 }
    group:entry { item = "garter_belt", damage = { 1, 3 }, probability = 15 }
    group:item("balclava", 15, "black")
    group:item("union_suit", 20)
    group:entry { item = "sleeveless_trenchcoat", damage = { 1, 3 }, probability = 30 }
    group:item("house_coat", 25)
    group:item("jedi_cloak", 1)
    group:item("apron_leather", 1)
    group:item("corset", 10)
    group:item("corset_waist", 10)
    group:item("chestwrap", 5)
    group:item("bellywrap", 2)
    group:item("boots_combat", 10)
    group:item("pants_army", 10)
    group:item("jacket_army", 10)
    group:item("tank_top", 20, "tank_top_camo")
    group:item("porkpie", 5)
    group:group("neckties", 5)
    group:item("jersey", 60)
    group:item("maid_hat", 3)
    group:item("halter_top", 50)
    group:item("nanoskirt", 40)
    group:item("ear_spool", 30)
    group:entry { item = "straw_fedora", damage = { 1, 3 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clothing_fancy", kind = "distribution" }
    group:item("leather_belt", 30)
    group:item("suit", 60)
    group:item("waistcoat", 30)
    group:item("tophat", 10)
    group:item("bowhat", 10)
    group:item("cowboy_hat", 10)
    group:item("glasses_monocle", 2)
    group:item("skirt_leather", 5)
    group:item("dress_shirt", 80)
    group:item("blazer", 35)
    group:item("peacoat", 30)
    group:item("greatcoat", 15)
    group:item("hat_newsboy", 20)
    group:item("cloak_wool", 5)
    group:item("tux", 5)
    group:item("gown", 5)
    group:item("long_glove_white", 5)
    group:item("veil_wedding", 1)
    group:item("dress_wedding", 1)
    group:group("neckties", 5)
    group:item("tieclip", 2)
    group:item("collarpin", 2)
    group:item("kilt", 3)
    group:item("fedora", 5)
    group:item("kufi", 2)
    group:item("kippah", 2)
    group:item("thawb", 1)
    group:item("hijab", 2)
    group:item("niqab", 1)
    group:item("abaya", 1)
    group:item("kittel", 1)
    group:item("tallit_katan", 1)
    group:item("cassock", 1)
    group:item("robe", 5)
    group:item("eboshi", 1)
    group:item("kariginu", 1)
    group:item("kimono", 3)
    group:item("haori", 2)
    group:item("hat_fur", 2)
    group:item("coat_faux_fur", 4)
    group:item("coat_fur", 4)
    group:item("gloves_fur", 4)
    group:item("boots_fur", 4)
    group:item("santa_dress_long", 3)
    group:item("long_dress_sleeved", 3, "sinister")
    group:item("gown_sleeved", 4, "sinister")
    group:item("long_dress_sleeved", 2, "witch_black")
    group:item("cheongsam", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dresser_servant", kind = "distribution" }
    group:item("maid_dress", 70)
    group:item("maid_dress_short", 30)
    group:item("maid_hat", 90)
    group:item("suit", 80)
    group:item("pocketwatch", 30)
    group:item("jeans", 20)
    group:item("jeans_skinny", 5)
    group:item("pants_checkered", 50)
    group:item("hat_chef", 50)
    group:item("jacket_chef", 50)
    group:item("apron_cotton", 50)
    group:item("waist_apron_long", 15)
    group:item("waist_apron_short", 1)
    group:item("shorts", 20)
    group:item("shorts_denim", 20)
    group:item("pants", 20)
    group:item("leather_belt", 30)
    group:item("pants_cargo", 20)
    group:item("shorts_cargo", 20)
    group:item("tshirt", 20)
    group:item("longshirt", 20)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 60)
    group:item("tank_top", 20)
    group:item("sweatshirt", 20)
    group:item("sweater", 20)
    group:item("hoodie", 10)
    group:item("long_underpants", 5)
    group:item("long_undertop", 5)
    group:item("union_suit", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "panic_room", kind = "distribution" }
    group:group("cannedfood", 70)
    group:item("water", 60)
    group:group("mansion_ammo", 40)
    group:group("tools_lighting", 30)
    group:group("softdrugs", 30)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "matches", charges = { 1, 20 }, probability = 20 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 20 }
    group:item("pocket_survival", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mansion_ammo", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:group("ammo_common_boxed", 90)
    group:group("archery_ammo", 60)
    group:group("crossbow_bolts", 60)
    group:group("mags_common", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "shoes_maid", kind = "distribution" }
    group:item("stockings", 70)
    group:item("dress_shoes", 60)
    group:item("sneakers", 50)
    group:item("dance_shoes", 20)
    group:item("tights", 20)
    group:item("socks", 20)
    group:item("heels", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mansion_maid_dress", kind = "distribution" }
    group:item("maid_dress", 80)
    group:item("maid_dress_short", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gear_butler", kind = "distribution" }
    group:item("knife_huge", 35, "knife_butcher")
    group:item("cane", 25)
    group:item("sinister_cane", 2)
    group:item("wizard_cane", 1)
    group:item("wizard_cane_cheap", 1)
    group:item("hollow_cane", 1)
    group:item("umbrella", 20)
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 15 }
    group:item("candlestick", 5)
    content.add(group)
end
