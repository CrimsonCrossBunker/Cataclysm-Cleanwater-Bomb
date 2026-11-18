local content = require("ccb").content

do
    -- items people could have carried in their bags prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_bags", kind = "collection" }
    group:group("default_zombie_items_bags_small")
    group:group("homebooks", 30)
    group:group("alcohol_bottled_canned", 10)
    group:group("vending_drink_items", 10)
    group:entry {
        item = "laptop",
        charges = { 0, 500 },
        contents = {
            { group = "civilian_laptop_efiles" },
        },
        probability = 10,
    }
    group:entry {
        item = "eink_tablet_pc",
        charges = { 0, 50 },
        contents = {
            { group = "civilian_einktablet_efiles" },
        },
        probability = 10,
    }
    group:item("teleumbrella", 10)
    group:item("thermos", 10)
    group:item("spray_can", 10)
    group:entry {
        distribution = {
            { group = "tools_common_small", count = { 1, 2 }, probability = 50 },
            { group = "tools_electronics", probability = 50 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "RPG_die", probability = 70 },
            { item = "dnd_handbook", probability = 30 },
            { item = "metal_RPG_die", probability = 10 },
        },
        probability = 1,
    }
    group:entry {
        distribution = {
            { item = "camera", charges = { 0, 50 }, probability = 40 },
            { item = "camera", charges = { 0, 50 }, container = "camera_bag", probability = 30 },
            { item = "camera_pro", charges = { 0, 50 }, probability = 10 },
            { item = "camera_pro", charges = { 0, 50 }, container = "camera_bag", probability = 20 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- items people could have carried in their small bags prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_bags_small", kind = "collection" }
    group:group("default_zombie_items_pockets", 50)
    group:group("sex_accessories_domestic", 1)
    group:item("file", 10)
    group:entry {
        distribution = {
            { item = "roadmap" },
            { item = "trailmap" },
            { item = "touristmap" },
            { item = "restaurantmap" },
            { item = "urbexmap" },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "talking_doll", charges = { 0, 50 }, probability = 33 },
            { item = "creepy_doll", charges = { 0, 50 }, probability = 33 },
            { item = "straw_doll", probability = 33 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- items that an average zombie carries around and drops on death
    -- any zombie could have died carrying a gun, or holding one
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
    group:group("bugout_bag", 1)
    group:group("default_zombie_items_pockets", 20)
    group:entry {
        distribution = {
            { item = "teargas_sprayer", charges = { 0, 8 }, probability = 10 },
            {
                collection = {
                    { item = "holster" },
                    { group = "guns_pistol_common_everyday_carry", damage = { 0, 2 } },
                },
                probability = 8,
            },
            {
                collection = {
                    { item = "holster" },
                    { item = "tazer", charges = { 0, 100 }, damage = { 0, 2 } },
                },
                probability = 5,
            },
        },
        probability = 2,
    }
    content.add(group)
end
