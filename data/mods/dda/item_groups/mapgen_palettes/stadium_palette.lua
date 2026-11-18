local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hotdog_fridge", kind = "collection" }
    group:entry { group = "bread_bag_plastic_2", count = { 1, 3 }, probability = 80 }
    group:entry { group = "hotdogs_frozen_bag_plastic_10", count = { 1, 10 }, probability = 60 }
    group:entry { item = "bratwurst_sausage", count = { 10, 40 }, probability = 20 }
    group:entry { group = "corndogs_frozen_bag_plastic_2", count = { 1, 10 }, probability = 70 }
    group:entry { item = "onion", count = { 1, 8 }, probability = 45 }
    group:entry { item = "ketchup", count = { 1, 3 }, probability = 55 }
    group:entry { item = "mustard", count = { 1, 3 }, probability = 55 }
    group:entry { item = "horseradish", count = { 1, 2 }, probability = 33 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "baseball_souvenir", kind = "collection" }
    group:entry { item = "tshirt", count = { 1, 12 }, variant = "baseball_fan_tshirt", probability = 60 }
    group:entry { item = "hat_ball", count = { 1, 12 }, variant = "baseball_fan_hatball", probability = 80 }
    group:entry { item = "helmet_ball", count = { 1, 2 }, probability = 11 }
    group:entry { item = "baseball", count = { 1, 2 }, probability = 11 }
    group:entry { item = "bat", count = { 1, 2 }, probability = 11 }
    group:entry { item = "armguard_soft", count = { 1, 2 }, probability = 11 }
    group:entry { item = "legguard_hard", count = { 1, 2 }, probability = 11 }
    group:entry { item = "book_nonf_soft_sports_lads", count = { 1, 2 }, probability = 3 }
    group:entry { item = "mag_bashing", count = { 1, 2 }, probability = 5 }
    group:entry { item = "book_fict_soft_sports_bunt", count = { 1, 2 }, probability = 2 }
    group:entry { item = "novel_sports", count = { 1, 3 }, probability = 7 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "football_souvenir", kind = "collection" }
    group:entry { item = "tshirt", count = { 1, 12 }, variant = "football_fan_tshirt", probability = 80 }
    group:entry { item = "hat_ball", count = { 1, 12 }, variant = "football_fan_hatball", probability = 60 }
    group:entry { item = "football", count = { 1, 2 }, probability = 11 }
    group:entry { item = "football_armor", count = { 1, 2 }, probability = 11 }
    group:entry { item = "helmet_football", count = { 1, 2 }, probability = 11 }
    group:entry { item = "cleats", count = { 1, 2 }, probability = 11 }
    group:entry { item = "armguard_soft", count = { 1, 2 }, probability = 11 }
    group:entry { item = "legguard_hard", count = { 1, 2 }, probability = 11 }
    group:entry { item = "book_fict_soft_sports_tdsp", count = { 1, 2 }, probability = 3 }
    group:entry { item = "novel_sports", count = { 1, 3 }, probability = 7 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bread_bag_plastic_2", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "bread", count = { 2, 2 }, container = "null" }
    content.add(group)
end
