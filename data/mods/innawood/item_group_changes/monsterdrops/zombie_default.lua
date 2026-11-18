local content = require("ccb").content

do
    -- items people could have carried in their bags prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_bags", kind = "collection" }
    group:group("default_zombie_items_bags_small")
    group:entry {
        distribution = {
            { group = "tools_common_small", count = { 1, 2 }, probability = 50 },
        },
        probability = 5,
    }
    content.replace(group)
end

do
    -- items people could have carried in their small bags prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_bags_small", kind = "collection" }
    group:group("default_zombie_items_pockets", 50)
    group:entry {
        distribution = {
            { item = "straw_doll", probability = 33 },
        },
        probability = 5,
    }
    content.replace(group)
end

do
    -- items that an average zombie carries around and drops on death
    local group = content.ItemGroup { id = "default_zombie_items", kind = "distribution" }
    group:entry {
        group = "large_bags",
        damage = { 1, 4 },
        contents = {
            { group = "default_zombie_items_bags" },
        },
        probability = 6,
    }
    group:entry {
        group = "small_bags",
        damage = { 1, 4 },
        contents = {
            { group = "default_zombie_items_bags_small" },
        },
        probability = 10,
    }
    group:group("default_zombie_items_pockets", 20)
    content.replace(group)
end
