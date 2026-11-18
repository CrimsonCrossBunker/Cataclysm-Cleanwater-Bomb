local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a refrigerator which is stocked with snacks and small meals.
    local group = content.ItemGroup { id = "SUS_fridge_snacks", kind = "collection" }
    group:entry { group = "soda_in_small_container", count = { 3, 7 }, probability = 75 }
    group:group("foodplace_food_box_small_4", 10)
    group:group("pie_box_small_8", 10)
    group:group("pie_veggy_box_small_8", 10)
    group:group("pie_meat_box_small_8", 10)
    group:group("pie_maple_box_small_8", 10)
    group:group("bologna_bag_plastic_10", 15)
    group:group("fruit_leather_bag_plastic_full", 15)
    group:group("frozen_dinner_box_small_2", 25)
    group:group("pizza_veggy_box_small_4", 5)
    group:group("pizza_cheese_box_small_4", 5)
    group:group("pizza_meat_box_small_4", 5)
    group:group("fried_mozzarella_sticks_bag_plastic_4", 5)
    group:entry { group = "sandwiches", count = { 2, 5 }, probability = 60 }
    group:entry { group = "vending_drink_items", count = { 1, 12 }, probability = 80 }
    group:item("yoghurt", 20)
    group:item("pudding", 25)
    group:item("junk_burrito", 25)
    group:item("dried_salad", 10)
    group:item("cheeseburger", 10)
    group:item("deluxe_cheeseburger", 15)
    group:item("hamburger", 10)
    group:item("tofu_rice", 10)
    group:item("fish_fried", 10)
    group:item("fish_sandwich", 10)
    group:item("lobster_cakes", 10)
    group:item("lobster_roll", 10)
    group:item("sloppyjoe", 10)
    group:item("fries", 10)
    group:item("cheese_fries", 5)
    group:item("onion_rings", 10)
    group:item("lunchmeat", 20)
    group:item("gelatin_dessert_processed", 10)
    group:item("mascarpone", 10)
    group:item("tiramisu", 15)
    content.add(group)
end
