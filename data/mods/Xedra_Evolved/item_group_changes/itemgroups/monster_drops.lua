local content = require("ccb").content

do
    local group = content.ItemGroup { id = "harddrugs", kind = "distribution" }
    group:entry { item = "faewild", count = { 3, 12 }, wrapper = "bag_zipper", container = "null", probability = 15 }
    group:entry { item = "lotus_blossom", count = { 2, 16 }, wrapper = "bag_zipper", container = "null", probability = 15 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "default_zombie_children_clothes", kind = "collection" }
    group:entry { item = "wyld_candy", sealed = false, wrapper = "wrapper_wyld", container = "null", probability = 15 }
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 35 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "default_zombie_items_pockets", kind = "collection" }
    group:entry { item = "faewild", count = { 3, 12 }, wrapper = "bag_zipper", container = "null", probability = 5 }
    group:entry { item = "lotus_blossom", count = { 2, 16 }, wrapper = "bag_zipper", container = "null", probability = 5 }
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 15 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_scientist_death_drops", kind = "collection" }
    group:group("xe_datacores", 3)
    content.extend_item_group(group)
end
