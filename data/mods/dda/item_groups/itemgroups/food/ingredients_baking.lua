local content = require("ccb").content

do
    local group = content.ItemGroup { id = "flour_various", kind = "distribution" }
    group:group("flour_bottle_plastic", 6)
    group:group("flour_bottle_glass", 6)
    group:group("flour_bag_plastic", 12)
    group:group("flour_bag_paper", 6)
    group:group("flour_wheat_free_bottle_plastic", 1)
    group:group("flour_wheat_free_bottle_glass", 1)
    group:group("flour_wheat_free_bag_plastic", 2)
    group:group("flour_wheat_free_bag_paper", 2)
    group:group("bread_flour_bag_plastic", 3)
    group:group("bread_flour_bag_paper", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_various_full", kind = "distribution" }
    group:group("flour_bag_plastic_full", 6)
    group:group("flour_bag_paper_full", 9)
    group:group("flour_wheat_free_bag_plastic_full", 1)
    group:group("flour_wheat_free_bag_paper_full", 2)
    group:group("bread_flour_bag_plastic_full", 2)
    group:group("bread_flour_bag_paper_full", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bulk", kind = "distribution" }
    group:group("flour_bag_plastic", 1)
    group:group("flour_bag_paper", 5)
    group:group("flour_bag_paper_bulk", 3)
    group:group("flour_bag_paper_50lb", 3)
    group:group("flour_wheat_free_bag_plastic", 1)
    group:group("flour_wheat_free_bag_paper", 2)
    group:group("flour_wheat_free_bag_paper_bulk", 1)
    group:group("flour_wheat_free_bag_paper_50lb", 1)
    group:group("bread_flour_bag_plastic", 1)
    group:group("bread_flour_bag_paper", 5)
    group:group("bread_flour_bag_paper_bulk", 3)
    group:group("bread_flour_bag_paper_50lb", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bag_plastic_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "flour", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "flour", count = { 100, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "flour_wheat_free_bag_plastic_full",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "flour_wheat_free", count = { 16, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "flour_wheat_free_bag_paper_full",
        kind = "collection",
        container = "bag_paper_powder",
    }
    group:entry { item = "flour_wheat_free", count = { 60, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_flour_bag_plastic_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "bread_flour", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_flour_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "bread_flour", count = { 16, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bottle_plastic", kind = "collection", container = "bottle_plastic_seasoning" }
    group:entry { item = "flour", count = { 2, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bottle_glass", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "flour", count = { 2, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "flour", count = { 10, 100 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bag_paper_bulk", kind = "collection", container = "bag_paper_powder_bulk" }
    group:entry { item = "flour", count = { 10, 400 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "flour", count = { 2, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bag_paper_50lb", kind = "collection", container = "bag_paper_powder_50lb" }
    group:entry { item = "flour", count = { 10, 1850 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "flour_wheat_free_bottle_plastic",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "flour_wheat_free", count = { 2, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "flour_wheat_free_bottle_glass",
        kind = "collection",
        container = "bottle_glass_seasoning",
    }
    group:entry { item = "flour_wheat_free", count = { 2, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_wheat_free_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "flour_wheat_free", count = { 5, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "flour_wheat_free_bag_paper_bulk",
        kind = "collection",
        container = "bag_paper_powder_bulk",
    }
    group:entry { item = "flour_wheat_free", count = { 5, 260 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_wheat_free_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "flour_wheat_free", count = { 2, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "flour_wheat_free_bag_paper_50lb",
        kind = "collection",
        container = "bag_paper_powder_50lb",
    }
    group:entry { item = "flour_wheat_free", count = { 5, 1200 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_flour_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "bread_flour", count = { 2, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_flour_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "bread_flour", count = { 1, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "bread_flour_bag_paper_bulk",
        kind = "collection",
        container = "bag_paper_powder_bulk",
    }
    group:entry { item = "bread_flour", count = { 2, 65 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "bread_flour_bag_paper_50lb",
        kind = "collection",
        container = "bag_paper_powder_50lb",
    }
    group:entry { item = "bread_flour", count = { 2, 300 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_bag_50", kind = "collection", container = "bag_plastic" }
    group:entry { item = "flour", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_flour_bag_50", kind = "collection", container = "bag_plastic" }
    group:entry { item = "bread_flour", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flour_wheat_free_bag_50", kind = "collection", container = "bag_plastic" }
    group:entry { item = "flour_wheat_free", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "tortilla_flour_bag_plastic_full",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "tortilla_flour", count = { 25, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_various", kind = "distribution" }
    group:group("yeast_bottle_plastic_small", 18)
    group:group("yeast_bottle_glass_small", 18)
    group:group("yeast_bottle_plastic", 2)
    group:group("yeast_bottle_glass", 2)
    group:group("yeast_bag_plastic", 4)
    group:group("yeast_bag_paper", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_various_full", kind = "distribution" }
    group:group("yeast_bottle_plastic_small_full", 10)
    group:group("yeast_bottle_glass_small_full", 10)
    group:group("yeast_bottle_plastic_full", 4)
    group:group("yeast_bottle_glass_full", 4)
    group:group("yeast_bag_plastic_full", 1)
    group:group("yeast_bag_paper_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bulk", kind = "distribution" }
    group:group("yeast_bottle_plastic", 20)
    group:group("yeast_bottle_glass", 20)
    group:group("yeast_bag_plastic", 5)
    group:group("yeast_bag_paper", 10)
    group:group("yeast_bag_paper_bulk", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "yeast_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "yeast", count = { 25, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "yeast_bottle_glass_small_full",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "yeast", count = { 25, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "yeast_bottle_plastic_full",
        kind = "collection",
        container = "bottle_plastic_seasoning",
    }
    group:entry { item = "yeast", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bottle_glass_full", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "yeast", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bag_plastic_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "yeast", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bag_10", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "yeast", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bag_paper_full", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "yeast", count = { 180, 180 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "yeast_bottle_plastic_small",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "yeast", count = { 5, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "yeast_bottle_glass_small",
        kind = "collection",
        container = "bottle_glass_seasoning_small",
    }
    group:entry { item = "yeast", count = { 5, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bottle_plastic", kind = "collection", container = "bottle_plastic_seasoning" }
    group:entry { item = "yeast", count = { 5, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bottle_glass", kind = "collection", container = "bottle_glass_seasoning" }
    group:entry { item = "yeast", count = { 5, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bag_plastic", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "yeast", count = { 5, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bag_paper", kind = "collection", container = "bag_paper_powder" }
    group:entry { item = "yeast", count = { 20, 180 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yeast_bag_paper_bulk", kind = "collection", container = "bag_paper_powder_bulk" }
    group:entry { item = "yeast", count = { 20, 1000 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cornmeal_box_full", kind = "collection", container = "box_small" }
    group:entry { item = "cornmeal", count = { -1, -1 }, container = "null" }
    content.add(group)
end
