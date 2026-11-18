local content = require("ccb").content

do
    -- Overwriting itemgroups so they stop trying to put ammo into blacklisted guns
    local group = content.ItemGroup { id = "nested_axmc_retool_300win", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { group = "ar15_223long", charges = { 0, 30 }, probability = 8 },
            { group = "ar15_223medium", charges = { 0, 30 }, probability = 8 },
            { group = "ar15_223short", charges = { 0, 30 }, probability = 6 },
        },
    }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "new_laptops", kind = "distribution" }
    group:item("null", 50)
    group:entry { item = "laptop", charges = { 200, 200 }, probability = 1 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "used_laptops", kind = "distribution" }
    group:item("null", 50)
    group:entry { item = "laptop", charges = { 0, -1 }, probability = 1 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "civilian_laptops", kind = "distribution" }
    group:item("null", 50)
    group:entry {
        item = "laptop",
        charges = { 0, -1 },
        contents = {
            { group = "civilian_laptop_efiles" },
        },
    }
    content.replace(group)
end

do
    -- Removed smartwatches, increase normal watch chance, reduce game watch chance
    local group = content.ItemGroup { id = "clothing_watch", kind = "distribution" }
    group:item("wristwatch", 180)
    group:item("silver_watch", 70)
    group:item("gold_watch", 40)
    group:item("platinum_watch", 10)
    group:item("sf_watch", 5)
    group:item("calculator_watch", 5)
    group:item("pocketwatch", 5)
    group:item("diving_watch", 20)
    group:entry { item = "game_watch", charges = { 0, 50 }, probability = 1 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "default_zombie_children_clothes", kind = "collection" }
    group:entry { group = "clothing_watch", damage = { 1, 4 }, probability = 5 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "default_zombie_clothes", kind = "collection" }
    group:entry { group = "clothing_watch", damage = { 1, 4 }, probability = 25 }
    content.extend_item_group(group)
end
