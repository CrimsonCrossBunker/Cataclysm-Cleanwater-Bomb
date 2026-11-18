local content = require("ccb").content

do
    local group = content.ItemGroup { id = "regional_supply_original_produce", kind = "distribution" }
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
    local group = content.ItemGroup {
        id = "regional_supply_original_fresh_produce",
        kind = "distribution",
        with_ammo = 75,
        with_magazine = 100,
    }
    group:item("apple", 10)
    group:item("orange", 65)
    group:item("lemon", 50)
    group:item("pear", 50)
    group:item("grapefruit", 5)
    group:item("cherries", 10)
    group:item("plums", 10)
    group:item("grapes", 20)
    group:item("pineapple", 5)
    group:item("peach", 10)
    group:entry { item = "cranberries", count = { 3, 3 }, probability = 7 }
    group:item("watermelon", 5)
    group:item("melon", 5)
    group:item("mango", 10)
    group:item("pomegranate", 5)
    group:item("rhubarb", 10)
    group:item("papaya", 3)
    group:item("kiwi", 5)
    group:item("apricot", 5)
    group:item("mushroom", 20)
    group:item("tomato", 20)
    group:entry { item = "lettuce", count = { 5, 5 }, probability = 15 }
    group:entry { item = "cabbage", count = { 8, 8 }, probability = 10 }
    group:entry { item = "radish_taproot", count = { 2, 2 }, probability = 5 }
    group:entry { item = "spinach", count = { 9, 9 }, probability = 6 }
    group:item("cucumber", 10)
    group:item("pumpkin", 10)
    group:item("celery", 3)
    group:item("broccoli", 9)
    group:item("zucchini", 15)
    group:item("onion", 15)
    group:entry { item = "chili_pepper", count = { 3, 3 }, probability = 15 }
    group:entry { item = "carrot", count = { 6, 6 }, probability = 15 }
    group:item("potato", 15)
    group:item("blueberries", 3)
    group:item("strawberries", 2)
    group:item("raspberries", 7)
    group:item("blackberries", 7)
    group:item("cholla_bud", 3)
    group:item("garlic", 3)
    group:group("pine_nuts_bag_plastic_4", 10)
    group:item("eggplant", 10)
    group:item("cauliflower_head", 10)
    group:item("kale_head", 10)
    group:item("raw_artichoke", 10)
    group:item("raw_asparagus", 10)
    group:item("brussels_sprout", 10)
    group:item("pea_pods", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_supply_original_small_crate_of_fruits", kind = "distribution" }
    group:entry { group = "small_crate_of_fruit_berries", count = { 1, 1 }, probability = 80 }
    group:entry { group = "small_crate_of_uncommon_fruits", count = { 1, 1 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_supply_original_small_crate_of_vegetables", kind = "distribution" }
    group:entry { item = "broccoli", count = { 1, 94 }, probability = 1 }
    group:entry { item = "cabbage_head", count = { 1, 10 }, probability = 1 }
    group:entry { item = "radish_taproot", count = { 1, 52 }, probability = 1 }
    group:entry { item = "spinach", count = { 1, 68 }, probability = 1 }
    group:entry { item = "carrot", count = { 1, 116 }, probability = 1 }
    group:entry { item = "celery", count = { 1, 116 }, probability = 1 }
    group:entry { item = "chili_pepper", count = { 1, 242 }, probability = 1 }
    group:entry { item = "cucumber", count = { 1, 61 }, probability = 1 }
    group:entry { item = "garlic", count = { 1, 377 }, probability = 1 }
    group:entry { item = "horseradish_root", count = { 1, 42 }, probability = 1 }
    group:entry { item = "lettuce_head", count = { 1, 9 }, probability = 1 }
    group:entry { item = "onion", count = { 1, 125 }, probability = 1 }
    group:entry { item = "potato", count = { 1, 73 }, probability = 1 }
    group:entry { item = "pumpkin", count = { 1, 8 }, probability = 1 }
    group:entry { item = "rhubarb", count = { 1, 91 }, probability = 1 }
    group:entry { item = "tomato", count = { 1, 113 }, probability = 1 }
    group:entry { item = "zucchini", count = { 1, 94 }, probability = 1 }
    group:entry { item = "bell_pepper", count = { 1, 76 }, probability = 1 }
    group:entry { item = "cauliflower_head", count = { 1, 61 }, probability = 1 }
    group:entry { item = "kale_head", count = { 1, 61 }, probability = 1 }
    group:entry { item = "eggplant", count = { 1, 61 }, probability = 1 }
    group:entry { item = "raw_artichoke", count = { 1, 61 }, probability = 1 }
    group:entry { item = "raw_asparagus", count = { 1, 61 }, probability = 1 }
    group:entry { item = "brussels_sprout", count = { 1, 61 }, probability = 1 }
    group:entry { item = "pea_pods", count = { 1, 61 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_supply_original_dry_goods",
        kind = "distribution",
        with_ammo = 75,
        with_magazine = 100,
    }
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
    local group = content.ItemGroup { id = "regional_supply_original_commercial_grains", kind = "distribution" }
    group:entry { group = "dry_rice_bag_plastic_full", count = { 1, 1 } }
    group:entry { group = "dry_lentils_bag_plastic_full", count = { 1, 1 } }
    group:entry { group = "dry_beans_bag_plastic_full", count = { 1, 1 } }
    group:entry { group = "oats_bag_plastic_full", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_supply_original_commercial_canned_meals", kind = "distribution" }
    group:group("pork_beans_in_can", 1)
    group:group("beans_in_can", 1)
    group:group("chowder_in_can", 1)
    group:group("ravioli_in_can", 1)
    group:group("cheese_in_can", 1)
    group:group("chili_in_can", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_supply_original_commercial_sauces_dressings", kind = "distribution" }
    group:item("ketchup", 1)
    group:item("sauce_pesto", 1)
    group:item("hot_sauce", 1)
    group:item("sauce_red", 1)
    group:item("barbecue_sauce", 1)
    group:item("honey_mustard", 1)
    group:item("mustard", 1)
    group:item("mayonnaise", 1)
    group:item("soysauce", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_supply_original_commercial_bread_specialty", kind = "distribution" }
    group:group("garlic_bread_in_bag_full", 1)
    group:group("frybread_in_bag_full", 1)
    group:group("cornbread_in_bag_full", 1)
    group:group("flatbread_in_bag_full", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-AB", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("cucumber", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("cucumber", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "cucumber", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_salmon", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-BC", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-MB", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cranberries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cranberries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cranberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-NB", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "cabbage", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_herring", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-NL", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("carrot", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("carrot", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "carrot", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_herring", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-NS", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_salmon", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-NT", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "cabbage", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_salmon", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-NU", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-ON", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("strawberries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("strawberries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "strawberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_herring", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-PE", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cranberries", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cranberries", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cranberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "cabbage", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-QC", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "wheat", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-SK", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("carrot", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("carrot", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "carrot", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_salmon", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-CA-YT", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("guayaba", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("guayaba", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "guayaba", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-AGU", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("grapes", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("grapes", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "grapes", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_tuna", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-BCN", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("mango", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("mango", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "mango", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_tuna", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-BCS", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("orange", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("orange", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "orange", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-CAM", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-CHH", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("mango", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("mango", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "mango", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-CHP", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("guayaba", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("guayaba", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "guayaba", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-CMX", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("grapes", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("grapes", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "grapes", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "onion", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-COA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("coconut", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("coconut", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "coconut", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_tuna", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-COL", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-DUR", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("mango", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("mango", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "mango", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_tuna", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-GRO", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("strawberries", 20)
    group:item("broccoli", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("strawberries", 20)
    group:item("broccoli", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "strawberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "broccoli", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-GUA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-HID", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-JAL", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("strawberries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("strawberries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "strawberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-MEX", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("regional_avocado", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("regional_avocado", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "regional_avocado", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-MIC", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("guayaba", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("guayaba", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "guayaba", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "onion", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-MOR", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("mango", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("mango", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "mango", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_tuna", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-NAY", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("orange", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("orange", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "orange", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "onion", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-NLE", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("mango", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("mango", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "mango", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-OAX", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-PUE", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("grapes", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("grapes", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "grapes", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-QUE", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("pineapple", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("pineapple", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "pineapple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-ROO", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("mango", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("mango", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "mango", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_tuna", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-SIN", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("orange", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("orange", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "orange", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-SLP", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("grapes", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("grapes", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "grapes", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "wheat", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-SON", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("papaya", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("papaya", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "papaya", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-TAB", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("orange", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("orange", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "orange", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "onion", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-TAM", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("peach", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("peach", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "peach", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-TLA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("orange", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("orange", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "orange", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-VER", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("papaya", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("papaya", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "papaya", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-YUC", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("guayaba", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("guayaba", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "guayaba", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-MX-ZAC", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-AK", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-AK", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-AK", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-AK", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-AK", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-AK", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-AK", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-AK", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_salmon", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-AK", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-AK", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-AL", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("peach", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-AL", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("peach", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-AL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "peach", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-AL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-AL", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-AL", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-AL", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-AL", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-AL", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-AL", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-AR", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("peach", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-AR", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("peach", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-AR", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "peach", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-AR", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-AR", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-AR", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup_corn", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-AR", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-AR", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-AR", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-AR", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("orange", 20)
    group:item("lettuce_head", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("orange", 20)
    group:item("lettuce_head", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "orange", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "lettuce_head", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-AZ", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-CA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("grapes", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-CA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("grapes", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-CA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "grapes", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-CA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-CA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-CA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-CA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-CA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_tuna", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-CA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-CA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-CO", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("peach", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-CO", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("peach", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-CO", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "peach", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-CO", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-CO", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-CO", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-CO", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-CO", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-CO", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-CO", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-CT", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("pumpkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-CT", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("pumpkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-CT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-CT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "pumpkin", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-CT", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-CT", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-CT", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-CT", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chowder", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-CT", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-CT", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-DC", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-DC", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-DC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-DC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-DC", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-DC", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-DC", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-DC", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_clams", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-DC", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-DC", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-DE", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("peach", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-DE", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("peach", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-DE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "peach", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-DE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-DE", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-DE", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-DE", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-DE", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_clams", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-DE", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-DE", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-FL", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("orange", 20)
    group:item("bell_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-FL", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("orange", 20)
    group:item("bell_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-FL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "orange", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-FL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "bell_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-FL", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-FL", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-FL", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-FL", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-FL", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-FL", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-GA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("peach", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-GA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("peach", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-GA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "peach", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-GA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "onion", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-GA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-GA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-GA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-GA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-GA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-GA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-HI", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("pineapple", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-HI", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("pineapple", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-HI", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "pineapple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-HI", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-HI", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-HI", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-HI", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-HI", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_spam", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-HI", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-HI", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-IA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-IA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-IA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-IA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-IA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-IA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-IA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-IA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-IA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-IA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-ID", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cherries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-ID", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cherries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-ID", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cherries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-ID", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-ID", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-ID", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-ID", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-ID", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-ID", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-ID", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-IL", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-IL", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-IL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-IL", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-IL", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-IL", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-IL", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-IL", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-IL", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-IL", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-IN", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("watermelon", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-IN", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("watermelon", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-IN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "watermelon", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-IN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-IN", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-IN", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-IN", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-IN", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-IN", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-IN", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-KS", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("watermelon", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-KS", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("watermelon", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-KS", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "watermelon", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-KS", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "wheat", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-KS", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-KS", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-KS", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-KS", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-KS", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-KS", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-KY", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-KY", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-KY", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-KY", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-KY", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-KY", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-KY", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-KY", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-KY", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-KY", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-LA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("orange", 20)
    group:item("bell_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-LA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("orange", 20)
    group:item("bell_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-LA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "orange", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-LA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "bell_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-LA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-LA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-LA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-LA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-LA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-LA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-MA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cranberries", 20)
    group:item("pumpkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-MA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cranberries", 20)
    group:item("pumpkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-MA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cranberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-MA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "pumpkin", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-MA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-MA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-MA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-MA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chowder", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-MA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-MA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-MD", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-MD", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-MD", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-MD", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-MD", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-MD", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-MD", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-MD", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_clams", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-MD", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-MD", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-ME", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-ME", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-ME", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-ME", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-ME", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-ME", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-ME", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-ME", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chowder", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-ME", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-ME", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-MI", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cherries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-MI", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cherries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-MI", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cherries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-MI", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-MI", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-MI", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-MI", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-MI", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-MI", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-MI", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-MN", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-MN", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-MN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-MN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-MN", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-MN", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-MN", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-MN", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-MN", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-MN", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-MO", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("peach", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-MO", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("peach", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-MO", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "peach", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-MO", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-MO", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-MO", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-MO", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-MO", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-MO", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-MO", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-MS", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-MS", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-MS", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-MS", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-MS", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-MS", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-MS", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-MS", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_sardine", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-MS", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-MS", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-MT", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cherries", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-MT", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cherries", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-MT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cherries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-MT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "wheat", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-MT", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-MT", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-MT", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-MT", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-MT", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-MT", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-NC", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-NC", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-NC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-NC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "cabbage", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-NC", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-NC", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-NC", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-NC", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-NC", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-NC", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-ND", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-ND", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-ND", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-ND", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-ND", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-ND", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-ND", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-ND", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-ND", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-ND", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-NE", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-NE", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-NE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-NE", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-NE", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-NE", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-NE", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-NE", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-NE", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-NE", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-NH", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("pumpkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-NH", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("pumpkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-NH", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-NH", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "pumpkin", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-NH", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-NH", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-NH", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-NH", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-NH", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-NH", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("blueberries", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("blueberries", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "blueberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_clams", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-NJ", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-NM", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-NM", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-NM", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-NM", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-NM", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-NM", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-NM", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-NM", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-NM", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-NM", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-NV", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("melon", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-NV", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("melon", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-NV", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "melon", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-NV", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "onion", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-NV", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-NV", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-NV", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-NV", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-NV", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-NV", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-NY", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-NY", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("cabbage", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-NY", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-NY", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "cabbage", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-NY", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-NY", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-NY", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-NY", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-NY", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-NY", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-OH", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-OH", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-OH", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-OH", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-OH", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-OH", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-OH", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-OH", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-OH", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-OH", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-OK", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("watermelon", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-OK", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("watermelon", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-OK", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "watermelon", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-OK", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "wheat", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-OK", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-OK", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-OK", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-OK", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-OK", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-OK", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-OR", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("pear", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-OR", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("pear", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-OR", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "pear", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-OR", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "onion", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-OR", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-OR", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-OR", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-OR", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_salmon", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-OR", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-OR", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-PA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("mushroom", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-PA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("mushroom", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-PA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-PA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "mushroom", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-PA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-PA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-PA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-PA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_clams", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-PA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-PA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-RI", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-RI", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-RI", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-RI", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-RI", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-RI", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-RI", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-RI", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chowder", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-RI", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-RI", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-SC", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("peach", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-SC", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("peach", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-SC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "peach", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-SC", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-SC", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-SC", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-SC", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-SC", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-SC", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-SC", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-SD", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-SD", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-SD", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-SD", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-SD", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-SD", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-SD", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-SD", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-SD", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-SD", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-TN", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("strawberries", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-TN", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("strawberries", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-TN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "strawberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-TN", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-TN", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-TN", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-TN", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-TN", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-TN", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-TN", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-TX", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("grapefruit", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-TX", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("grapefruit", 20)
    group:item("chili_pepper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-TX", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "grapefruit", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-TX", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "chili_pepper", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-TX", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-TX", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-TX", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-TX", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-TX", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-TX", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-UT", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cherries", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-UT", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cherries", 20)
    group:item("onion", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-UT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cherries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-UT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "onion", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-UT", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_beans_bag_plastic_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-UT", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-UT", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_beans_bag_plastic_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-UT", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-UT", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("salsa", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-UT", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-VA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-VA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("tomato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-VA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-VA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "tomato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-VA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-VA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-VA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-VA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_clams", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-VA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-VA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-VT", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("pumpkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-VT", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("pumpkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-VT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-VT", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "pumpkin", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-VT", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("oatmeal_box_1lb", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-VT", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("syrup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-VT", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("oatmeal_box_1lb", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-VT", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-VT", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-VT", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-WA", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-WA", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-WA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-WA", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-WA", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("dry_rice_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-WA", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-WA", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("dry_rice_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-WA", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_salmon", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-WA", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-WA", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-WI", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cranberries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-WI", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cranberries", 20)
    group:item("corn", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-WI", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cranberries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-WI", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "corn", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-WI", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-WI", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-WI", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-WI", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_beans", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-WI", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-WI", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-WV", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-WV", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("apple", 20)
    group:item("potato", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-WV", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "apple", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-WV", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "potato", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-WV", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("cornmeal_box_full", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-WV", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("molasses", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-WV", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("cornmeal_box_full", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-WV", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_chicken", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-WV", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("hot_sauce", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-WV", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "produce-US-WY", kind = "distribution" }
    group:group("regional_supply_original_produce", 60)
    group:item("cherries", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fresh_produce-US-WY", kind = "distribution" }
    group:group("regional_supply_original_fresh_produce", 60)
    group:item("cherries", 20)
    group:item("wheat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits-US-WY", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_fruits", 60)
    group:entry { item = "cherries", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_vegetables-US-WY", kind = "distribution" }
    group:group("regional_supply_original_small_crate_of_vegetables", 60)
    group:entry { item = "wheat", count = { 3, 12 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_goods-US-WY", kind = "distribution" }
    group:group("regional_supply_original_dry_goods", 60)
    group:group("flour_various", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pantry_liquids-US-WY", kind = "distribution" }
    group:group("regional_supply_original_pantry_liquids", 60)
    group:item("honey_bottled", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains-US-WY", kind = "distribution" }
    group:group("regional_supply_original_commercial_grains", 60)
    group:group("flour_various", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals-US-WY", kind = "distribution" }
    group:group("regional_supply_original_commercial_canned_meals", 60)
    group:item("can_corn", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings-US-WY", kind = "distribution" }
    group:group("regional_supply_original_commercial_sauces_dressings", 60)
    group:item("vinegar", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty-US-WY", kind = "distribution" }
    group:group("regional_supply_original_commercial_bread_specialty", 60)
    group:item("tortilla_flour", 40)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_supply_original_pantry_liquids",
        kind = "distribution",
        with_ammo = 75,
        with_magazine = 100,
    }
    group:entry { item = "syrup", charges = { 1, -1 }, probability = 15 }
    group:entry { item = "syrup_simple", charges = { 1, -1 }, probability = 1 }
    group:entry { item = "syrup_corn", charges = { 1, -1 }, probability = 5 }
    group:entry { item = "molasses", charges = { 1, -1 }, probability = 15 }
    group:group("vegetable_oil_bottle", 60)
    group:entry { item = "honey_bottled", charges = { 1, -1 }, probability = 15 }
    group:entry { item = "honey_glassed", count = { 1, -1 }, probability = 5 }
    group:item("jar_glass_sealed", 20)
    group:item("jar_3l_glass_sealed", 30)
    group:entry { item = "vinegar", charges = { 1, -1 }, probability = 15 }
    content.add(group)
end
