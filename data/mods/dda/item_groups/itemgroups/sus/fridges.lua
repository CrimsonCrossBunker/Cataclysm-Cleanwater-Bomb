local content = require("ccb").content

do
    -- Select a fridge from several available options.
    local group = content.ItemGroup { id = "SUS_fridge", kind = "distribution" }
    group:group("SUS_fridge_stocked", 70)
    group:group("SUS_fridge_partial_empty", 20)
    group:group("SUS_fridge_bachelor", 5)
    group:group("SUS_fridge_healthy_vegan", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sixpack_bottles_random", kind = "distribution" }
    group:entry {
        collection = {
            { item = "water_clean", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "water_clean", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 90,
    }
    group:entry {
        collection = {
            { item = "water_mineral", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "water_mineral", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 70,
    }
    group:entry {
        collection = {
            { item = "oj", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "oj", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "pineapple_juice", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "pineapple_juice", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "cranberry_juice", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "cranberry_juice", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "juice", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "juice", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "lemonade", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "lemonade", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 50,
    }
    group:group("sixpack_bottles_random_unhealthy", 525)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sixpack_bottles_random_unhealthy", kind = "distribution" }
    group:entry {
        collection = {
            { item = "cola", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "cola", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 70,
    }
    group:entry {
        collection = {
            { item = "rootbeer", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "rootbeer", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 65,
    }
    group:entry {
        collection = {
            { item = "tonic_water", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "tonic_water", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "sports_drink", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "sports_drink", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            { item = "choc_drink", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "choc_drink", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            { item = "purple_drink", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "purple_drink", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 35,
    }
    group:entry {
        collection = {
            { item = "creamsoda", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "creamsoda", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 35,
    }
    group:entry {
        collection = {
            { item = "lemonlime", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "lemonlime", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 35,
    }
    group:entry {
        collection = {
            { item = "orangesoda", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "orangesoda", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "crispycran", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "crispycran", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "colamdew", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "colamdew", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 35,
    }
    group:entry {
        collection = {
            { item = "zerocola", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "zerocola", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "zeroorange", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "zeroorange", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "zerotropical", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "zerotropical", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "zeromdew", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "zeromdew", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "foodplace_zero_drink", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "foodplace_zero_drink", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            { item = "sparkling", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "sparkling", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 15,
    }
    group:entry {
        collection = {
            { item = "sparkling_peach", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "sparkling_peach", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 15,
    }
    group:entry {
        collection = {
            { item = "sparkling_pomegranate", charges = { 1, 1 }, sealed = false, container = "bottle_plastic", probability = 50 },
            { item = "sparkling_pomegranate", count = { 1, 6 }, container = "bottle_plastic" },
        },
        probability = 15,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sixpack_cans_random", kind = "distribution" }
    group:entry { item = "oj", count = { 1, 6 }, probability = 50 }
    group:entry { item = "pineapple_juice", count = { 1, 6 }, probability = 50 }
    group:entry { item = "cranberry_juice", count = { 1, 6 }, probability = 50 }
    group:entry { item = "juice", count = { 1, 6 }, probability = 50 }
    group:entry { item = "lemonade", count = { 1, 6 }, probability = 50 }
    group:group("sixpack_cans_random_unhealthy", 540)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sixpack_cans_random_unhealthy", kind = "distribution" }
    group:entry { item = "cola", count = { 1, 6 }, probability = 70 }
    group:entry { item = "rootbeer", count = { 1, 6 }, probability = 65 }
    group:entry { item = "tonic_water", count = { 1, 6 }, probability = 20 }
    group:entry { item = "sports_drink", count = { 1, 6 }, probability = 30 }
    group:entry { item = "choc_drink", count = { 1, 6 }, probability = 30 }
    group:entry { item = "horchata", count = { 1, 6 }, probability = 15 }
    group:entry { item = "purple_drink", count = { 1, 6 }, probability = 35 }
    group:entry { item = "creamsoda", count = { 1, 6 }, probability = 35 }
    group:entry { item = "lemonlime", count = { 1, 6 }, probability = 35 }
    group:entry { item = "orangesoda", count = { 1, 6 }, probability = 20 }
    group:entry { item = "crispycran", count = { 1, 6 }, probability = 20 }
    group:entry { item = "colamdew", count = { 1, 6 }, probability = 35 }
    group:entry { item = "zerocola", count = { 1, 6 }, probability = 20 }
    group:entry { item = "zeroorange", count = { 1, 6 }, probability = 20 }
    group:entry { item = "zerotropical", count = { 1, 6 }, probability = 20 }
    group:entry { item = "zeromdew", count = { 1, 6 }, probability = 20 }
    group:entry { item = "foodplace_zero_drink", count = { 1, 6 }, probability = 5 }
    group:entry { item = "sparkling", count = { 1, 6 }, probability = 15 }
    group:entry { item = "sparkling_peach", count = { 1, 6 }, probability = 15 }
    group:entry { item = "sparkling_pomegranate", count = { 1, 6 }, probability = 15 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a refrigerator which can be found in survivor/bandits locations.
    -- It contains mostly canned foods.
    local group = content.ItemGroup { id = "SUS_fridge_survivor", kind = "collection" }
    group:entry { group = "big_canned_food", count = { 3, 6 }, probability = 40 }
    group:entry { group = "foodintincan", count = { 4, 8 }, probability = 80 }
    group:entry { group = "condiments", count = { 1, 2 }, probability = 25 }
    group:entry { group = "preserved_food", count = { 3, 6 }, probability = 40 }
    group:entry { group = "soda_in_small_container", count = { 3, 7 }, probability = 75 }
    group:entry { group = "alcohol_bottled_canned", count = { 2, 4 }, probability = 30 }
    group:entry { item = "water_clean", count = { 2, 6 }, container = "bottle_plastic", probability = 65 }
    content.add(group)
end

do
    -- Select a freezer from several available options.
    local group = content.ItemGroup { id = "SUS_freezer", kind = "distribution" }
    group:group("SUS_freezer_stocked", 30)
    group:group("SUS_freezer_partial_empty", 50)
    group:group("SUS_freezer_feral", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a freezer which is well stocked.
    local group = content.ItemGroup { id = "SUS_freezer_stocked", kind = "collection" }
    group:entry { group = "toasterpastryfrozen_box_snack_2", count = { 1, 3 }, probability = 75 }
    group:entry { group = "hotdogs_frozen_bag_plastic_10", count = { 1, 4 }, probability = 75 }
    group:entry { group = "frozen_dinner_box_small_2", count = { 2, 5 }, probability = 75 }
    group:entry { group = "cheese_bag_plastic", count = { 1, 2 }, probability = 75 }
    group:entry { group = "corndogs_frozen_bag_plastic_2", count = { 1, 3 }, probability = 75 }
    group:group("pizza_veggy_box_small_4", 75)
    group:group("pizza_meat_box_small_4", 75)
    group:item("milkshake", 20)
    group:item("milkshake_deluxe", 15)
    group:item("frozen_lemonade", 15)
    group:item("milkshake_choc", 15)
    group:item("milkshake_deluxe_choc", 15)
    group:entry { item = "icecream", count = { 1, 4 }, probability = 50 }
    group:entry { item = "icecream_choc", count = { 1, 2 }, probability = 50 }
    group:entry { item = "icecream_candy", count = { 1, 2 }, probability = 25 }
    group:entry { item = "icecream_custard", count = { 1, 2 }, probability = 25 }
    group:item("icecream_sorbet", 25)
    group:item("icecream_gelato", 25)
    group:entry { item = "icecream_artificial", count = { 1, 2 }, probability = 25 }
    group:entry { item = "sausage_raw", count = { 1, 10 }, probability = 75 }
    group:entry { item = "bacon", count = { 1, 8 }, probability = 75 }
    group:entry { item = "fish", count = { 1, 4 }, probability = 75 }
    group:entry { item = "meat", count = { 2, 12 }, probability = 75 }
    group:entry { item = "porkbelly", count = { 1, 4 }, probability = 75 }
    group:entry { item = "bacon_uncut", count = { 1, 8 }, probability = 75 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a freezer which is running low on food.
    local group = content.ItemGroup { id = "SUS_freezer_partial_empty", kind = "collection" }
    group:group("toasterpastryfrozen_box_snack_2", 25)
    group:group("hotdogs_frozen_bag_plastic_10", 25)
    group:group("frozen_dinner_box_small_2", 50)
    group:group("cheese_bag_plastic", 25)
    group:group("corndogs_frozen_bag_plastic_2", 25)
    group:group("pizza_veggy_box_small_4", 25)
    group:group("pizza_meat_box_small_4", 25)
    group:item("milkshake", 10)
    group:item("milkshake_deluxe", 5)
    group:item("frozen_lemonade", 5)
    group:item("milkshake_choc", 5)
    group:item("milkshake_deluxe_choc", 5)
    group:item("icecream", 15)
    group:item("icecream_choc", 15)
    group:item("icecream_candy", 10)
    group:item("icecream_custard", 10)
    group:item("icecream_sorbet", 10)
    group:item("icecream_gelato", 10)
    group:item("icecream_artificial", 5)
    group:item("sausage_raw", 50)
    group:item("bacon", 25)
    group:item("fish", 25)
    group:entry { item = "meat", count = { 1, 3 }, probability = 50 }
    group:item("porkbelly", 25)
    group:item("bacon_uncut", 50)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a freezer that a feral might have tried stocking.
    local group = content.ItemGroup { id = "SUS_freezer_feral", kind = "distribution" }
    group:group("corpses_verydead_no_items", 75)
    group:entry {
        collection = {
            { item = "brain", probability = 75 },
            { item = "meat_tainted", count = { 5, 25 }, probability = 75 },
            { item = "arm", probability = 50 },
            { item = "leg", probability = 50 },
            { item = "fat_tainted", count = { 1, 10 }, probability = 75 },
            { item = "bone_tainted", count = { 1, 10 }, probability = 75 },
        },
        probability = 25,
    }
    content.add(group)
end
