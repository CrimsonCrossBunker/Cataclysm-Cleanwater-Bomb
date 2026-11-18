local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hive", kind = "distribution" }
    group:item("honeycomb", 10)
    content.replace(group)
end

do
    -- Override for mx_Trapdoor_spider_den, no loot value but even more warning
    local group = content.ItemGroup { id = "wasp_lair", kind = "distribution", with_ammo = 10 }
    group:group("human_parts", 1)
    content.replace(group)
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
    group:item("mushroom", 4)
    group:item("blueberries", 3)
    group:item("strawberries", 2)
    group:item("cucumber", 8)
    group:item("tomato", 9)
    group:item("pumpkin", 8)
    group:item("broccoli", 9)
    group:item("zucchini", 7)
    group:item("celery", 2)
    group:item("onion", 3)
    group:item("carrot", 3)
    group:item("potato", 10)
    group:item("pear", 65)
    group:item("grapefruit", 1)
    group:item("cherries", 5)
    group:item("plums", 9)
    group:item("grapes", 45)
    group:item("pineapple", 2)
    group:item("peach", 1)
    group:item("cranberries", 15)
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
    group:item("rock", 40)
    group:item("rock_large", 5)
    group:item("stick", 95)
    group:item("honey_ant", 30)
    group:item("honeydew", 30)
    content.replace(group)
end
