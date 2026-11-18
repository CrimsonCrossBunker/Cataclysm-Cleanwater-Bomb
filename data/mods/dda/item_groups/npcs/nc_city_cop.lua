local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "xanax_bottle_plastic_pill_prescription_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "xanax", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "prozac_bottle_plastic_pill_prescription_15",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "prozac", count = { 15, 15 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "diazepam_bottle_plastic_pill_prescription_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "diazepam", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coke_bag_zipper_8", kind = "collection", container = "bag_zipper" }
    group:entry { item = "coke", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crack_bag_zipper_4", kind = "collection", container = "bag_zipper" }
    group:entry { item = "crack", count = { 4, 4 }, container = "null" }
    content.add(group)
end
