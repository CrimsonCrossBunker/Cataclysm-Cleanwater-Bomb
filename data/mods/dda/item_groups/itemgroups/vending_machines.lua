local content = require("ccb").content

do
    local group = content.ItemGroup { id = "default_vending_machine", kind = "collection" }
    group:group("vending_drink", 50)
    group:group("vending_drink", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vending_food", kind = "collection" }
    group:entry { group = "vending_food_items", count = { 5, 20 } }
    group:entry { group = "vending_food_items", count = { 5, 25 }, probability = 66 }
    group:entry { group = "vending_food_items", count = { 5, 25 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vending_drink", kind = "collection" }
    group:entry { group = "vending_drink_items", count = { 5, 20 } }
    group:entry { group = "vending_drink_items", count = { 5, 25 }, probability = 66 }
    group:entry { group = "vending_drink_items", count = { 5, 25 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vending_drink_home_impr", kind = "distribution" }
    group:item("water_clean", 50)
    group:item("water_mineral", 20)
    group:item("oj", 40)
    group:item("pineapple_juice", 35)
    group:item("juice", 35)
    group:item("cranberry_juice", 35)
    group:item("cola", 50)
    group:item("lemonlime", 45)
    group:item("V8", 15)
    group:group("chewing_gum_full", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vending_food_items", kind = "distribution" }
    group:group("candy_chocolate", 615)
    group:group("salty_snacks", 485)
    group:entry { item = "peanut_shelled", count = { -1, -1 }, probability = 60 }
    group:entry { item = "almond_shelled", count = { -1, -1 }, probability = 60 }
    group:entry { item = "cashews", count = { -1, -1 }, probability = 60 }
    group:entry { item = "pistachio_shelled", count = { -1, -1 }, probability = 60 }
    group:entry { item = "cookies", count = { -1, -1 }, probability = 80 }
    group:entry { item = "choco_coffee_beans", count = { -1, -1 }, probability = 10 }
    group:entry { item = "fruit_leather", count = { -1, -1 }, probability = 25 }
    content.add(group)
end
