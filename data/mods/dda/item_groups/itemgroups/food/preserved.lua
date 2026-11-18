local content = require("ccb").content

do
    local group = content.ItemGroup { id = "foodintincan", kind = "distribution" }
    group:item("offal_canned", 1)
    group:group("coconut_milk_in_can", 1)
    group:item("con_milk", 1)
    group:item("milk_evap", 1)
    group:item("sauce_red", 1)
    group:item("can_peach", 1)
    group:group("fruits_in_can", 1)
    group:group("cheese_in_can", 1)
    group:group("fish_in_can", 1)
    group:group("lobster_in_can", 1)
    group:group("brown_bread_can_medium_14", 1)
    group:group("spam_in_can", 1)
    group:group("sardine_in_can", 1)
    group:group("ravioli_in_can", 1)
    group:group("chili_in_can", 1)
    group:group("pork_beans_in_can", 1)
    group:group("tuna_in_can", 1)
    group:group("clams_in_can", 1)
    group:group("chicken_in_can", 1)
    group:group("can_herring_jar_glass_sealed_2", 1)
    group:item("can_clams", 1)
    group:group("chowder_in_can", 1)
    group:item("meat_canned", 1)
    group:item("confit_meat", 1)
    group:group("pelmeni_can_medium_2", 1)
    group:group("canned_liver_can_food_4", 1)
    group:group("beans_in_can", 1)
    group:group("tomatoes_in_can", 1)
    group:item("broth", 1)
    group:item("broth_bone", 1)
    group:item("soup_veggy", 1)
    group:item("soup_meat", 1)
    group:item("soup_fish", 1)
    group:item("soup_lobsterstew", 1)
    group:item("curry_veggy", 1)
    group:item("curry_meat", 1)
    group:item("soup_woods", 1)
    group:item("soup_chicken", 1)
    group:item("soup_mushroom", 1)
    group:item("soup_tomato", 1)
    group:item("soup_dumplings", 1)
    group:item("soup_cullenskink", 1)
    group:group("corn_in_can", 1)
    group:item("cooked_pumpkin", 1)
    group:item("veggy_canned", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cannedfood_commercial", kind = "distribution" }
    group:entry { group = "kitchen_sealed_3L_jar", count = { 1, 4 }, probability = 1 }
    group:entry { group = "kitchen_plastic_bag", count = { 1, 4 }, probability = 1 }
    group:entry { group = "kitchen_sack", count = { 1, 2 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "big_canned_food", kind = "distribution" }
    group:group("can_beans_can_food_big_12", 4)
    group:group("can_tomato_can_food_big_24", 4)
    group:group("can_pineapple_can_food_big_12", 3)
    group:group("can_corn_can_food_big_6", 3)
    group:entry { item = "sauce_red", charges = { 48, 48 }, container = "can_food_big", probability = 3 }
    group:group("raw_coffee_in_container", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clams_in_can", kind = "distribution" }
    group:entry { item = "can_clams", count = { 1, 1 }, wrapper = "can_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salmon_in_can", kind = "distribution" }
    group:entry { item = "can_salmon", count = { 1, 1 }, wrapper = "can_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tuna_in_can", kind = "distribution" }
    group:entry { item = "can_tuna", count = { 1, 1 }, wrapper = "can_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sardine_in_can", kind = "distribution" }
    group:entry { item = "can_sardine", count = { 1, 1 }, wrapper = "can_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lobster_in_can", kind = "distribution" }
    group:entry { item = "lobster_canned", count = { 1, 1 }, wrapper = "can_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fish_in_can", kind = "distribution" }
    group:entry { item = "fish_canned", count = { 1, 1 }, wrapper = "can_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fruits_in_can", kind = "distribution" }
    group:entry { item = "apple_canned", count = { 1, 1 }, wrapper = "can_food" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chili_in_can", kind = "distribution" }
    group:entry { item = "chili", count = { 2, 2 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beans_in_can", kind = "distribution" }
    group:entry { item = "can_beans", count = { 2, 2 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tomatoes_in_can", kind = "distribution" }
    group:entry { item = "can_tomato", count = { 4, 4 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pork_beans_in_can", kind = "distribution" }
    group:entry { item = "pork_beans", count = { 2, 2 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chicken_in_can", kind = "distribution" }
    group:entry { item = "can_chicken", count = { 2, 2 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corn_in_can", kind = "distribution" }
    group:entry { item = "can_corn", count = { 2, 2 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spam_in_can", kind = "distribution" }
    group:entry { item = "can_spam", count = { 6, 6 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pineapple_in_can", kind = "distribution" }
    group:entry { item = "can_pineapple", count = { 2, 2 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coconut_milk_in_can", kind = "distribution" }
    group:entry { item = "can_coconut", wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chowder_in_can", kind = "distribution" }
    group:entry { item = "can_chowder", count = { 2, 2 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ravioli_in_can", kind = "distribution" }
    group:entry { item = "ravioli", count = { 2, 2 }, wrapper = "can_medium" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pelmeni_can_medium_2", kind = "collection", container = "can_medium" }
    group:entry { item = "pelmeni", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "canned_liver_can_food_4", kind = "collection", container = "can_food" }
    group:entry { item = "canned_liver", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "can_beans_can_food_big_12", kind = "collection", container = "can_food_big" }
    group:entry { item = "can_beans", count = { 12, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "can_tomato_can_food_big_24", kind = "collection", container = "can_food_big" }
    group:entry { item = "can_tomato", count = { 24, 24 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "can_pineapple_can_food_big_12", kind = "collection", container = "can_food_big" }
    group:entry { item = "can_pineapple", count = { 12, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "can_corn_can_food_big_6", kind = "collection", container = "can_food_big" }
    group:entry { item = "can_corn", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "veggy_pickled_jar_glass_sealed_2",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "veggy_pickled", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sauerkraut_jar_glass_sealed_2", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "sauerkraut", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "meat_pickled_jar_glass_sealed_2",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "meat_pickled", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "offal_pickled_jar_glass_sealed_2",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "offal_pickled", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "fish_pickled_jar_glass_sealed_2",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "fish_pickled", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "can_herring_jar_glass_sealed_2", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "can_herring", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pickle_jar_glass_sealed_2", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "pickle", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "meat_canned_jar_3l_glass_sealed_12",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "meat_canned", count = { 12, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "confit_meat_jar_3l_glass_sealed_12",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "confit_meat", count = { 12, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "veggy_canned_jar_3l_glass_sealed_12",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "veggy_canned", count = { 12, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fruits_in_3l_jar", kind = "distribution" }
    group:entry { item = "apple_canned", count = { 24, 24 }, wrapper = "jar_3l_glass_sealed" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "can_tomato_jar_3l_glass_sealed_24",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "can_tomato", count = { 24, 24 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "fish_pickled_jar_3l_glass_sealed_12",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "fish_pickled", count = { 12, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "meat_pickled_jar_3l_glass_sealed_12",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "meat_pickled", count = { 12, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "veggy_pickled_jar_3l_glass_sealed_12",
        kind = "collection",
        container = "jar_3l_glass_sealed",
    }
    group:entry { item = "veggy_pickled", count = { 12, 12 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chili_can_medium_1_inf", kind = "collection", container = "can_medium" }
    group:entry { item = "chili", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salsa_jar_glass_sealed_1_inf", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "salsa", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "veggy_pickled_jar_glass_sealed_1_inf",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "veggy_pickled", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "sauerkraut_jar_glass_sealed_1_inf",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "sauerkraut", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "meat_pickled_jar_glass_sealed_1_inf",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "meat_pickled", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "jam_fruit_jar_sealed", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "jam_fruit", count = { -1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "fish_pickled_jar_glass_sealed_1_inf",
        kind = "collection",
        container = "jar_glass_sealed",
    }
    group:entry { item = "fish_pickled", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pickle_jar_glass_sealed_1_inf", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "pickle", count = { 1, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cannedfood", kind = "distribution" }
    group:group("beans_in_can", 40)
    group:group("pork_beans_in_can", 40)
    group:item("can_tomato", 40)
    group:group("corn_in_can", 35)
    group:item("cooked_pumpkin", 25)
    group:item("con_milk", 30)
    group:group("spam_in_can", 30)
    group:group("pineapple_in_can", 30)
    group:item("can_peach", 30)
    group:group("coconut_milk_in_can", 10)
    group:item("can_sardine", 14)
    group:group("tuna_in_can", 35)
    group:group("clams_in_can", 25)
    group:group("chowder_in_can", 35)
    group:group("can_herring_jar_glass_sealed_2", 30)
    group:group("chicken_in_can", 40)
    group:group("brown_bread_can_medium_14", 20)
    group:item("broth", 15)
    group:entry { item = "crackers", count = { -1, -1 }, probability = 10 }
    group:group("oyster_crackers_plastic_bag_vac_8", 10)
    group:entry { item = "grahmcrackers", count = { -1, -1 }, probability = 10 }
    group:entry { item = "marshmallow", count = { -1, -1 }, probability = 10 }
    group:entry { item = "syrup", charges = { -1, -1 }, probability = 10 }
    group:entry { item = "syrup_corn", charges = { -1, -1 }, probability = 4 }
    group:entry { item = "syrup_simple", charges = { -1, -1 }, probability = 1 }
    group:entry { item = "coffee_syrup", charges = { -1, -1 }, probability = 15 }
    group:item("instant_coffee", 15)
    group:item("soup_veggy", 15)
    group:item("soup_meat", 15)
    group:item("soup_chicken", 15)
    group:item("soup_mushroom", 15)
    group:item("soup_tomato", 15)
    group:item("soup_dumplings", 15)
    group:item("curry_veggy", 15)
    group:item("curry_meat", 15)
    group:group("flour_various", 80)
    group:group("milk_powder_various", 20)
    group:group("cocoa_powder_various", 20)
    group:group("milk_cocoa_powder_various", 20)
    group:group("cornmeal_box_full", 30)
    group:group("tortilla_corn_bag_plastic_full", 20)
    group:group("tortilla_flour_bag_plastic_full", 20)
    group:group("powder_eggs_bottle_plastic_small_16", 20)
    group:group("protein_powder_bottle_plastic_small_1_9", 12)
    group:item("dry_meat", 10)
    group:entry { item = "dry_fish", container = "wrapper", probability = 10 }
    group:item("dry_lobster", 10)
    group:entry { item = "dry_veggy", count = { 2, 2 }, probability = 10 }
    group:item("dry_corn", 1)
    group:item("dry_fruit", 10)
    group:group("oatmeal_box_1lb", 40)
    group:group("toastem_box_small_8", 90)
    group:group("sugar_various", 20)
    group:group("artificial_sweetener_box_small_71", 5)
    group:group("lemonade_powder_bottle_plastic_small_10", 5)
    group:entry { item = "molasses", charges = { -1, -1 }, probability = 10 }
    group:group("cheese_in_can", 40)
    group:group("cheese_hard_wrapper_8", 5)
    group:group("salt_various", 20)
    group:group("pepper_various", 20)
    group:group("seasoning_salt_various", 25)
    group:entry { item = "vinegar", charges = { -1, -1 }, probability = 15 }
    group:group("vegetable_oil_bottle", 30)
    group:group("veggy_pickled_jar_glass_sealed_2", 8)
    group:group("sauerkraut_jar_glass_sealed_2", 5)
    group:item("sports_drink", 10)
    group:item("protein_shake", 10)
    group:entry { item = "dogfood", container = "can_medium", probability = 5 }
    group:entry { item = "catfood", container = "can_food", probability = 5 }
    group:group("fish_pickled_jar_glass_sealed_2", 8)
    group:item("lutefisk", 1)
    group:group("dry_beans_bag_plastic_full", 40)
    group:group("dry_lentils_bag_plastic_full", 40)
    group:group("dry_rice_various", 60)
    group:group("meat_pickled_jar_glass_sealed_2", 6)
    group:group("kitchen_sealed_3L_jar", 2)
    group:group("big_canned_food", 1)
    group:group("teabag_box", 20)
    group:group("soup_box", 20)
    content.add(group)
end
