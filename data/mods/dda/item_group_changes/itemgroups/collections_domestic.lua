local content = require("ccb").content

do
    -- Mundane household appliances that you might find in a kitchen.
    local group = content.ItemGroup { id = "kitchen_appliances", kind = "distribution" }
    group:item("toaster", 30)
    group:item("microwave", 30)
    group:item("coffeemaker", 30)
    group:item("food_processor", 30)
    group:item("waffleiron", 25)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:item("pastaextruder", 10)
    group:item("dehydrator", 10)
    group:item("hotplate", 10)
    group:item("clock", 10)
    group:item("multi_cooker", 5)
    group:entry { item = "char_smoker", charges = { 0, -1 }, probability = 5 }
    group:item("can_sealer", 2)
    group:item("oil_press_manual", 2)
    group:item("snow_machine_home", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "home_hw", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:group("tools_home", 150)
    group:group("tools_general", 30)
    group:group("supplies_hardware", 50)
    group:item("manual_mechanics", 35)
    group:item("manual_fabrication", 20)
    group:item("recipe_bows", 10)
    group:item("recipe_arrows", 10)
    group:item("bubblewrap", 50)
    group:item("binoculars", 20)
    group:item("roller_blades", 20)
    group:group("duct_tape_roll_part")
    group:group("glue_weak_domestic", 60)
    group:group("glue_strong_domestic", 40)
    group:item("lawnmower", 25)
    group:item("lawn_dart", 10)
    group:item("dehydrator", 15)
    group:entry { item = "jar_glass_sealed", count = { 1, 12 }, probability = 25 }
    group:item("jar_glass_sealed", 50)
    group:item("jar_3l_glass_sealed", 40)
    group:item("flotation_vest", 1)
    group:group("tools_fishingrods_commercial", 2)
    group:entry { item = "portable_stove", sealed = false, container = "nylon_bag", probability = 1 }
    group:entry { item = "bearing", charges = { 1, 50 }, probability = 1 }
    group:item("alarmclock", 10)
    group:item("pet_carrier", 3)
    group:group("charcoal_bag_part", 20)
    group:item("thermometer", 3)
    group:item("hygrometer", 3)
    group:item("barometer", 3)
    group:entry { item = "smart_lamp", charges = { 0, 100 }, probability = 3 }
    group:entry {
        collection = {
            { group = "charcoal_bag_part", probability = 70 },
            { item = "char_smoker" },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            { item = "denat_alcohol", probability = 70 },
            { item = "popcan_stove" },
        },
        probability = 6,
    }
    group:entry {
        collection = {
            { item = "methed_alcohol", probability = 70 },
            { item = "popcan_stove" },
        },
        probability = 4,
    }
    group:entry {
        collection = {
            { item = "oil_lamp" },
            { item = "lamp_oil", probability = 70 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "livingroom", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:group("soda_in_small_container", 325)
    group:group("magazines", 265)
    group:item("basket_laundry", 20)
    group:item("television", 30)
    group:item("clock", 10)
    group:item("fp_loyalty_card", 5)
    group:entry { item = "cola", sealed = false, container = "bottle_plastic", probability = 20 }
    group:entry { item = "rootbeer", sealed = false, container = "bottle_plastic", probability = 20 }
    group:entry { item = "lemonlime", sealed = false, container = "bottle_plastic", probability = 10 }
    group:entry { item = "orangesoda", sealed = false, container = "bottle_plastic", probability = 15 }
    group:entry { item = "colamdew", sealed = false, container = "bottle_plastic", probability = 10 }
    group:entry { item = "zerocola", sealed = false, container = "bottle_plastic", probability = 10 }
    group:entry { item = "zeroorange", sealed = false, container = "bottle_plastic", probability = 10 }
    group:entry { item = "zerotropical", sealed = false, container = "bottle_plastic", probability = 10 }
    group:entry { item = "zeromdew", sealed = false, container = "bottle_plastic", probability = 10 }
    group:entry { item = "foodplace_zero_drink", sealed = false, container = "bottle_plastic", probability = 3 }
    group:entry { item = "tonic_water", sealed = false, container = "bottle_plastic", probability = 5 }
    group:item("sponge", 5)
    group:group("tobacco_products", 151)
    group:group("cigar_box_opened", 5)
    group:entry { item = "weed", count = { 1, 5 }, probability = 10 }
    group:item("hi_q_shatter", 5)
    group:item("hi_q_wax", 5)
    group:item("joint", 10)
    group:entry { item = "seed_weed", count = { 2, 2 }, probability = 5 }
    group:item("seed_tobacco", 5)
    group:item("seed_poppy_bud", 5)
    group:item("rolling_paper", 5)
    group:item("mask_hockey", 5)
    group:item("mask_skull", 5, "guy_fawkes")
    group:item("hockey_stick", 10)
    group:item("throat_guard_nylon", 3)
    group:item("throat_guard_canvas", 3)
    group:item("throat_guard_plastic", 1)
    group:item("throat_guard_cut_resistant", 1)
    group:item("news_regional", 4)
    group:group("newspaper_old", 5)
    group:group("kids_books", 110)
    group:group("novels", 16)
    group:item("tailor_portfolio", 1)
    group:item("trappers_companion", 1)
    group:item("puck", 5)
    group:item("shuttlecock", 1)
    group:item("baseball", 5)
    group:item("football", 5)
    group:item("golf_club", 10)
    group:item("jersey", 10)
    group:item("fan", 10)
    group:item("pipe_glass", 5)
    group:group("coke_bag_zipper_1_8", 8)
    group:item("hat_golf", 15)
    group:item("gloves_golf", 15)
    group:item("golf_bag", 10)
    group:item("golf_tee", 15)
    group:item("golf_ball", 30)
    group:item("golf_club", 15)
    group:group("meth_bag_zipper_1_6", 2)
    group:item("sandbox_kit", 1)
    group:item("sneakers", 80)
    group:item("boots", 70)
    group:item("knee_high_boots", 10)
    group:item("boots_combat", 10)
    group:item("boots_winter", 60)
    group:item("boots_hiking", 10)
    group:item("travelpack", 7)
    group:item("backpack_denim", 1)
    group:item("backpack_hiking", 4)
    group:item("backpack_hunting", 1)
    group:item("bigback", 1)
    group:item("petpack", 1)
    group:item("smart_lamp", 1)
    group:item("runner_bag", 5)
    group:item("flip_flops", 35)
    group:item("flip_flops_exp", 5)
    group:item("lowtops", 45)
    group:item("dress_shoes", 50)
    group:item("dance_shoes", 5)
    group:item("heels", 50)
    group:item("coat_rain", 50)
    group:item("hood_rain", 20)
    group:item("jacket_windbreaker", 25)
    group:item("rashguard", 15)
    group:item("flag_swimsuit", 10)
    group:item("wetsuit", 2)
    group:item("wetsuit_spring", 2)
    group:item("wetsuit_spring_sleeveless", 2)
    group:item("wetsuit_gloves", 3)
    group:item("wetsuit_booties", 3)
    group:item("wetsuit_hood", 2)
    group:item("swim_cap", 10)
    group:item("scuba_tank", 2)
    group:item("scuba_regulator", 2)
    group:item("dive_bag", 3)
    group:item("dry_bag", 3)
    group:item("dry_duffelbag", 2)
    group:item("dry_bag_large", 1)
    group:item("poncho", 15)
    group:group("wallets", 15)
    group:item("folding_poncho", 5)
    group:item("gloves_light", 35)
    group:item("mittens", 30)
    group:item("armguard_soft", 40)
    group:item("chestguard_hard", 20)
    group:item("armguard_hard", 20)
    group:item("legguard_hard", 15)
    group:item("gloves_wool", 33)
    group:item("gloves_wool_fingerless", 15)
    group:item("thermal_socks", 2)
    group:item("thermal_gloves", 2)
    group:item("thermal_suit", 2)
    group:item("thermal_mask", 2)
    group:item("thermal_outfit", 1)
    group:item("gloves_winter", 40)
    group:item("gloves_liner", 25)
    group:item("gloves_leather", 45)
    group:item("gloves_fingerless", 20)
    group:item("gloves_work", 2)
    group:item("bandana", 35)
    group:item("scarf", 45)
    group:item("knit_scarf", 35)
    group:item("long_knit_scarf", 5)
    group:item("scarf_long", 2)
    group:item("hairpin", 5)
    group:item("fc_hairpin", 1)
    group:item("barrette", 3)
    group:item("hat_cotton", 45)
    group:item("hat_knit", 25)
    group:item("hat_fur", 15)
    group:item("hat_faux_fur", 30)
    group:item("hat_newsboy", 20)
    group:item("hat_sombrero", 3)
    group:item("helmet_bike", 35)
    group:item("helmet_motor", 40)
    group:item("touring_suit", 15)
    group:item("motorbike_armor", 10)
    group:item("motorbike_pants", 10)
    group:item("motorbike_boots", 10)
    group:item("leg_bag", 10)
    group:item("briefcase", 2)
    group:item("trailmap", 10)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 60 }
    group:entry { item = "lighter", charges = { 0, 50 }, probability = 30 }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 2 }
    group:group("butane_lighter_and_fuel", 2)
    group:entry { item = "matches", charges = { 1, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 60 }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 6 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "game_watch", charges = { 0, 50 }, probability = 2 }
    group:group("decks_of_cards", 2)
    group:group("alcohol", 163)
    group:group("civilian_phones", 36)
    group:item("waterproof_smart_phone_case", 5)
    group:item("wristwatch", 15)
    group:item("pocketwatch", 5)
    group:item("umbrella", 50)
    group:item("teleumbrella", 20)
    group:item("fish_bowl", 1)
    group:entry { item = "lsd", count = { 1, 5 }, probability = 1 }
    group:group("civilian_laptops", 10)
    group:item("file", 5)
    group:group("civilian_eink_tablet_pcs", 2)
    group:group("civilian_usb_drives", 15)
    group:group("civilian_memory_cards", 4)
    group:entry { item = "camera", charges = { 0, 150 }, probability = 1 }
    group:entry { item = "camera", charges = { 0, 150 }, container = "camera_bag", probability = 2 }
    group:item("camera_bag", 3)
    group:group("chewing_gum_used", 30)
    group:group("chewing_gum_used_caff", 3)
    group:group("licorice_bag_plastic_4", 3)
    group:item("flask_hip", 5)
    group:item("dog_whistle", 5)
    group:item("pet_carrier", 2)
    group:item("rubber_harness_dog", 2)
    group:entry { item = "dogfood", container = "can_medium", probability = 5 }
    group:entry { item = "catfood", container = "can_food", probability = 5 }
    group:entry { item = "dogfood_dry", count = { 2, -1 }, probability = 2 }
    group:entry { item = "catfood_dry", count = { 2, -1 }, probability = 2 }
    group:group("chewing_gum_used_nic", 2)
    group:entry { item = "oxygen_tank", charges = { 0, 12 }, probability = 2 }
    group:entry { item = "smoxygen_tank", charges = { 0, 24 }, probability = 1 }
    group:group("religious_books", 38)
    group:group("SUS_book_nonf_pulp_newage", 5)
    group:item("leathersandals", 25)
    group:item("espadrilles", 15)
    group:item("phonebook", 5)
    group:item("survnote", 1)
    group:group("toy_radio_car", 2)
    group:group("toy_makerspace_kit", 1)
    group:group("toy_robot_kit", 1)
    group:group("toy_engine_kit", 1)
    group:entry { item = "radiocontrol", charges = { 0, 50 }, probability = 5 }
    group:item("magnifying_glass", 2)
    group:item("straw_hat", 5)
    group:item("kufi", 1)
    group:item("hijab", 1)
    group:item("niqab", 1)
    group:item("thawb", 1)
    group:item("abaya", 1)
    group:item("kippah", 1)
    group:item("robe", 3)
    group:item("yukata", 1)
    group:item("eclipse_glasses", 1)
    group:entry { item = "reading_light", charges = { 0, 50 }, probability = 9 }
    group:item("balloon", 5)
    group:group("memorial", 3)
    group:item("air_launcher", 1)
    group:item("home_picture", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kitchen", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:group("snacks", 370)
    group:item("aluminum_foil", 25)
    group:item("rolling_pin", 25)
    group:group("breakfast_cereal_in_box", 60)
    group:group("kitchen_appliances", 253)
    group:item("apron_cotton", 25)
    group:item("waist_apron_long", 7)
    group:item("waist_apron_short", 4)
    group:item("apron_leather", 2)
    group:item("hat_chef", 2)
    group:item("garlic", 3)
    group:item("jacket_chef", 2)
    group:item("gloves_cut_resistant", 1)
    group:item("pot", 25)
    group:item("sponge", 30)
    group:item("pot_copper", 15)
    group:item("pot_canning", 15)
    group:item("pressure_cooker", 10)
    group:item("dutch_oven", 5)
    group:item("thermometer", 5)
    group:item("pan", 25)
    group:group("dishes_dining", 460)
    group:group("condiments", 425)
    group:group("pantry_liquids", 160)
    group:item("knife_huge", 10, "knife_butcher")
    group:item("cotton_patchwork", 1)
    group:entry { item = "popcan_stove", charges = { 0, 500 }, probability = 5 }
    group:group("alcohol", 101)
    group:item("sweet_sausage", 2)
    group:item("roasted_coffee_bean", 10)
    group:group("bacon_bag_plastic_2", 25)
    group:group("bleach_jug_part", 20)
    group:entry { item = "chem_washing_soda", count = { 1, -1 }, probability = 20 }
    group:entry { item = "chem_baking_soda", count = { 1, -1 }, probability = 20 }
    group:group("ammonia_hydroxide_bottle_twoliter_part", 24)
    group:entry { item = "butane_can", charges = { 200, 400 }, probability = 10 }
    group:group("milk_powder_various", 15)
    group:group("cocoa_powder_various", 15)
    group:group("milk_cocoa_powder_various", 15)
    group:group("powder_eggs_bottle_plastic_small_16", 20)
    group:group("protein_powder_bottle_plastic_small_1_9", 12)
    group:group("dry_goods", 365)
    group:group("fchicken_box_small_4", 25)
    group:item("lunchmeat", 10)
    group:group("bologna_bag_plastic_10", 10)
    group:item("nachosc", 10)
    group:item("nachosm", 10)
    group:item("nachosmc", 2)
    group:group("toastem_box_small_8", 95)
    group:group("brownie_box_small_4", 30)
    group:group("lemonade_powder_bottle_plastic_small_10", 15)
    group:item("funnel", 50)
    group:group("cookbooks", 135)
    group:group("pizza_veggy_box_small_4", 8)
    group:group("pizza_meat_box_small_4", 8)
    group:group("pizza_cheese_box_small_4", 8)
    group:item("cheeseburger", 8)
    group:item("hamburger", 8)
    group:item("fish_fried", 8)
    group:item("fish_sandwich", 8)
    group:item("sloppyjoe", 8)
    group:group("hotdogs_frozen_bag_plastic_10", 8)
    group:group("corndogs_frozen_bag_plastic_2", 8)
    group:item("heatpack", 60)
    group:group("beans_in_can", 40)
    group:group("pork_beans_in_can", 40)
    group:group("chicken_in_can", 40)
    group:group("tomatoes_in_can", 40)
    group:item("cooked_pumpkin", 20)
    group:item("con_milk", 20)
    group:item("milk_evap", 20)
    group:group("corn_in_can", 35)
    group:group("spam_in_can", 30)
    group:group("pineapple_in_can", 30)
    group:item("can_peach", 30)
    group:group("coconut_milk_in_can", 10)
    group:group("sardine_in_can", 14)
    group:group("tuna_in_can", 35)
    group:group("clams_in_can", 25)
    group:group("chowder_in_can", 35)
    group:group("can_herring_jar_glass_sealed_2", 30)
    group:item("broth", 15)
    group:item("soup_veggy", 15)
    group:item("soup_meat", 15)
    group:item("soup_chicken", 15)
    group:item("soup_mushroom", 15)
    group:item("soup_tomato", 15)
    group:item("soup_dumplings", 15)
    group:item("curry_veggy", 15)
    group:item("curry_meat", 15)
    group:group("curry_powder_various", 15)
    group:group("chilly-p_various", 10)
    group:item("spaghetti_raw", 40)
    group:item("lasagne_raw", 40)
    group:item("macaroni_raw", 40)
    group:item("noodles_fast", 30)
    group:group("ravioli_in_can", 25)
    group:item("sauce_red", 20)
    group:item("gelatin_dessert_powder", 20)
    group:item("sauce_pesto", 15)
    group:group("bread_in_bag", 14)
    group:group("garlic_bread_in_bag", 7)
    group:group("cornbread_in_bag", 7)
    group:group("flatbread_in_bag", 7)
    group:entry { item = "crackers", count = { 1, -1 }, probability = 20 }
    group:entry { item = "grahmcrackers", count = { 2, -1 }, probability = 20 }
    group:group("oyster_crackers_plastic_bag_vac_8", 15)
    group:entry { item = "marshmallow", count = { 1, -1 }, probability = 20 }
    group:group("biscuit_box_small_10", 12)
    group:entry { item = "hardtack", count = { 2, 2 }, probability = 2 }
    group:group("cheese_bag_plastic", 40)
    group:group("cheese_hard_wrapper_8", 5)
    group:group("cheese_in_can", 8)
    group:item("cottage_cheese", 8)
    group:item("yoghurt", 8)
    group:item("pudding", 10)
    group:item("gelatin_dessert_processed", 10)
    group:group("veggy_pickled_jar_glass_sealed_2", 8)
    group:group("sauerkraut_jar_glass_sealed_2", 5)
    group:group("meat_pickled_jar_glass_sealed_2", 4)
    group:group("fish_pickled_jar_glass_sealed_2", 6)
    group:item("ghee", 5)
    group:item("lutefisk", 1)
    group:item("tongs", 25)
    group:item("lawn_dart", 10)
    group:item("flask_hip", 5)
    group:group("lye_powder_bottle_part", 5)
    group:item("smart_lamp", 2)
    group:item("dog_whistle", 5)
    group:entry { item = "dogfood", container = "can_medium", probability = 10 }
    group:entry { item = "catfood", container = "can_food", probability = 10 }
    group:entry { item = "dogfood_dry", count = { 2, -1 }, probability = 5 }
    group:entry { item = "catfood_dry", count = { 2, -1 }, probability = 5 }
    group:entry { group = "charcoal_bag_part", charges = { 25, 50 }, probability = 5 }
    group:entry { item = "soap", charges = { 1, 10 }, probability = 70 }
    group:group("detergent_small_box_part", 25)
    group:group("borax_box_part", 15)
    group:item("survnote", 1)
    group:item("cookbook_sushi", 5)
    group:item("scots_cookbook", 6)
    group:item("balloon", 5)
    group:item("eclipse_glasses", 1)
    group:item("thermos", 15)
    group:group("meat_canned_jar_3l_glass_sealed_12", 4)
    group:group("veggy_canned_jar_3l_glass_sealed_12", 4)
    group:group("fruits_in_3l_jar", 4)
    group:group("can_tomato_jar_3l_glass_sealed_24", 4)
    group:group("fish_pickled_jar_3l_glass_sealed_12", 4)
    group:group("meat_pickled_jar_3l_glass_sealed_12", 4)
    group:group("veggy_pickled_jar_3l_glass_sealed_12", 4)
    group:group("fish_pickled_jar_3l_glass_sealed_12", 4)
    group:entry { item = "sauce_red", charges = { 48, 48 }, container = "jar_3l_glass_sealed", probability = 4 }
    group:entry { item = "kompot", charges = { 12, 12 }, container = "jar_3l_glass_sealed", probability = 4 }
    group:group("big_canned_food", 4)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "nightstand", kind = "distribution" }
    group:item("alarmclock", 60)
    group:item("glasses_reading", 50)
    group:item("glasses_eye", 30)
    group:item("novel_drama", 50)
    group:item("novel_romance", 40)
    group:item("novel_mystery", 40)
    group:item("glasses_bifocal", 20)
    group:group("cotton_ball_bag_used", 20)
    group:group("cotton_ball_bag_full", 3)
    group:group("box_of_contact_lens_any", 20)
    group:item("transition_contacts", 2)
    group:item("national_flag", 1)
    group:group("vitamins_bottle_plastic_pill_supplement_1_20", 20)
    group:group("bottle_otc_painkiller_1_20", 20)
    group:group("chewing_gum_used_nic", 20)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 20 }
    group:group("cig_box_cigarette_1_20", 20)
    group:entry { item = "water", container = "glass", probability = 10 }
    group:group("glass_of_wine", 10)
    group:entry { item = "gummy_vitamins", count = { 1, 10 }, probability = 10 }
    group:entry { group = "civilian_phones", charges = { 0, -1 }, probability = 12 }
    group:item("eyedrops", 10)
    group:item("steroid_eyedrops", 5)
    group:item("holy_symbol", 5)
    group:item("pills_sleep", 5)
    group:group("melatonin_tablet_bottle_plastic_pill_supplement_1_30", 3)
    group:group("antihistamine_bottle_plastic_pill_supplement_1_30", 5)
    group:group("any_cough_syrup_in_bottle", 5)
    group:group("mansion_guns", 3)
    group:group("harddrugs_residential", 1)
    group:group("wallets", 10)
    group:item("ankle_wallet_pouch", 1)
    group:item("joint", 1)
    group:item("curler_hair", 10)
    group:item("hairbrush", 5)
    group:group("pillbox_any_used", 10)
    group:item("home_picture", 50)
    group:group("sex_accessories_domestic", 20)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "bedroom", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:item("awl_steel", 5)
    group:item("loom_frame", 1)
    group:item("shed_stick", 1)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 14 }
    group:entry { item = "eyedrops", count = { 10, 10 }, probability = 25 }
    group:entry { item = "steroid_eyedrops", count = { 3, 3 }, probability = 10 }
    group:item("television", 10)
    group:item("travelpack", 4)
    group:item("backpack_tactical_large", 1)
    group:item("backpack_hiking", 3)
    group:item("backpack_hunting", 1)
    group:item("clock", 10)
    group:item("basket_laundry", 30)
    group:group("tobacco_products", 146)
    group:group("cigar_box_opened", 20)
    group:entry { item = "weed", count = { 1, 5 }, probability = 15 }
    group:item("joint", 5)
    group:item("razor_blade", 5)
    group:entry { item = "weed", count = { 1, 5 }, probability = 20 }
    group:entry { item = "seed_weed", count = { 2, 2 }, probability = 15 }
    group:item("seed_tobacco", 5)
    group:item("seed_poppy_bud", 5)
    group:entry { item = "rolling_paper", charges = { 1, 30 }, probability = 5 }
    group:item("pipe_glass", 5)
    group:group("coke_bag_zipper_1_8", 8)
    group:group("meth_bag_zipper_1_6", 2)
    group:group("heroin_bag_zipper_1_4", 1)
    group:item("sneakers", 80)
    group:item("mask_hockey", 5)
    group:item("hockey_stick", 10)
    group:item("throat_guard_nylon", 3)
    group:item("throat_guard_canvas", 3)
    group:item("throat_guard_plastic", 1)
    group:item("throat_guard_cut_resistant", 1)
    group:group("wallets", 10)
    group:item("roller_blades", 20)
    group:item("roller_shoes_off", 10)
    group:item("jersey", 40)
    group:item("puck", 5)
    group:item("shuttlecock", 1)
    group:item("tacjacket", 10)
    group:item("baseball", 5)
    group:item("football", 5)
    group:item("hairpin", 20)
    group:item("fc_hairpin", 5)
    group:group("jewelry_accessories", 1)
    group:item("barrette", 10)
    group:item("tieclip", 3)
    group:item("collarpin", 3)
    group:item("socks", 70)
    group:item("socks_ankle", 50)
    group:item("briefcase", 5)
    group:item("mocassins", 5)
    group:item("boots_western", 4)
    group:item("motorbike_boots", 5)
    group:item("bandana", 35)
    group:item("glasses_eye", 90)
    group:group("box_of_contact_lens_any", 6)
    group:entry { item = "transition_contacts", count = { 6, 6 }, probability = 1 }
    group:item("sunglasses", 90)
    group:item("fitover_sunglasses", 60)
    group:item("glasses_reading", 90)
    group:item("glasses_bifocal", 90)
    group:item("towel", 40)
    group:item("thermometer", 2)
    group:item("hat_ball", 30)
    group:item("hat_newsboy", 20)
    group:item("hat_sombrero", 3)
    group:item("backpack", 38)
    group:item("backpack_denim", 8)
    group:item("backpack_giant", 1)
    group:item("backpack_leather", 18)
    group:item("purse", 40)
    group:item("armrig", 5)
    group:item("leg_small_bag", 5)
    group:item("leg_bag", 5)
    group:item("ankle_wallet_pouch", 2)
    group:item("mbag", 20)
    group:item("slingpack", 15)
    group:item("fanny", 10)
    group:item("acoustic_guitar", 20)
    group:item("drum_percussion", 10)
    group:item("saxophone", 15)
    group:item("clarinet", 10)
    group:item("flute", 10)
    group:item("harmonica_holder", 10)
    group:item("banjo", 5)
    group:item("kantele", 1)
    group:item("ukulele", 15)
    group:item("guitar_electric", 20)
    group:group("bugout_bag", 5)
    group:group("box_of_batteries_random", 50)
    group:entry { item = "bb", charges = { 1, 500 }, probability = 8 }
    group:entry { item = "bbgun", charges = { 0, 150 }, probability = 10 }
    group:item("fan", 10)
    group:group("magazines", 225)
    group:item("photo_album", 5)
    group:group("novels", 95)
    group:item("ZSG", 5)
    group:item("manual_mechanics", 35)
    group:item("manual_driving", 5)
    group:item("manual_fabrication", 12)
    group:item("manual_speech", 50)
    group:item("manual_business", 40)
    group:item("manual_computer", 20)
    group:item("hackerman_computer", 20)
    group:item("scots_tailor", 10)
    group:group("kids_books", 70)
    group:item("tailor_portfolio", 1)
    group:item("recipe_augs", 1)
    group:group("civilian_laptops", 10)
    group:group("civilian_phones", 40)
    group:group("civilian_eink_tablet_pcs", 2)
    group:group("civilian_memory_cards", 4)
    group:group("civilian_usb_drives", 15)
    group:entry { item = "smart_lamp", charges = { 0, 100 }, probability = 2 }
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 60 }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 2 }
    group:entry { item = "matches", charges = { 1, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 60 }
    group:entry { item = "sewing_kit", charges = { 0, -1 }, probability = 47 }
    group:entry { item = "tailors_kit", charges = { 0, -1 }, probability = 3 }
    group:item("electric_spinwheel", 3)
    group:item("thread", 40)
    group:item("scissors", 50)
    group:item("soldering_iron", 70)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 70 }
    group:group("solder_wire_spool_part", 70)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:item("syringe", 8)
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 6 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "game_watch", charges = { 0, 50 }, probability = 2 }
    group:group("decks_of_cards", 2)
    group:item("firecracker_pack", 5)
    group:item("firecracker", 5)
    group:group("fried_seeds_bag_plastic_4", 30)
    group:group("bag_chips", 65)
    group:group("soda_in_small_container", 380)
    group:item("picklocks", 10)
    group:item("fursuit", 6)
    group:item("zentai", 4)
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 60 }
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 40 }
    group:item("blanket", 10)
    group:item("blanket_weighted", 3)
    group:item("electric_blanket", 4)
    group:item("house_coat", 25)
    group:entry { item = "talking_doll", charges = { 0, 100 }, probability = 65 }
    group:item("marble", 65)
    group:entry { item = "creepy_doll", charges = { 0, 100 }, probability = 1 }
    group:group("esoteric_books", 1)
    group:item("straw_doll", 1)
    group:item("money_strap_five", 30)
    group:item("wristwatch", 15)
    group:item("balloon", 5)
    group:item("diving_watch", 5)
    group:item("gold_watch", 5)
    group:item("silver_watch", 7)
    group:item("sf_watch", 2)
    group:item("pocketwatch", 5)
    group:entry { item = "lsd", count = { 1, 5 }, probability = 1 }
    group:group("chewing_gum_used", 30)
    group:group("chewing_gum_used_caff", 4)
    group:group("chewing_gum_used_nic", 2)
    group:group("box_small_nicotine_patch_1_10", 1)
    group:item("clown_suit", 1)
    group:item("clownshoes", 1)
    group:item("bondage_suit", 5)
    group:item("bondage_mask", 5)
    group:item("bodysuit_lycra", 5, "bondage_suit")
    group:item("bodysuit_lycra", 1)
    group:item("flask_hip", 5)
    group:group("sex_accessories_domestic", 5)
    group:item("tux", 1)
    group:item("gown", 1)
    group:item("cheongsam", 1)
    group:item("long_glove_white", 1)
    group:item("veil_wedding", 1)
    group:item("dress_wedding", 1)
    group:item("corset", 15)
    group:item("corset_waist", 15)
    group:item("firehelmet", 1)
    group:item("bunker_coat", 1)
    group:item("bunker_pants", 1)
    group:item("boots_bunker", 1)
    group:item("fireman_belt", 1)
    group:item("mask_bunker", 1)
    group:item("nomex_suit", 1)
    group:item("nomex_hood", 1)
    group:item("nomex_gloves", 1)
    group:item("nomex_socks", 1)
    group:entry { item = "oxygen_tank", charges = { 0, 24 }, probability = 3 }
    group:entry { item = "smoxygen_tank", charges = { 0, 12 }, probability = 2 }
    group:item("alarmclock", 30)
    group:item("maid_dress", 3)
    group:item("maid_dress_short", 3)
    group:item("maid_hat", 3)
    group:group("religious_books", 38)
    group:item("mouthpiece", 1)
    group:item("leathersandals", 25)
    group:item("espadrilles", 15)
    group:item("survnote", 2)
    group:item("mask_skull", 5, "guy_fawkes")
    group:item("magnifying_glass", 2)
    group:item("holy_symbol", 5)
    group:item("pet_carrier", 3)
    group:item("rubber_harness_dog", 3)
    group:item("eclipse_glasses", 1)
    group:item("bodypillow", 2)
    group:item("teddy_bear", 2)
    group:entry { item = "reading_light", charges = { 0, 50 }, probability = 8 }
    group:entry { item = "condom", count = { 1, 5 }, probability = 50 }
    group:item("air_launcher", 1)
    group:item("home_picture", 50)
    content.upsert_item_group(group)
end
