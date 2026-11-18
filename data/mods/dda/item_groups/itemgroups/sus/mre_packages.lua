local content = require("ccb").content

do
    local group = content.ItemGroup { id = "MRE", kind = "distribution" }
    group:group("mre_full_pack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_MRE", kind = "distribution" }
    group:group("mre_full_pack")
    group:group("mre_used_pack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_sides", kind = "distribution" }
    group:entry { item = "mre_potato", container = "null" }
    group:entry { item = "mre_fried_rice", container = "null" }
    group:entry { item = "mre_zapplesauce", container = "null" }
    group:entry { item = "mre_blackbeans", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_dessert_pack", kind = "collection" }
    group:entry {
        distribution = {
            { item = "mre_chocolate_cake", container = "null" },
            { item = "mre_carrot_cake", container = "null" },
            { item = "mre_poppyseed_cake", container = "null" },
            { item = "mre_chocolate_pudding", container = "null" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_bread_pack", kind = "collection", container = "mre_bag_small" }
    group:entry {
        distribution = {
            { item = "crackers", count = { 2, 2 }, container = "null" },
            { item = "snack_bread", count = { 2, 2 }, container = "null" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_accessory_pack", kind = "collection", container = "bag_plastic" }
    group:item("gummy_vitamins")
    group:entry { item = "matches", charges = { 20, 20 } }
    group:entry { item = "napkin", count = { 8, 8 } }
    group:entry { item = "gum", count = { 2, 2 } }
    group:group("pur_tablets_beverage_bag_6")
    group:group("sugar_beverage_bag_2")
    group:item("spork")
    group:entry {
        distribution = {
            { item = "instant_coffee", count = { 1, 1 }, container = "bag_zipper" },
            { item = "lemonade_powder", count = { 1, 1 }, container = "bag_zipper" },
            { item = "orangeade_powder", count = { 1, 1 }, container = "bag_zipper" },
            { item = "grapeade_powder", count = { 1, 1 }, container = "bag_zipper" },
        },
    }
    content.add(group)
end

do
    -- What an MRE in pristine condition should contain.
    local group = content.ItemGroup { id = "mre_contents", kind = "collection" }
    group:entry { group = "mre_entrees", sealed = true, container = "mre_bag_small" }
    group:entry { group = "mre_sides", sealed = true, container = "mre_bag_small" }
    group:entry {
        distribution = {
            { item = "can_cheese", sealed = true, wrapper = "mre_bag_spread", container = "null" },
            { item = "spread_peanutbutter", sealed = true, wrapper = "mre_bag_spread", container = "null" },
            { item = "jam_fruit", charges = { 1, 1 }, sealed = true, wrapper = "mre_bag_jam", container = "null" },
        },
    }
    group:entry { group = "mre_bread_pack", sealed = true }
    group:entry { group = "mre_dessert_pack", sealed = true, container = "mre_bag_dessert" }
    group:group("mre_accessory_pack")
    group:item("heatpack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_full_pack", kind = "collection" }
    group:entry {
        item = "mre_package",
        sealed = true,
        contents = {
            { group = "mre_contents" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_used_dessert_pack", kind = "collection" }
    group:entry {
        distribution = {
            { item = "cookies", count = { 0, 1 }, container = "null" },
            { item = "mre_carrot_cake", count = { 0, 1 }, container = "null" },
            { item = "mre_poppyseed_cake", count = { 0, 1 }, container = "null" },
            { item = "chocolate", count = { 0, 1 }, container = "null" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_used_contents", kind = "collection" }
    group:entry { group = "mre_entrees", sealed = false, container = "mre_bag_small", probability = 40 }
    group:entry { group = "mre_sides", sealed = false, container = "mre_bag_small", probability = 40 }
    group:item("heatpack", 40)
    group:entry {
        distribution = {
            { item = "can_cheese", sealed = true, wrapper = "mre_bag_spread", container = "null", probability = 40 },
            { item = "spread_peanutbutter", sealed = true, wrapper = "mre_bag_spread", container = "null", probability = 40 },
            { item = "jam_fruit", charges = { 1, 1 }, sealed = true, wrapper = "mre_bag_jam", container = "null", probability = 40 },
        },
    }
    group:entry { group = "mre_bread_pack", sealed = false, probability = 40 }
    group:group("mre_accessory_pack", 50)
    group:entry { group = "mre_dessert_pack", sealed = false, container = "mre_bag_dessert", probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_used_pack", kind = "collection" }
    group:entry {
        item = "mre_package",
        sealed = false,
        contents = {
            { group = "mre_used_contents" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candy2_wrapper_1", kind = "collection", container = "wrapper" }
    group:entry { item = "candy2", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cookies_wrapper_1", kind = "collection", container = "wrapper" }
    group:entry { item = "cookies", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pur_tablets_beverage_bag_6", kind = "collection", container = "bag_zipper" }
    group:entry { item = "pur_tablets", count = { 6, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_beverage_bag_2", kind = "collection", container = "bag_zipper" }
    group:entry { item = "sugar", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crackers_mre_bag_small_2", kind = "collection", container = "mre_bag_small" }
    group:entry { item = "crackers", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pur_tablets_beverage_bag_0_6", kind = "collection", container = "bag_zipper" }
    group:entry { item = "pur_tablets", count = { 0, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sugar_beverage_bag_0_2", kind = "collection", container = "bag_zipper" }
    group:entry { item = "sugar", count = { 0, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crackers_mre_bag_small_0_2", kind = "collection", container = "mre_bag_small" }
    group:entry { item = "crackers", count = { 0, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mre_entrees", kind = "distribution" }
    group:item("mre_asianbeef")
    group:item("mre_bbqbeef")
    group:item("mre_beef")
    group:item("mre_beefstew")
    group:item("mre_beeftaco")
    group:item("mre_cheesetort")
    group:item("mre_chicken")
    group:item("mre_chickenburritobowl")
    group:item("mre_chickennoodle")
    group:item("mre_chickenpesto")
    group:item("mre_chilibeans")
    group:item("mre_chilimac")
    group:item("mre_hashbrownbacon")
    group:item("mre_hotdog")
    group:item("mre_lemontuna")
    group:item("mre_lobstermedley")
    group:item("mre_macaronimarinara")
    group:item("mre_maplesausage")
    group:item("mre_meatball")
    group:item("mre_mexicanchickenstew")
    group:item("mre_mushroomfettuccine")
    group:item("mre_pepperjackbeef")
    group:item("mre_ratatouille")
    group:item("mre_ravioli")
    group:item("mre_sfettuccine")
    group:item("mre_southwestbeef")
    group:item("mre_spaghetti")
    group:item("mre_pizza")
    group:item("mre_cheesepizza")
    group:item("mre_veggy")
    content.add(group)
end
