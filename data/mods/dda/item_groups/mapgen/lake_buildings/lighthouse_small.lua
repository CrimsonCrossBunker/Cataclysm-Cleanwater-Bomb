local content = require("ccb").content

do
    local group = content.ItemGroup { id = "lighthouse_rainwater", kind = "distribution" }
    group:entry { item = "water_clean", charges = { 50, 200 }, container = "30gal_barrel" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lighthouse_fuel", kind = "distribution" }
    group:entry { item = "diesel", charges = { 0, 50000 }, container = "30gal_drum" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lighthouse_food", kind = "collection", container = "box_medium" }
    group:entry {
        distribution = {
            { item = "can_sardine", count = { 1, 10 } },
            { item = "can_tomato", count = { 1, 10 } },
            { item = "soup_veggy", count = { 1, 10 } },
            { item = "soup_meat", count = { 1, 10 } },
            { item = "soup_chicken", count = { 1, 10 } },
            { item = "soup_mushroom", count = { 1, 10 } },
            { item = "soup_tomato", count = { 1, 10 } },
            { item = "soup_dumplings", count = { 1, 10 } },
            { item = "curry_veggy", count = { 1, 10 } },
            { item = "curry_meat", count = { 1, 10 } },
            { item = "can_corn", count = { 1, 10 } },
            { item = "noodles_fast", count = { 1, 10 } },
        },
        probability = 90,
    }
    group:entry { item = "con_milk", count = { 0, 10 }, probability = 25 }
    group:entry { item = "instant_coffee", count = { 0, 5 }, probability = 50 }
    content.add(group)
end
