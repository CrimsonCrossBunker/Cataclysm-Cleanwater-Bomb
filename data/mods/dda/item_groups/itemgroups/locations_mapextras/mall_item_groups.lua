local content = require("ccb").content

do
    local group = content.ItemGroup { id = "toy_store", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("bat_nerf")
    group:entry { item = "portable_game", charges = { 100, 100 }, probability = 60 }
    group:item("bat", 60)
    group:item("pom_poms", 40)
    group:item("backpack_small", 40)
    group:item("backpack", 5)
    group:item("backpack_denim", 5)
    group:item("backpack_giant", 1)
    group:item("pockknife", 5)
    group:item("wristwatch", 20)
    group:item("teleumbrella", 5)
    group:group("kids_books", 155)
    group:group("games", 170)
    group:item("frisbee", 40)
    group:item("disc_golf", 40)
    group:item("magic_8_ball", 30)
    group:item("novel_pulp", 20)
    group:item("folded_bicycle", 5)
    group:item("sunglasses", 25)
    group:item("cowboy_hat", 25)
    group:item("fursuit", 5)
    group:entry { item = "mp3", charges = { 100, 100 }, probability = 20 }
    group:item("fursuit", 5, "wolfsuit")
    group:item("fursuit", 5, "dinosuit")
    group:group("chewing_gum_full", 10)
    group:item("shuttlecock", 10)
    group:item("baseball", 40)
    group:item("football", 40)
    group:item("basketball", 50)
    group:item("shark_plushie", 25)
    group:entry { item = "talking_doll", charges = { 100, 100 }, probability = 50 }
    group:entry { item = "marble", charges = { 1, 20 }, probability = 60 }
    group:entry { item = "creepy_doll", charges = { 100, 100 }, probability = 1 }
    group:item("jedi_cloak", 5)
    group:item("clown_suit", 5)
    group:item("clownshoes", 5)
    group:group("toy_radio_car", 10)
    group:group("toy_makerspace_kit", 10)
    group:group("toy_robot_kit", 10)
    group:group("toy_engine_kit", 10)
    group:item("air_launcher", 5)
    group:entry { item = "wizard_cane_cheap", charges = { 1, 100 }, probability = 5 }
    group:entry { item = "wizard_cane", charges = { 50, 100 }, probability = 1 }
    group:item("sinister_cane", 5)
    group:item("scythe_toy", 5)
    group:item("RPG_die", 5)
    group:item("metal_RPG_die", 1)
    group:entry { item = "inflatable_dragon", charges = { 0, 56 }, probability = 1 }
    group:entry { item = "inflatable_ghost", charges = { 0, 56 }, probability = 1 }
    group:entry { item = "fog_machine", charges = { 0, 56 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glasses", kind = "distribution" }
    group:item("glasses_monocle", 5)
    group:item("glasses_bal", 10)
    group:item("sunglasses", 30)
    group:item("glasses_bifocal", 30)
    group:item("glasses_safety", 30)
    group:item("glasses_reading", 50)
    group:item("glasses_eye", 85)
    group:item("sunglasses_bifocal", 25)
    group:item("sunglasses_reading", 35)
    group:item("sunglasses_eye", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "knife_shop", kind = "distribution" }
    group:item("knife_huge", 20, "knife_butcher")
    group:item("knife_combat", 5)
    group:item("knife_combat_army", 2)
    group:item("knife_combat_marine", 1)
    group:item("knife_KABAR", 35)
    group:entry { item = "knife_combat_army", variant = "akbayonet", wrapper = "sheath", probability = 10 }
    group:group("infantry_knives", 5)
    group:entry { item = "throwing_knife", count = { 1, 6 }, wrapper = "leg_sheath6", probability = 5 }
    group:item("throwing_knife", 10)
    group:item("pockknife", 50)
    group:item("punch_dagger", 10)
    group:item("knife_trench", 7)
    group:item("switchblade", 20)
    group:item("knife_hunting", 20)
    group:group("knife_rambo_full", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "leather_shop", kind = "distribution" }
    group:item("hot_pants_leather", 20)
    group:item("cloak_leather", 20)
    group:item("duster_leather", 20)
    group:item("skirt_leather", 20)
    group:item("touring_suit", 20)
    group:item("chestwrap_leather", 20)
    group:item("bellywrap_leather", 8)
    group:item("chaps_leather", 35)
    group:item("trenchcoat_leather", 10)
    group:item("vest_leather", 50)
    group:item("apron_leather", 10)
    group:item("backpack_leather", 7)
    group:item("pants_leather", 20)
    group:item("bikini_top_leather", 20)
    group:item("jacket_leather", 5)
    group:item("horse_tack", 5)
    group:item("yoke_harness", 5)
    group:item("reins_tackle", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "leather_shop_accessories", kind = "distribution" }
    group:item("leather_belt", 20)
    group:item("gloves_leather", 35)
    group:item("leather_harness_dog", 10)
    group:item("pockknife", 50)
    group:item("leather_tarp", 10)
    group:item("leather_cat_tail", 7)
    group:item("leather_cat_ears", 20)
    group:item("leather_collar", 20)
    group:item("bondage_mask", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "leather_shop_repair", kind = "distribution" }
    group:item("awl_steel", 40)
    group:entry { item = "sewing_kit", charges = { 200, 200 }, probability = 5 }
    group:item("sewing_machine", 50)
    group:entry { item = "tailors_kit", charges = { 400, 400 }, probability = 50 }
    group:item("thread", 10)
    group:item("string_6", 50)
    group:item("leather", 10)
    group:item("fur", 7)
    group:item("sheet_leather", 20)
    group:item("tanned_hide", 20)
    group:item("tanned_pelt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "smoke_shop", kind = "distribution" }
    group:item("pipe_tobacco", 60)
    group:group("tobacco_bag_plastic_20", 70)
    group:entry { group = "cigar_box_unopened", count = { 1, 10 }, probability = 15 }
    group:entry { item = "case_cigar", count = { 1, 5 }, probability = 20 }
    group:entry { item = "weed", count = { 5, 5 }, probability = 5 }
    group:item("joint", 5)
    group:entry { item = "seed_weed", count = { 2, 2 }, probability = 5 }
    group:item("seed_tobacco", 5)
    group:item("rolling_paper", 45)
    group:item("pipe_glass", 20)
    group:group("cig_box_cigarette_20", 60)
    group:group("chaw_wrapper_20", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cell_shop", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:entry { item = "portable_game", charges = { 100, 100 }, probability = 20 }
    group:item("antenna", 25)
    group:group("box_of_batteries_unopened", 50)
    group:entry { item = "mp3", charges = { 100, 100 }, probability = 30 }
    group:group("new_phones", 90)
    group:group("new_usb_drives", 10)
    group:group("new_memory_cards", 10)
    group:item("manual_electronics", 20)
    group:group("cable_roll", 60)
    group:group("copper_wire_roll_part", 30)
    group:item("wristwatch", 60)
    group:item("fitness_band", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beauty", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("mag_glam", 40)
    group:item("mag_beauty", 30)
    group:item("hairpin", 40)
    group:item("scarf", 10)
    group:item("scarf_long", 5)
    group:item("knit_scarf", 10)
    group:item("long_knit_scarf", 5)
    group:item("bellyband", 5)
    group:item("barrette", 5)
    group:item("eyedrops", 35)
    group:entry { item = "candle", charges = { 100, 100 }, probability = 50 }
    group:item("scissors", 30)
    group:item("soap", 45)
    group:entry { item = "moisturizer", charges = { 1, -1 }, container = "bottle_plastic_small", probability = 60 }
    group:entry { item = "tailors_kit", charges = { 400, 400 }, probability = 25 }
    group:entry { item = "shavingkit", charges = { 10, 10 }, probability = 20 }
    group:entry { item = "elec_hairtrimmer", charges = { 50, 50 }, probability = 20 }
    group:item("razor_shaving", 20)
    group:item("curler_hair", 30)
    group:item("hair_dryer", 40)
    group:item("curling_iron", 40)
    group:item("comb_pocket", 10)
    group:item("hairbrush", 10)
    group:item("mirror", 35)
    group:item("makeup_kit", 30)
    content.add(group)
end
