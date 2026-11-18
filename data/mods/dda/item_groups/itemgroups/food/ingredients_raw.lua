local content = require("ccb").content

do
    local group = content.ItemGroup { id = "box_spaghetti_1lb", kind = "collection", container = "box_snack" }
    group:entry { item = "spaghetti_raw", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_lasagne_1lb", kind = "collection", container = "box_small" }
    group:entry { item = "lasagne_raw", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_macaroni_1lb", kind = "collection", container = "box_snack" }
    group:entry { item = "macaroni_raw", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_macncheese", kind = "collection", container = "box_snack" }
    group:entry { item = "macaroni_raw", count = { 6, 6 }, container = "null" }
    group:entry { item = "cheese_powder", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spaghetti_raw_bag_30", kind = "collection", container = "bag_plastic" }
    group:entry { item = "spaghetti_raw", count = { 30, 30 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lasagne_raw_bag_30", kind = "collection", container = "bag_plastic" }
    group:entry { item = "lasagne_raw", count = { 30, 30 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "noodles_fast_bag_5", kind = "collection", container = "bag_plastic" }
    group:entry { item = "noodles_fast", count = { 5, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "potato_bag_plastic_1", kind = "collection", container = "bag_canvas" }
    group:entry { item = "potato", count = { 1, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "onion_bag_plastic_1", kind = "collection", container = "bag_canvas" }
    group:entry { item = "onion", count = { 1, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "oatmeal_box_1lb", kind = "collection", container = "box_small" }
    group:entry { item = "oatmeal", count = { 16, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "koji_bag_plastic_25", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "koji", count = { 25, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_rice_various", kind = "distribution" }
    group:group("dry_rice_bag_paper", 10)
    group:group("dry_rice_bag_paper_bulk", 1)
    group:group("dry_rice_bag_plastic_full", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_rice_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "dry_rice", count = { 1, 30 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_rice_bag_paper_bulk", kind = "collection", container = "bag_paper_powder_bulk" }
    group:entry { item = "dry_rice", count = { 1, 120 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_rice_bag_plastic_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "dry_rice", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "dry_wild_rice_bag_plastic_full",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "dry_wild_rice", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cocoa_powder_various", kind = "distribution" }
    group:group("cocoa_powder_bag_plastic", 4)
    group:group("cocoa_powder_bag_paper", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cocoa_powder_various_full", kind = "distribution" }
    group:group("cocoa_powder_bag_paper_full", 2)
    group:group("cocoa_powder_bag_plastic_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cocoa_powder_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "cocoa_powder", count = { 40, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cocoa_powder_bag_plastic_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cocoa_powder", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cocoa_powder_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cocoa_powder", count = { 2, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cocoa_powder_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "cocoa_powder", count = { 5, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_cocoa_powder_various", kind = "distribution" }
    group:group("milk_cocoa_powder_bag_plastic", 4)
    group:group("milk_cocoa_powder_bag_paper", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_cocoa_powder_various_full", kind = "distribution" }
    group:group("milk_cocoa_powder_bag_paper_full", 2)
    group:group("milk_cocoa_powder_bag_plastic_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "milk_cocoa_powder_bag_paper_full",
        kind = "collection",
        container = "bag_paper_powder",
    }
    group:entry { item = "cocoa_powder_milk", count = { 40, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "milk_cocoa_powder_bag_plastic_full",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "cocoa_powder_milk", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_cocoa_powder_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cocoa_powder_milk", count = { 2, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milk_cocoa_powder_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "cocoa_powder_milk", count = { 5, 40 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "powder_eggs_bottle_plastic_small_16",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "powder_eggs", count = { 16, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "lemonade_powder_bottle_plastic_small_10",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "lemonade_powder", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "gelatin_powder_bag_plastic_full",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "gelatin_powder", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "yogurt_starter_culture_bag_plastic_4",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "yogurt_starter_culture", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vegetable_oil_bottle", kind = "distribution" }
    group:entry { item = "cooking_oil", charges = { 0, 20 }, container = "bottle_plastic" }
    group:entry { item = "cooking_oil", charges = { 0, 20 }, container = "bottle_folding" }
    group:entry { item = "cooking_oil", charges = { 0, 80 }, container = "bottle_twoliter" }
    group:entry { item = "cooking_oil", charges = { 0, 150 }, container = "jug_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "oil_bottle_empty", kind = "distribution" }
    group:item("bottle_plastic")
    group:item("bottle_folding")
    group:item("bottle_twoliter")
    group:item("jug_plastic")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_beans_bag_plastic_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "dry_beans", count = { -1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vegetable_oil_bottle_full", kind = "distribution" }
    group:entry { item = "cooking_oil", container_group = "oil_bottle_empty" }
    content.add(group)
end
