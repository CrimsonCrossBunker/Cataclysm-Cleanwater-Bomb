local content = require("ccb").content

do
    local group = content.ItemGroup { id = "sourdough_bread_in_bag", kind = "collection" }
    group:entry { item = "sourdough_bread", count = { 1, 14 }, wrapper = "bag_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sourdough_bread_in_bag_full", kind = "collection" }
    group:entry { item = "sourdough_bread", count = { 14, 14 }, wrapper = "bag_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_in_bag", kind = "collection" }
    group:entry { item = "bread", count = { 1, 14 }, wrapper = "bag_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_in_bag_full", kind = "collection" }
    group:entry { item = "bread", count = { 14, 14 }, wrapper = "bag_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "garlic_bread_in_bag", kind = "collection" }
    group:entry { item = "bread_garlic", count = { 1, 8 }, wrapper = "bag_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "garlic_bread_in_bag_full", kind = "collection" }
    group:entry { item = "bread_garlic", count = { 8, 8 }, wrapper = "bag_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "frybread_in_bag", kind = "collection" }
    group:entry { item = "frybread", count = { 1, 8 }, wrapper = "bag_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "frybread_in_bag_full", kind = "collection" }
    group:entry { item = "frybread", count = { 8, 8 }, wrapper = "bag_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cornbread_in_bag", kind = "collection" }
    group:entry { item = "cornbread", count = { 1, 8 }, wrapper = "bag_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cornbread_in_bag_full", kind = "collection" }
    group:entry { item = "cornbread", count = { 8, 8 }, wrapper = "bag_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "tortilla_corn_bag_plastic_full",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "tortilla_corn", count = { 25, 25 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flatbread_in_bag", kind = "collection" }
    group:entry { item = "flatbread", count = { 1, 8 }, wrapper = "bag_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flatbread_in_bag_full", kind = "collection" }
    group:entry { item = "flatbread", count = { 8, 8 }, wrapper = "bag_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "brown_bread_in_bag_full", kind = "collection" }
    group:entry { item = "brown_bread", count = { 10, 10 }, wrapper = "bag_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "brown_bread_in_bag", kind = "collection" }
    group:entry { item = "brown_bread", count = { 0, 10 }, wrapper = "bag_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "brown_bread_can_medium_14",
        kind = "collection",
        container = "can_medium",
        overflow = "discard",
    }
    group:entry { item = "brown_bread", count = { 14, 14 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_wheat_free_bag_plastic_14", kind = "collection", container = "bag_plastic" }
    group:entry {
        item = "bread",
        count = { 14, 14 },
        container = "null",
        components = {
            "flour_wheat_free",
        },
    }
    content.add(group)
end
