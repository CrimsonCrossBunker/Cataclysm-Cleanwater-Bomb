local content = require("ccb").content

do
    local group = content.ItemGroup { id = "behindcounter", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:group("bottle_otc_painkiller_1_20", 85)
    group:group("caffeine_bottle_plastic_pill_supplement_1_10", 25)
    group:group("melatonin_tablet_bottle_plastic_pill_supplement_1_30", 5)
    group:group("tobacco_products", 161)
    group:entry { group = "cigar_box_unopened", count = { 1, 4 }, probability = 10 }
    group:item("cigar_cutter", 10)
    group:item("cigar_punch", 8)
    group:item("sponge", 10)
    group:group("box_of_batteries_random", 50)
    group:group("sex_accessories_domestic", 3)
    group:entry { item = "condom", count = { 1, 3 }, probability = 5 }
    group:item("mag_porn", 20)
    group:entry { item = "lighter", charges = { 95, 100 }, probability = 60 }
    group:entry { item = "ref_lighter", charges = { 40, 50 }, probability = 5 }
    group:entry { item = "matches", charges = { 19, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 31, 32 }, probability = 50 }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry { item = "tazer", charges = { 0, 500 }, probability = 3 }
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 9 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "game_watch", charges = { 0, 50 }, probability = 2 }
    group:group("decks_of_cards", 2)
    group:group("roadmap_stock", 40)
    group:item("trailmap", 20)
    group:item("file", 10)
    group:item("touristmap", 20)
    group:item("restaurantmap", 20)
    group:item("money_strap_one", 55)
    group:item("money_strap_five", 55)
    group:item("money_strap_ten", 25)
    group:item("gold_watch", 5)
    group:item("silver_watch", 10)
    group:entry { group = "chewing_gum_full", count = { 1, 10 }, probability = 30 }
    group:entry { group = "chewing_gum_full_caff", count = { 1, 10 }, probability = 10 }
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:entry { group = "chewing_gum_full_nic", count = { 1, 10 }, probability = 2 }
    group:item("razor_blade", 3)
    group:item("knitting_needles", 1)
    group:group("newspaper_recent", 15)
    group:item("survnote", 2)
    group:item("eclipse_glasses", 1)
    group:item("thermos", 10)
    group:group("writing_utensils", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glass_shop", kind = "distribution" }
    group:item("glass", 15)
    group:item("jar_glass_sealed", 10)
    group:item("glass_bowl", 10)
    group:item("test_tube", 10)
    group:item("bottle_glass", 10)
    group:item("flask_glass", 10)
    group:item("pipe_glass", 10)
    group:item("fish_bowl", 1)
    group:item("glass_plate", 20)
    group:item("glass_sheet", 5)
    group:item("jar_3l_glass_sealed", 15)
    group:item("magnifying_glass", 5)
    group:item("tempered_glass_sheet", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dollar_books", kind = "distribution" }
    group:group("book_mag_tech", 30)
    group:group("book_mag_gen", 45)
    group:group("book_mag_interests", 30)
    group:group("kids_books", 65)
    group:item("family_cookbook", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dollar_tools", kind = "distribution" }
    group:item("rope_6", 20)
    group:item("string_36", 25)
    group:item("toilet_paper", 10)
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 15 }
    group:group("duct_tape_roll_part", 25)
    group:group("glue_weak_domestic", 25)
    group:group("glue_strong_domestic", 20)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 25 }
    group:item("thread", 20)
    group:group("box_of_batteries_unopened", 25)
    group:entry { item = "candle", charges = { 0, 100 }, probability = 25 }
    group:group("small_candles_in_box", 10)
    group:item("hammer", 20)
    group:item("screwdriver", 20)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 25 }
    group:item("electric_lighter", 5)
    group:item("pockknife", 15)
    group:item("metal_file", 15)
    group:item("pin_reamer", 10)
    group:item("sandbox_kit", 5)
    group:entry {
        distribution = {
            { group = "full_survival_kit" },
            { group = "used_survival_kit" },
        },
        probability = 5,
    }
    group:group("writing_utensils", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dollar_kitchen", kind = "distribution" }
    group:item("cup_plastic", 20)
    group:item("rolling_pin", 20)
    group:item("bowl_plastic", 20)
    group:item("canteen", 10)
    group:item("flask_hip", 15)
    group:item("fork", 25)
    group:item("sponge", 30)
    group:item("spoon", 25)
    group:item("knife_butter", 25)
    group:item("pan", 15)
    group:item("pot", 15)
    group:item("teapot", 15)
    group:group("tinware", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pawn_guns", kind = "distribution" }
    group:group("guns_common_display")
    group:group("guns_display_pieces", 1)
    group:group("guns_collectible", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pawn_valuable", kind = "distribution" }
    group:item("sword_cane", 5)
    group:item("advanced_ecig", 5)
    group:item("television", 10)
    group:entry { item = "gold_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 10 }
    group:entry { item = "silver_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 20 }
    group:entry { item = "platinum_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 10 }
    group:item("gold_watch", 15)
    group:item("silver_watch", 20)
    group:item("sf_watch", 7)
    group:item("platinum_watch", 1)
    group:group("civilian_phones", 31)
    group:entry { item = "goggles_nv", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "goggles_ir", charges = { 0, 100 }, probability = 1 }
    group:group("civilian_eink_tablet_pcs", 12)
    group:entry { item = "camera_pro", charges = { 0, 150 }, probability = 5 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 8 }
    group:item("knife_rm42", 1)
    group:item("gold_ring", 12)
    group:item("silver_ring", 6)
    group:item("platinum_ring", 1)
    group:item("diamond_ring", 1)
    group:item("ring_engagement", 2)
    group:item("ring_wedding", 1)
    group:item("ring_purity", 2)
    group:item("ring_signet", 1)
    group:item("diamond", 1)
    group:item("cufflinks", 2)
    group:item("cufflinks_intricate", 1)
    group:item("pearl_collar", 1)
    group:item("silver_necklace", 14)
    group:item("gold_ear", 12)
    group:item("silver_ear", 14)
    group:item("bead_ear", 14)
    group:item("platinum_ear", 1)
    group:item("platinum_bracelet", 1)
    group:item("gold_bracelet", 8)
    group:item("silver_bracelet", 10)
    group:item("jade_brooch", 1)
    group:item("silver_locket", 1)
    group:item("gold_locket", 1)
    group:item("platinum_locket", 1)
    group:item("gold_anklet", 1)
    group:item("silver_anklet", 2)
    group:item("gold_lip_ring_loop", 1)
    group:item("gold_lip_ring_stud", 1)
    group:item("silver_lip_ring_loop", 2)
    group:item("silver_lip_ring_stud", 2)
    group:item("gold_nose_ring_loop", 1)
    group:item("gold_nose_ring_stud", 1)
    group:item("silver_nose_ring_loop", 2)
    group:item("silver_nose_ring_stud", 2)
    group:item("gold_toe_ring", 1)
    group:item("silver_toe_ring", 2)
    group:group("mags_common", 300)
    content.add(group)
end

do
    -- for pawn_shop safe
    local group = content.ItemGroup { id = "my_precious", kind = "distribution" }
    group:entry { group = "supplies_metal_precious", wrapper = "box_small_wood", probability = 70 }
    group:entry { item = "money_strap_five", count = { 1, 5 }, probability = 90 }
    group:entry { item = "money_strap_ten", count = { 1, 3 }, probability = 70 }
    group:entry { item = "money_strap_twenty", count = { 1, 3 }, probability = 30 }
    group:item("money_strap_fifty", 10)
    group:item("gold_watch", 30)
    group:item("gold_ear", 30)
    group:item("gold_bracelet", 30)
    group:item("diamond_ring", 20)
    group:item("diamond", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_fridge", kind = "distribution" }
    group:item("water_clean", 30)
    group:item("water_mineral", 15)
    group:group("soda_in_small_container", 121)
    group:group("milk_in_container", 20)
    group:item("juice", 31)
    group:item("pie", 40)
    group:item("pie_meat", 28)
    group:item("pie_veggy", 15)
    group:item("pie_maple", 7)
    group:item("yoghurt", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "liqstore_brew", kind = "distribution" }
    group:item("yeast", 5)
    group:item("hops", 40)
    content.add(group)
end

do
    -- For paintball_field.json
    local group = content.ItemGroup { id = "paintball_items", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "paintball", probability = 125 },
            { item = "paintballgun", charges = { 0, 50 } },
            { group = "paintball_clothes", probability = 30 },
        },
    }
    content.add(group)
end

do
    -- For paintball_field.json
    local group = content.ItemGroup { id = "paintball_clothes", kind = "distribution" }
    group:entry {
        distribution = {
            {
                item = "airsoft_helmet",
                contents = {
                    { group = "airsoft_helmet_attachments" },
                },
                probability = 35,
            },
            { item = "gloves_airsoft", probability = 20 },
            { item = "glasses_bal", probability = 20 },
            { item = "mask_bal", probability = 2 },
            { item = "stab_vest", variant = "airsoft_stab_vest", probability = 10 },
            { item = "face_shield_plastic", probability = 4 },
            { item = "plastic_mandible_guard", probability = 4 },
            { item = "gloves_tactical", probability = 4 },
            { item = "counterweight_pouch", probability = 1 },
            { item = "legguard_hard", probability = 2 },
            { item = "elbow_pads", probability = 2 },
            { item = "armguard_hard", probability = 2 },
            { item = "knee_pads", probability = 1 },
            { item = "load_bearing_vest", probability = 1 },
            { item = "light_load_bearing_vest", probability = 1 },
            { group = "jackets", probability = 5 },
            { group = "mil_armor_pants", probability = 5 },
            { group = "clothing_outdoor_shoes", probability = 5 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airsoft_helmet_attachments", kind = "collection" }
    group:entry {
        distribution = {
            {
                distribution = {
                    { item = "face_shield_plastic", probability = 90 },
                    { item = "face_shield", probability = 10 },
                },
            },
            {
                distribution = {
                    { item = "plastic_mandible_guard", probability = 90 },
                    { item = "ballistic_mandible_guard", probability = 10 },
                },
            },
        },
    }
    content.add(group)
end

do
    -- for music store
    local group = content.ItemGroup { id = "musicstore_showpiece", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "acoustic_guitar" },
            { item = "bagpipes", probability = 25 },
            { item = "banjo", probability = 60 },
            { item = "clarinet", probability = 50 },
            { item = "flute", probability = 50 },
            { item = "harmonica_holder", probability = 70 },
            { item = "tonewood", probability = 30 },
            { item = "saxophone", probability = 50 },
            { item = "trumpet", probability = 50 },
            { item = "tuba", probability = 25 },
            { item = "drum_percussion", probability = 10 },
            { item = "kantele", probability = 10 },
            { item = "ukulele", probability = 50 },
            { item = "violin", probability = 90 },
            { item = "guitar_electric", probability = 90 },
            {
                collection = {
                    { item = "case_violin" },
                    { item = "violin" },
                },
                probability = 50,
            },
        },
    }
    content.add(group)
end

do
    -- for music store
    local group = content.ItemGroup { id = "mussto_windinst", kind = "distribution" }
    group:item("tuba", 10)
    group:item("trumpet", 25)
    group:item("flute", 25)
    group:item("clarinet", 25)
    group:item("saxophone", 25)
    group:item("harmonica_holder", 25)
    group:item("tonewood", 10)
    group:item("bagpipes", 5)
    content.add(group)
end

do
    -- for music store
    local group = content.ItemGroup { id = "mussto_stringinst", kind = "distribution" }
    group:item("acoustic_guitar")
    group:item("violin", 80)
    group:item("ukulele", 90)
    group:item("kantele", 10)
    group:item("banjo")
    group:item("tonewood", 10)
    group:item("guitar_electric")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bowling_alcohol", kind = "distribution" }
    group:group("beer_in_container", 373)
    group:group("liquor_and_spirits", 80)
    group:item("drink_rumcola", 40)
    group:item("drink_screwdriver", 35)
    group:item("drink_wild_apple", 10)
    group:item("long_island", 17)
    group:item("wine_chardonnay", 20)
    group:item("wine_cabernet", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bowling_food", kind = "distribution" }
    group:item("water_clean", 50)
    group:item("water_mineral", 20)
    group:item("oj", 40)
    group:item("pineapple_juice", 35)
    group:item("juice", 35)
    group:item("cranberry_juice", 35)
    group:group("soda_in_small_container", 95)
    group:item("V8", 15)
    group:group("chewing_gum_full", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bowling_fridge", kind = "distribution" }
    group:item("water_clean", 50)
    group:item("water_mineral", 20)
    group:item("oj", 40)
    group:item("pineapple_juice", 35)
    group:item("juice", 35)
    group:item("cranberry_juice", 35)
    group:group("soda_in_small_container", 95)
    group:item("V8", 15)
    group:item("fries", 7)
    group:item("cheese_fries", 5)
    group:item("onion_rings", 7)
    group:item("mayonnaise", 3)
    group:group("ketchup_sealed_rng", 3)
    group:group("mustard_sealed_rng", 3)
    group:group("pickle_jar_glass_sealed_2", 5)
    group:item("cheeseburger", 10)
    group:item("hamburger", 8)
    group:item("sloppyjoe", 6)
    group:group("hotdogs_frozen_bag_plastic_10", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bowling_table", kind = "distribution" }
    group:group("cig_box_cigarette_1_20", 50)
    group:entry { item = "matches", charges = { 1, 20 }, probability = 45 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 45 }
    group:entry { item = "rolling_paper", charges = { 1, 30 }, probability = 10 }
    group:item("bottle_glass", 50)
    group:item("bottle_plastic", 70)
    group:item("can_drink", 65)
    group:item("wrapper", 50)
    group:item("wrapper_foil", 5)
    group:item("ceramic_plate", 40)
    group:item("news_regional", 20)
    group:item("mag_news", 20)
    group:item("scorecard", 30)
    group:group("writing_utensils", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bowling_bathroom", kind = "distribution" }
    group:entry { item = "weed", count = { 1, 5 }, probability = 30 }
    group:group("coke_bag_zipper_1_8", 30)
    group:group("bottle_otc_painkiller_1_20", 40)
    group:group("cig_box_cigarette_1_20", 20)
    group:item("syringe", 20)
    group:group("meth_bag_zipper_1_6", 10)
    group:group("heroin_bag_zipper_1_4", 5)
    group:item("mag_porn", 35)
    group:item("hairpin", 5)
    group:item("purse", 15)
    group:item("armrig", 1)
    group:group("SUS_toilet", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bowling_item", kind = "distribution" }
    group:item("socks_bowling")
    group:item("shoes_bowling")
    group:item("bowling_pin")
    group:item("bowling_ball")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bowling_balls", kind = "distribution" }
    group:item("bowling_ball")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bikeshop_for_sale", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "wheel_bicycle" },
            { item = "wheel_bicycle", probability = 90 },
            { item = "horn_bicycle", probability = 80 },
            { item = "foot_crank", probability = 80 },
            { item = "saddle", probability = 80 },
            { item = "chain", probability = 40 },
            { item = "bike_rack", probability = 20 },
            { item = "small_storage_battery", probability = 10 },
            { item = "alternator_bicycle", probability = 10 },
            { item = "folded_bicycle", probability = 10 },
            { item = "roller_blades", probability = 10 },
        },
    }
    group:entry {
        distribution = {
            { item = "helmet_bike", probability = 25 },
            { group = "helmet_bike_modified", probability = 10 },
            { item = "plastic_chin_guard", probability = 5 },
            { item = "shield_visor", probability = 10 },
            { item = "knee_pads", probability = 35 },
            { item = "elbow_pads", probability = 35 },
            { item = "gloves_leather", probability = 35 },
            { item = "gloves_light", probability = 35 },
            { item = "gloves_fingerless", probability = 35 },
            { item = "touring_suit", probability = 25 },
            { item = "bandana", probability = 25 },
            { item = "scarf", probability = 15 },
            { item = "sunglasses", probability = 25 },
            { item = "fitover_sunglasses", probability = 20 },
            { item = "canteen", probability = 20 },
            { item = "camelbak", probability = 20 },
        },
    }
    group:entry {
        distribution = {
            { item = "protein_powder", probability = 7 },
            { item = "dry_veggy", probability = 10 },
            { item = "dry_fruit", probability = 10 },
            { item = "granola", probability = 5 },
        },
    }
    group:entry {
        distribution = {
            { item = "wrench", probability = 20 },
            { item = "multitool", probability = 30 },
            { item = "screwdriver_set", probability = 20 },
            { item = "socket_screwdriver_set", probability = 20 },
            { group = "duct_tape_roll", probability = 50 },
            { group = "glue_weak_professional_full", probability = 5 },
            { group = "glue_strong_professional_full", probability = 5 },
            { item = "misc_repairkit", probability = 25 },
            { group = "tools_toolbox", probability = 2 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_house_items", kind = "distribution" }
    group:item("syrup", 60)
    group:item("sandwich_pbm", 20)
    group:item("maple_candy", 90)
    group:item("pancakes", 50)
    group:item("fruit_pancakes", 30)
    group:item("choc_pancakes", 20)
    group:item("fruit_waffles", 20)
    group:item("choc_waffles", 20)
    group:item("pie_maple", 70)
    group:item("pork_beans", 15)
    group:item("glazed_tenderloin", 5)
    group:group("civilian_phones", 4)
    group:item("glass", 40)
    group:item("spoon", 25)
    group:item("fork", 25)
    group:item("knife_butter", 20)
    group:item("knife_small", 15, "knife_steak")
    group:item("spork", 5)
    group:item("foon", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_house_tools", kind = "distribution" }
    group:item("hammer")
    group:item("hand_drill")
    group:item("screwdriver", 20)
    group:item("screwdriver_set", 10)
    group:entry { item = "cordless_drill", charges = { 0, 500 }, probability = 70 }
    group:item("thermometer", 60)
    group:item("saw", 90)
    group:item("bow_saw", 30)
    group:entry { item = "chainsaw_off", charges = { 0, 450 }, probability = 10 }
    group:item("bucket")
    group:item("bucket_5gal")
    group:item("tree_spile")
    group:item("pot")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_house_furnace", kind = "collection" }
    group:entry { item = "maple_sap", charges = { 2, 15 }, container = "metal_tank" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_house_drum", kind = "collection" }
    group:entry { item = "syrup", charges = { 2, 150 }, container = "55gal_drum" }
    content.add(group)
end

do
    -- For cs_car_showroom
    local group = content.ItemGroup { id = "oa_ig_cs_lockers", kind = "distribution" }
    group:group("box_of_batteries_random", 10)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 10 }
    group:item("cotton_patchwork", 30)
    group:item("dress_shoes", 20)
    group:item("longshirt", 30)
    group:item("polo_shirt", 30)
    group:item("dress_shirt", 30)
    group:item("denim_shirt", 15)
    group:item("tie_skinny", 10)
    group:item("tie_necktie", 10)
    group:item("tie_clipon", 10)
    group:item("tieclip", 10)
    group:item("collarpin", 10)
    group:item("blazer", 35)
    group:item("undershirt", 30)
    group:item("suit", 30)
    group:item("waistcoat", 30)
    group:item("gold_watch", 5)
    group:item("wristwatch", 10)
    content.add(group)
end

do
    -- for cs_car_dealership
    local group = content.ItemGroup { id = "oa_ig_cd_fuel", kind = "distribution" }
    group:entry { item = "gasoline", charges = { 450, 2000 }, sealed = false, container = "jug_plastic", probability = 20 }
    group:entry { item = "gasoline", charges = { 450, 4000 }, container = "jerrycan", probability = 30 }
    group:entry { item = "gasoline", charges = { 2650, 10000 }, container = "jerrycan_big", probability = 10 }
    content.add(group)
end

do
    -- for cs_tire_shop
    local group = content.ItemGroup { id = "oa_ig_ts_tables", kind = "distribution" }
    group:entry { item = "radio", charges = { 0, 100 }, probability = 30 }
    group:item("cotton_patchwork", 30)
    group:entry { item = "cell_phone", charges = { 0, 150 }, probability = 10 }
    group:item("mag_mechanics", 20)
    group:item("manual_driving", 10)
    group:item("manual_mechanics", 10)
    group:item("jack", 60)
    group:item("jack_small", 60)
    group:item("jack_makeshift", 30)
    group:item("wrench", 50)
    group:item("wrench_large", 20)
    group:item("socket_wrench_set", 40)
    group:item("gloves_work", 30)
    group:item("glasses_safety", 20)
    group:item("tire_repair_kit", 60)
    content.add(group)
end

do
    -- for cs_tire_shop
    local group = content.ItemGroup { id = "oa_ig_ts_tires", kind = "distribution" }
    group:item("wheel_small", 30)
    group:item("wheel", 30)
    group:item("wheel_wide", 20)
    group:item("tire_medium", 30)
    group:item("tire_wide", 20)
    group:item("deflated_wheel", 20)
    group:item("deflated_wheel", 30)
    group:item("deflated_wheel_wide", 20)
    group:item("hand_pump", 10)
    group:item("wheel_rim_medium", 5)
    group:item("wheel_rim_wide", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_commercial_shelf_porn_literature", kind = "distribution" }
    group:entry { item = "mag_porn", count = { 0, 40 }, probability = 70 }
    group:entry { item = "novel_erotic", count = { 0, 20 }, probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sex_clothes", kind = "distribution" }
    group:item("panties", 90)
    group:item("bra", 30)
    group:group("bikini", 40)
    group:entry {
        collection = {
            { item = "bikini_top", variant = "maid_bikini_top" },
            { item = "bikini_bottom", variant = "maid_bikini_bottom" },
        },
        probability = 15,
    }
    group:item("flag_swimsuit", 10)
    group:item("corset", 20)
    group:item("corset_waist", 10)
    group:item("apron_leather", 10)
    group:item("apron_cotton", 20, "maid_apron")
    group:item("apron_cotton", 15, "gothic_apron")
    group:item("waist_apron_short", 20, "maid_apron")
    group:item("waist_apron_short", 15, "gothic_apron")
    group:item("skirt_leather", 15)
    group:item("nanoskirt", 15)
    group:item("skirt", 10)
    group:item("cheerleader_skirt_short", 15)
    group:item("cheerleader_top_short", 15)
    group:item("chaps_leather", 15)
    group:item("hot_pants", 20)
    group:item("hot_pants_leather", 20)
    group:item("hot_pants_fur", 20)
    group:item("leather_cat_tail", 20)
    group:item("leather_cat_ears", 20)
    group:item("leather_collar", 20)
    group:item("bondage_mask", 30)
    group:item("gloves_claws", 15)
    group:item("priest_collar", 10)
    group:item("gloves_fingerless", 10)
    group:item("maid_hat", 10)
    group:item("santa_hat", 5)
    group:item("pointed_hat", 1)
    group:item("cowboy_hat", 1)
    group:item("santa_shorts", 1)
    group:item("leggings", 5)
    group:item("tights", 5)
    group:item("garter_belt", 5)
    group:item("cuffs", 30)
    group:item("collar_playboy", 30)
    group:item("bunny_ears_black", 30)
    group:item("bondage_suit", 10)
    group:item("bodysuit_lycra", 10, "bondage_suit")
    group:item("bodysuit_lycra", 5)
    group:item("leotard", 5)
    group:item("unitard", 5)
    group:item("zentai", 3)
    group:item("maid_dress_short", 20)
    group:item("santa_dress_short", 10)
    group:item("santa_jacket_short", 5)
    group:item("jacket_leather", 5)
    group:item("cheerleader_dress", 15)
    group:item("ninja_dress", 3)
    group:item("ninja_dress_sleeveless", 5)
    group:item("short_dress", 2, "sinister")
    group:item("dress_sleeved", 5, "witch_black")
    group:item("short_dress_sleeved", 5, "witch_black")
    group:item("bunny_suit_playboy", 30)
    group:group("pet_collars", 10)
    content.add(group)
end

do
    -- for the employee backroom in cs_sex_shop
    local group = content.ItemGroup { id = "backroom", kind = "distribution" }
    group:entry { item = "weed", count = { 1, 5 }, probability = 10 }
    group:group("coke_bag_zipper_1_8", 10)
    group:entry { group = "cigar_box_opened", count = { 1, 2 }, probability = 10 }
    group:group("meth_bag_zipper_1_6", 10)
    group:group("bottle_otc_painkiller_1_20", 10)
    group:item("mag_porn", 10)
    group:item("purse", 10)
    group:item("hairpin", 5)
    group:item("syringe", 10)
    group:item("blanket", 20)
    group:entry { item = "candle", charges = { 0, 100 }, probability = 20 }
    group:item("bodypillow", 10)
    group:item("pillow", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "thrift_books", kind = "distribution" }
    group:group("magazines", 120)
    group:item("manual_traps", 12)
    group:item("trappers_companion", 2)
    group:item("manual_survival", 20)
    group:item("textbook_firstaid", 8)
    group:item("pocket_survival", 2)
    group:item("manual_archery", 8)
    group:item("book_archery", 2)
    group:item("recipe_arrows", 4)
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_cameras", kind = "distribution" }
    group:entry { item = "camera", charges = { 150, 150 }, probability = 75 }
    group:entry { item = "camera_pro", charges = { 150, 150 }, probability = 25 }
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_entapl", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("television", 50)
    group:item("radio", 20)
    group:item("stereo", 40)
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_diy", kind = "distribution" }
    group:group("cable_roll_part", 95)
    group:group("copper_wire_roll_part", 60)
    group:group("box_of_batteries_unopened", 85)
    group:item("scrap", 70)
    group:item("e_scrap", 95)
    group:item("antenna", 50)
    group:item("breadboard", 85)
    group:item("voltmeter", 80)
    group:entry { item = "multimeter", charges = { 0, 100 }, probability = 80 }
    group:item("circuit", 35)
    group:item("small_lcd_screen", 10)
    group:item("large_lcd_screen", 10)
    group:item("RAM", 35)
    group:item("processor", 10)
    group:item("amplifier", 7)
    group:item("transponder", 5)
    group:item("receiver", 5)
    group:item("soldering_iron", 65)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 65 }
    group:group("solder_wire_spool_part", 50)
    group:group("glue_weak_professional", 25)
    group:group("glue_strong_professional", 30)
    group:item("screwdriver", 60)
    group:item("dremel", 90)
    group:item("motor_small", 30)
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_books", kind = "distribution" }
    group:item("mag_electronics", 60)
    group:item("manual_electronics", 50)
    group:item("advanced_electronics", 35)
    group:item("ic_reference_electronics", 20)
    group:item("textbook_electronics", 30)
    group:item("radio_book", 40)
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_stor", kind = "distribution" }
    group:group("new_usb_drives", 65)
    group:group("new_memory_cards", 95)
    group:entry {
        group = "new_usb_drives",
        contents = {
            { group = "efiles_software" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "laundromat_bleach", kind = "distribution" }
    group:group("bleach_jug_part", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "laundromat_containers", kind = "distribution" }
    group:item("duffelbag", 5)
    group:item("backpack", 5)
    group:item("bag_plastic", 30)
    group:item("basket_laundry", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "plastic_dishes", kind = "distribution" }
    group:entry {
        collection = {
            { item = "plastic_plate" },
            { item = "plastic_fork" },
            { item = "plastic_knife" },
            { item = "tumbler_plastic" },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "bowl_plastic" },
            { item = "plastic_fork" },
            { item = "plastic_spoon" },
            { item = "tumbler_plastic" },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- for sports_store
    local group = content.ItemGroup { id = "clothing_sport", kind = "distribution" }
    group:group("clothing_outdoor_torso")
    group:group("clothing_outdoor_pants")
    group:group("clothing_outdoor_shoes")
    group:group("clothing_glasses", 10)
    group:group("clothing_watch", 5)
    content.add(group)
end

do
    -- for cs_internet_cafe
    local group = content.ItemGroup { id = "ic_merch_vending", kind = "distribution" }
    group:group("salty_snacks", 300)
    group:item("water_clean")
    group:item("water_mineral")
    group:item("coffee")
    group:item("atomic_coffee")
    content.add(group)
end

do
    -- for cs_internet_cafe
    local group = content.ItemGroup { id = "ic_merch", kind = "distribution" }
    group:entry { item = "cell_phone", charges = { 0, 150 }, probability = 10 }
    group:item("mag_computer", 20)
    group:group("box_of_batteries_unopened", 20)
    group:item("radio", 20)
    group:item("television", 20)
    group:item("two_way_radio", 20)
    group:item("noise_emitter", 20)
    group:item("eyedrops", 20)
    group:item("mag_electronics", 20)
    group:item("ecig", 20)
    group:group("new_usb_drives", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "daycare_kitchen", kind = "distribution" }
    group:item("oj", 35)
    group:item("cooked_pumpkin", 25)
    group:group("bread_in_bag", 10)
    group:item("fruit_waffles", 5)
    group:item("grahmcrackers", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hotel_coffee_bar", kind = "collection" }
    group:item("coffeemaker", 60)
    group:entry { group = "coffee_display", count = { 1, 3 }, probability = 60 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hotel_luggage", kind = "collection", container = "suitcase_l", overflow = "discard" }
    group:entry {
        distribution = {
            { group = "SUS_dresser_mens_small_bags", probability = 50 },
            { group = "SUS_dresser_womens_small_bags", probability = 50 },
        },
    }
    group:group("pillbox_any_used", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "book_hotel_tower_bible", kind = "collection" }
    group:item("holybook_bible3")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "farm_supply_soil_and_sand", kind = "collection" }
    group:group("sandbag", 50)
    group:group("earthbag", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "farm_supply_rocks", kind = "collection" }
    group:entry { item = "rock", count = { 1, 10 }, probability = 40 }
    group:entry { item = "rock_large", count = { 1, 10 }, probability = 10 }
    group:entry { item = "rock_flaking", count = { 1, 10 }, probability = 20 }
    group:entry { item = "flint", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_shrd_limestone", count = { 1, 10 }, probability = 40 }
    group:entry { item = "material_limestone", count = { 1, 10 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "farm_supply_wire", kind = "collection" }
    group:entry { item = "lc_wire", count = { 20, 50 }, probability = 50 }
    group:entry { item = "mc_wire", count = { 0, 20 }, probability = 5 }
    group:entry { item = "hc_wire", count = { 0, 20 }, probability = 5 }
    group:entry { item = "qt_wire", count = { 0, 20 }, probability = 5 }
    group:entry { item = "wire_barbed", count = { 20, 50 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "farm_supply_quicklime_and_saltpetre", kind = "distribution" }
    group:group("quicklime_bag", 85)
    group:group("quicklime_barrel", 20)
    group:group("saltpeter_canvas_bag_part", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "farm_supply_animal_feed", kind = "distribution" }
    group:group("cattlefodder_bag_canvas_50", 50)
    group:group("birdfood_bag_canvas_60", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "farm_supply_riding_gear", kind = "collection" }
    group:item("horse_tack")
    group:item("saddlebag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "farm_supply_floor_surprises", kind = "distribution" }
    group:group("camping", 50)
    group:group("ammo_common_loose", 2)
    group:group("tools_survival", 5)
    group:group("clothing_outdoor_shoes", 7)
    group:group("clothing_outdoor_torso", 7)
    group:group("clothing_outdoor_pants", 7)
    group:group("farming_tools", 5)
    group:group("farming_seeds", 20)
    group:item("rock", 5)
    group:group("wallets", 2)
    group:group("banknotes", 4)
    group:group("coins", 4)
    group:group("discount_cards", 1)
    group:entry { item = "spray_can", charges = { 0, 10 }, probability = 10 }
    group:item("survnote", 1)
    group:item("touristmap", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cattlefodder_bag_canvas_50", kind = "collection", container = "bag_canvas" }
    group:entry { item = "cattlefodder", count = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "birdfood_bag_canvas_60", kind = "collection", container = "bag_canvas" }
    group:entry { item = "birdfood", count = { 60, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_sex_shop_stock", kind = "collection" }
    group:entry { group = "SUS_sex_shop_shelf", count = { 0, 3 } }
    group:entry { group = "SUS_commercial_shelf_porn_literature", count = { 0, 2 } }
    group:entry { group = "sex_clothes", count = { 0, 20 }, probability = 50 }
    group:entry { group = "underwear_womens", count = { 0, 20 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_sex_shop_shelf", kind = "distribution" }
    group:entry {
        collection = {
            { item = "sextoy", count = { 0, 5 }, variant = "beads" },
            { item = "sextoy", count = { 0, 5 }, variant = "plug" },
            { item = "sextoy", count = { 0, 5 }, variant = "dildo" },
        },
        probability = 40,
    }
    group:entry {
        collection = {
            { item = "vibrator", count = { 0, 5 }, charges = { 100, 100 }, variant = "wand" },
            { item = "vibrator", count = { 0, 5 }, charges = { 100, 100 }, variant = "egg" },
            { item = "vibrator", count = { 0, 5 }, charges = { 100, 100 }, variant = "dildo" },
        },
        probability = 40,
    }
    group:entry {
        collection = {
            { item = "rope_6", count = { 0, 3 } },
            { item = "bullwhip", count = { 0, 3 } },
            { item = "candle", count = { 0, 3 } },
            { item = "handcuffs_leather", count = { 0, 3 } },
            { item = "gag_ball", count = { 0, 3 } },
            { item = "paddle_plastic", count = { 0, 3 } },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "moisturizer", count = { 0, 15 }, variant = "lube", container = "bottle_plastic_small" },
            { item = "condom_sealed", count = { 0, 50 } },
        },
        probability = 10,
    }
    content.add(group)
end
