local content = require("ccb").content

do
    -- This list tracks the things that Smokes will sell the player.
    -- As a general rule of thumb, Smokes should stock tools, spare parts, and other stuff that scavengers bring in; they canonically have a surplus that they trade for food.
    -- Speaking of food, Smokes shouldn't ever offer food!  At the moment they need all the stuff they can get.
    -- Smokes offers the following things:
    -- - A large quantity of merch, always available;
    -- - A guaranteed handful of welding gear, like you might find on a garage rack;
    -- - Huge quantities of spare parts, such as solder, thread, nails, tailoring supplies, and so on;
    -- - Civilian-grade ammo;
    -- - Small quantities of low-end melee weapons, with a chance for civilian-grade guns;
    -- - A selection of men's and women's clothing;
    -- - A lot of assorted tools and other hardware.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop", kind = "collection" }
    group:entry { item = "FMCNote", count = { 200, 300 } }
    group:entry { item = "money_strap_FMCNote", count = { 1, 3 } }
    group:entry { group = "SUS_welding_gear", count = { 1, 2 } }
    group:entry { group = "FREE_MERCHANTS_Shop_Parts_Generic", count = { 40, 50 } }
    group:entry { group = "FREE_MERCHANTS_Shop_Parts_Tailoring", count = { 5, 8 } }
    group:entry { group = "FREE_MERCHANTS_Shop_Parts_Mechanics", count = { 5, 8 } }
    group:entry { item = "tire_repair_kit", count = { 1, 2 }, probability = 60 }
    group:entry { group = "FREE_MERCHANTS_Shop_Weapons_Ammo", count = { 2, 4 } }
    group:group("FREE_MERCHANTS_Shop_Weapons_Guns", 75)
    group:group("FREE_MERCHANTS_Shop_Weapons_Melee")
    group:entry { group = "FREE_MERCHANTS_Shop_Clothes", count = { 1, 2 } }
    group:group("FREE_MERCHANTS_Shop_Hardware")
    content.add(group)
end

do
    -- Generic spare parts that can be used in a lot of different places, like nails and such. Thread is included here due to how it's used a lot even outside of tailoring.
    -- Also includes duct tape, but it's useful to them too, not just outsiders. They won't sell as much of it as other crafting goods. Same goes for superglue.
    -- To a lesser degree, this also includes building materials, but not that many.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop_Parts_Generic", kind = "distribution" }
    group:entry { group = "solder_wire_spool", count = { 2, 5 } }
    group:entry { item = "thread", charges = { 100, 240 } }
    group:entry { item = "nail", charges = { 80, 100 } }
    group:group("duct_tape_roll_part")
    group:entry { group = "glue_strong_professional", count = { 0, 1 } }
    group:entry { group = "glue_weak_professional", count = { 0, 1 } }
    group:entry { item = "glass_shard", count = { 150, 200 } }
    group:entry { item = "clay_lump", count = { 2, 3 } }
    group:entry { item = "splinter", count = { 5, 7 } }
    group:entry { item = "2x4", count = { 1, 3 } }
    content.add(group)
end

