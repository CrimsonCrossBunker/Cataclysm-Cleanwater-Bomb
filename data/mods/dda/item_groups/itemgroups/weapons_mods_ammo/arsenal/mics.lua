local content = require("ccb").content

do
    local group = content.ItemGroup { id = "arsenal_mics_group", kind = "distribution" }
    group:entry { group = "arsenal_mics_carrying", count = { 1, 4 }, probability = 80 }
    group:group("arsenal_mics_rare", 10)
    group:entry { group = "arsenal_mics_mods", count = { 1, 2 }, probability = 25 }
    group:entry { group = "full_ifak", count = { 1, 2 }, probability = 80 }
    group:entry { group = "arsenal_mics_tools", count = { 1, 4 } }
    group:item("large_repairkit", 2)
    group:item("small_repairkit", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arsenal_mics_tools", kind = "distribution" }
    group:item("pipe_cleaner")
    group:item("binoculars")
    group:entry { item = "two_way_radio", count = { 2, 2 } }
    group:item("flashlight")
    group:entry { item = "light_battery_cell", count = { 1, 3 } }
    group:item("mask_gas")
    group:entry { item = "gasfilter_med", count = { 1, 3 } }
    content.add(group)
end

do
    -- decided to left this groups here, so it would be easier to improve this part in the future
    local group = content.ItemGroup { id = "arsenal_mics_carrying", kind = "distribution" }
    group:group("molle_backpacks_and_accessories")
    group:group("loaded_lbv")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arsenal_mics_rare", kind = "distribution" }
    group:item("goggles_nv")
    group:item("goggles_ir")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "arsenal_mics_mods",
        kind = "collection",
        container = "ammunition_can_30",
        overflow = "spill",
    }
    group:entry { item = "bubblewrap", count = { 2, 2 } }
    group:entry { group = "gunmod_collection", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gunmod_collection", kind = "distribution" }
    group:group("gunmod_rare")
    group:group("gunmod_milspec")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_guns&ammo_or_leftovers", kind = "collection" }
    group:group("milspec_arsenal_group_guns&mags&cans", 20)
    group:group("arsenal_empty_cans")
    group:group("arsenal_leftovers", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arsenal_empty_cans", kind = "distribution" }
    group:entry { item = "ammunition_can_30", count = { 2, 5 } }
    group:entry { item = "ammunition_can_50", count = { 1, 4 } }
    group:entry { item = "ammunition_can_fat_50", count = { 1, 4 } }
    content.add(group)
end

do
    -- represent small amount of stuff that were left in locker while active using.
    local group = content.ItemGroup { id = "arsenal_leftovers", kind = "collection" }
    group:entry { item = "bubblewrap", count = { 0, 2 }, probability = 80 }
    group:entry { group = "arsenal_mics_tools", count = { 0, 2 }, probability = 80 }
    group:entry { group = "arsenal_mics_group", count = { 0, 1 }, probability = 50 }
    group:entry { group = "arsenal_armor+plates", count = { 0, 1 }, probability = 20 }
    content.add(group)
end
