local content = require("ccb").content

do
    -- Nested group to damage the container-item
    local group = content.ItemGroup { id = "map_extra_science", kind = "collection" }
    group:entry { group = "map_extra_science_corpse", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_college_camping", kind = "collection" }
    group:entry { group = "map_extra_college_camping_corpse", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_college_sports", kind = "collection" }
    group:entry { group = "map_extra_college_sports_corpse", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_college_lake", kind = "collection" }
    group:entry { group = "map_extra_college_lake_corpse", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "map_extra_college_lake_corpse",
        kind = "collection",
        container = "corpse_generic_human",
    }
    group:entry { group = "underwear", damage = { 1, 3 } }
    group:entry { group = "shirts", damage = { 1, 4 } }
    group:entry { group = "jackets", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "pants", damage = { 1, 4 } }
    group:entry { group = "socks_unisex", damage = { 1, 4 } }
    group:entry { group = "shoes", damage = { 1, 4 } }
    group:entry { group = "hatstore_hats", damage = { 1, 4 }, probability = 40 }
    group:group("college_lake", 50)
    group:group("college_lake", 70)
    group:group("SUS_book_nonf_soft", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_drugdeal", kind = "collection" }
    group:entry { group = "map_extra_drugdeal_corpse", damage = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_drugdeal_corpse", kind = "collection", container = "corpse_generic_human" }
    group:group("drugdealer", 75)
    group:entry {
        distribution = {
            { item = "weed", count = { 20, 30 }, wrapper = "bag_zipper", container = "null", probability = 10 },
            { item = "coke", count = { 10, 20 }, wrapper = "bag_zipper", container = "null", probability = 40 },
            { item = "meth", count = { 8, 14 }, wrapper = "bag_zipper", container = "null", probability = 30 },
            { item = "heroin", count = { 6, 12 }, wrapper = "bag_zipper", container = "null", probability = 20 },
        },
        probability = 50,
    }
    group:entry { item = "pants_cargo", damage = { 1, 4 } }
    group:entry { group = "socks_unisex", damage = { 1, 4 } }
    group:entry { group = "lab_shoes", damage = { 1, 4 }, probability = 50 }
    group:entry { group = "shirts", damage = { 1, 4 }, probability = 50 }
    group:entry { group = "jackets", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "underwear", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_police", kind = "collection" }
    group:entry { group = "map_extra_police_corpse", damage = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_police_corpse", kind = "collection", container = "corpse_generic_human" }
    group:group("mon_zombie_cop_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_showdown_victim", kind = "collection" }
    group:entry { group = "map_extra_showdown_victim_corpse", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "map_extra_showdown_victim_corpse",
        kind = "collection",
        container = "corpse_generic_human",
    }
    group:entry { group = "underwear", damage = { 1, 3 } }
    group:entry { group = "shirts", damage = { 1, 4 } }
    group:entry { group = "jackets", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "pants", damage = { 1, 4 } }
    group:entry { group = "socks_unisex", damage = { 1, 4 } }
    group:entry { group = "shoes", damage = { 1, 4 } }
    group:entry { group = "hatstore_hats", damage = { 1, 4 }, probability = 40 }
    group:group("guns_pistol_common_everyday_carry", 30)
    group:entry {
        distribution = {
            { group = "guns_rifle_common_worn", probability = 50 },
            { group = "12_gauge_pump_display", probability = 50 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_dermatik_victim_itemgroup", kind = "collection" }
    group:entry { group = "default_zombie_death_drops", damage = { 1, 3 } }
    group:entry { item = "corpse_dermatik_victim", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_casings", kind = "distribution" }
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
    }
    group:item("cigar_butt")
    group:item("cig_butt")
    group:item("can_drink")
    content.add(group)
end
