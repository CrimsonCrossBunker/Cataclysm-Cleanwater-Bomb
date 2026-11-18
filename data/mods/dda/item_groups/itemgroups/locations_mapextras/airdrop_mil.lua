local content = require("ccb").content

do
    local group = content.ItemGroup { id = "airdrop_water_drum", kind = "distribution" }
    group:entry { item = "water_clean", charges = { 700, 800 }, container = "55gal_drum_rubber" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airdrop_military_kit", kind = "collection" }
    group:entry { group = "airdrop_MRE", count = { 1, 4 }, probability = 60 }
    group:entry { group = "airdrop_IFAK", count = { 1, 2 }, probability = 50 }
    group:entry { group = "airdrop_water_canteen", count = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airdrop_water_canteen", kind = "collection", container = "box_medium" }
    group:entry { item = "water_clean", count = { 10, 10 }, charges = { 6, 6 }, container = "canteen" }
    group:entry { item = "cardboard", count = { 30, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airdrop_IFAK", kind = "collection", container = "box_medium" }
    group:entry { group = "full_ifak", count = { 10, 10 } }
    group:entry { item = "cardboard", count = { 9, 9 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airdrop_MRE", kind = "collection", container = "box_medium" }
    group:entry { group = "MRE", count = { 10, 10 } }
    group:entry { item = "cardboard", count = { 13, 13 } }
    content.add(group)
end
