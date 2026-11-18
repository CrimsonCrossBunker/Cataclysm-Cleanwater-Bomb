local content = require("ccb").content

do
    local group = content.ItemGroup { id = "commercial_sauces_dressings", kind = "distribution" }
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
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_sauces_dressings", kind = "collection" }
    group:entry { group = "commercial_sauces_dressings", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_spices_seasoning", kind = "distribution" }
    group:group("salt_bottle_plastic_small_full", 1)
    group:group("seasoning_salt_bottle_plastic_small_full", 1)
    group:group("pepper_bottle_plastic_small_full", 1)
    group:group("garlic_powder_bottle_plastic_small_full", 1)
    group:group("curry_powder_bottle_plastic_small_full", 1)
    group:group("chilly_p_bottle_plastic_small_full", 1)
    group:group("seasoning_italian_bottle_plastic_small_full", 1)
    group:group("wild_herbs_jar_glass_sealed_20_inf", 1)
    group:group("thyme_bowl_plastic_full", 1)
    group:group("mustard_powder_bottle_plastic_small_full", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_spices_seasoning", kind = "collection" }
    group:entry { group = "commercial_spices_seasoning", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_oil_vinegar", kind = "distribution" }
    group:entry { item = "cooking_oil", count = { 1, 1 }, container = "jug_plastic", probability = 1 }
    group:item("vinegar", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_oil_vinegar", kind = "collection" }
    group:entry { group = "commercial_oil_vinegar", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_exotic_food", kind = "distribution" }
    group:group("noodles_fast_bag_5", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_exotic_food", kind = "collection" }
    group:entry { group = "commercial_exotic_food", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_grains", kind = "distribution" }
    group:entry { group = "dry_rice_bag_plastic_full", count = { 1, 1 } }
    group:entry { group = "dry_lentils_bag_plastic_full", count = { 1, 1 } }
    group:entry { group = "dry_beans_bag_plastic_full", count = { 1, 1 } }
    group:entry { group = "oats_bag_plastic_full", count = { 1, 1 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_grains", kind = "collection" }
    group:entry { group = "commercial_grains", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_baking", kind = "distribution" }
    group:group("flour_bag_50", 1)
    group:group("bread_flour_bag_50", 1)
    group:group("flour_wheat_free_bag_50", 1)
    group:group("yeast_bag_10", 1)
    group:group("sugar_bag_50", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_baking", kind = "collection" }
    group:entry { group = "commercial_baking", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_pasta", kind = "distribution" }
    group:group("spaghetti_raw_bag_30", 1)
    group:group("lasagne_raw_bag_30", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_pasta", kind = "collection" }
    group:entry { group = "commercial_pasta", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_vegetables", kind = "distribution" }
    group:group("corn_in_can", 1)
    group:group("tomatoes_in_can", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_canned_vegetables", kind = "collection" }
    group:entry { group = "commercial_canned_vegetables", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_fruits", kind = "distribution" }
    group:group("pineapple_in_can", 1)
    group:group("coconut_milk_in_can", 1)
    group:group("fruits_in_can", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_canned_fruits", kind = "collection" }
    group:entry { group = "commercial_canned_fruits", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meat", kind = "distribution" }
    group:group("fish_in_can", 1)
    group:group("lobster_in_can", 1)
    group:group("sardine_in_can", 1)
    group:group("tuna_in_can", 1)
    group:group("salmon_in_can", 1)
    group:group("chicken_in_can", 1)
    group:group("spam_in_can", 1)
    group:group("clams_in_can", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_canned_meat", kind = "collection" }
    group:entry { group = "commercial_canned_meat", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_canned_meals", kind = "distribution" }
    group:group("pork_beans_in_can", 1)
    group:group("beans_in_can", 1)
    group:group("chowder_in_can", 1)
    group:group("ravioli_in_can", 1)
    group:group("cheese_in_can", 1)
    group:group("chili_in_can", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_canned_meals", kind = "collection" }
    group:entry { group = "commercial_canned_meals", count = { 1, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_coffee", kind = "collection" }
    group:entry { group = "raw_coffee_in_container_full", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_tea", kind = "distribution" }
    group:group("tea_bag_box_10", 1)
    group:group("tea_green_bag_box_10", 1)
    group:group("tea_fruit_bag_box_10", 1)
    group:group("herbal_tea_bag_box_10", 1)
    group:group("tea_bag_dandelion_box_10", 1)
    group:group("tea_bag_chamomile_box_10", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_tea", kind = "collection" }
    group:entry { group = "commercial_tea", count = { 1, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_breakfast_cereal", kind = "collection" }
    group:entry { group = "cereal_in_container_full", count = { 1, 60 } }
    content.add(group)
end

do
    -- Should include pancake mixes. TODO fix.
    local group = content.ItemGroup { id = "commercial_breakfast_mixes", kind = "distribution" }
    group:group("cocoa_powder_various_full")
    group:group("milk_cocoa_powder_various_full")
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_breakfast_mixes", kind = "collection" }
    group:entry { group = "commercial_breakfast_mixes", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_spreads", kind = "distribution" }
    group:item("jam_fruit", 12)
    group:item("honey_bottled", 12)
    group:group("spread_peanutbutter_2", 8)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_spreads", kind = "collection" }
    group:entry { group = "commercial_spreads", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sweet_snacks", kind = "distribution" }
    group:item("chocolate", 8)
    group:item("protein_bar_zero", 6)
    group:item("protein_bar_peanut", 6)
    group:item("protein_bar_milk", 6)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_sweet_snacks", kind = "collection" }
    group:entry { group = "commercial_sweet_snacks", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_butter_cream", kind = "distribution" }
    group:group("butter_wrapper_32", 10)
    group:group("milk_cream_bottle_2", 10)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_butter_cream", kind = "collection" }
    group:entry { group = "commercial_butter_cream", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_yoghurt", kind = "distribution" }
    group:item("yoghurt", 1)
    group:item("pudding", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_yoghurt", kind = "collection" }
    group:entry { group = "commercial_yoghurt", count = { 1, 60 } }
    content.add(group)
end

do
    -- Spawn 250ml (not g because soft cheeses are outliers) at a time, need to be improved
    local group = content.ItemGroup { id = "commercial_cheese", kind = "distribution" }
    group:group("cheese_hard_wrapper_8", 1)
    group:group("cheese_bag_8", 1)
    group:group("mozzarella_cheese_bag_1", 1)
    group:group("mozzarella_cheese_smoked_bag_1", 1)
    group:group("mascarpone_container_1", 1)
    group:group("pecorino_cheese_wrapper_4", 1)
    group:group("cottage_cheese_tub_1", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_cheese", kind = "collection" }
    group:entry { group = "commercial_cheese", count = { 1, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_milk", kind = "collection" }
    group:entry { group = "milk_in_container_full", count = { 0, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_eggs", kind = "collection" }
    group:entry { group = "eggs_in_carton_full", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_deli", kind = "distribution" }
    group:item("froglegs", 1)
    group:item("gastropod_purged", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_deli", kind = "collection" }
    group:entry { group = "commercial_deli", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_meat_beef", kind = "distribution" }
    group:item("meat", 4)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_meat_beef", kind = "collection" }
    group:entry { group = "commercial_meat_beef", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_meat_pork", kind = "distribution" }
    group:item("meat", 4)
    group:item("porkbelly", 2)
    group:item("bacon_uncut", 3)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_meat_pork", kind = "collection" }
    group:entry { group = "commercial_meat_pork", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_meat_poultry", kind = "distribution" }
    group:item("poultry", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_meat_poultry", kind = "collection" }
    group:entry { group = "commercial_meat_poultry", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_meat_seafood", kind = "distribution" }
    group:item("fish", 4)
    group:item("lobster", 1)
    group:item("mollusk", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_meat_seafood", kind = "collection" }
    group:entry { group = "commercial_meat_seafood", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_icecream", kind = "distribution" }
    group:item("icecream", 1)
    group:item("icecream_artificial", 1)
    group:item("icecream_choc", 1)
    group:item("icecream_candy", 1)
    group:item("icecream_fruit", 1)
    group:item("icecream_custard", 1)
    group:item("icecream_yogurt", 1)
    group:item("icecream_gelato", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_icecream", kind = "collection" }
    group:entry { group = "commercial_icecream", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_frozen_dessert", kind = "distribution" }
    group:item("tiramisu", 1)
    group:item("milkshake", 1)
    group:item("milkshake_fastfood", 1)
    group:item("milkshake_choc", 1)
    group:item("milkshake_deluxe", 1)
    group:item("milkshake_deluxe_choc", 1)
    group:item("frozen_lemonade", 1)
    group:item("snowcone", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_frozen_dessert", kind = "collection" }
    group:entry { group = "commercial_frozen_dessert", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_water", kind = "distribution" }
    group:item("water_clean", 1)
    group:item("water_mineral", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_water", kind = "collection" }
    group:entry { group = "commercial_water", count = { 1, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_soda", kind = "collection" }
    group:entry { group = "soda_in_container_full", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_juices", kind = "distribution" }
    group:item("juice_pasteurized", 1)
    group:item("juice", 1)
    group:item("pineapple_juice", 1)
    group:item("oj", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_juices", kind = "collection" }
    group:entry { group = "commercial_juices", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_sports_drink", kind = "distribution" }
    group:item("sports_drink", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_sports_drink", kind = "collection" }
    group:entry { group = "commercial_sports_drink", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_snacks_chips", kind = "distribution" }
    group:group("bag_chips")
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_chips", kind = "collection" }
    group:entry { group = "commercial_snacks_chips", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_snacks_nuts_crackers", kind = "distribution" }
    group:group("crackers_box_16", 1)
    group:group("oyster_crackers_box_20", 1)
    group:group("peanut_bag_plastic_4", 1)
    group:group("peanut_shelled_bag_plastic_4", 1)
    group:group("chestnut_roasted_bag_plastic_4", 1)
    group:group("pistachio_shelled_bag_plastic_4", 1)
    group:group("pistachio_roasted_bag_plastic_4", 1)
    group:group("almond_roasted_bag_plastic_4", 1)
    group:group("cashews_bag_plastic_4", 1)
    group:group("pecan_shelled_bag_plastic_4", 1)
    group:group("pecan_roasted_bag_plastic_4", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_nuts_crackers", kind = "collection" }
    group:entry { group = "commercial_snacks_nuts_crackers", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_chocolate", kind = "distribution" }
    group:item("chocolate", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_chocolate", kind = "collection" }
    group:entry { group = "commercial_chocolate", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_candy", kind = "distribution" }
    group:item("candy", 1)
    group:item("candy2", 1)
    group:item("candy3", 1)
    group:item("candy4", 1)
    group:item("candy5", 1)
    group:item("candy3gator", 1)
    group:item("cow_candy", 1)
    group:entry { item = "powder_candy", container = "bag_plastic_small", probability = 1 }
    group:item("candy_bracelet", 1)
    group:item("candycigarette", 1)
    group:item("candy_coated_peanuts", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_candy", kind = "collection" }
    group:entry { group = "commercial_candy", count = { 1, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_pet_food_in_container", kind = "collection" }
    group:entry { group = "pet_food_in_container_full", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_pet_accessories", kind = "distribution" }
    group:item("pet_carrier", 1)
    group:item("petpack", 1)
    group:item("dog_tag_dog", 1)
    group:item("dog_whistle", 1)
    group:item("rubber_harness_dog", 1)
    group:item("leather_harness_dog", 1)
    group:group("pet_collars", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_pet_accessories", kind = "collection" }
    group:entry { group = "commercial_pet_accessories", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_baby_accessories_food", kind = "distribution" }
    group:item("teddy_bear", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_baby_accessories_food", kind = "collection" }
    group:entry { group = "commercial_baby_accessories_food", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_baby_hygiene", kind = "distribution" }
    group:item("paper", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_baby_hygiene", kind = "collection" }
    group:entry { group = "commercial_baby_hygiene", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_office_supplies", kind = "distribution" }
    group:item("rubber_band", 1)
    group:item("file", 1)
    group:item("paper", 1)
    group:item("book_binder", 1)
    group:item("stapler", 1)
    group:item("office_holepunch", 1)
    group:item("scissors", 1)
    group:entry { group = "writing_utensils", count = { 40, 100 }, probability = 80 }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_office_supplies", kind = "collection" }
    group:entry { group = "commercial_office_supplies", count = { 1, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_electronics_accessories", kind = "collection" }
    group:entry { group = "commercial_electronics_accessories", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_books", kind = "distribution" }
    group:group("book_school", 1)
    group:group("manuals_school", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_books", kind = "collection" }
    group:entry { group = "commercial_books", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_magazines", kind = "distribution" }
    group:group("magazines", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_magazines", kind = "collection" }
    group:entry { group = "commercial_magazines", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_household_laundry", kind = "distribution" }
    group:item("sponge", 1)
    group:item("brush", 1)
    group:item("liquid_soap", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_laundry", kind = "collection" }
    group:entry { group = "commercial_household_laundry", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_household_dish_cleaning", kind = "distribution" }
    group:item("soap", 6)
    group:item("liquid_soap", 1)
    group:item("sponge", 1)
    group:item("brush", 1)
    group:item("dish_towel", 3)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_dish_cleaning", kind = "collection" }
    group:entry { group = "commercial_household_dish_cleaning", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_cleaning_supplies", kind = "distribution" }
    group:item("soap", 6)
    group:item("liquid_soap", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_cleaning_supplies", kind = "collection" }
    group:entry { group = "commercial_cleaning_supplies", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_toilet_paper", kind = "distribution" }
    group:item("toilet_paper", 12)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_toilet_paper", kind = "collection" }
    group:entry { group = "commercial_toilet_paper", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_dental_care", kind = "distribution" }
    group:item("toothbrush_plain", 1)
    group:item("toothbrush_electric", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_dental_care", kind = "collection" }
    group:entry { group = "commercial_dental_care", count = { 1, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_drugs", kind = "collection" }
    group:entry { group = "vitamin_shop", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_shower_supplies", kind = "distribution" }
    group:item("soap", 6)
    group:item("liquid_soap", 1)
    group:item("house_coat", 1)
    group:item("bath_toy", 1)
    group:item("bottle_bathroom", 1)
    group:item("bathroom_scale", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_shower_supplies", kind = "collection" }
    group:entry { group = "commercial_shower_supplies", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_personal_care", kind = "distribution" }
    group:item("makeup_kit", 1)
    group:group("hair_dye_display")
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_personal_care", kind = "collection" }
    group:entry { group = "commercial_personal_care", count = { 1, 60 } }
    content.add(group)
end

do
    -- small crates aren't in the game yet, assumed volume of 26L (-33% for unevenness, so 17L)
    local group = content.ItemGroup { id = "small_crate_of_vegetables", kind = "distribution" }
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
    -- 3 levels * 3 crates per level = 9
    local group = content.ItemGroup { id = "SUS_shelf_commercial_vegetables", kind = "collection" }
    group:entry { group = "small_crate_of_vegetables", count = { 9, 9 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_common_berries", kind = "collection" }
    group:entry { item = "blueberries", count = { 1, 68 }, probability = 1 }
    group:entry { item = "strawberries", count = { 1, 68 }, probability = 1 }
    group:entry { item = "cranberries", count = { 1, 68 }, probability = 1 }
    group:entry { item = "raspberries", count = { 1, 68 }, probability = 1 }
    group:entry { item = "blackberries", count = { 1, 68 }, probability = 1 }
    content.add(group)
end

do
    -- small crates aren't in the game yet, assumed volume of 26L (-33% for unevenness, so 17L)
    local group = content.ItemGroup { id = "small_crate_of_uncommon_fruits", kind = "distribution" }
    group:entry { item = "guayaba", count = { 1, 136 }, probability = 1 }
    group:entry { item = "maracuya", count = { 1, 68 }, probability = 1 }
    group:entry { item = "lulo", count = { 1, 68 }, probability = 1 }
    group:entry { item = "coconut", count = { 1, 9 }, probability = 1 }
    group:entry { item = "mango", count = { 1, 34 }, probability = 1 }
    group:entry { item = "pomegranate", count = { 1, 30 }, probability = 1 }
    group:entry { item = "papaya", count = { 1, 28 }, probability = 1 }
    content.add(group)
end

do
    -- small crates aren't in the game yet, assumed volume of 26L (-33% for unevenness, so 17L)
    local group = content.ItemGroup { id = "small_crate_of_common_fruits", kind = "distribution" }
    group:entry { item = "apple", count = { 1, 73 }, probability = 1 }
    group:entry { item = "banana", count = { 1, 136 }, probability = 1 }
    group:entry { item = "orange", count = { 1, 108 }, probability = 1 }
    group:entry { item = "lemon", count = { 1, 147 }, probability = 1 }
    group:entry { item = "pear", count = { 1, 68 }, probability = 1 }
    group:entry { item = "grapefruit", count = { 1, 37 }, probability = 1 }
    group:entry { item = "cherries", count = { 1, 68 }, probability = 1 }
    group:entry { item = "plums", count = { 1, 207 }, probability = 1 }
    group:entry { item = "grapes", count = { 1, 68 }, probability = 1 }
    group:entry { item = "pineapple", count = { 1, 7 }, probability = 1 }
    group:entry { item = "peach", count = { 1, 94 }, probability = 1 }
    group:entry { item = "watermelon", count = { 1, 2 }, probability = 1 }
    group:entry { item = "melon", count = { 1, 15 }, probability = 1 }
    group:entry { item = "kiwi", count = { 1, 242 }, probability = 1 }
    group:entry { item = "apricot", count = { 1, 68 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruit_berries", kind = "distribution" }
    group:entry { group = "small_crate_of_common_fruits", count = { 1, 1 }, probability = 80 }
    group:entry { group = "small_crate_of_common_berries", count = { 1, 1 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_crate_of_fruits", kind = "distribution" }
    group:entry { group = "small_crate_of_fruit_berries", count = { 1, 1 }, probability = 80 }
    group:entry { group = "small_crate_of_uncommon_fruits", count = { 1, 1 }, probability = 20 }
    content.add(group)
end

do
    -- 3 levels * 3 crates per level = 9
    local group = content.ItemGroup { id = "SUS_shelf_commercial_fruits", kind = "collection" }
    group:entry { group = "small_crate_of_fruits", count = { 9, 9 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread_specialty", kind = "distribution" }
    group:group("garlic_bread_in_bag_full", 1)
    group:group("frybread_in_bag_full", 1)
    group:group("cornbread_in_bag_full", 1)
    group:group("flatbread_in_bag_full", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_bread_specialty", kind = "collection" }
    group:entry { group = "commercial_bread_specialty", count = { 1, 60 } }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_bread_sweet", kind = "collection" }
    group:entry { group = "baked_goods", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_bread", kind = "distribution" }
    group:group("bread_in_bag_full", 1)
    group:group("bread_in_bag_full", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_bread", kind = "collection" }
    group:entry { group = "commercial_bread", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_frozen_meals", kind = "distribution" }
    group:group("chili_in_can", 4)
    group:group("ravioli_in_can", 4)
    group:group("veggy_salad_bowl_2", 3)
    group:group("sushi_veggyroll_bowl_2", 6)
    group:group("sauerkraut_jar_glass_sealed_2", 2)
    group:group("onion_rings_box_6", 8)
    group:group("chicken_fried_box_6", 8)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_frozen_meals", kind = "collection" }
    group:entry { group = "commercial_frozen_meals", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "commercial_frozen_vegetables", kind = "distribution" }
    group:item("broccoli", 1)
    group:item("cabbage_head", 1)
    group:item("radish_taproot", 1)
    group:item("spinach", 1)
    group:item("carrot", 1)
    group:item("garlic", 1)
    group:item("pumpkin", 1)
    group:item("rhubarb", 1)
    group:item("tomato", 1)
    group:item("zucchini", 1)
    group:item("bell_pepper", 1)
    group:item("eggplant", 1)
    group:item("cauliflower_head", 1)
    group:item("kale_head", 1)
    group:item("raw_artichoke", 1)
    group:item("raw_asparagus", 1)
    group:item("brussels_sprout", 1)
    group:item("pea", 40)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_commercial_frozen_vegetables", kind = "collection" }
    group:entry { group = "commercial_frozen_vegetables", count = { 1, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_supermarket_SUS", kind = "distribution" }
    group:group("SUS_shelf_commercial_sauces_dressings", 1)
    group:group("SUS_shelf_commercial_oil_vinegar", 1)
    group:group("SUS_shelf_commercial_exotic_food", 1)
    group:group("SUS_shelf_commercial_grains", 1)
    group:group("SUS_shelf_commercial_baking", 1)
    group:group("SUS_shelf_commercial_pasta", 1)
    group:group("SUS_shelf_commercial_canned_vegetables", 1)
    group:group("SUS_shelf_commercial_canned_fruits", 1)
    group:group("SUS_shelf_commercial_canned_meat", 1)
    group:group("SUS_shelf_commercial_canned_meals", 1)
    group:group("SUS_shelf_commercial_coffee", 1)
    group:group("SUS_shelf_commercial_tea", 1)
    group:group("SUS_shelf_commercial_breakfast_cereal", 1)
    group:group("SUS_shelf_commercial_breakfast_mixes", 1)
    group:group("SUS_shelf_commercial_spreads", 1)
    group:group("SUS_shelf_commercial_sweet_snacks", 1)
    group:group("SUS_shelf_commercial_butter_cream", 1)
    group:group("SUS_shelf_commercial_yoghurt", 1)
    group:group("SUS_shelf_commercial_cheese", 1)
    group:group("SUS_shelf_commercial_milk", 1)
    group:group("SUS_shelf_commercial_eggs", 1)
    group:group("SUS_shelf_commercial_deli", 1)
    group:group("SUS_shelf_commercial_meat_beef", 1)
    group:group("SUS_shelf_commercial_meat_pork", 1)
    group:group("SUS_shelf_commercial_meat_poultry", 1)
    group:group("SUS_shelf_commercial_meat_seafood", 1)
    group:group("SUS_shelf_commercial_icecream", 1)
    group:group("SUS_shelf_commercial_frozen_dessert", 1)
    group:group("SUS_shelf_commercial_water", 1)
    group:group("SUS_shelf_commercial_soda", 1)
    group:group("SUS_shelf_commercial_juices", 1)
    group:group("SUS_shelf_commercial_sports_drink", 1)
    group:group("SUS_shelf_commercial_chips", 1)
    group:group("SUS_shelf_commercial_nuts_crackers", 1)
    group:group("SUS_shelf_commercial_chocolate", 1)
    group:group("SUS_shelf_commercial_candy", 1)
    group:group("SUS_shelf_commercial_pet_food_in_container", 1)
    group:group("SUS_shelf_commercial_pet_accessories", 1)
    group:group("SUS_shelf_commercial_baby_accessories_food", 1)
    group:group("SUS_shelf_commercial_baby_hygiene", 1)
    group:group("SUS_shelf_commercial_office_supplies", 1)
    group:group("SUS_shelf_commercial_electronics_accessories", 1)
    group:group("SUS_shelf_commercial_books", 1)
    group:group("SUS_shelf_commercial_magazines", 1)
    group:group("SUS_shelf_commercial_laundry", 1)
    group:group("SUS_shelf_commercial_dish_cleaning", 1)
    group:group("SUS_shelf_commercial_cleaning_supplies", 1)
    group:group("SUS_shelf_commercial_toilet_paper", 1)
    group:group("SUS_shelf_commercial_dental_care", 1)
    group:group("SUS_shelf_commercial_drugs", 1)
    group:group("SUS_shelf_commercial_shower_supplies", 1)
    group:group("SUS_shelf_commercial_personal_care", 1)
    group:group("SUS_shelf_commercial_vegetables", 1)
    group:group("SUS_shelf_commercial_fruits", 1)
    group:group("SUS_shelf_commercial_bread_specialty", 1)
    group:group("SUS_shelf_commercial_bread_sweet", 1)
    group:group("SUS_shelf_commercial_bread", 1)
    group:group("SUS_shelf_commercial_frozen_meals", 1)
    group:group("SUS_shelf_commercial_frozen_vegetables", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_shelf_any", kind = "collection" }
    group:entry { group = "any_supermarket_SUS", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_supermarket_SUS_fridge", kind = "distribution" }
    group:group("SUS_shelf_commercial_meat_beef", 1)
    group:group("SUS_shelf_commercial_meat_pork", 1)
    group:group("SUS_shelf_commercial_meat_poultry", 1)
    group:group("SUS_shelf_commercial_meat_seafood", 1)
    group:group("SUS_shelf_commercial_icecream", 1)
    group:group("SUS_shelf_commercial_frozen_dessert", 1)
    group:group("SUS_shelf_commercial_frozen_meals", 1)
    group:group("SUS_shelf_commercial_frozen_vegetables", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_supermarket_fridge_any", kind = "collection" }
    group:entry { group = "any_supermarket_SUS_fridge", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_supermarket_SUS_freezer", kind = "distribution" }
    group:group("SUS_shelf_commercial_sauces_dressings", 1)
    group:group("SUS_shelf_commercial_butter_cream", 1)
    group:group("SUS_shelf_commercial_yoghurt", 1)
    group:group("SUS_shelf_commercial_cheese", 1)
    group:group("SUS_shelf_commercial_milk", 1)
    group:group("SUS_shelf_commercial_eggs", 1)
    group:group("SUS_shelf_commercial_vegetables", 1)
    group:group("SUS_shelf_commercial_fruits", 1)
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "SUS_supermarket_freezer_any", kind = "collection" }
    group:entry { group = "any_supermarket_SUS_freezer", count = { 0, 3 } }
    content.add(group)
end

do
    -- A few packs in a box by the checkout
    local group = content.ItemGroup { id = "SUS_commercial_chewing_gum", kind = "collection" }
    group:entry { group = "chewing_gum_full", count = { 1, 15 }, wrapper = "box_snack" }
    group:entry { group = "chewing_gum_full_caff", count = { 1, 10 }, wrapper = "box_snack", probability = 50 }
    group:entry { group = "chewing_gum_full_nic", count = { 1, 10 }, wrapper = "box_snack", probability = 50 }
    content.add(group)
end

do
    -- 1m long / 20cm arbitrary item width * 3 rows on average * 4 shelves = 60 items
    local group = content.ItemGroup { id = "cardboards", kind = "collection" }
    group:entry { item = "box_small_folded", count = { 0, 8 }, probability = 20 }
    group:entry { item = "box_medium_folded", count = { 0, 4 }, probability = 10 }
    group:entry { item = "box_large_folded", count = { 0, 2 }, probability = 15 }
    group:entry { item = "box_oversize_folded", count = { 0, 1 }, probability = 5 }
    content.add(group)
end
