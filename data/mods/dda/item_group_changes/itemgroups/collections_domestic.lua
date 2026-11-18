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
