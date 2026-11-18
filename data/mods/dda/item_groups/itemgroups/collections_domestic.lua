local content = require("ccb").content

do
    -- Items that might be found scattered around a kitchen counter.
    local group = content.ItemGroup { id = "kitchen_counters", kind = "distribution" }
    group:group("dishes_dining")
    group:group("dishes_utility", 50)
    group:group("kitchen_appliances", 25)
    group:group("SUS_cooking_bookcase", 15)
    group:group("pillbox_any_used", 5)
    content.add(group)
end

do
    -- Mundane household dishes that would be used for eating, not food prep.
    -- May be some overlap for food prep dishes that could be used for serving, like mixing bowls and teapots.
    -- If it would fit on a dining table, it would fit in this group.
    local group = content.ItemGroup { id = "dishes_dining", kind = "distribution" }
    group:item("knife_butter", 90)
    group:item("fork", 90)
    group:item("spoon", 90)
    group:item("chopsticks", 90)
    group:item("knife_small", 50, "knife_steak")
    group:item("glass", 50)
    group:item("ceramic_plate", 50)
    group:item("ceramic_bowl", 50)
    group:item("ceramic_cup", 20)
    group:item("ceramic_mug", 19)
    group:item("wine_glass", 20)
    group:item("plastic_plate", 50)
    group:item("tumbler_plastic", 50)
    group:item("bowl_pewter", 25)
    group:item("glass_plate", 20)
    group:item("glass_bowl", 20)
    group:item("bowl_wood", 5)
    group:item("plastic_spoon", 20)
    group:item("plastic_knife", 20)
    group:item("plastic_fork", 20)
    group:item("teapot", 5)
    group:entry {
        collection = {
            { item = "plastic_bowl_kids" },
            { item = "plastic_spoon_kids" },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- Mundane household dishes that would be used for cooking, not found on a dining table.
    -- If it would be OK in a dishwasher but generally not as a table setting, it would fit in this group.
    local group = content.ItemGroup { id = "dishes_utility", kind = "distribution" }
    group:item("pot", 50)
    group:item("pan", 50)
    group:item("steel_pan", 45)
    group:item("copper_pan", 35)
    group:item("pot_canning", 10)
    group:item("pot_copper", 25)
    group:item("iron_pot", 25)
    group:item("casserole", 25)
    group:item("stock_pot", 15)
    group:item("pressure_cooker", 5)
    group:item("dutch_oven", 5)
    group:item("teapot", 40)
    group:item("kettle", 40)
    group:item("colander_steel", 35)
    group:item("splatter_guard", 10)
    group:item("jar_glass_sealed", 50)
    group:item("jar_3l_glass_sealed", 40)
    group:item("bowl_pewter", 25)
    group:item("knife_huge", 20, "knife_butcher")
    group:item("thermos", 15)
    group:item("tongs", 15)
    group:item("spatula", 15)
    group:item("whisk", 15)
    group:item("ladle", 15)
    group:item("rolling_pin", 15)
    group:item("garlic_press", 15)
    group:item("potato_masher", 15)
    group:item("carving_fork", 15)
    group:item("can_opener", 15)
    group:item("corkscrew", 10)
    group:item("peeler", 15)
    group:item("brush", 15)
    group:item("knife_small", 25, "knife_paring")
    group:item("knife_large", 20, "knife_bread")
    group:item("knife_large", 20, "knife_chef")
    group:item("knife_large", 20, "knife_carving")
    group:item("knife_huge", 10, "knife_butcher")
    group:item("knife_cleaver", 10, "knife_meat_cleaver")
    group:item("knife_cleaver", 10, "knife_vegetable_cleaver")
    group:item("cutting_board", 20)
    group:item("bottle_opener", 15)
    group:item("mortar_pestle", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "memorial_mansion", kind = "collection" }
    group:entry { item = "corpse_ash", count = { 190, 396 }, wrapper = "crystal_urn" }
    group:item("photo_album", 80)
    group:item("bouquet", 80)
    group:entry { item = "candlestick", count = { 1, 6 }, probability = 50 }
    group:group("liquor_and_spirits", 60)
    group:group("wines_worthy", 50)
    group:entry { item = "cigar", count = { 5, 5 }, probability = 50 }
    group:group("jewelry_accessories", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dining", kind = "distribution" }
    group:item("wrapper", 50)
    group:item("wrapper_foil", 5)
    group:item("knife_butter", 90)
    group:item("knife_small", 85, "knife_steak")
    group:item("fork", 90)
    group:item("spoon", 90)
    group:item("spork", 5)
    group:item("foon", 5)
    group:group("ketchup_sealed_rng", 10)
    group:group("mustard_sealed_rng", 10)
    group:group("barbecue_sauce_sealed_rng", 5)
    group:group("honey_mustard_sealed_rng", 3)
    group:item("soysauce", 10)
    group:item("horseradish", 10)
    group:item("glass", 90)
    group:item("glass_bowl", 90)
    group:item("glass_plate", 90)
    group:item("bottle_glass", 10)
    group:group("tinware", 10)
    content.add(group)
end

do
    -- Items that might be found scattered around the home of a hoarder.
    local group = content.ItemGroup { id = "hoarder", kind = "distribution" }
    group:group("SUS_trash_floor")
    group:group("cleaning", 20)
    group:group("dishes_dining", 20)
    group:group("dishes_utility", 10)
    group:group("child_items", 10)
    group:group("SUS_bathroom_sink", 10)
    group:group("bed", 10)
    group:group("games", 5)
    group:group("SUS_junk_drawer", 1)
    content.add(group)
end

do
    -- Items you might find on the floor in a disorganized house.
    local group = content.ItemGroup { id = "untidy_floor_clutter", kind = "distribution" }
    group:item("box_large", 10)
    group:entry {
        collection = {
            { group = "laundry", count = { 3, 5 }, probability = 75 },
            { item = "basket_laundry" },
        },
        probability = 8,
    }
    group:group("coat_rack", 5)
    group:item("hair_dryer", 3)
    group:item("bucket", 3)
    group:item("bucket_5gal", 3)
    group:item("briefcase", 2)
    group:item("suitcase_m", 2)
    group:entry { item = "candle", charges = { 5, 50 }, probability = 3 }
    group:entry {
        collection = {
            {
                collection = {
                    { item = "hammer" },
                    { item = "nail", charges = { 2, 6 }, probability = 75 },
                },
                probability = 50,
            },
            { item = "pliers", probability = 33 },
            { item = "paint_brush", probability = 33 },
            { item = "xacto", probability = 10 },
            { item = "screwdriver", probability = 10 },
            { group = "duct_tape_roll_part" },
            { group = "glue_weak_domestic", probability = 5 },
            { group = "glue_strong_domestic", probability = 5 },
            { item = "splinter", count = { 2, 3 }, probability = 10 },
            { item = "toolbox_empty" },
        },
        probability = 3,
    }
    group:item("extinguisher", 2)
    content.add(group)
end

do
    -- Items you might find on the floor in a disorganized and dirty house.
    local group = content.ItemGroup { id = "messy_floor_clutter", kind = "distribution" }
    group:group("laundry", 10)
    group:group("SUS_trash_floor", 7)
    group:group("untidy_floor_clutter", 7)
    group:group("coins", 5)
    group:entry {
        collection = {
            { group = "SUS_trash_trashcan", count = { 3, 6 }, probability = 75 },
            { item = "bag_garbage" },
        },
        probability = 2,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fungicide_bag_plastic_400", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "fungicide", count = { 400, 400 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "insecticide_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "insecticide", count = { 9, 9 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_candles_in_box", kind = "collection", container = "box_small" }
    group:entry {
        distribution = {
            { item = "candle_small", count = { 20, 45 }, charges = { 0, 100 }, container = "null" },
            { item = "candle_small", count = { 20, 45 }, charges = { 50, 100 }, container = "null" },
            { item = "candle_small", count = { 20, 45 }, charges = { 100, 100 }, container = "null" },
        },
    }
    content.add(group)
end

do
    -- Mundane household items that might be found in or around a shower or bath.
    local group = content.ItemGroup { id = "shower", kind = "distribution" }
    group:item("cotton_patchwork", 40)
    group:entry { item = "bath_toy", count = { 1, 4 }, probability = 10 }
    group:item("bathroom_scale", 20)
    group:entry { item = "liquid_soap", count = { 1, 4 }, charges = { 1, -1 }, probability = 70 }
    group:item("towel", 30)
    group:entry { item = "soap", charges = { 1, 10 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "memorial", kind = "collection" }
    group:entry { item = "corpse_ash", count = { 190, 396 }, wrapper = "porcelain_urn" }
    group:item("photo_album", 75)
    group:item("bouquet", 50)
    group:entry { item = "candle", charges = { 1, 6 }, probability = 50 }
    group:entry {
        distribution = {
            { group = "religious_books", probability = 20 },
            { item = "bead_necklace", probability = 20 },
            { item = "bead_bracelet", probability = 20 },
            { item = "holy_symbol", probability = 20 },
            { item = "candlestick", probability = 20 },
        },
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "american_flag", probability = 70 },
                    { item = "beret", probability = 33 },
                    { item = "service_medal", probability = 50 },
                    { item = "dog_tag" },
                },
                probability = 10,
            },
            {
                collection = {
                    { item = "ceramic_mug", probability = 50 },
                    { group = "beer_in_container", probability = 50 },
                    { group = "liquor_and_spirits", probability = 20 },
                    { group = "wines_worthy", probability = 10 },
                    { item = "cigar", probability = 20 },
                    { item = "hat_ball", probability = 20 },
                    { group = "jewelry_accessories", probability = 50 },
                    { group = "clothing_glasses", probability = 50 },
                    { item = "foodperson_mask", charges = { 0, 500 }, probability = 1 },
                },
                probability = 70,
            },
            {
                collection = {
                    {
                        item = "teddy_bear",
                        damage = { 0, 3 },
                        flags = {
                            "FILTHY",
                        },
                        probability = 50,
                    },
                    { item = "hat_ball", probability = 20 },
                    { item = "baseball", probability = 20 },
                    { item = "roller_shoes_off", probability = 10 },
                    { item = "gold_medal", probability = 20 },
                    { item = "silver_medal", probability = 20 },
                    { item = "bronze_medal", probability = 20 },
                    { item = "story_book", probability = 50 },
                    { item = "hairpin", probability = 20 },
                    { item = "barrette", probability = 20 },
                    { item = "newspaper_memorial", probability = 20 },
                },
                probability = 5,
            },
            {
                collection = {
                    { item = "dog_whistle", probability = 50 },
                    { item = "dog_whistle_wood", probability = 25 },
                    { item = "leather_harness_dog", probability = 50 },
                    { item = "dogfood_dry", container = "bowl_plastic", probability = 50 },
                    { item = "bone", probability = 50 },
                    { item = "dog_tag_dog" },
                },
                probability = 15,
            },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "grave_cremains", kind = "collection" }
    group:entry { item = "corpse_ash", count = { 190, 396 }, wrapper = "porcelain_urn" }
    group:item("bouquet")
    group:entry {
        distribution = {
            { group = "religious_books", probability = 25 },
            { item = "bead_necklace", probability = 25 },
            { item = "bead_bracelet", probability = 25 },
            { item = "holy_symbol", probability = 25 },
        },
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "american_flag", probability = 70 },
                    { item = "beret", probability = 33 },
                    { item = "service_medal", probability = 50 },
                    { item = "dog_tag" },
                },
                probability = 20,
            },
            {
                collection = {
                    { item = "ceramic_mug", probability = 50 },
                    { group = "beer_in_container", probability = 50 },
                    { group = "liquor_and_spirits", probability = 20 },
                    { group = "wines_worthy", probability = 10 },
                    { item = "cigar", probability = 20 },
                    { item = "hat_ball", probability = 20 },
                    { group = "jewelry_accessories", probability = 50 },
                    { group = "clothing_glasses", probability = 50 },
                    { item = "foodperson_mask", charges = { 0, 500 }, probability = 1 },
                },
                probability = 70,
            },
            {
                collection = {
                    {
                        item = "teddy_bear",
                        damage = { 0, 3 },
                        flags = {
                            "FILTHY",
                        },
                        probability = 50,
                    },
                    { item = "hat_ball", probability = 20 },
                    { item = "baseball", probability = 20 },
                    { item = "roller_shoes_off", probability = 10 },
                    { item = "gold_medal", probability = 20 },
                    { item = "silver_medal", probability = 20 },
                    { item = "bronze_medal", probability = 20 },
                    { item = "story_book", probability = 50 },
                    { item = "hairpin", probability = 20 },
                    { item = "barrette", probability = 20 },
                    { item = "newspaper_memorial", probability = 20 },
                },
                probability = 10,
            },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cat_hoarder", kind = "distribution" }
    group:item("pet_carrier", 30)
    group:item("petpack", 15)
    group:entry { item = "catfood", container = "can_food", probability = 30 }
    group:entry { item = "catfood_dry", count = { 12, -1 }, probability = 10 }
    group:item("towel", 20)
    group:item("soap", 10)
    group:item("gloves_medical", 20)
    group:item("cotton_patchwork", 15)
    group:item("bag_plastic", 20)
    group:item("missing_poster_cat", 40)
    group:item("rope_6", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chem_home", kind = "distribution" }
    group:group("iodine_bottle_plastic_pill_supplement_1_10", 5)
    group:group("prussian_blue_bottle_plastic_pill_supplement_1_10", 5)
    group:item("textbook_chemistry", 8)
    group:item("brewing_cookbook", 4)
    group:item("adv_chemistry", 6)
    group:item("water_clean", 80)
    group:item("salt_water", 30)
    group:entry { item = "bleach", charges = { 1, -1 }, probability = 20 }
    group:item("chem_calcium_chloride", 2)
    group:entry { item = "chem_washing_soda", count = { 1, -1 }, probability = 20 }
    group:entry { item = "chem_baking_soda", count = { 1, -1 }, probability = 20 }
    group:entry { item = "chunk_borax", count = { 1, -1 }, probability = 10 }
    group:group("ammonia_hydroxide_bottle_twoliter_part", 24)
    group:group("yeast_bag_plastic", 2)
    group:group("yogurt_starter_culture_bag_plastic_4", 1)
    group:item("royal_jelly", 8)
    group:group("glue_weak_domestic", 10)
    group:group("glue_strong_domestic", 10)
    group:item("bottle_glass", 10)
    group:item("syringe", 4)
    group:item("adrenaline_injector", 2)
    group:group("used_1st_aid", 4)
    group:entry { item = "saline", charges = { 1, 5 }, probability = 1 }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:item("hotplate", 10)
    group:item("thermometer", 10)
    group:item("pressure_cooker", 10)
    group:item("funnel", 50)
    group:item("jar_glass_sealed", 20)
    group:item("jar_3l_glass_sealed", 15)
    group:item("apron_plastic", 15)
    group:item("apron_cotton", 3)
    group:item("apron_leather", 3)
    group:group("pur_tablets_bottle_plastic_small_1_50", 15)
    group:group("lye_powder_bottle_part", 20)
    group:group("oxy_powder_bottle_part", 24)
    group:item("chemistry_set", 10)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 20 }
    group:entry { item = "eyedrops", count = { 10, 10 }, probability = 25 }
    group:entry { item = "steroid_eyedrops", count = { 3, 3 }, probability = 10 }
    group:group("charcoal_bag_part", 15)
    group:item("tin", 15)
    group:item("lamp_oil", 12)
    group:item("chem_hydrogen_peroxide", 15)
    group:group("calciumcarbide_small_bottle_part", 10)
    group:group("zincpowder_small_bottle_part", 10)
    group:group("manganesedioxide_small_bottle_part", 5)
    group:group("potassiumchloride_small_bottle_part", 5)
    group:item("chem_muriatic_acid", 15)
    group:item("denat_alcohol", 6)
    group:item("methed_alcohol", 4)
    group:item("textbook_extraction", 5)
    group:entry { item = "butane_can", charges = { 200, 400 }, probability = 10 }
    group:item("gasket_plastic", 10)
    group:item("vac_pump", 3)
    group:item("recovery_pump", 3)
    group:item("filter_paper_qualitative", 5)
    group:item("filter_paper_quantitative", 5)
    group:entry { item = "chem_turpentine", charges = { 20, -1 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cleaning", kind = "distribution" }
    group:item("salt_water", 20)
    group:group("bleach_jug_part", 20)
    group:entry { item = "chem_washing_soda", count = { 1, -1 }, probability = 20 }
    group:group("ammonia_hydroxide_bottle_twoliter_part", 24)
    group:item("broom", 30)
    group:item("mop", 15)
    group:item("mop_folded", 15)
    group:item("sponge", 30)
    group:item("gloves_rubber", 20)
    group:item("apron_plastic", 15)
    group:item("mask_dust", 65)
    group:item("towel", 40)
    group:item("plastic_sheet", 40)
    group:item("bottle_plastic", 10)
    group:item("bottle_plastic_small", 5)
    group:entry { item = "sewing_kit", charges = { 0, -1 }, probability = 47 }
    group:entry { item = "tailors_kit", charges = { 0, -1 }, probability = 3 }
    group:item("electric_spinwheel", 3)
    group:item("thread", 40)
    group:item("cotton_patchwork", 1)
    group:item("scissors", 50)
    group:item("string_36", 40)
    group:item("vinegar", 10)
    group:group("lye_powder_bottle_part", 5)
    group:group("oxy_powder_bottle_part", 5)
    group:item("boots_rubber", 20)
    group:group("charcoal_bag_part", 5)
    group:group("fungicide_bag_plastic_400", 2)
    group:group("insecticide_bag_plastic", 2)
    group:item("soap", 80)
    group:item("detergent", 80)
    group:entry { item = "chem_borax", charges = { 50, 500 }, probability = 15 }
    group:item("chem_hydrogen_peroxide", 20)
    group:item("plunger_toilet", 30)
    group:item("plunger_futuristic", 15)
    group:item("toilet_paper", 10)
    group:item("dish_towel", 20)
    group:entry { item = "chem_turpentine", charges = { 20, -1 }, probability = 10 }
    content.add(group)
end

do
    -- this list is for collectibles, antiques, sports memorablia, awards, etc. that a person might put on display in their home
    local group = content.ItemGroup { id = "home_display_case", kind = "distribution" }
    group:group("liquor_and_spirits", 50)
    group:group("wines_worthy", 50)
    group:group("coins", 40)
    group:item("trailmap", 30)
    group:item("collector_book", 40)
    group:item("classic_literature", 40)
    group:item("bronze_medal", 20)
    group:item("silver_medal", 15)
    group:item("gold_medal", 10)
    group:item("platinum_watch", 25)
    group:item("gold_watch", 25)
    group:item("silver_watch", 25)
    group:item("gold_ring", 25)
    group:item("silver_ring", 25)
    group:item("jade_brooch", 25)
    group:item("silver_locket", 25)
    group:item("gold_locket", 25)
    group:item("platinum_locket", 10)
    group:item("pearl_collar", 10)
    group:item("pocketwatch", 50)
    group:item("candlestick", 50)
    group:item("menorah", 3)
    group:item("ring_signet", 40)
    group:item("cufflinks_intricate", 50)
    group:item("boxing_gloves", 25)
    group:item("hat_ball", 50)
    group:item("football", 50)
    group:item("baseball", 50)
    group:item("shuttlecock", 5)
    group:item("jersey", 50, "sportsteam")
    group:item("helmet_football", 50)
    group:item("mask_hockey", 50)
    group:group("toy_radio_car", 50)
    group:item("bottle_glass", 40)
    group:item("creepy_doll", 40)
    group:item("holy_symbol", 40)
    group:item("spiral_stone", 5)
    group:item("petrified_eye", 5)
    group:item("talking_doll", 40)
    group:item("bondage_mask", 20)
    group:item("knife_hunting", 25)
    group:item("throwing_knife", 25)
    group:entry { item = "throwing_knife", count = { 1, 6 }, wrapper = "leg_sheath6", probability = 5 }
    group:item("throwing_axe", 25)
    group:item("binoculars", 50)
    group:item("crossbow", 20)
    group:item("compcrossbow", 20)
    group:group("esoteric_books", 5)
    group:group("mansion_exotic_weapons", 1)
    group:item("rapier_fake", 10)
    group:item("cavalry_sabre_fake", 20)
    group:item("katana_fake", 20)
    group:item("katana_inferior", 2)
    group:item("cutlass_fake", 25)
    group:item("cutlass_inferior", 2)
    group:item("longbow", 10)
    group:item("compbow", 25)
    group:item("compositebow", 20)
    group:item("pistol_flintlock", 1)
    group:item("carbine_flintlock", 1)
    group:item("rifle_flintlock", 1)
    group:entry { group = "modular_deagle_44", charges = { 0, 8 }, probability = 25 }
    group:item("fencing_foil", 20)
    group:item("fencing_sabre", 20)
    group:item("fencing_epee", 20)
    group:item("fencing_mask", 20)
    group:item("home_picture", 50)
    content.add(group)
end
