local content = require("ccb").content

do
    local group = content.ItemGroup { id = "knifeblock", kind = "distribution" }
    group:item("knife_small", 85, "knife_steak")
    group:item("knife_huge", 10, "knife_butcher")
    group:item("kukri", 1)
    group:item("tongs", 28)
    group:item("meat", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pool_table", kind = "distribution" }
    group:item("pool_cue", 4)
    group:item("pool_ball", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "barrels", kind = "distribution" }
    group:item("wooden_barrel", 30)
    group:item("30gal_barrel", 50)
    group:item("30gal_drum", 45)
    group:item("55gal_drum", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flower_pots", kind = "distribution" }
    group:item("clay_pot_flower", 65)
    group:item("plastic_pot_flower")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flower_pots_broken", kind = "distribution" }
    group:entry { item = "ceramic_shard", count = { 2, 5 }, probability = 65 }
    group:entry { item = "plastic_chunk", count = { 2, 5 } }
    content.add(group)
end

do
    -- something you can find in entertainment center, except the tv
    local group = content.ItemGroup { id = "entertainment_center_loot", kind = "distribution" }
    group:entry { group = "games", count = { 0, 3 }, probability = 40 }
    group:entry { group = "magazines", count = { 0, 6 }, probability = 40 }
    group:entry { group = "newspaper", count = { 1, 2 }, probability = 40 }
    group:entry { group = "homebooks", count = { 0, 2 }, probability = 40 }
    group:entry { group = "novels", count = { 0, 8 }, probability = 40 }
    group:entry { group = "religious_books", count = { 0, 8 }, probability = 40 }
    group:item("stereo", 30)
    group:item("portable_game", 30)
    group:item("battery_charger", 40)
    group:item("extension_cable", 30)
    group:item("microphone_xlr_generic", 20)
    group:item("cable_xlr", 40)
    group:item("cable_speaker", 20)
    group:item("headphones_circumaural", 10)
    group:item("cable_instrument", 5)
    content.add(group)
end
