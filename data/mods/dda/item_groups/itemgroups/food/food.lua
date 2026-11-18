local content = require("ccb").content

do
    local group = content.ItemGroup { id = "dry_goods", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:group("flour_various", 80)
    group:group("potato_bag_plastic_1", 10)
    group:group("onion_bag_plastic_1", 10)
    group:group("yeast_various", 50)
    group:group("yogurt_starter_culture_bag_plastic_4", 8)
    group:group("cornmeal_box_full", 40)
    group:item("dry_meat", 10)
    group:item("dry_fish", 10)
    group:entry { item = "dry_lobster", container = "wrapper", probability = 10 }
    group:entry { item = "dry_veggy", count = { 2, 2 }, probability = 10 }
    group:item("dry_corn", 1)
    group:item("dry_fruit", 10)
    group:group("oatmeal_box_1lb", 40)
    group:group("fruit_leather_bag_plastic_full", 15)
    group:item("salted_fish", 15)
    group:group("dry_beans_bag_plastic_full", 40)
    group:group("dry_lentils_bag_plastic_full", 30)
    group:group("dry_rice_various", 60)
    group:group("freeze_dried_meal_box_any", 10)
    group:group("gelatin_powder_bag_plastic_full", 40)
    group:group("chem_agar_bottle_plastic_small_50", 15)
    group:item("gelatin_dessert_powder", 40)
    group:group("instant_gravy", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce", kind = "distribution" }
    group:item("apple", 70)
    group:item("orange", 65)
    group:item("banana", 40)
    group:item("lemon", 50)
    group:item("pear", 50)
    group:item("cherries", 30)
    group:item("plums", 30)
    group:item("grapes", 50)
    group:entry { item = "cranberries", count = { 3, 3 }, probability = 7 }
    group:item("raspberries", 7)
    group:item("blackberries", 7)
    group:item("rhubarb", 20)
    group:item("mushroom", 4)
    group:item("potato", 10)
    group:item("blueberries", 3)
    group:item("strawberries", 2)
    group:item("tomato", 9)
    group:item("pumpkin", 11)
    group:item("broccoli", 9)
    group:item("cucumber", 10)
    group:item("zucchini", 7)
    group:item("celery", 5)
    group:item("wheat", 3)
    group:item("onion", 3)
    group:item("garlic", 3)
    group:group("pine_nuts_bag_plastic_4", 10)
    group:entry { item = "carrot", count = { 6, 6 }, probability = 3 }
    group:item("bell_pepper", 7)
    group:item("eggplant", 7)
    group:item("raw_artichoke", 7)
    group:item("raw_asparagus", 7)
    group:item("brussels_sprout", 7)
    group:item("cauliflower_head", 7)
    group:item("kale_head", 7)
    group:item("pea_pods", 7)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "food_vendor_cart_kitchen", kind = "collection" }
    group:entry { item = "cheeseburger", count = { 0, 3 } }
    group:entry { item = "deluxe_cheeseburger", count = { 0, 3 } }
    group:entry { item = "hamburger", count = { 0, 3 } }
    group:entry { item = "hamburger", count = { 0, 3 } }
    group:entry { item = "sloppyjoe", count = { 0, 3 } }
    group:entry { item = "fries", count = { 0, 3 } }
    group:entry { group = "fried_mozzarella_sticks_bag_plastic_4", count = { 0, 3 } }
    group:entry { item = "hotdogs_cooked", count = { 0, 3 } }
    group:entry { group = "corndogs_cooked_wrapper_2", count = { 0, 3 } }
    group:entry { group = "bacon_bag_plastic_2", count = { 0, 3 } }
    group:group("instant_gravy_tub", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "food_vendor_cart_fridge", kind = "collection" }
    group:entry { item = "lemonade", count = { 0, 3 } }
    group:entry { item = "cola", count = { 0, 3 } }
    group:entry { item = "zerocola", count = { 0, 3 } }
    group:entry { item = "sports_drink", count = { 0, 3 } }
    group:entry { item = "rootbeer", count = { 0, 3 } }
    group:entry { item = "pickle", count = { 0, 3 } }
    group:entry { item = "ketchup", count = { 0, 3 }, charges = { 10, 16 } }
    group:entry { item = "mustard", count = { 0, 3 }, charges = { 10, 48 } }
    group:entry { item = "honey_mustard", count = { 0, 3 }, charges = { 10, 48 } }
    group:entry { item = "mayonnaise", count = { 0, 3 }, charges = { 10, 16 } }
    group:entry { item = "onion", count = { 0, 3 } }
    group:entry { item = "chili_pepper", count = { 0, 9 } }
    group:entry { item = "lettuce", count = { 0, 30 } }
    group:entry { item = "tomato", count = { 0, 3 } }
    group:entry { group = "cheese_bag_plastic", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fast_food", kind = "distribution" }
    group:group("candy_chocolate", 480)
    group:group("soda_in_small_container", 480)
    group:item("water_clean", 90)
    group:group("sandwich_t_wrapper_2", 30)
    group:item("sandwich_pb", 30)
    group:item("sandwich_pbj", 30)
    group:item("sandwich_pbh", 30)
    group:item("sandwich_pbm", 30)
    group:item("sandwich_pbf", 30)
    group:group("pizza_veggy_box_small_4", 8)
    group:group("pizza_cheese_box_small_4", 8)
    group:group("pizza_meat_box_small_4", 8)
    group:group("pie_box_small_8", 20)
    group:group("pie_meat_box_small_8", 20)
    group:group("pie_veggy_box_small_8", 20)
    group:group("pie_maple_box_small_8", 10)
    group:group("bag_chips", 65)
    group:group("fried_seeds_bag_plastic_4", 25)
    group:group("cookies_box_snack_4", 60)
    group:item("mayonnaise", 60)
    group:item("spork", 10)
    group:item("foon", 10)
    group:group("ketchup_sealed_rng", 60)
    group:group("mustard_sealed_rng", 60)
    group:group("barbecue_sauce_sealed_rng", 10)
    group:group("honey_mustard_sealed_rng", 10)
    group:item("soysauce", 45)
    group:item("hot_sauce", 45)
    group:item("horseradish", 30)
    group:group("pickle_jar_glass_sealed_2", 40)
    group:group("salt_various", 20)
    group:group("pepper_various", 20)
    group:item("meat_smoked", 4)
    group:item("fish_smoked", 4)
    group:item("lobster_smoked", 4)
    group:item("cheeseburger", 20)
    group:item("deluxe_cheeseburger", 60)
    group:group("hotdogs_frozen_bag_plastic_10", 12)
    group:item("hotdogs_cooked", 35)
    group:group("foodplace_food_box_small_4", 8)
    group:group("chili_in_can", 20)
    group:group("chilidogs_wrapper_2", 20)
    group:item("hotdogs_newyork", 15)
    group:item("fries", 80)
    group:item("cheese_fries", 70)
    group:item("onion_rings", 80)
    group:item("hamburger", 30)
    group:item("fish_fried", 8)
    group:item("fish_sandwich", 8)
    group:item("lobster_roll", 8)
    group:item("lobster_cakes", 6)
    group:item("crab_cakes", 6)
    group:group("stuffed_clams_box_small_5", 4)
    group:item("tofu_rice", 4)
    group:item("sloppyjoe", 8)
    group:group("bacon_bag_plastic_2", 25)
    group:group("cheese_bag_plastic", 30)
    group:item("mozzarella_cheese", 20)
    group:item("restaurantmap", 5)
    group:item("touristmap", 2)
    group:item("noodles_fast", 30)
    group:item("milkshake_fastfood", 15)
    group:group("teabag_box", 5)
    group:group("soup_box", 5)
    group:group("instant_gravy_tub", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lunchbox_fruit", kind = "distribution" }
    group:item("banana", 10)
    group:item("apple", 10)
    group:item("orange", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lunchbox_food", kind = "distribution" }
    group:group("sandwiches", 75)
    group:group("lunchbox_fruit", 25)
    group:item("cheeseburger", 5)
    group:item("hamburger", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_fish", kind = "distribution" }
    group:entry { item = "fish", count = { 1, 3 }, probability = 30 }
    group:entry { item = "fish_scrap", count = { 3, 6 }, probability = 20 }
    group:item("lobster", 10)
    group:entry { item = "gastropod_purged", count = { 3, 8 }, probability = 10 }
    group:entry { item = "mollusk", count = { 1, 2 }, probability = 10 }
    group:entry { item = "oyster", count = { 6, 24 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fish_market_stall", kind = "collection" }
    group:group("fish_pickled_jar_glass_sealed_2", 15)
    group:group("lobster_in_can", 10)
    group:item("soup_fish", 25)
    group:item("salted_fish", 10)
    group:item("salted_mollusk", 10)
    group:item("fish_smoked", 10)
    group:item("lobster_smoked", 10)
    group:item("mollusk_smoked", 10)
    group:group("fish_pickled_jar_3l_glass_sealed_12", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "barbecue", kind = "distribution" }
    group:group("beer_in_container_full", 30)
    group:item("meat", 65)
    group:entry { item = "glazed_tenderloin", count = { 3, 3 }, probability = 55 }
    group:item("fish", 10)
    group:item("fish_smoked", 5)
    group:item("lobster", 10)
    group:item("lobster_smoked", 5)
    group:item("lobster_cakes", 10)
    group:item("crab_cakes", 10)
    group:group("stuffed_clams_box_small_5", 5)
    group:item("meat_smoked", 60)
    group:item("sausage", 35)
    group:entry { item = "bratwurst_sausage", count = { 10, 10 }, probability = 30 }
    group:group("hotdogs_frozen_bag_plastic_10", 65)
    group:item("hotdogs_cooked", 65)
    group:item("hotdogs_newyork", 45)
    group:group("chilidogs_wrapper_2", 30)
    group:group("currywurst_wrapper_2", 15)
    group:entry { item = "lettuce", count = { 5, 5 }, probability = 45 }
    group:item("tomato", 45)
    group:item("onion", 30)
    group:entry { item = "chili_pepper", count = { 3, 3 }, probability = 30 }
    group:item("corn", 20)
    group:group("irradiated_lettuce_bag_plastic_5", 20)
    group:entry {
        item = "tomato",
        flags = {
            "IRRADIATED",
        },
        probability = 20,
    }
    group:entry {
        item = "onion",
        flags = {
            "IRRADIATED",
        },
        probability = 5,
    }
    group:entry {
        item = "corn",
        flags = {
            "IRRADIATED",
        },
        probability = 10,
    }
    group:group("bacon_bag_plastic_2", 20)
    group:item("potato_baked", 15)
    group:group("bread_in_bag", 40)
    group:group("bread_wheat_free_bag_plastic_14", 40)
    group:group("ketchup_sealed_rng", 70)
    group:group("mustard_sealed_rng", 75)
    group:group("barbecue_sauce_sealed_rng", 80)
    group:group("honey_mustard_sealed_rng", 40)
    group:group("pickle_jar_glass_sealed_2", 20)
    group:item("pickle", 20)
    group:item("cheeseburger", 20)
    group:item("deluxe_cheeseburger", 50)
    group:item("hamburger", 70)
    group:group("cheese_bag_plastic", 45)
    group:item("mozzarella_cheese", 30)
    group:item("mozzarella_cheese_smoked", 10)
    group:item("ceramic_plate", 30)
    group:item("knife_small", 45, "knife_steak")
    group:item("tongs", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "honey_market_stall", kind = "collection" }
    group:group("honey_mustard_sealed_rng", 15)
    group:entry { item = "honey_bottled", charges = { -1, -1 }, probability = 20 }
    group:entry { item = "honey_glassed", count = { -1, -1 }, probability = 20 }
    group:entry { item = "honeycomb", count = { 2, 4 }, probability = 10 }
    group:entry { item = "honey_glassed", count = { -1, -1 }, probability = 10 }
    content.add(group)
end
