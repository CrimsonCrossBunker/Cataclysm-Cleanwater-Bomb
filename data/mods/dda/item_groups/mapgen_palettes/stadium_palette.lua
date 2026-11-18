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

do
    local group = content.ItemGroup { id = "football_items", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("whistle", 10)
    group:item("sports_drink", 60)
    group:item("bottle_plastic", 80)
    group:item("towel", 80)
    group:item("heatpack", 40)
    group:item("heatpack_used", 60)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 20 }
    group:entry { item = "liq_bandage_spray", charges = { 1, -1 }, probability = 10 }
    group:group("adhesive_bandages_box_used", 20)
    group:item("mouthpiece", 40)
    group:item("football", 60)
    group:item("football_armor", 60)
    group:item("helmet_football", 60)
    group:item("armguard_soft", 30)
    group:item("legguard_hard", 30)
    group:item("jersey", 60)
    group:item("cleats", 60)
    group:item("duffelbag", 30)
    group:item("backpack", 40)
    group:item("energy_drink", 30)
    group:entry { item = "cell_phone", charges = { 0, 150 }, probability = 6 }
    group:entry { group = "civilian_phones", charges = { 0, -1 }, probability = 44 }
    group:item("mp3", 50)
    group:entry { item = "inhaler", charges = { 0, 100 }, probability = 10 }
    content.add(group)
end
