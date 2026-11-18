local content = require("ccb").content

do
    local group = content.ItemGroup { id = "teabag_box", kind = "distribution" }
    group:group("tea_bag_box_tea_1_10", 20)
    group:group("tea_fruit_bag_box_tea_1_10", 10)
    group:group("tea_green_bag_box_tea_1_10", 10)
    group:group("tea_bag_chamomile_box_tea_1_10", 10)
    group:group("herbal_tea_bag_box_tea_1_10", 5)
    group:group("tea_bag_dandelion_box_tea_1_10", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_bag_box_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_bag", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_bag_box_tea_1_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_bag", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_green_bag_box_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_green_bag", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_green_bag_box_tea_1_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_green_bag", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_fruit_bag_box_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_fruit_bag", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_fruit_bag_box_tea_1_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_fruit_bag", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "herbal_tea_bag_box_10", kind = "collection", container = "box_tea" }
    group:entry { item = "herbal_tea_bag", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "herbal_tea_bag_box_tea_1_10", kind = "collection", container = "box_tea" }
    group:entry { item = "herbal_tea_bag", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_bag_dandelion_box_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_bag_dandelion", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_bag_dandelion_box_tea_1_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_bag_dandelion", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_bag_chamomile_box_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_bag_chamomile", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_bag_chamomile_box_tea_1_10", kind = "collection", container = "box_tea" }
    group:entry { item = "tea_bag_chamomile", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    -- 100 g of tea
    local group = content.ItemGroup { id = "tea_raw_bag_plastic_33", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "tea_raw", count = { 2, 33 }, container = "null" }
    content.add(group)
end

do
    -- 100 g of tea
    local group = content.ItemGroup { id = "tea_green_raw_bag_plastic_33", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "tea_green_raw", count = { 2, 33 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_raw_jar_glass_sealed_10_40", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "tea_raw", count = { 10, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "tea_green_raw_jar_glass_sealed_10_40",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "tea_green_raw", count = { 10, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_raw_bag_plastic_20", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "coffee_raw", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "raw_coffee_in_container", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "instant_coffee", count = { 1, 40 }, wrapper = "bottle_glass_seasoning" },
            { item = "instant_coffee", count = { 1, 40 }, wrapper = "can_medium" },
        },
    }
    group:entry {
        distribution = {
            { group = "ground_coffee_small", wrapper = "can_food_big" },
            { group = "ground_coffee_small", wrapper = "bag_plastic" },
        },
    }
    group:entry {
        distribution = {
            { group = "ground_coffee_big", wrapper = "can_food_big" },
            { group = "ground_coffee_big", wrapper = "bag_plastic" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "raw_coffee_in_container_full", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "instant_coffee", count = { 40, 40 }, wrapper = "bottle_glass_seasoning" },
            { item = "instant_coffee", count = { 40, 40 }, wrapper = "can_medium" },
        },
    }
    group:entry {
        distribution = {
            { group = "ground_coffee_small_full", wrapper = "can_food_big" },
            { group = "ground_coffee_small_full", wrapper = "bag_plastic" },
        },
    }
    group:entry {
        distribution = {
            { group = "ground_coffee_big_full", wrapper = "can_food_big" },
            { group = "ground_coffee_big_full", wrapper = "bag_plastic" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ground_coffee_small", kind = "distribution" }
    group:entry { item = "coffee_raw", count = { 1, 30 } }
    group:entry { item = "coffee_raw_kentucky", count = { 1, 30 } }
    group:entry { item = "roasted_coffee_bean", count = { 1, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ground_coffee_small_full", kind = "distribution" }
    group:entry { item = "coffee_raw", count = { 30, 30 } }
    group:entry { item = "coffee_raw_kentucky", count = { 30, 30 } }
    group:entry { item = "roasted_coffee_bean", count = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ground_coffee_big", kind = "distribution" }
    group:entry { item = "coffee_raw", count = { 1, 60 } }
    group:entry { item = "coffee_raw_kentucky", count = { 1, 60 } }
    group:entry { item = "roasted_coffee_bean", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ground_coffee_big_full", kind = "distribution" }
    group:entry { item = "coffee_raw", count = { 60, 60 } }
    group:entry { item = "coffee_raw_kentucky", count = { 60, 60 } }
    group:entry { item = "roasted_coffee_bean", count = { 60, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "bee_balm_jar_3l_glass_sealed_1_12",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "bee_balm", count = { 1, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "raw_burdock_jar_3l_glass_sealed_1_inf",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "raw_burdock", count = { 1, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "wild_herbs_jar_glass_sealed_20_inf",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "wild_herbs", count = { 20, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "raw_dandelion_jar_glass_sealed_1_inf",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "raw_dandelion", count = { 1, -1 } }
    content.add(group)
end
