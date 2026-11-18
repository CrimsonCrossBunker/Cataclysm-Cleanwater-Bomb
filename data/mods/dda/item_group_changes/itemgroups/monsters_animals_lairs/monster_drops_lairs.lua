local content = require("ccb").content

do
    -- Beekeeper gear, as spawned on beekeeper zombie
    local group = content.ItemGroup { id = "hive", kind = "distribution" }
    group:item("honeycomb", 10)
    group:item("honey_scraper", 2)
    group:item("beekeeping_hood", 5)
    group:item("beekeeping_suit", 5)
    group:item("beekeeping_gloves", 5)
    content.add(group)
end

do
    -- Damaged generic/military/science drops, nothing fancy
    local group = content.ItemGroup { id = "wasp_lair", kind = "distribution", with_ammo = 10 }
    group:entry { group = "allclothes", damage = { 2, 4 }, probability = 150 }
    group:entry { group = "clothing_outdoor_set", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "clothing_hunting", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "clothing_work_set", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "everyday_gear", damage = { 2, 4 }, probability = 50 }
    group:entry { group = "gear_homeless", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "child_items", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "traveler", damage = { 2, 4 }, probability = 10 }
    group:entry { group = "default_zombie_clothes", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "default_zombie_items_bags", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "default_zombie_items_pockets", damage = { 2, 4 }, probability = 30 }
    group:entry { group = "mon_zombie_scientist_death_drops", damage = { 2, 4 }, probability = 5 }
    group:entry { group = "mon_zombie_labsecurity_death_drops", damage = { 2, 4 }, probability = 5 }
    group:entry { group = "mon_zombie_kevlar_death_drops", damage = { 2, 4 }, probability = 15 }
    group:entry { group = "mon_zombie_military_pilot_death_drops", damage = { 2, 4 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ant_food", kind = "distribution" }
    group:item("meat", 50)
    group:item("veggy", 30)
    group:item("meat_tainted", 60)
    group:item("veggy_tainted", 35)
    group:item("apple", 70)
    group:item("orange", 65)
    group:item("banana", 40)
    group:item("mushroom", 70)
    group:item("mushroom_morel", 70)
    group:item("blueberries", 3)
    group:item("strawberries", 2)
    group:item("cucumber", 8)
    group:item("tomato", 9)
    group:item("pumpkin", 8)
    group:item("broccoli", 9)
    group:item("zucchini", 7)
    group:item("celery", 2)
    group:item("onion", 3)
    group:entry { item = "carrot", count = { 6, 6 }, probability = 3 }
    group:item("potato", 10)
    group:item("pear", 65)
    group:item("grapefruit", 1)
    group:item("cherries", 5)
    group:item("plums", 9)
    group:item("grapes", 45)
    group:item("pineapple", 2)
    group:item("peach", 1)
    group:entry { item = "cranberries", count = { 3, 3 }, probability = 15 }
    group:item("watermelon", 2)
    group:item("melon", 1)
    group:item("raspberries", 3)
    group:item("blackberries", 3)
    group:item("mango", 1)
    group:item("pomegranate", 1)
    group:item("rhubarb", 5)
    group:item("papaya", 1)
    group:item("kiwi", 2)
    group:item("apricot", 1)
    group:item("honeycomb", 10)
    group:item("royal_jelly", 8)
    group:item("arm", 4)
    group:item("leg", 4)
    group:item("rock", 40)
    group:item("rock_large", 5)
    group:item("stick", 95)
    group:item("survivormap", 1)
    group:group("hat_hard_flashlight", 10)
    group:entry { item = "honey_ant", count = { 2, 2 }, probability = 30 }
    group:item("homemade_bomb_act", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ant_egg", kind = "distribution" }
    group:item("ant_egg", 5)
    content.add(group)
end
