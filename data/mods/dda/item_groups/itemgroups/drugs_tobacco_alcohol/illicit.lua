local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mobile_meth_lab", kind = "collection" }
    group:entry {
        distribution = {
            { item = "adderall", count = { 0, 20 }, wrapper = "bottle_plastic_pill_prescription", container = "null" },
            { item = "energy_drink", count = { 0, 2 } },
            { item = "caffeine", count = { 0, 20 }, wrapper = "bottle_plastic_pill_supplement", container = "null" },
        },
    }
    group:entry { group = "nondrowsy_cough_syrup_in_bottle", count = { 0, 2 } }
    group:entry { item = "red_phosphorous", charges = { 0, 1 }, probability = 40 }
    group:entry { item = "iodine_crystal", charges = { 0, 1 }, probability = 40 }
    group:entry { group = "meth_bag_zipper_1_6", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "meth_ingredients", kind = "distribution" }
    group:group("nondrowsy_cough_syrup_in_bottle", 2)
    group:entry { item = "red_phosphorous", charges = { 1, 20 }, probability = 25 }
    group:entry { item = "iodine_crystal", charges = { 1, 10 }, probability = 10 }
    group:item("energy_drink", 2)
    group:group("caffeine_bottle_plastic_pill_supplement_1_10", 20)
    content.add(group)
end

do
    -- For sale display appropriate packaging
    local group = content.ItemGroup { id = "jar_weed", kind = "distribution" }
    group:item("jar_3l_glass_sealed")
    group:entry { group = "weed_jar_3l_glass_sealed_10_420", sealed = false }
    group:item("jar_glass_sealed")
    group:entry { group = "hi_q_shatter_jar_glass_sealed_5_140", sealed = false }
    group:entry { group = "hi_q_wax_jar_glass_sealed_5_140", sealed = false }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "weed_jar_3l_glass_sealed_10_420",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "weed", count = { 10, 420 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "hi_q_shatter_jar_glass_sealed_5_140",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "hi_q_shatter", count = { 5, 140 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "hi_q_wax_jar_glass_sealed_5_140",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "hi_q_wax", count = { 5, 140 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "meth_bag_zipper_6", kind = "collection", container = "bag_zipper" }
    group:entry { item = "meth", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "meth_bag_zipper_1_6", kind = "collection", container = "bag_zipper" }
    group:entry { item = "meth", count = { 1, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crack_bag_zipper_1_4", kind = "collection", container = "bag_zipper" }
    group:entry { item = "crack", count = { 1, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "heroin_bag_zipper_4", kind = "collection", container = "bag_zipper" }
    group:entry { item = "heroin", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "heroin_bag_zipper_1_4", kind = "collection", container = "bag_zipper" }
    group:entry { item = "heroin", count = { 1, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coke_bag_zipper_1_8", kind = "collection", container = "bag_zipper" }
    group:entry { item = "coke", count = { 1, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lsd_bag_zipper_1_5", kind = "collection", container = "bag_zipper" }
    group:entry { item = "lsd", count = { 1, 5 } }
    content.add(group)
end
