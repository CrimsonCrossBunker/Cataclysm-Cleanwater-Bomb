local content = require("ccb").content

do
    local group = content.ItemGroup { id = "foraging_faction_camp_spring", kind = "distribution" }
    group:entry { item = "datura_seed", count = { 2, 5 }, probability = 5 }
    group:entry { item = "raw_dandelion", count = { 1, 4 }, probability = 20 }
    group:entry { item = "raw_burdock", count = { 1, 4 }, probability = 20 }
    group:entry { item = "cattail_stalk", count = { 1, 4 }, probability = 20 }
    group:group("forage_spring", 55)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "foraging_faction_camp_summer", kind = "distribution" }
    group:entry { item = "datura_seed", count = { 2, 5 }, probability = 5 }
    group:entry { item = "raw_dandelion", count = { 1, 4 }, probability = 20 }
    group:entry { item = "raw_burdock", count = { 1, 4 }, probability = 20 }
    group:entry { item = "cattail_stalk", count = { 1, 4 }, probability = 20 }
    group:entry { item = "sunflower", count = { 1, 2 }, probability = 20 }
    group:entry { item = "cherries", count = { 3, 9 }, probability = 30 }
    group:entry { item = "pear", count = { 1, 3 }, probability = 30 }
    group:entry { item = "apricot", count = { 1, 3 }, probability = 30 }
    group:entry { item = "plums", count = { 1, 3 }, probability = 30 }
    group:entry { item = "mulberries", count = { 1, 3 }, probability = 30 }
    group:entry { item = "elderberries", count = { 4, 10 }, probability = 30 }
    group:entry { item = "blueberries", count = { 1, 3 }, probability = 30 }
    group:entry { item = "strawberries", count = { 1, 3 }, probability = 30 }
    group:entry { item = "blackberries", count = { 1, 3 }, probability = 30 }
    group:entry { item = "huckleberries", count = { 1, 3 }, probability = 30 }
    group:entry { item = "raspberries", count = { 1, 3 }, probability = 30 }
    group:entry { item = "grapes", count = { 1, 3 }, probability = 25 }
    group:entry { item = "wild_rice", count = { 2, 4 }, probability = 10 }
    group:group("forage_summer", 250)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "foraging_faction_camp_autumn", kind = "distribution" }
    group:entry { item = "datura_seed", count = { 2, 5 }, probability = 5 }
    group:entry { item = "raw_dandelion", count = { 1, 4 }, probability = 20 }
    group:entry { item = "raw_burdock", count = { 1, 4 }, probability = 20 }
    group:entry { item = "cattail_stalk", count = { 1, 4 }, probability = 20 }
    group:entry { item = "walnut", count = { 2, 6 }, probability = 20 }
    group:entry { item = "butternut", count = { 2, 4 }, probability = 20 }
    group:entry { item = "chestnut", count = { 2, 6 }, probability = 20 }
    group:entry { item = "beech_nuts", count = { 8, 24 }, probability = 20 }
    group:entry { item = "hazelnut", count = { 2, 6 }, probability = 20 }
    group:entry { item = "acorns", count = { 8, 24 }, probability = 20 }
    group:entry { item = "apple", count = { 1, 3 }, probability = 20 }
    group:entry { item = "pear", count = { 1, 3 }, probability = 20 }
    group:entry { item = "coffee_pod", count = { 8, 20 }, probability = 15 }
    group:entry { item = "hickory_nut", count = { 3, 6 }, probability = 20 }
    group:entry { item = "pistachio", count = { 3, 6 }, probability = 20 }
    group:entry { item = "almond", count = { 3, 6 }, probability = 20 }
    group:entry { item = "pecan", count = { 3, 6 }, probability = 20 }
    group:entry { item = "peanut", count = { 3, 6 }, probability = 20 }
    group:group("forage_autumn", 200)
    content.add(group)
end
