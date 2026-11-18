local content = require("ccb").content

do
    local group = content.ItemGroup { id = "displays", kind = "distribution" }
    group:item("tea", 70)
    group:group("tea_raw_bag_plastic_33", 70)
    group:group("tea_green_raw_bag_plastic_33", 35)
    group:item("ceramic_cup", 70)
    group:item("teapot", 70)
    group:item("clay_teapot", 70)
    group:group("teabag_box", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bar_alcohol", kind = "distribution" }
    group:group("beer_in_container", 453)
    group:group("wines_worthy")
    group:group("liquor_and_spirits", 116)
    group:group("mixed_alcoholic_drinks", 202)
    group:item("fruit_wine", 5)
    group:item("sherry", 10)
    group:item("bristol_sherry", 5)
    group:item("madeira", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bar_fridge", kind = "distribution" }
    group:entry { item = "water_clean", charges = { -1, -1 }, probability = 50 }
    group:entry { item = "water_mineral", charges = { -1, -1 }, probability = 20 }
    group:entry { item = "grenadine_syrup", charges = { 2, -1 }, probability = 40 }
    group:entry { item = "syrup_simple", charges = { 2, -1 }, probability = 60 }
    group:entry { item = "oj", charges = { 2, -1 }, probability = 40 }
    group:entry { item = "pineapple_juice", charges = { 2, -1 }, probability = 35 }
    group:entry { item = "juice", charges = { 2, -1 }, probability = 35 }
    group:entry { item = "tomato_juice", charges = { 2, -1 }, probability = 25 }
    group:entry { item = "cranberry_juice", charges = { 2, -1 }, probability = 35 }
    group:group("soda_in_small_container", 95)
    group:entry { item = "V8", charges = { 2, -1 }, probability = 15 }
    group:item("fries", 7)
    group:item("cheese_fries", 5)
    group:item("onion_rings", 7)
    group:group("pizza_veggy_box_small_4", 7)
    group:group("pizza_meat_box_small_4", 7)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_beer", kind = "distribution" }
    group:group("beer_in_container", 10)
    group:entry { item = "wine_chardonnay", charges = { -1, -1 }, probability = 1 }
    group:entry { item = "wine_cabernet", charges = { -1, -1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_soda", kind = "distribution" }
    group:group("soda_in_small_container", 70)
    group:item("energy_drink", 5)
    group:entry { item = "lemonade", charges = { -1, -1 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_display_2", kind = "distribution" }
    group:item("bottle_glass", 5)
    group:item("ceramic_cup", 15)
    group:item("ceramic_plate", 15)
    group:group("bag_chips", 75)
    group:group("choco_coffee_beans_bag_plastic_5", 50)
    group:group("coffee_raw_bag_plastic_20", 50)
    group:item("coffee_syrup", 15)
    group:group("licorice_bag_plastic_4", 10)
    group:group("cookies_box_snack_4", 35)
    group:group("tea_raw_bag_plastic_33", 50)
    group:group("tea_green_raw_bag_plastic_33", 25)
    group:group("teabag_box", 30)
    group:group("toast_bag_plastic_2", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_prep", kind = "distribution" }
    group:item("bottle_glass", 15)
    group:group("coffee_raw_bag_plastic_20", 25)
    group:entry { item = "coffee_syrup", charges = { 1, -1 }, probability = 25 }
    group:item("cup_plastic", 35)
    group:item("jug_plastic", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_softdrink", kind = "distribution" }
    group:entry { item = "lemonade", charges = { -1, -1 }, probability = 30 }
    group:entry { item = "sports_drink", charges = { -1, -1 }, probability = 40 }
    group:item("energy_drink", 40)
    group:item("energy_drink_atomic", 5)
    group:group("soda_in_small_container", 290)
    group:item("spezi", 10)
    group:entry { item = "cola", charges = { -1, -1 }, container = "bottle_plastic", probability = 30 }
    group:entry { item = "creamsoda", charges = { -1, -1 }, container = "bottle_plastic", probability = 20 }
    group:entry { item = "lemonlime", charges = { -1, -1 }, container = "bottle_plastic", probability = 20 }
    group:entry { item = "orangesoda", charges = { -1, -1 }, container = "bottle_plastic", probability = 15 }
    group:entry { item = "colamdew", charges = { -1, -1 }, container = "bottle_plastic", probability = 10 }
    group:entry { item = "zerocola", charges = { -1, -1 }, container = "bottle_plastic", probability = 10 }
    group:entry { item = "zeroorange", charges = { -1, -1 }, container = "bottle_plastic", probability = 10 }
    group:entry { item = "zerotropical", charges = { -1, -1 }, container = "bottle_plastic", probability = 10 }
    group:entry { item = "zeromdew", charges = { -1, -1 }, container = "bottle_plastic", probability = 10 }
    group:entry { item = "foodplace_zero_drink", charges = { -1, -1 }, container = "bottle_plastic", probability = 3 }
    group:entry { item = "rootbeer", charges = { -1, -1 }, container = "bottle_plastic", probability = 20 }
    group:entry { item = "tonic_water", charges = { -1, -1 }, container = "bottle_plastic", probability = 5 }
    group:entry { item = "sparkling", charges = { -1, -1 }, container = "bottle_plastic", probability = 7 }
    group:entry { item = "sparkling_peach", charges = { -1, -1 }, container = "bottle_plastic", probability = 7 }
    group:entry { item = "sparkling_pomegranate", charges = { -1, -1 }, container = "bottle_plastic", probability = 7 }
    group:entry { item = "cola", charges = { -1, -1 }, container = "bottle_twoliter", probability = 20 }
    group:entry { item = "creamsoda", charges = { -1, -1 }, container = "bottle_twoliter", probability = 10 }
    group:entry { item = "lemonlime", charges = { -1, -1 }, container = "bottle_twoliter", probability = 15 }
    group:entry { item = "orangesoda", charges = { -1, -1 }, container = "bottle_twoliter", probability = 15 }
    group:entry { item = "colamdew", charges = { -1, -1 }, container = "bottle_twoliter", probability = 10 }
    group:entry { item = "zerocola", charges = { -1, -1 }, container = "bottle_twoliter", probability = 10 }
    group:entry { item = "zeroorange", charges = { -1, -1 }, container = "bottle_twoliter", probability = 10 }
    group:entry { item = "zerotropical", charges = { -1, -1 }, container = "bottle_twoliter", probability = 10 }
    group:entry { item = "zeromdew", charges = { -1, -1 }, container = "bottle_twoliter", probability = 10 }
    group:entry { item = "sparkling", charges = { -1, -1 }, container = "bottle_twoliter", probability = 7 }
    group:entry { item = "sparkling_peach", charges = { -1, -1 }, container = "bottle_twoliter", probability = 7 }
    group:entry { item = "sparkling_pomegranate", charges = { -1, -1 }, container = "bottle_twoliter", probability = 7 }
    group:entry { item = "tonic_water", charges = { -1, -1 }, container = "bottle_twoliter", probability = 2 }
    group:entry { item = "rootbeer", charges = { -1, -1 }, container = "bottle_twoliter", probability = 15 }
    content.add(group)
end
