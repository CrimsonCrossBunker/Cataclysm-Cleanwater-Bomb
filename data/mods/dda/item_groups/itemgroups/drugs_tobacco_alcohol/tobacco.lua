local content = require("ccb").content

do
    local group = content.ItemGroup { id = "tobacco_products", kind = "distribution" }
    group:group("cig_box_cigarette_1_20", 60)
    group:group("tobacco_bag_plastic_1_20", 20)
    group:group("chaw_wrapper_1_20", 20)
    group:group("nic_pouch_can_opened", 20)
    group:group("nic_pouch_can_new", 10)
    group:entry { item = "cigar", count = { 1, 5 }, probability = 10 }
    group:entry { item = "ecig", count = { 1, 40 }, probability = 10 }
    group:entry { item = "advanced_ecig", charges = { 1, 100 }, probability = 8 }
    group:group("nicotine_liquid_bottle_part", 15)
    group:item("pipe_tobacco", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cigarettes_opened", kind = "distribution" }
    group:entry { item = "cig", count = { 1, 20 }, variant = "cig_basic", container = "null", probability = 40 }
    group:entry { item = "cig", count = { 1, 20 }, variant = "cig_light", container = "null", probability = 25 }
    group:entry { item = "cig", count = { 1, 20 }, variant = "cig_menthol", container = "null", probability = 25 }
    group:entry { item = "cig", count = { 1, 20 }, variant = "cig_gold", container = "null", probability = 7 }
    group:entry { item = "cig", count = { 1, 20 }, variant = "cig_little_cigar", container = "null", probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cigarettes_new", kind = "distribution" }
    group:entry { item = "cig", count = { 20, 20 }, variant = "cig_basic", container = "null", probability = 40 }
    group:entry { item = "cig", count = { 20, 20 }, variant = "cig_light", container = "null", probability = 25 }
    group:entry { item = "cig", count = { 20, 20 }, variant = "cig_menthol", container = "null", probability = 25 }
    group:entry { item = "cig", count = { 20, 20 }, variant = "cig_gold", container = "null", probability = 7 }
    group:entry { item = "cig", count = { 20, 20 }, variant = "cig_little_cigar", container = "null", probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cigar_box_unopened", kind = "collection", container = "box_small_wood" }
    group:entry { item = "cigar", count = { 25, 25 } }
    group:entry { item = "paper", charges = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cigar_box_opened", kind = "collection", container = "box_small_wood" }
    group:entry { item = "cigar", count = { 0, 25 } }
    group:entry { item = "paper", charges = { 2, 2 }, probability = 90 }
    group:entry {
        distribution = {
            { item = "cigar_cutter", probability = 50 },
            { item = "cigar_punch", probability = 50 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chaw_wrapper_20", kind = "collection", container = "wrapper" }
    group:entry { item = "chaw", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chaw_wrapper_1_20", kind = "collection", container = "wrapper" }
    group:entry { item = "chaw", count = { 1, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cig_box_cigarette_20", kind = "collection", container = "box_cigarette" }
    group:group("cigarettes_new")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cig_box_cigarette_1_20", kind = "collection", container = "box_cigarette" }
    group:group("cigarettes_opened")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_small_nicotine_patch_full", kind = "collection", container = "box_small" }
    group:entry { item = "nicotine_patch", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_small_nicotine_patch_1_10", kind = "collection", container = "box_small" }
    group:entry { item = "nicotine_patch", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tobacco_bag_plastic_20", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "tobacco", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tobacco_bag_plastic_1_20", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "tobacco", count = { 1, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nic_pouch_can_opened", kind = "distribution", container = "nic_pouch_can" }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_basic", probability = 20 }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_mint", probability = 15 }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_coffee", probability = 10 }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_citrus", probability = 5 }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_cinnamon", probability = 8 }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_menthol", probability = 10 }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_spearmint", probability = 5 }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_peppermint", probability = 15 }
    group:entry { item = "nic_pouch", count = { 1, 14 }, variant = "nic_pouch_wintergreen", probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nic_pouch_can_new", kind = "distribution", container = "nic_pouch_can" }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_basic", probability = 20 }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_mint", probability = 15 }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_citrus", probability = 5 }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_coffee", probability = 10 }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_cinnamon", probability = 8 }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_menthol", probability = 10 }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_spearmint", probability = 5 }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_peppermint", probability = 15 }
    group:entry { item = "nic_pouch", count = { 15, 15 }, variant = "nic_pouch_wintergreen", probability = 12 }
    content.add(group)
end
