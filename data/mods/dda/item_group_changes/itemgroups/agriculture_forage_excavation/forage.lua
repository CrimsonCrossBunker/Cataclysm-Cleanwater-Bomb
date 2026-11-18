local content = require("ccb").content

do
    local group = content.ItemGroup { id = "forage_spring", kind = "distribution" }
    group:entry { item = "young_leaves", count = { 1, 4 }, probability = 50 }
    group:entry { item = "plant_stalk", count = { 1, 3 }, probability = 20 }
    group:entry { group = "any_wild_egg", count = { 2, 5 }, probability = 15 }
    group:entry { item = "groundnut", count = { 1, 8 }, probability = 5 }
    group:entry { item = "snail_garden", count = { 1, 3 }, probability = 10 }
    group:entry { item = "wild_garlic", count = { 2, 7 }, probability = 5 }
    group:entry { item = "rhubarb", count = { 2, 5 }, probability = 5 }
    group:entry { item = "wild_herbs", count = { 20, 20 }, probability = 10 }
    group:entry { item = "thyme", count = { 1, 2 }, probability = 5 }
    group:entry { item = "seed_wild_garlic", count = { 1, 2 }, probability = 4 }
    group:entry { item = "seed_canola", count = { 1, 2 }, probability = 5 }
    group:entry { item = "dogbane", count = { 1, 2 }, probability = 5 }
    group:entry { item = "carrot_wild", count = { 3, 6 }, probability = 5 }
    group:entry { item = "raw_asparagus", count = { 3, 6 }, probability = 5 }
    group:entry { item = "bee_balm", count = { 4, 8 }, probability = 5 }
    group:entry { item = "mugwort", count = { 1, 2 }, probability = 5 }
    group:item("swarm_bees", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "forage_summer", kind = "distribution" }
    group:entry { item = "mayapple", count = { 1, 3 }, probability = 10 }
    group:entry { item = "plant_stalk", count = { 1, 3 }, probability = 10 }
    group:entry { item = "groundnut", count = { 1, 6 }, probability = 3 }
    group:group("forage_mushroom", 25)
    group:entry { group = "any_wild_egg", count = { 2, 5 }, probability = 5 }
    group:entry { group = "egg_reptile_forest", count = { 2, 5 }, probability = 5 }
    group:entry { item = "snail_garden", count = { 1, 3 }, probability = 10 }
    group:entry { item = "wild_herbs", count = { 20, 20 }, probability = 20 }
    group:entry { item = "thyme", count = { 1, 3 }, probability = 5 }
    group:item("wild_garlic", 1)
    group:entry { item = "seed_wild_garlic", count = { 1, 6 }, probability = 4 }
    group:entry { item = "seed_canola", count = { 1, 3 }, probability = 10 }
    group:entry { item = "dogbane", count = { 1, 3 }, probability = 10 }
    group:entry { item = "bee_balm", count = { 1, 3 }, probability = 10 }
    group:entry { item = "mugwort", count = { 1, 3 }, probability = 10 }
    group:entry { item = "salsify_raw", count = { 1, 2 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "forage_autumn", kind = "distribution" }
    group:entry { item = "mayapple", count = { 1, 2 }, probability = 8 }
    group:entry { item = "plant_stalk", count = { 1, 3 }, probability = 5 }
    group:entry { item = "groundnut", count = { 1, 9 }, probability = 2 }
    group:group("forage_mushroom", 50)
    group:entry { item = "wild_herbs", count = { 20, 20 }, probability = 10 }
    group:entry { item = "thyme", count = { 1, 3 }, probability = 5 }
    group:item("wild_garlic", 1)
    group:entry { item = "snail_garden", count = { 1, 3 }, probability = 10 }
    group:entry { item = "seed_wild_garlic", count = { 1, 6 }, probability = 4 }
    group:entry { item = "seed_canola", count = { 1, 3 }, probability = 5 }
    group:entry { item = "dogbane", count = { 1, 3 }, probability = 5 }
    group:entry { item = "carrot_wild", count = { 3, 6 }, probability = 5 }
    group:entry { item = "raw_asparagus", count = { 3, 6 }, probability = 5 }
    group:entry { item = "bee_balm", count = { 1, 3 }, probability = 5 }
    group:entry { item = "mugwort", count = { 1, 3 }, probability = 5 }
    group:entry { item = "salsify_raw", count = { 1, 3 }, probability = 5 }
    content.add(group)
end
