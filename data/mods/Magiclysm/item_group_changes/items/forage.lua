local content = require("ccb").content

do
    local group = content.ItemGroup { id = "forage_spring", kind = "distribution" }
    group:entry { item = "whiskflower", count = { 1, 2 }, probability = 30 }
    group:entry { item = "olieribos", count = { 1, 3 }, probability = 10 }
    group:entry { item = "kampuch", count = { 1, 4 }, probability = 11 }
    group:entry { item = "wood_barnacle", count = { 1, 4 }, probability = 2 }
    group:entry { item = "horn_moss_capsule", count = { 1, 1 }, probability = 1 }
    group:entry { item = "dragon_nail", count = { 1, 4 }, probability = 6 }
    group:entry { item = "moly_tuber", count = { 1, 2 }, probability = 6 }
    group:entry { item = "fern_flower", count = { 1, 1 }, probability = 2 }
    group:entry { item = "glowing_mushroom", count = { 1, 2 }, probability = 4 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "forage_summer", kind = "distribution" }
    group:entry { item = "whiskflower", count = { 1, 2 }, probability = 30 }
    group:entry { item = "olieribos", count = { 1, 3 }, probability = 10 }
    group:entry { item = "kampuch", count = { 1, 4 }, probability = 11 }
    group:entry { item = "wood_barnacle", count = { 1, 4 }, probability = 2 }
    group:entry { item = "dragon_nail", count = { 1, 4 }, probability = 6 }
    group:entry { item = "moly_tuber", count = { 1, 2 }, probability = 6 }
    group:entry { item = "fern_flower", count = { 1, 1 }, probability = 2 }
    group:entry { item = "glowing_mushroom", count = { 1, 2 }, probability = 4 }
    group:entry { item = "funnelcap_chunk", count = { 10, 25 }, probability = 7 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "forage_autumn", kind = "distribution" }
    group:entry { item = "whiskflower", count = { 1, 2 }, probability = 30 }
    group:entry { item = "olieribos", count = { 1, 3 }, probability = 10 }
    group:entry { item = "kampuch", count = { 1, 4 }, probability = 11 }
    group:entry { item = "wood_barnacle", count = { 1, 4 }, probability = 2 }
    group:entry { item = "dragon_nail", count = { 1, 4 }, probability = 6 }
    group:entry { item = "moly_tuber", count = { 1, 2 }, probability = 6 }
    group:entry { item = "fern_flower", count = { 1, 1 }, probability = 2 }
    group:entry { item = "glowing_mushroom", count = { 1, 2 }, probability = 4 }
    group:entry { item = "funnelcap_chunk", count = { 10, 25 }, probability = 7 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "foraging_faction_camp_spring", kind = "distribution" }
    group:entry { item = "golden_reed_stalk", count = { 1, 4 }, probability = 1 }
    group:entry { item = "platonic_flower", count = { 1, 1 }, probability = 4 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "foraging_faction_camp_summer", kind = "distribution" }
    group:entry { item = "golden_reed_stalk", count = { 1, 4 }, probability = 1 }
    group:entry { item = "platonic_flower", count = { 1, 1 }, probability = 4 }
    group:entry { item = "sojourners_flower", count = { 1, 5 }, probability = 2 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "foraging_faction_camp_autumn", kind = "distribution" }
    group:entry { item = "golden_reed_stalk", count = { 1, 4 }, probability = 1 }
    group:entry { item = "platonic_flower", count = { 1, 1 }, probability = 4 }
    group:entry { item = "sojourners_flower", count = { 1, 5 }, probability = 2 }
    content.extend_item_group(group)
end
