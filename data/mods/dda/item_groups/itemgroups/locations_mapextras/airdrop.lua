local content = require("ccb").content

do
    local group = content.ItemGroup { id = "airdrop_humanitarian_full", kind = "collection" }
    group:entry { group = "protein_bar_wrapped_box", count = { 3, 8 } }
    group:entry {
        distribution = {
            { group = "bottle_pur_tablets" },
            { group = "twoliter_water_batch", count = { 3, 8 } },
        },
    }
    group:group("disinfectant_bottle", 25)
    group:entry { group = "toilet_paper_packed", count = { 3, 4 }, probability = 50 }
    group:entry { group = "soap_packed", count = { 1, 4 }, probability = 50 }
    group:group("toothbrush_packed", 25)
    group:group("airdrop_tent", 25)
    group:group("emer_blanket_box", 50)
    group:group("bandages_box", 25)
    group:entry { item = "cardboard", count = { 1200, 1700 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airdrop_humanitarian_looted", kind = "collection" }
    group:entry { group = "full_box_of_evacuation_protein_bar", count = { 1, 8 }, probability = 60 }
    group:entry { item = "toilet_paper", count = { 0, 10 }, probability = 50 }
    group:entry { group = "soap_packed", count = { 0, 1 }, probability = 50 }
    group:entry { item = "large_tent_kit", count = { 0, 3 }, probability = 50 }
    group:entry { item = "emer_blanket", count = { 0, 7 }, probability = 75 }
    group:entry { item = "cardboard", count = { 1200, 1700 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_wrapped_box", kind = "collection", container = "box_medium" }
    group:entry { group = "full_box_of_evacuation_protein_bar", count = { 8, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bottle_pur_tablets", kind = "collection", container = "box_small" }
    group:entry { group = "pur_tablets_bottle_plastic_small_50", count = { 8, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "twoliter_water_batch", kind = "collection", container = "shrink_wrap" }
    group:entry { item = "water_clean", count = { 6, 6 }, charges = { 8, 8 }, container = "bottle_twoliter" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "disinfectant_bottle", kind = "collection", container = "box_small" }
    group:entry { item = "disinfectant", count = { 8, 8 }, charges = { 10, 10 }, container = "bottle_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toilet_paper_packed", kind = "collection" }
    group:entry { item = "toilet_paper", count = { 24, 24 }, container = "bag_plastic" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soap_packed", kind = "collection", container = "box_small" }
    group:entry { item = "soap", count = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toothbrush_packed", kind = "collection", container = "box_small" }
    group:entry { item = "toothbrush_plain", count = { 10, 10 } }
    group:entry { item = "plastic_chunk", count = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airdrop_tent", kind = "collection", container = "box_large" }
    group:entry { item = "large_tent_kit", count = { 15, 15 } }
    group:entry { item = "cardboard", count = { 504, 504 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "emer_blanket_box", kind = "collection", container = "box_medium" }
    group:entry { item = "emer_blanket", count = { 40, 40 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandages_box", kind = "collection", container = "box_medium" }
    group:entry { item = "bandages", count = { 250, 270 } }
    content.add(group)
end

do
    -- This is a small diesel generator, outputting ~1.3kW. It is not military spec, but it is the only generator we have. Should be replaced with milspec 5kW generator item in the future
    -- yes, they should be 50-75% full, according to FM 10-535.
    local group = content.ItemGroup { id = "airdrop_generator", kind = "collection" }
    group:entry { item = "jp8", charges = { 10000, 15000 }, container = "diesel_generator" }
    group:item("standing_directed_floodlight")
    group:entry { item = "jp8", count = { 5, 5 }, charges = { 19000, 20000 }, container = "jerrycan_big" }
    group:entry { item = "cardboard", count = { 1200, 1700 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "airdrop_trash", kind = "collection", container = "box_medium", overflow = "spill" }
    group:entry {
        item = "paper",
        count = { 5, 15 },
        flags = {
            "FILTHY",
        },
    }
    group:entry { item = "cardboard", count = { 100, 210 } }
    group:entry { item = "shrink_wrap", count = { 2, 8 } }
    group:entry { item = "bottle_twoliter", count = { 3, 11 } }
    group:entry { item = "plastic_chunk", count = { 10, 30 } }
    group:entry { item = "bottle_plastic_small", count = { 0, 4 }, probability = 50 }
    content.add(group)
end
