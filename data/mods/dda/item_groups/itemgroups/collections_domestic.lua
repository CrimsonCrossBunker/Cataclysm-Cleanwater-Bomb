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
