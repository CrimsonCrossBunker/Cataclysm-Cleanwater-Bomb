local content = require("ccb").content

do
    local group = content.ItemGroup { id = "skeltal_drops", kind = "distribution" }
    group:item("milk", 9)
    group:item("trumpet", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "powerthirst_flavors", kind = "distribution" }
    group:entry { item = "powerthirst1", charges = { 2, 2 }, container = "rocket_can_drink", probability = 10 }
    group:entry { item = "powerthirst2", charges = { 2, 2 }, container = "rocket_can_drink", probability = 10 }
    group:entry { item = "powerthirst3", charges = { 2, 2 }, container = "rocket_can_drink", probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "party_rocker_death_drop", kind = "collection" }
    group:entry {
        distribution = {
            { item = "speedo", probability = 22 },
            { item = "shorts_denim", probability = 16 },
            { item = "hot_pants", probability = 20 },
            { item = "bikini_bottom_short", probability = 20 },
            { item = "bikini_bottom", probability = 12 },
            { item = "briefs", probability = 5 },
            { item = "trunks", probability = 5 },
        },
    }
    group:entry {
        distribution = {
            { group = "harddrugs", probability = 33 },
        },
    }
    group:entry {
        distribution = {
            { item = "tshirt", variant = "flag_shirt", probability = 6 },
            { item = "bikini_top", probability = 19 },
            { item = "bra", probability = 8 },
            { item = "binder_top", probability = 5 },
            { item = "bikini_top_short", probability = 16 },
            { item = "hoodie", probability = 5 },
            { item = "halter_top", probability = 20 },
            { item = "tshirt_cropped", probability = 21 },
        },
    }
    group:item("sunglasses", 80)
    group:entry {
        distribution = {
            { group = "alcohol", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "mp3", charges = { 0, 100 } },
        },
    }
    group:entry {
        distribution = {
            { item = "lowtops", probability = 80 },
            { item = "bastsandals", probability = 20 },
        },
    }
    group:entry {
        distribution = {
            { group = "jewelry_accessories", probability = 90 },
            { group = "rings_and_things", probability = 90 },
            { group = "rings_and_things", probability = 90 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "party_rocker_death_drop_pipe", kind = "collection" }
    group:entry {
        distribution = {
            { item = "crackpipe", damage = { 1, 3 }, probability = 5 },
            { item = "pipe_glass", damage = { 1, 3 }, probability = 60 },
            { item = "pipe_tobacco", damage = { 2, 4 }, probability = 35 },
        },
    }
    group:entry { group = "party_rocker_death_drop", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "party_rocker_death_drop_bottle", kind = "collection" }
    group:entry {
        distribution = {
            { item = "bottle_metal", damage = { 1, 3 }, probability = 40 },
            { item = "bottle_glass", damage = { 3, 4 }, probability = 40 },
        },
    }
    group:entry { group = "party_rocker_death_drop", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "jackson_drops", kind = "collection" }
    group:item("jacket_leather", 100, "jacket_leather_red")
    group:item("red_jeans")
    group:item("socks")
    group:item("dance_shoes")
    group:item("glove_jackson")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "shia_stuff", kind = "distribution" }
    group:item("knife_small", 3, "knife_steak")
    group:item("ax", 1)
    content.add(group)
end
