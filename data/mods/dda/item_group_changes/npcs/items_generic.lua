local content = require("ccb").content

do
    local group = content.ItemGroup { id = "npc_underwear_bottom_male", kind = "collection" }
    group:group("male_underwear_bottom", 95)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_bottom_female", kind = "collection" }
    group:group("female_underwear_bottom", 95)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_top_male", kind = "collection" }
    group:group("male_underwear_top", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_top_female", kind = "collection" }
    group:group("female_underwear_top", 95)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_feet_male", kind = "distribution" }
    group:item("socks", 80)
    group:item("socks_ankle", 60)
    group:item("socks_wool", 20)
    group:item("null", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_feet_female", kind = "distribution" }
    group:item("socks", 50)
    group:item("socks_ankle", 30)
    group:item("socks_wool", 10)
    group:item("stockings", 20)
    group:item("tights", 20)
    group:item("null", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_pants_male", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("shorts", 5)
    group:item("shorts_cargo", 10)
    group:item("pants_cargo", 20)
    group:item("b_shorts", 10)
    group:item("motorbike_pants", 5)
    group:item("jeans_mod", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_pants_female", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("shorts", 5)
    group:item("shorts_cargo", 10)
    group:item("pants_cargo", 20)
    group:item("b_shorts", 10)
    group:item("motorbike_pants", 5)
    group:item("jeans_mod", 5)
    group:item("skirt", 20)
    group:item("skirt_long", 10)
    group:item("skirt_denim", 10)
    group:item("skirt_leather", 10)
    group:item("nanoskirt", 5)
    group:item("hot_pants", 20)
    group:item("shorts_denim", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_shirt_male", kind = "distribution" }
    group:item("tshirt", 25)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("longshirt", 20)
    group:item("denim_shirt", 10)
    group:item("sweatshirt", 20)
    group:item("buttonshirt", 10, "striped")
    group:item("sweater", 20)
    group:item("jersey", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_shirt_female", kind = "distribution" }
    group:item("tshirt", 25)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("longshirt", 20)
    group:item("denim_shirt", 10)
    group:item("sweatshirt", 20)
    group:item("buttonshirt", 10, "striped")
    group:item("sweater", 20)
    group:item("jersey", 10)
    group:item("tank_top", 20)
    group:item("halter_top", 20)
    group:item("camisole", 20)
    group:item("dress", 10)
    group:item("sundress", 10)
    group:item("corset", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_gloves", kind = "distribution" }
    group:item("null", 60)
    group:item("gloves_leather", 20)
    group:item("gloves_fingerless", 20)
    group:item("fire_gauntlets", 20)
    group:item("gloves_work", 10)
    group:item("gloves_fingerless_mod", 5)
    group:item("gloves_medical", 10)
    group:item("gloves_winter", 5)
    group:item("gloves_wool", 20)
    group:item("gloves_light", 20)
    group:item("gloves_tactical", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("hoodie", 20)
    group:item("wool_hoodie", 20)
    group:item("jacket_light", 20)
    group:item("jacket_leather", 20)
    group:item("trenchcoat", 20)
    group:item("jacket_jean", 20)
    group:item("jacket_jean_mod", 5)
    group:item("jacket_windbreaker", 10)
    group:item("folding_poncho", 10)
    group:item("jacket_leather_mod", 5)
    group:item("american_flag", 5)
    group:item("jacket_army", 3)
    group:item("jacket_army_modern", 7)
    group:item("jacket_flannel", 10)
    group:item("jacket_evac", 20)
    group:item("winter_jacket_army", 5)
    group:item("coat_winter", 10)
    group:item("peacoat", 10)
    group:item("greatcoat", 5)
    group:item("cloak", 5)
    group:item("cloak_wool", 5)
    group:item("house_coat", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_shoes_male", kind = "distribution" }
    group:item("boots", 20)
    group:item("boots_combat", 10)
    group:item("boots_hiking", 20)
    group:item("boots_western", 10)
    group:item("boots_winter", 5)
    group:item("motorbike_boots", 5)
    group:item("dress_shoes", 20)
    group:item("sneakers", 20)
    group:item("lowtops", 20)
    group:item("flip_flops", 10)
    group:item("leathersandals", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_shoes_female", kind = "distribution" }
    group:item("boots", 10)
    group:item("boots_combat", 10)
    group:item("boots_hiking", 20)
    group:item("boots_western", 20)
    group:item("boots_winter", 5)
    group:item("motorbike_boots", 5)
    group:item("dress_shoes", 20)
    group:item("sneakers", 20)
    group:item("lowtops", 20)
    group:item("flip_flops", 10)
    group:item("leathersandals", 5)
    group:item("heels", 5)
    group:item("thigh_high_boots", 10)
    group:item("knee_high_boots", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_masks", kind = "distribution" }
    group:item("null", 80)
    group:item("mask_dust", 10)
    group:item("bandana", 10)
    group:item("mask_filter", 10)
    group:item("mask_gas", 5)
    group:item("mask_bunker", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_scarf", kind = "distribution" }
    group:item("null", 20)
    group:item("knit_scarf", 30)
    group:item("long_knit_scarf", 15)
    group:item("scarf", 30)
    group:item("scarf_long", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_eyes", kind = "distribution" }
    group:item("null", 80)
    group:item("glasses_safety", 20)
    group:item("sunglasses", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_hat", kind = "distribution" }
    group:item("null", 20)
    group:item("hat_ball", 20)
    group:item("hat_hard", 5)
    group:item("hat_boonie", 5)
    group:item("hat_cotton", 20)
    group:item("hat_fur", 5)
    group:item("hat_knit", 20)
    group:item("hat_newsboy", 10)
    group:item("cowboy_hat", 10)
    group:item("hat_sombrero", 5)
    group:item("10gal_hat", 5)
    group:item("straw_hat", 5)
    group:item("hat_hunting", 10)
    group:item("hat_hard_hooded", 5)
    group:item("helmet_bike", 10)
    group:item("helmet_riot", 5)
    group:item("helmet_motor", 5)
    group:item("helmet_skid", 5)
    group:item("helmet_ball", 5)
    group:item("helmet_football", 5)
    group:item("pot_helmet", 10)
    group:item("firehelmet", 5)
    group:item("helmet_army", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_extra", kind = "distribution" }
    group:item("null", 20)
    group:item("gold_ring", 20)
    group:item("diamond_ring", 2)
    group:item("copper_bracelet", 10)
    group:item("gold_bracelet", 10)
    group:item("silver_bracelet", 10)
    group:item("silver_necklace", 5)
    group:item("silver_locket", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_wrist", kind = "distribution" }
    group:item("null", 20)
    group:item("diving_watch", 10)
    group:item("game_watch", 5)
    group:item("gold_watch", 5)
    group:item("wristwatch", 20)
    group:item("sf_watch", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_storage", kind = "distribution" }
    group:item("null", 10)
    group:item("backpack", 20)
    group:item("backpack_denim", 5)
    group:item("backpack_leather", 20)
    group:item("rucksack", 5)
    group:item("mbag", 20)
    group:item("runner_bag", 5)
    group:item("duffelbag", 5)
    group:item("dive_bag", 5)
    group:item("slingpack", 10)
    group:item("molle_pack", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_belt", kind = "distribution" }
    group:item("null", 20)
    group:item("leather_belt", 50)
    group:item("tool_belt", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_holster", kind = "distribution" }
    group:item("null", 50)
    group:item("sholster", 10)
    group:item("sheath", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_stabbing", kind = "distribution" }
    group:group("survivor_knife", 20)
    group:group("survivor_stabbing", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_throw", kind = "distribution" }
    group:item("throwing_knife", 7)
    group:item("throwing_axe", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_archery", kind = "distribution" }
    group:item("crossbow", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_misc", kind = "distribution", with_ammo = 75, with_magazine = 50 }
    group:item("101_carpentry", 1)
    group:group("used_1st_aid", 20)
    group:item("223_casing", 1)
    group:item("2lcanteen", 3)
    group:item("3006_casing", 1)
    group:item("308_casing", 1)
    group:item("38_casing", 1)
    group:item("40_casing", 1)
    group:item("44_casing", 1)
    group:item("45_casing", 1)
    group:item("57mm_casing", 1)
    group:item("762_casing", 1)
    group:item("9mm_casing", 1)
    group:item("adderall", 2)
    group:item("adjustable_stock", 1)
    group:item("adv_chemistry", 1)
    group:item("advanced_ecig", 5)
    group:item("advanced_electronics", 1)
    group:item("airhorn", 3)
    group:item("airspeargun", 1)
    group:item("alarmclock", 20)
    group:item("amplifier", 5)
    group:item("ant_egg", 5)
    group:item("antenna", 5)
    group:item("antibiotics", 20)
    group:item("antifungal", 5)
    group:item("antiparasitic", 5)
    group:item("armguard_hard", 3)
    group:item("atomic_survival", 1)
    group:item("ammonia_hydroxide", 5)
    group:group("ammonia_hydroxide_bottle_twoliter_part", 5)
    group:item("apple", 2)
    group:item("apple_cider", 2)
    group:item("apricot", 2)
    group:item("apron_leather", 1)
    group:item("aspirin", 25)
    group:item("ibuprofen", 25)
    group:item("acetaminophen", 25)
    group:item("naproxen", 25)
    group:item("ax", 5)
    group:item("backpack", 5)
    group:item("bacon", 2)
    group:item("banana", 1)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 20 }
    group:group("adhesive_bandages_box_used", 20)
    group:item("barbecue_sauce", 4)
    group:item("barrel_ported", 1)
    group:item("baseball", 1)
    group:item("bat", 5)
    group:group("ammo_pocket_batteries_full", 25)
    group:item("beartrap", 10)
    group:item("beer", 15)
    group:item("belgian_ale", 3)
    group:group("birth_control", 5)
    group:item("binoculars", 10)
    group:item("biscuit", 3)
    group:item("blackberries", 3)
    group:item("blanket", 5)
    group:group("bleach_jug_part", 5)
    group:item("blt", 1)
    group:item("blueberries", 3)
    group:item("bologna", 2)
    group:item("boltcutters", 5)
    group:item("book_archery", 1)
    group:item("book_icef", 1)
    group:item("bootstrap", 1)
    group:item("bottle_plastic", 1)
    group:item("brandy", 5)
    group:item("brass_catcher", 1)
    group:item("bread", 5)
    group:item("brewing_cookbook", 1)
    group:item("briefcase", 2)
    group:item("broccoli", 1)
    group:item("broth", 5)
    group:item("bucket", 2)
    group:item("bucket_5gal", 2)
    group:item("bum_wine", 5)
    group:item("c_fishspear", 1)
    group:item("c4", 1)
    group:group("chewing_gum_full_caff", 3)
    group:item("caffeine", 2)
    group:item("cake2", 1)
    group:item("cake3", 1)
    group:group("beans_in_can", 5)
    group:group("cheese_in_can", 5)
    group:group("chicken_in_can", 5)
    group:group("chowder_in_can", 5)
    group:item("can_coconut", 5)
    group:group("corn_in_can", 5)
    group:item("can_herring", 3)
    group:group("pineapple_in_can", 3)
    group:group("salmon_in_can", 3)
    group:group("sardine_in_can", 5)
    group:group("spam_in_can", 5)
    group:group("tuna_in_can", 5)
    group:item("candy", 3)
    group:item("candy2", 3)
    group:item("candy3", 3)
    group:item("candycigarette", 1)
    group:item("canteen", 5)
    group:item("carpentry_book", 1)
    group:item("carrot", 3)
    group:entry { item = "catfood", container = "can_food", probability = 3 }
    group:entry { item = "cell_phone", charges = { 0, 150 }, probability = 3 }
    group:entry { group = "civilian_phones", charges = { 0, -1 }, probability = 17 }
    group:item("ceramic_armor", 1)
    group:group("breakfast_cereal_in_box_full", 5)
    group:group("breakfast_cereal_in_box_full", 5)
    group:group("breakfast_cereal_in_box_full", 5)
    group:item("chain", 10)
    group:item("chainsaw_off", 7)
    group:item("char_smoker", 3)
    group:group("charcoal_bag_part", 5)
    group:item("chaw", 20)
    group:item("cheese", 5)
    group:item("cheese_fries", 1)
    group:item("cheeseburger", 1)
    group:item("cherries", 5)
    group:item("child_book", 1)
    group:item("chili", 1)
    group:item("chilidogs", 1)
    group:item("chilly-p", 1)
    group:item("chips", 15)
    group:item("chisel", 3)
    group:item("choc_drink", 2)
    group:item("choco_coffee_beans", 1)
    group:item("chocolate", 2)
    group:item("cig", 30)
    group:item("cigar", 10)
    group:item("case_cigar", 5)
    group:group("pocket_cigar", 10)
    group:item("circsaw_blade", 3)
    group:item("circsaw_off", 3)
    group:item("cleansuit", 5)
    group:item("clock", 5)
    group:item("coconut", 1)
    group:item("codeine", 3)
    group:item("coffee_raw", 5)
    group:item("coffee_syrup", 1)
    group:item("coke", 5)
    group:item("cola", 5)
    group:item("colamdew", 3)
    group:item("computer_science", 1)
    group:item("con_milk", 2)
    group:group("box_of_contact_lens_any", 5)
    group:item("corn", 3)
    group:item("cornbread", 1)
    group:item("corndogs_frozen", 2)
    group:item("cookbook", 2)
    group:item("cookbook_human", 1)
    group:item("cookbook_italian", 1)
    group:item("cookbook_mexican", 1)
    group:item("cookies", 3)
    group:group("vegetable_oil_bottle", 3)
    group:item("cordless_drill", 2)
    group:item("corded_powerdrill", 2)
    group:item("cornmeal", 3)
    group:group("cotton_ball_bag_used", 3)
    group:group("cotton_ball_bag_full", 1)
    group:item("crack", 3)
    group:item("crackers", 5)
    group:item("cranberries", 5)
    group:item("cranberry_juice", 3)
    group:item("creamsoda", 5)
    group:item("creepy_doll", 1)
    group:item("crispycran", 3)
    group:item("crowbar", 8)
    group:item("crucible", 1)
    group:item("curry_meat", 1)
    group:item("curry_powder", 2)
    group:item("curry_veggy", 1)
    group:item("dayquil", 5)
    group:item("decoy_anarch", 1)
    group:item("decoy_elfa", 1)
    group:item("dehydrator", 5)
    group:group("detergent_small_box_part", 5)
    group:item("diazepam", 3)
    group:item("disinfectant", 10)
    group:item("dive_bag", 1)
    group:item("diveknife", 1)
    group:item("diving_watch", 1)
    group:item("dog_whistle", 3)
    group:entry { item = "dogfood", container = "can_medium", probability = 3 }
    group:item("doublespeargun", 1)
    group:item("drink_boozeberry", 1)
    group:item("drink_hard_seltzer", 1)
    group:item("drink_rumcola", 1)
    group:item("drink_screwdriver", 1)
    group:item("drink_strawberry_surprise", 1)
    group:item("drink_wild_apple", 1)
    group:item("dry_beans", 7)
    group:item("dry_fish", 3)
    group:item("dry_fruit", 15)
    group:item("dry_meat", 3)
    group:item("dry_rice", 8)
    group:item("dry_veggy", 5)
    group:group("duct_tape_roll_part", 20)
    group:item("dynamite", 3)
    group:item("e_tool", 1)
    group:item("ear_plugs", 1)
    group:item("ecig", 10)
    group:item("elbow_pads", 3)
    group:item("electrohack", 1)
    group:item("emer_blanket", 2)
    group:item("emergency_book", 3)
    group:item("energy_drink", 3)
    group:item("energy_drink_atomic", 1)
    group:item("essay_book", 1)
    group:item("european_pilsner", 1)
    group:item("extinguisher", 1)
    group:item("eyedrops", 5)
    group:item("steroid_eyedrops", 2)
    group:item("fairy_tales", 1)
    group:item("family_cookbook", 3)
    group:item("fanny", 5)
    group:item("fc_hairpin", 1)
    group:item("fchicken", 1)
    group:item("file", 1)
    group:item("firecracker", 3)
    group:item("firecracker_pack", 2)
    group:item("fish_fried", 1)
    group:item("fish_sandwich", 1)
    group:item("fish_smoked", 1)
    group:item("fishspear", 1)
    group:item("flashbang", 1)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:item("flask_hip", 5)
    group:item("flour", 10)
    group:item("flyer", 1)
    group:item("folded_bicycle", 1)
    group:item("folded_skateboard_generic", 1)
    group:item("folding_poncho", 5)
    group:item("foon", 1)
    group:item("football", 1)
    group:item("fork", 1)
    group:item("fries", 1)
    group:item("junk_burrito", 3)
    group:item("frozen_dinner", 3)
    group:item("fruit_leather", 3)
    group:item("fruit_wine", 5)
    group:item("fungicide", 3)
    group:item("insecticide", 3)
    group:item("fun_survival", 5)
    group:item("funnel", 3)
    group:item("fur", 5)
    group:item("gasbomb", 1)
    group:item("gasoline_lantern", 5)
    group:item("geiger_off", 3)
    group:item("gin", 5)
    group:item("glassblowing_book", 1)
    group:item("glasses_bal", 5)
    group:item("glasses_safety", 5)
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 10 }
    group:item("goggles_ir", 1)
    group:item("goggles_nv", 1)
    group:item("balloon", 1)
    group:item("goggles_welding", 3)
    group:item("gold_watch", 5)
    group:item("golf_club", 1)
    group:item("grahmcrackers", 4)
    group:item("granola", 5)
    group:item("grapefruit", 1)
    group:item("grapes", 2)
    group:item("grapnel", 1)
    group:item("grenade", 1)
    group:item("grenade_inc", 1)
    group:item("grip", 1)
    group:group("chewing_gum_full", 8)
    group:item("g_shovel", 1)
    group:item("hackerman_computer", 1)
    group:item("hacksaw", 3)
    group:item("hairpin", 4)
    group:item("halligan", 1)
    group:item("hamburger", 1)
    group:item("hammer", 7)
    group:item("hammer_sledge", 1)
    group:item("hammer_sledge_short", 1)
    group:item("hammer_sledge_engineer", 1)
    group:item("hammer_sledge_heavy", 1)
    group:item("hand_drill", 2)
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 3 }
    group:item("hardtack", 2)
    group:item("hatchet", 5)
    group:item("heatpack", 4)
    group:item("heroin", 3)
    group:item("hockey_stick", 5)
    group:item("hoe", 4)
    group:item("holo_sight", 1)
    group:item("holster", 5)
    group:item("holybook_bible1", 3)
    group:item("holybook_bible2", 3)
    group:item("holybook_granth", 2)
    group:item("holybook_hadith", 3)
    group:item("holybook_kallisti", 1)
    group:item("holybook_kojiki", 1)
    group:item("holybook_mormon", 1)
    group:item("holybook_nag_hammadi", 1)
    group:item("holybook_pastafarian", 1)
    group:item("holybook_quran", 2)
    group:item("holybook_satanic", 1)
    group:item("holybook_scientology", 1)
    group:item("holybook_slack", 1)
    group:item("holybook_sutras", 2)
    group:item("holybook_talmud", 2)
    group:item("holybook_tanakh", 1)
    group:item("holybook_tripitaka", 1)
    group:item("holybook_upanishads", 1)
    group:item("holybook_vedas", 1)
    group:item("honey_bottled", 3)
    group:item("honey_mustard", 3)
    group:item("honeycomb", 2)
    group:item("hops", 1)
    group:item("hotdogs_frozen", 2)
    group:item("hotdogs_cooked", 1)
    group:item("hotplate", 10)
    group:item("howto_computer", 1)
    group:item("howto_traps", 2)
    group:item("imperial_stout", 2)
    group:item("improve_sights", 1)
    group:item("india_pale_ale", 2)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 5 }
    group:item("iodine", 5)
    group:entry {
        item = "apple",
        flags = {
            "IRRADIATED",
        },
        probability = 3,
    }
    group:entry {
        item = "apricot",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "banana",
        flags = {
            "IRRADIATED",
        },
        probability = 3,
    }
    group:entry {
        item = "blackberries",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "blueberries",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "broccoli",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "carrot",
        flags = {
            "IRRADIATED",
        },
        probability = 3,
    }
    group:entry {
        item = "cherries",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "cranberries",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "grapefruit",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "grapes",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "kiwi",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "lemon",
        flags = {
            "IRRADIATED",
        },
        probability = 3,
    }
    group:entry {
        item = "lettuce",
        flags = {
            "IRRADIATED",
        },
        probability = 3,
    }
    group:entry {
        item = "mango",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "melon",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "onion",
        flags = {
            "IRRADIATED",
        },
        probability = 3,
    }
    group:entry {
        item = "orange",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "papaya",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "peach",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "pear",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "pineapple",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "plums",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "pomegranate",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "raspberries",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "rhubarb",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "strawberries",
        flags = {
            "IRRADIATED",
        },
        probability = 1,
    }
    group:entry {
        item = "tomato",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "watermelon",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:entry {
        item = "zucchini",
        flags = {
            "IRRADIATED",
        },
        probability = 2,
    }
    group:item("jackhammer", 2)
    group:item("jackhammer_mining", 1)
    group:item("jam_fruit", 4)
    group:item("jar_3l_glass_sealed", 2)
    group:group("fish_pickled_jar_glass_sealed_2", 2)
    group:item("jar_glass_sealed", 2)
    group:group("meat_pickled_jar_glass_sealed_2", 2)
    group:group("veggy_pickled_jar_glass_sealed_2", 4)
    group:item("jerrycan", 3)
    group:item("jerrycan_big", 2)
    group:item("joint", 10)
    group:item("joint_roach", 5)
    group:item("jug_plastic", 3)
    group:item("juice", 5)
    group:item("kernels", 4)
    group:item("ketchup", 4)
    group:item("sheet_kevlar_layered", 1)
    group:item("knee_pads", 4)
    group:item("knife_huge", 6)
    group:item("knife_butter", 4)
    group:item("knife_combat", 4)
    group:item("knife_small", 8, "knife_steak")
    group:item("knife_trench", 3)
    group:item("knitting_needles", 1)
    group:item("lamp_oil", 2)
    group:item("laptop", 3)
    group:item("large_repairkit", 1)
    group:item("lasagne_raw", 2)
    group:item("laser_sight", 1)
    group:item("lead", 5)
    group:item("leather", 5)
    group:item("legguard_hard", 3)
    group:item("legrig", 5)
    group:item("lemon", 3)
    group:item("lemonade", 4)
    group:item("lemonlime", 4)
    group:item("lettuce", 3)
    group:item("lighter", 20)
    group:item("lgpistol_primer", 3)
    group:item("lgrifle_primer", 3)
    group:item("silver_locket", 10)
    group:item("long_island", 3)
    group:item("lsd", 3)
    group:item("lunchmeat", 3)
    group:item("lutefisk", 3)
    group:group("lye_powder_bottle_part", 4)
    group:item("m_fishspear", 1)
    group:item("macaroni_raw", 4)
    group:item("mag_archery", 2)
    group:item("mag_barter", 2)
    group:item("mag_bashing", 1)
    group:item("mag_beauty", 3)
    group:item("mag_carpentry", 2)
    group:item("mag_cars", 2)
    group:item("mag_comic", 2)
    group:item("mag_computer", 1)
    group:item("mag_cooking", 3)
    group:item("mag_cutting", 1)
    group:item("mag_dodge", 1)
    group:item("mag_dude", 1)
    group:item("mag_electronics", 2)
    group:item("mag_fabrication", 3)
    group:item("mag_firstaid", 5)
    group:item("mag_gaming", 2)
    group:item("mag_glam", 3)
    group:item("mag_guns", 3)
    group:item("mag_launcher", 1)
    group:item("mag_mechanics", 3)
    group:item("mag_melee", 1)
    group:item("mag_news", 2)
    group:item("mag_pistol", 2)
    group:item("mag_porn", 6)
    group:item("mag_rifle", 2)
    group:item("mag_shotgun", 2)
    group:item("mag_smg", 2)
    group:item("mag_stabbing", 2)
    group:item("mag_survival", 6)
    group:item("mag_swimming", 1)
    group:item("mag_tailor", 3)
    group:item("mag_throwing", 1)
    group:item("mag_traps", 5)
    group:item("mag_tv", 1)
    group:item("mag_unarmed", 1)
    group:item("manual_archery", 3)
    group:item("manual_brawl", 2)
    group:item("manual_business", 2)
    group:item("manual_carpentry", 3)
    group:item("manual_computer", 1)
    group:item("manual_cutting", 1)
    group:item("manual_dodge", 1)
    group:item("manual_gun", 2)
    group:item("manual_knives", 2)
    group:item("manual_fabrication", 2)
    group:item("manual_first_aid", 3)
    group:item("manual_launcher", 1)
    group:item("manual_mechanics", 2)
    group:item("manual_melee", 1)
    group:item("manual_pistol", 1)
    group:item("manual_rifle", 1)
    group:item("manual_shotgun", 1)
    group:item("manual_smg", 1)
    group:item("manual_speech", 2)
    group:item("manual_stabbing", 1)
    group:item("manual_survival", 2)
    group:item("manual_swimming", 1)
    group:item("manual_throw", 1)
    group:item("manual_traps", 2)
    group:item("maple_sap", 1)
    group:item("mask_bal", 1)
    group:item("mask_dust", 4)
    group:item("mask_filter", 1)
    group:item("maltballs", 1)
    group:item("maple_candy", 2)
    group:item("marshmallow", 2)
    group:item("mask_hockey", 1)
    group:item("masterkey", 1)
    group:item("match_trigger", 1)
    group:item("matches", 10)
    group:item("mayonnaise", 2)
    group:item("mbag", 5)
    group:item("slingpack", 5)
    group:item("meat", 10)
    group:item("meat_smoked", 2)
    group:item("medical_gauze", 3)
    group:group("medical_tape_roll_part", 3)
    group:item("melon", 3)
    group:item("meth", 5)
    group:item("milk_powder", 3)
    group:item("mintpatties", 3)
    group:item("misc_repairkit", 5)
    group:item("ballistic_vest_esapi", 1)
    group:item("molasses", 3)
    group:item("money_strap_one", 10)
    group:item("money_strap_five", 5)
    group:item("money_strap_ten", 5)
    group:item("money_strap_twenty", 2)
    group:item("moonshine", 5)
    group:item("mp3", 10)
    group:entry { group = "any_MRE", count = { 1, 3 }, probability = 20 }
    group:item("mushroom", 5)
    group:item("mustard", 3)
    group:item("muzzle_brake", 1)
    group:item("nachos", 1)
    group:item("nachosc", 1)
    group:item("nachosm", 1)
    group:item("nachosmc", 1)
    group:item("nail", 3)
    group:item("nailgun", 3)
    group:item("neccowafers", 4)
    group:item("silver_necklace", 5)
    group:item("news_regional", 3)
    group:group("chewing_gum_full_nic", 8)
    group:group("nicotine_liquid_bottle_part", 6)
    group:item("noodles_fast", 3)
    group:item("novel_adventure", 1)
    group:item("novel_buddy", 1)
    group:item("novel_coa", 1)
    group:item("novel_crime", 1)
    group:item("novel_drama", 1)
    group:item("novel_erotic", 1)
    group:item("novel_experimental", 1)
    group:item("novel_fantasy", 1)
    group:item("novel_horror", 1)
    group:item("novel_mystery", 1)
    group:item("novel_road", 1)
    group:item("novel_romance", 1)
    group:item("novel_pulp", 1)
    group:item("novel_samurai", 1)
    group:item("novel_satire", 1)
    group:item("novel_scifi", 1)
    group:item("novel_sports", 1)
    group:item("novel_spy", 1)
    group:item("novel_swash", 1)
    group:item("novel_thriller", 1)
    group:item("novel_tragedy", 1)
    group:item("novel_war", 1)
    group:item("novel_western", 1)
    group:item("nyquil", 8)
    group:item("oatmeal", 3)
    group:item("oil_lamp", 4)
    group:item("onion", 4)
    group:item("onion_rings", 1)
    group:item("orange", 2)
    group:item("orangesoda", 3)
    group:group("oxy_powder_bottle_part", 3)
    group:item("oxycodone", 5)
    group:item("oxygen_tank", 2)
    group:item("pale_ale", 2)
    group:item("pan", 8)
    group:item("pastaextruder", 1)
    group:item("peach", 3)
    group:item("peanutbutter", 6)
    group:item("pear", 3)
    group:item("pepper", 5)
    group:entry { item = "permanent_marker", charges = { 0, 500 }, probability = 5 }
    group:item("philosophy_book", 1)
    group:item("photo_album", 1)
    group:item("pickaxe", 8)
    group:item("pickle", 5)
    group:item("picklocks", 5)
    group:item("pie", 3)
    group:item("pie_meat", 1)
    group:item("pills_sleep", 3)
    group:item("pipe", 4)
    group:item("pipe_glass", 1)
    group:item("pipe_tobacco", 1)
    group:item("pipebomb", 3)
    group:item("pistol_bayonet", 1)
    group:item("pistol_scope", 1)
    group:item("pistol_stock", 1)
    group:item("pizza_veggy", 1)
    group:item("pizza_meat", 1)
    group:item("plays_book", 1)
    group:item("plums", 2)
    group:item("plut_cell", 2)
    group:item("pocket_firearms", 2)
    group:item("pocket_firstaid", 3)
    group:item("pocket_survival", 2)
    group:item("pocketwatch", 5)
    group:item("pockknife", 10)
    group:item("poetry_book", 1)
    group:item("pool_ball", 1)
    group:item("pool_cue", 6)
    group:item("portable_game", 1)
    group:item("pot", 10)
    group:item("potato", 4)
    group:item("powder_candy", 2)
    group:item("powder_eggs", 4)
    group:item("power_supply", 1)
    group:item("press", 1)
    group:item("processor", 1)
    group:group("protein_powder_bottle_plastic_small_1_9", 1)
    group:item("protein_shake", 1)
    group:item("prozac", 3)
    group:item("puck", 1)
    group:item("pudding", 2)
    group:item("puller", 1)
    group:item("punch_dagger", 2)
    group:group("pur_tablets_bottle_plastic_small_50")
    group:item("purple_drink", 3)
    group:item("purse", 4)
    group:item("quikclot", 5)
    group:item("quiver", 3)
    group:item("quiver_large", 1)
    group:item("RAM", 2)
    group:item("radio", 8)
    group:item("radio_book", 2)
    group:item("cotton_patchwork", 5)
    group:item("rail_laser_sight", 1)
    group:item("raspberries", 4)
    group:item("ravioli", 1)
    group:item("razor_blade", 3)
    group:item("rebreather", 3)
    group:item("rebreather_filler_soda_lime", 1)
    group:item("receiver", 1)
    group:item("recipe_arrows", 3)
    group:item("recipe_augs", 1)
    group:item("recipe_bows", 3)
    group:item("recipe_bullets", 3)
    group:item("recipe_elfa", 1)
    group:item("battery_ups", 5)
    group:item("recoil_stock", 1)
    group:item("red_dot_sight", 1)
    group:item("ref_lighter", 6)
    group:item("restaurantmap", 5)
    group:item("rhubarb", 1)
    group:item("rifle_scope", 4)
    group:item("gold_ring", 6)
    group:item("roadmap", 4)
    group:item("rolling_paper", 3)
    group:item("rollmat", 8)
    group:item("rootbeer", 4)
    group:item("rope_30", 4)
    group:item("rope_6", 4)
    group:item("royal_jelly", 1)
    group:item("rubber_band", 4)
    group:item("rum", 4)
    group:item("runner_bag", 1)
    group:item("SICP", 1)
    group:item("saline", 3)
    group:item("salt", 10)
    group:item("salt_water", 3)
    group:item("salted_fish", 5)
    group:item("sandwich_t", 3)
    group:item("sandwich_pb", 3)
    group:item("sandwich_pbj", 3)
    group:item("sandwich_pbh", 3)
    group:item("sandwich_pbm", 3)
    group:item("sauce_pesto", 2)
    group:item("sauce_red", 2)
    group:item("saw", 5)
    group:item("scissors", 8)
    group:item("screwdriver", 8)
    group:item("scythe", 5)
    group:item("seasoning_italian", 5)
    group:item("seasoning_salt", 8)
    group:item("seed_barley", 3)
    group:item("seed_blueberries", 3)
    group:item("seed_cotton_boll", 3)
    group:item("seed_hops", 3)
    group:item("seed_strawberries", 3)
    group:item("seed_sugar_beet", 3)
    group:item("seed_tomato", 3)
    group:item("seed_weed", 3)
    group:item("seed_tobacco", 3)
    group:item("seed_wheat", 3)
    group:entry { item = "sewing_kit", charges = { 0, -1 }, probability = 15 }
    group:item("sheath", 8)
    group:item("shot_hull", 1)
    group:item("shotgun_primer", 2)
    group:item("shovel", 8)
    group:item("sickle", 3)
    group:item("sleeping_bag_roll", 10)
    group:item("sloppyjoe", 3)
    group:item("sm_extinguisher", 2)
    group:item("small_lcd_screen", 1)
    group:item("small_repairkit", 3)
    group:item("smart_lamp", 2)
    group:item("smokebomb", 2)
    group:item("smoxygen_tank", 1)
    group:item("smpistol_primer", 2)
    group:item("smrifle_primer", 2)
    group:item("soap", 10)
    group:item("socks", 10)
    group:item("socks_ankle", 10)
    group:item("socks_wool", 10)
    group:group("solder_wire_spool_part", 5)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 5 }
    group:item("soup_chicken", 3)
    group:item("soup_dumplings", 3)
    group:item("soup_meat", 3)
    group:item("soup_mushroom", 2)
    group:item("soup_tomato", 2)
    group:item("soup_veggy", 2)
    group:item("spaghetti_raw", 4)
    group:item("speargun", 1)
    group:item("spoon", 5)
    group:item("spork", 3)
    group:item("sports_drink", 4)
    group:item("spray_can", 3)
    group:item("stethoscope", 2)
    group:item("stick", 5)
    group:item("story_book", 1)
    group:item("stout", 3)
    group:item("strawberries", 3)
    group:item("string_36", 4)
    group:item("string_6", 4)
    group:item("sugar", 7)
    group:item("sugar_beet", 2)
    group:group("glue_weak_domestic", 4)
    group:group("glue_strong_domestic", 4)
    group:item("suppressor", 1)
    group:item("survival_book", 3)
    group:item("survnote", 3)
    group:item("swim_fins", 1)
    group:item("switchblade", 5)
    group:item("sword_bayonet", 1)
    group:item("syringe", 3)
    group:item("shavingkit", 3)
    group:item("survivor_shavingkit", 5)
    group:item("elec_hairtrimmer", 2)
    group:item("survivor_hairtrimmer", 3)
    group:item("syrup", 4)
    group:item("tailor_portfolio", 1)
    group:item("talking_doll", 3)
    group:item("tall_tales", 1)
    group:item("tazer", 5)
    group:group("tea_raw_bag_plastic_33", 8)
    group:group("tea_green_raw_bag_plastic_33", 4)
    group:item("teapot", 8)
    group:item("teleumbrella", 4)
    group:item("tent_kit", 6)
    group:item("tequila", 5)
    group:item("textbook_anarch", 1)
    group:item("improvised_munition_handbook", 1)
    group:item("textbook_armeast", 1)
    group:item("textbook_armwest", 1)
    group:item("textbook_business", 1)
    group:item("textbook_carpentry", 2)
    group:item("textbook_chemistry", 1)
    group:item("textbook_computer", 1)
    group:item("textbook_electronics", 1)
    group:item("textbook_fabrication", 2)
    group:item("textbook_fireman", 1)
    group:item("textbook_firstaid", 2)
    group:item("textbook_gaswarfare", 1)
    group:item("textbook_mechanics", 1)
    group:item("textbook_robots", 1)
    group:item("textbook_speech", 1)
    group:item("textbook_survival", 1)
    group:item("textbook_tailor", 1)
    group:item("textbook_traps", 2)
    group:item("textbook_weapeast", 1)
    group:item("textbook_weapwest", 1)
    group:item("textbook_weparabic", 1)
    group:item("thermal_socks", 3)
    group:item("thorazine", 3)
    group:item("thread", 8)
    group:item("throw_extinguisher", 2)
    group:item("throwing_knife", 6)
    group:item("tin", 2)
    group:item("toastem", 9)
    group:item("toasterpastryfrozen", 3)
    group:item("tobacco", 8)
    group:item("tomato", 3)
    group:item("tongs", 2)
    group:item("tool_belt", 8)
    group:group("tools_toolbox", 4)
    group:item("touristmap", 6)
    group:item("towel", 4)
    group:item("tramadol", 4)
    group:item("transponder", 2)
    group:item("trappers_companion", 2)
    group:item("triple_sec", 2)
    group:item("two_way_radio", 10)
    group:item("UPS_OFF", 4)
    group:item("umbrella", 3)
    group:item("usb_drive", 3)
    group:item("V8", 3)
    group:item("vac_sealer", 1)
    group:item("vacutainer", 3)
    group:item("veggy", 8)
    group:group("sex_accessories_domestic", 3)
    group:item("vinegar", 5)
    group:item("vitamins", 10)
    group:item("calcium_tablet", 10)
    group:item("vodka", 4)
    group:item("water_clean", 20)
    group:item("water_mineral", 10)
    group:item("water_purifier", 8)
    group:item("watermelon", 4)
    group:item("wearable_light", 10)
    group:item("webbasics_computer", 1)
    group:item("weed", 12)
    group:item("welder", 3)
    group:item("welding_book", 2)
    group:item("wheat", 3)
    group:item("whiskey", 6)
    group:item("wine_barley", 12)
    group:item("wine_cabernet", 3)
    group:item("wine_chardonnay", 3)
    group:item("wine_marsala", 2)
    group:item("wine_noir", 3)
    group:item("wine_riesling", 3)
    group:item("wine_vermouth", 3)
    group:item("wrapped_rad_badge", 2)
    group:item("wrapper", 3)
    group:item("wrench", 3)
    group:item("wristwatch", 10)
    group:item("xacto", 5)
    group:item("xanax", 3)
    group:item("yeast", 5)
    group:item("yoghurt", 2)
    group:item("zucchini", 3)
    content.add(group)
end
