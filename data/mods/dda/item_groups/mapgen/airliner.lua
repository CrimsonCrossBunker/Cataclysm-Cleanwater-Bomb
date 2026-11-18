local content = require("ccb").content

do
    local group = content.ItemGroup { id = "airliner_luggage", kind = "collection" }
    group:entry { group = "allclothes", count = { 3, 7 } }
    group:group("shoes", 30)
    group:group("glasses", 10)
    group:group("magazines", 10)
    group:group("bags_trip")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airliner_cockpit", kind = "collection" }
    group:item("crash_axe")
    group:entry {
        collection = {
            { item = "flaregun" },
            { item = "signal_flare", count = { 1, 2 } },
        },
        probability = 40,
    }
    group:group("full_1st_aid", 40)
    group:entry { item = "handflare", count = { 1, 3 }, charges = { 300, 300 }, probability = 30 }
    group:item("sm_extinguisher", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airliner_galley", kind = "collection" }
    group:group("full_1st_aid", 40)
    group:entry { item = "handflare", count = { 1, 3 }, charges = { 300, 300 }, probability = 30 }
    group:item("sm_extinguisher", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airliner_debris", kind = "distribution" }
    group:item("scrap", 30)
    group:item("ch_steel_chunk", 20)
    group:item("ch_steel_lump", 10)
    group:item("sheet_metal_small", 10)
    group:item("sheet_metal", 5)
    content.add(group)
end
