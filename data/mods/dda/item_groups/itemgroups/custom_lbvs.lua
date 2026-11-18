local content = require("ccb").content

do
    local group = content.ItemGroup { id = "loaded_lbv", kind = "distribution" }
    group:entry {
        item = "load_bearing_vest",
        contents = {
            { group = "custom_medium_lbv" },
        },
        probability = 60,
    }
    group:entry {
        item = "light_load_bearing_vest",
        contents = {
            { group = "custom_light_lbv" },
        },
        probability = 20,
    }
    group:entry {
        item = "heavy_load_bearing_vest",
        contents = {
            { group = "custom_heavy_lbv" },
        },
        probability = 20,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "loaded_webbing_belt", kind = "collection" }
    group:entry {
        item = "webbing_belt",
        contents = {
            { group = "molle_belt_contents" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "molle_vest_bag_accessories", kind = "collection" }
    group:item("tactical_holster", 5)
    group:entry {
        distribution = {
            { item = "canteen_pouch" },
            { item = "h2o_pouch" },
            { item = "gas_mask_pouch" },
        },
        probability = 10,
    }
    group:group("molle_accessories")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "molle_accessories", kind = "collection" }
    group:entry {
        distribution = {
            { item = "dump_pouch", count = { 1, 2 } },
            { item = "gadget_pouch", count = { 1, 2 } },
            { item = "sustainment_pouch", count = { 1, 2 } },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "tool_pouch" },
            { item = "radio_pouch" },
        },
        probability = 70,
    }
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "grenade_pouch" },
                    { item = "tactical_shotshell_pouch" },
                    { item = "tactical_grenade_pouch", count = { 1, 3 } },
                },
                probability = 70,
            },
            { item = "flashlight_pouch", probability = 40 },
        },
    }
    content.add(group)
end

do
    -- stuff that might be attached to a molle belt
    local group = content.ItemGroup { id = "molle_belt_contents", kind = "collection" }
    group:item("tactical_holster", 60)
    group:entry {
        distribution = {
            { item = "canteen_pouch" },
            { item = "h2o_pouch" },
            { item = "gas_mask_pouch" },
        },
        probability = 70,
    }
    group:entry { group = "molle_accessories", count = { 1, 3 } }
    content.add(group)
end

do
    -- generic spawns for a generic vest
    local group = content.ItemGroup { id = "custom_light_lbv", kind = "collection" }
    group:entry {
        distribution = {
            { item = "chestpouch", count = { 1, 2 } },
            { item = "triple_stacker_pouch" },
        },
    }
    group:entry { group = "molle_vest_bag_accessories", count = { 1, 2 } }
    content.add(group)
end

do
    -- generic spawns for a generic vest
    local group = content.ItemGroup { id = "custom_medium_lbv", kind = "collection" }
    group:entry {
        distribution = {
            { item = "chestpouch", count = { 1, 2 } },
            { item = "triple_stacker_pouch" },
        },
    }
    group:entry { group = "molle_vest_bag_accessories", count = { 1, 3 } }
    content.add(group)
end

do
    -- generic spawns for a generic vest
    local group = content.ItemGroup { id = "custom_heavy_lbv", kind = "collection" }
    group:entry {
        distribution = {
            { item = "chestpouch", count = { 1, 2 } },
            { item = "triple_stacker_pouch", count = { 1, 2 } },
        },
    }
    group:entry { group = "molle_vest_bag_accessories", count = { 1, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "molle_backpacks_and_accessories", kind = "distribution" }
    group:entry {
        item = "molle_pack",
        contents = {
            { group = "molle_backpacks_contents" },
        },
        probability = 70,
    }
    group:entry {
        item = "molle_medium_rucksack",
        contents = {
            { group = "molle_backpacks_contents" },
        },
        probability = 15,
    }
    group:entry {
        item = "molle_large_rucksack",
        contents = {
            { group = "molle_backpacks_contents" },
        },
        probability = 15,
    }
    content.add(group)
end

do
    -- stuff that might be in a molle pack
    local group = content.ItemGroup { id = "molle_backpacks_contents", kind = "collection" }
    group:entry { item = "sustainment_pouch", count = { 1, 2 }, probability = 80 }
    group:item("camelbak", 40)
    group:entry { group = "molle_vest_bag_accessories", count = { 1, 2 } }
    group:item("deployment_bag", 10)
    content.add(group)
end