do
    -- Random tailoring parts, including rags, cloth sheets, and fasteners.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop_Parts_Tailoring", kind = "distribution" }
    group:entry { item = "cotton_patchwork", count = { 5, 10 }, probability = 40 }
    group:entry { group = "SUS_tailoring_materials", count = { 1, 2 } }
    group:entry { group = "SUS_tailoring_fasteners", count = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "welding_rod_steel_split", kind = "collection" }
    group:entry { item = "welding_rod_steel", count = { 750, 4000 }, wrapper = "tube_welding_rod" }
    group:entry { item = "welding_rod_steel", count = { 250, 2000 }, wrapper = "tube_welding_rod" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "welding_rod_alloy_split", kind = "collection" }
    group:entry { item = "welding_rod_alloy", count = { 750, 4000 }, wrapper = "tube_welding_rod" }
    group:entry { item = "welding_rod_alloy", count = { 250, 2000 }, wrapper = "tube_welding_rod" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "welding_wire_steel_split", kind = "collection" }
    group:entry { item = "welding_wire_steel", count = { 333, 2000 }, wrapper = "spool_welding" }
    group:entry { item = "welding_wire_steel", count = { 333, 2000 }, wrapper = "spool_welding" }
    group:entry { item = "welding_wire_steel", count = { 333, 2000 }, wrapper = "spool_welding" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "welding_wire_alloy_split", kind = "collection" }
    group:entry { item = "welding_wire_alloy", count = { 500, 3000 }, wrapper = "spool_welding" }
    group:entry { item = "welding_wire_alloy", count = { 500, 3000 }, wrapper = "spool_welding" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "brazing_rod_bronze_split", kind = "collection" }
    group:entry { item = "brazing_rod_bronze", count = { 250, 2000 }, wrapper = "tube_welding_rod" }
    group:entry { item = "brazing_rod_bronze", count = { 250, 2000 }, wrapper = "tube_welding_rod" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "brazing_rod_alloy_split", kind = "collection" }
    group:entry { item = "brazing_rod_alloy", count = { 250, 2000 }, wrapper = "tube_welding_rod" }
    group:entry { item = "brazing_rod_alloy", count = { 250, 2000 }, wrapper = "tube_welding_rod" }
    content.add(group)
end

do
    -- A collection of welding consumables for both steel and aluminum.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop_Parts_Mechanics", kind = "collection" }
    group:entry {
        distribution = {
            { group = "welding_rod_steel_split", probability = 65 },
            { group = "welding_wire_steel_split", probability = 45 },
            { group = "brazing_rod_bronze_split", probability = 25 },
        },
    }
    group:entry {
        distribution = {
            { group = "welding_rod_alloy_split", probability = 35 },
            { group = "welding_wire_alloy_split", probability = 15 },
            { group = "brazing_rod_alloy_split", probability = 10 },
        },
    }
    content.add(group)
end

do
    -- Clothes for both men and women. Distribution chance should be even for both sexes.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop_Clothes", kind = "collection" }
    group:entry { group = "SUS_wardrobe_mens", count = { 0, 1 } }
    group:entry { group = "SUS_wardrobe_womens", count = { 0, 1 } }
    group:entry { group = "SUS_dresser_mens", count = { 0, 1 } }
    group:entry { group = "SUS_dresser_womens", count = { 0, 1 } }
    content.add(group)
end

do
    -- Ammo for common guns. Note that this is a collection - the shop will always stock some quantity of ammo, even if it doesn't carry guns in a given rotation.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop_Weapons_Ammo", kind = "collection" }
    group:entry { group = "ammo_common_boxed", count = { 7, 12 } }
    content.add(group)
end

do
    -- Common weapons. Pistols should be much more common than long weapons, since they're using good weapons for their own defense.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop_Weapons_Guns", kind = "distribution" }
    group:entry { group = "guns_pistol_common", count = { 1, 2 } }
    group:entry { group = "guns_rifle_common", count = { 0, 1 } }
    group:entry { group = "guns_shotgun_common", count = { 0, 1 } }
    content.add(group)
end

do
    -- Low-end melee implements. As with guns, they're using good weapons for themselves, so make sure this doesn't have overly strong ones.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop_Weapons_Melee", kind = "distribution" }
    group:entry { group = "survivor_melee", count = { 3, 5 } }
    content.add(group)
end

do
    -- Tools you might find in a house or construction site. They have a ton of common stuff to go around, and quite a bit of heavy-duty hardware as well.
    -- Groups like home_hw and similar are deliberately excluded here since they spawn things that the merchants would definitely want to hold onto for themselves instead of selling.
    local group = content.ItemGroup { id = "FREE_MERCHANTS_Shop_Hardware", kind = "collection" }
    group:entry { group = "hand_tools", count = { 9, 12 } }
    group:entry { group = "tools_home", count = { 5, 6 } }
    group:entry { group = "tools_construction", count = { 2, 3 } }
    group:entry { group = "hardware_bulk", count = { 4, 5 } }
    group:entry { item = "spray_can", count = { 3, 5 }, charges = { 10, 10 } }
    content.add(group)
end
