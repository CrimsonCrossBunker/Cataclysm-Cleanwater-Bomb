local content = require("ccb").content

do
    local group = content.ItemGroup { id = "baked_goods", kind = "distribution" }
    group:group("cookies_box_snack_4", 17)
    group:entry { item = "cake2", count = { 12, 12 }, probability = 15 }
    group:entry { item = "cake3", count = { 12, 12 }, probability = 10 }
    group:group("biscuit_box_small_10", 10)
    group:entry { item = "jihelucake", count = { 12, 12 }, probability = 10 }
    group:group("brownie_box_small_4", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tea_dishes", kind = "distribution" }
    group:item("ceramic_cup", 70)
    group:item("ceramic_plate", 50)
    group:item("spoon", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chair_hat", kind = "distribution" }
    group:item("hat_newsboy", 10)
    group:item("bowhat", 40)
    group:item("porkpie", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chair_torso", kind = "distribution" }
    group:item("suit", 70)
    group:item("waistcoat", 70)
    group:item("dress_shirt", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chair_extra", kind = "distribution" }
    group:item("cane", 70)
    group:item("pocketwatch", 70)
    group:item("umbrella", 70)
    group:item("manual_fencing", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corner_reader", kind = "distribution" }
    group:item("mag_cutting", 70)
    group:item("mag_stabbing", 70)
    group:item("mag_unarmed", 70)
    group:item("manual_dodge", 70)
    group:item("novel_spy", 70)
    group:item("novel_thriller", 70)
    group:item("novel_crime", 70)
    group:item("novel_adventure", 70)
    group:item("novel_war", 70)
    group:item("poetry_book", 30)
    group:item("cookbook_human", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corner_weapon", kind = "distribution" }
    group:entry { item = "tazer", charges = { 0, 500 }, probability = 70 }
    group:item("knuckle_brass", 50)
    group:item("knuckle_steel_forged", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prepared_teas", kind = "distribution" }
    group:item("tea", 60)
    group:item("bee_balm_tea", 20)
    group:entry { item = "dandelionburdock_tea", charges = { 0, 2 }, sealed = false, container = "bottle_plastic", probability = 20 }
    group:entry { item = "dandelion_tea", charges = { 0, 2 }, sealed = false, container = "bottle_plastic", probability = 10 }
    group:entry { item = "pine_tea", charges = { 0, 2 }, sealed = false, container = "bottle_plastic", probability = 10 }
    group:item("herbal_tea", 50)
    group:item("chamomile_tea", 40)
    group:item("lotus_tea", 30)
    group:item("spurge_tea", 20)
    group:item("milk_tea", 20)
    group:item("chai_tea", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "teashop_bulk_teas_no_stackable", kind = "distribution" }
    group:entry { item = "tanbark", count = { 1, 2 }, probability = 3 }
    group:entry { item = "spurge", count = { 1, 2 }, probability = 20 }
    group:entry { item = "lotus", count = { 1, 2 }, probability = 20 }
    group:entry { item = "chamomile", count = { 1, 2 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "teashop_fridge", kind = "distribution" }
    group:group("milk_in_container", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "teashop_kitchen_counter", kind = "distribution" }
    group:group("sugar_jar_glass_sealed_10_140", 30)
    group:group("tea_raw_bag_plastic_33", 40)
    group:group("tea_green_raw_bag_plastic_33", 20)
    group:item("teapot", 20)
    group:item("spoon", 20)
    content.add(group)
end

do
    -- Alcohol you'd find in at a still or moonshine camp
    local group = content.ItemGroup { id = "still_alcohol", kind = "distribution" }
    group:item("brandied_fruit", 75)
    group:item("moonshine", 86)
    group:item("beer", 80)
    group:item("fruit_wine", 40)
    group:item("brandy", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bar_food", kind = "distribution" }
    group:item("mayonnaise", 3)
    group:group("ketchup_sealed_rng", 3)
    group:group("mustard_sealed_rng", 3)
    group:group("barbecue_sauce_sealed_rng", 2)
    group:group("honey_mustard_sealed_rng", 1)
    group:group("pickle_jar_glass_sealed_2", 5)
    group:item("pickle", 5)
    group:item("cheeseburger", 10)
    group:group("fried_mozzarella_sticks_bag_plastic_4", 5)
    group:item("hamburger", 8)
    group:item("sloppyjoe", 6)
    group:item("fries", 10)
    group:item("cheese_fries", 7)
    group:item("onion_rings", 8)
    group:group("hotdogs_cooked_wrapper_1_inf", 6)
    group:group("hotdogs_newyork_wrapper_1_inf", 5)
    group:group("crab_cakes_box_small_1_inf", 8)
    group:group("stuffed_clams_box_small_1_inf", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bar_table", kind = "distribution" }
    group:group("cig_box_cigarette_1_20", 50)
    group:entry { item = "matches", charges = { 1, 20 }, probability = 45 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 45 }
    group:entry { item = "rolling_paper", charges = { 1, 30 }, probability = 10 }
    group:item("bottle_glass", 70)
    group:item("shot_glass", 60)
    group:item("bucket", 5)
    group:item("can_drink", 65)
    group:item("wrapper", 50)
    group:item("wrapper_foil", 5)
    group:item("ceramic_plate", 40)
    group:item("news_regional", 20)
    group:item("mag_news", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bar_bathroom", kind = "distribution" }
    group:entry { item = "weed", count = { 1, 5 }, probability = 40 }
    group:group("coke_bag_zipper_1_8", 40)
    group:group("bottle_otc_painkiller_1_20", 40)
    group:group("cig_box_cigarette_1_20", 20)
    group:item("syringe", 30)
    group:group("meth_bag_zipper_1_6", 20)
    group:group("heroin_bag_zipper_1_4", 7)
    group:item("mag_porn", 35)
    group:item("hairpin", 5)
    group:item("purse", 15)
    group:group("SUS_toilet", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_display", kind = "distribution" }
    group:item("pizza_meat", 50)
    group:item("pizza_veggy", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_fridge", kind = "distribution" }
    group:item("sauce_red", 29)
    group:item("royal_beef", 3)
    group:item("can_sardine", 18)
    group:item("onion", 14)
    group:item("chili_pepper", 14)
    group:item("can_chicken", 13)
    group:item("bacon", 15)
    group:item("cheese", 38)
    group:item("mozzarella_cheese", 25)
    group:item("sauce_pesto", 12)
    group:item("zucchini", 13)
    group:item("tomato", 10)
    group:item("mushroom", 27)
    group:item("sausage", 25)
    group:item("pineapple", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_table", kind = "distribution" }
    group:group("cig_box_cigarette_1_20", 15)
    group:entry { item = "rolling_paper", charges = { 1, 30 }, probability = 7 }
    group:item("wrapper", 35)
    group:item("wrapper_foil", 2)
    group:item("ceramic_plate", 40)
    group:item("cup_plastic", 40)
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 10 }
    group:item("chips", 20)
    group:item("news_regional", 12)
    group:item("flyer", 7)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_locker", kind = "distribution" }
    group:item("towel", 15)
    group:entry { item = "soap", charges = { 1, 10 }, probability = 15 }
    group:group("detergent_small_box_part", 10)
    group:group("borax_box_part", 10)
    group:group("bleach_jug_part", 15)
    group:item("broom", 13)
    group:item("fursuit", 7, "dinosuit")
    group:item("hat_ball", 19)
    group:item("jacket_light", 15)
    group:item("mbag", 10)
    group:item("cotton_patchwork", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_bathroom", kind = "distribution" }
    group:entry { item = "weed", count = { 1, 5 }, probability = 40 }
    group:group("coke_bag_zipper_1_8", 20)
    group:group("meth_bag_zipper_1_6", 1)
    group:group("bottle_otc_painkiller_1_20", 15)
    group:item("mag_porn", 30)
    group:item("purse", 10)
    group:item("hairpin", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_counter", kind = "distribution" }
    group:item("atomic_coffee", 3)
    group:item("bottle_glass", 5)
    group:item("ceramic_cup", 30)
    group:group("choco_coffee_beans_bag_plastic_5", 40)
    group:group("licorice_bag_plastic_4", 10)
    group:item("coffee", 55)
    group:group("cookies_box_snack_4", 5)
    group:item("cup_plastic", 70)
    group:item("tea", 15)
    group:group("toast_bag_plastic_2", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_newsstand", kind = "distribution" }
    group:item("mag_news", 35)
    group:item("news_regional", 35)
    group:item("newest_newspaper", 55)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_freezer", kind = "distribution" }
    group:group("blt_wrapper_2", 40)
    group:item("insta_salad", 60)
    group:item("pudding", 40)
    group:item("sandwich_pb", 35)
    group:item("sandwich_pbh", 35)
    group:item("sandwich_pbj", 40)
    group:item("sandwich_pbm", 10)
    group:group("sandwich_t_wrapper_2", 45)
    group:item("yoghurt", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_dishes", kind = "distribution" }
    group:item("ceramic_cup", 70)
    group:item("ceramic_plate", 50)
    group:item("cup_plastic", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_bathroom", kind = "distribution" }
    group:entry { item = "weed", count = { 1, 5 }, probability = 10 }
    group:group("coke_bag_zipper_1_8", 10)
    group:group("bottle_otc_painkiller_1_20", 45)
    group:item("mag_news", 30)
    group:item("purse", 10)
    group:item("hairpin", 25)
    group:group("SUS_toilet", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fast_table", kind = "distribution" }
    group:item("cup_plastic", 60)
    group:item("wrapper", 60)
    group:item("wrapper_foil", 6)
    group:item("bag_plastic", 45)
    group:item("cotton_patchwork", 10)
    group:item("fries", 25)
    group:item("cheese_fries", 15)
    group:item("onion_rings", 20)
    group:item("cheeseburger", 15)
    group:group("fried_mozzarella_sticks_bag_plastic_4", 15)
    group:item("hamburger", 15)
    group:item("fish_sandwich", 10)
    group:group("soda_in_small_container", 75)
    group:group("hotdogs_cooked_wrapper_1_inf", 25)
    group:group("hotdogs_newyork_wrapper_1_inf", 15)
    group:group("crab_cakes_box_small_1_inf", 20)
    group:group("stuffed_clams_box_small_1_inf", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fast_bath", kind = "distribution" }
    group:item("hairpin", 10)
    group:item("briefs", 10)
    group:item("tieclip", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_premade", kind = "distribution" }
    group:group("blt_wrapper_2", 50)
    group:item("sandwich_pbj", 50)
    group:item("sandwich_pbh", 20)
    group:item("sandwich_pbf", 20)
    group:item("sandwich_pbm", 10)
    group:item("sandwich_pb", 35)
    group:item("fish_sandwich", 20)
    group:group("sandwich_t_wrapper_2", 50)
    group:item("junk_burrito", 30)
    group:item("taco", 40)
    group:item("insta_salad", 60)
    group:item("yoghurt", 50)
    group:item("macaroni_cooked", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cereal_in_container_full", kind = "distribution" }
    group:group("oatmeal_box_1lb", 50)
    group:group("breakfast_cereal_in_box_full", 400)
    group:group("toastem_box_small_8")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_pasta", kind = "distribution" }
    group:group("box_spaghetti_1lb", 60)
    group:group("box_lasagne_1lb", 50)
    group:group("box_macaroni_1lb", 60)
    group:group("box_macncheese", 50)
    group:entry { item = "noodles_fast", count = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_frozen", kind = "distribution" }
    group:group("frozen_dinner_box_small_2", 80)
    group:group("pizza_veggy_box_small_4", 50)
    group:group("pizza_meat_box_small_4", 50)
    group:item("junk_burrito", 50)
    group:item("icecream_artificial", 30)
    group:item("icecream_candy", 20)
    group:item("sundae_cup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_meat", kind = "distribution" }
    group:group("bologna_bag_plastic_10", 50)
    group:item("sausage", 50)
    group:entry { item = "bratwurst_sausage", count = { 10, 10 }, probability = 35 }
    group:item("sweet_sausage", 10)
    group:group("hotdogs_frozen_bag_plastic_10", 50)
    group:item("lunchmeat", 60)
    group:item("meat", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_dairyegg", kind = "distribution" }
    group:group("eggs_in_carton", 65)
    group:group("milk_in_container_full", 80)
    group:entry { item = "milk_raw", charges = { -1, -1 }, probability = 5 }
    group:group("groce_dairyfake", 40)
    group:group("butter_wrapper_8", 35)
    group:item("buttermilk", 15)
    group:group("cheese_bag_plastic", 60)
    group:item("cottage_cheese", 30)
    group:item("yoghurt", 40)
    group:item("pudding", 30)
    group:item("icecream", 30)
    group:item("icecream_artificial", 15)
    group:item("sundae_cup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_dairyfake", kind = "distribution" }
    group:entry { item = "soy_milk", charges = { -1, -1 }, probability = 60 }
    group:entry { item = "almond_milk", charges = { -1, -1 }, probability = 20 }
    group:entry { item = "hazelnut_milk", charges = { -1, -1 }, probability = 10 }
    group:entry { item = "oat_milk", charges = { -1, -1 }, probability = 15 }
    group:entry { item = "walnut_milk", charges = { -1, -1 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaur_table", kind = "distribution" }
    group:item("candlestick", 50)
    group:item("ceramic_plate", 70)
    group:item("ceramic_bowl", 50)
    group:item("glass", 70)
    group:item("spoon", 50)
    group:item("fork", 50)
    group:item("knife_butter", 40)
    group:item("knife_small", 35, "knife_steak")
    group:item("spork", 10)
    group:item("foon", 10)
    group:item("bottle_glass", 15)
    group:group("bar_alcohol", 68)
    group:item("currywurst", 5)
    group:item("macaroni_cooked", 5)
    group:item("lasagne", 5)
    group:item("foodplace_food", 2)
    group:item("spaghetti_pesto", 5)
    group:item("glazed_tenderloin", 5)
    group:item("toad_in_a_hole", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sea_restaur_table", kind = "distribution" }
    group:item("candlestick", 50)
    group:item("ceramic_plate", 70)
    group:item("ceramic_bowl", 50)
    group:item("glass", 70)
    group:item("spoon", 50)
    group:item("fork", 50)
    group:item("knife_butter", 40)
    group:item("knife_small", 35, "knife_steak")
    group:item("bottle_glass", 15)
    group:group("bar_alcohol", 68)
    group:item("lobster_roll", 10)
    group:item("soup_lobsterstew", 5)
    group:item("lobster_cooked", 10)
    group:item("lobster_platter", 10)
    group:item("fish_fried", 10)
    group:item("fish_sandwich", 10)
    group:group("cornbread_in_bag", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaur_bath", kind = "distribution" }
    group:item("coke", 5)
    group:item("restaurantmap", 2)
    group:item("touristmap", 2)
    group:item("purse", 10)
    group:item("hairpin", 10)
    group:item("cig", 10)
    group:item("news_regional", 10)
    group:item("mag_news", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaur_rack", kind = "distribution" }
    group:item("ceramic_plate", 50)
    group:item("glass", 50)
    group:item("knife_butter", 30)
    group:item("knife_small", 15, "knife_steak")
    group:item("spoon", 20)
    group:item("fork", 20)
    group:item("spork", 5)
    group:item("foon", 5)
    group:group("wines_worthy", 66)
    group:item("fruit_wine", 20)
    group:item("gloves_cut_resistant", 5)
    group:item("armguard_cut_resistant", 2)
    group:item("hat_chef", 30)
    group:item("jacket_chef", 30)
    group:item("apron_cotton", 30)
    group:item("waist_apron_long", 20)
    group:item("waist_apron_short", 20)
    group:item("pants_checkered", 28)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaur_sink", kind = "distribution" }
    group:item("ceramic_plate", 50)
    group:item("glass", 50)
    group:item("knife_butter", 50)
    group:item("knife_small", 25, "knife_steak")
    group:item("spoon", 50)
    group:item("fork", 50)
    group:item("spork", 5)
    group:item("foon", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salad_bar", kind = "distribution" }
    group:item("bowl_plastic", 80)
    group:item("veggy_salad", 6)
    group:entry { item = "tomato", container = "bowl_plastic", probability = 8 }
    group:entry { item = "onion", container = "bowl_plastic", probability = 6 }
    group:entry { item = "broccoli", container = "bowl_plastic", probability = 6 }
    group:entry { item = "celery", container = "bag_plastic", probability = 6 }
    group:group("cabbage_bag_plastic_8", 12)
    group:group("carrot_bowl_plastic_2", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soup_bar", kind = "distribution" }
    group:item("pot", 90)
    group:entry { item = "soup_chicken", charges = { 1, 1 }, container = "pot", probability = 12 }
    group:entry { item = "soup_chicken", charges = { 2, 2 }, container = "pot", probability = 6 }
    group:entry { item = "soup_fish", charges = { 1, 1 }, container = "pot", probability = 9 }
    group:entry { item = "soup_fish", charges = { 2, 2 }, container = "pot", probability = 4 }
    group:entry { item = "soup_tomato", charges = { 1, 1 }, container = "pot", probability = 10 }
    group:entry { item = "soup_tomato", charges = { 2, 2 }, container = "pot", probability = 5 }
    group:entry { item = "soup_veggy", charges = { 1, 1 }, container = "pot", probability = 10 }
    group:entry { item = "soup_veggy", charges = { 2, 2 }, container = "pot", probability = 5 }
    group:group("oyster_crackers_plastic_bag_vac_8", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "diner_food", kind = "distribution" }
    group:item("cheeseburger", 6)
    group:item("hamburger", 8)
    group:item("sloppyjoe", 6)
    group:group("blt_wrapper_2", 6)
    group:item("fries", 10)
    group:group("fried_mozzarella_sticks_bag_plastic_4", 6)
    group:item("onion_rings", 8)
    group:group("fchicken_box_small_4", 8)
    group:item("sausage", 8)
    group:entry { item = "bratwurst_sausage", count = { 10, 10 }, probability = 6 }
    group:item("sweet_sausage", 2)
    group:item("hotdogs_cooked", 8)
    group:group("chilidogs_wrapper_2", 6)
    group:group("corndogs_cooked_wrapper_2", 8)
    group:entry { item = "scrambled_eggs", count = { 2, 2 }, probability = 8 }
    group:item("tofu_rice", 4)
    group:entry { item = "deluxe_eggs", count = { 3, 3 }, probability = 5 }
    group:entry { item = "pancakes", count = { 4, 4 }, probability = 12 }
    group:entry { item = "fruit_pancakes", count = { 4, 4 }, probability = 6 }
    group:entry { item = "choc_pancakes", count = { 4, 4 }, probability = 6 }
    group:item("waffles", 10)
    group:item("fruit_waffles", 6)
    group:item("choc_waffles", 6)
    group:group("pie_box_small_8", 9)
    group:group("pie_meat_box_small_8", 8)
    group:item("pan", 30)
    group:group("hotdogs_newyork_wrapper_1_inf", 5)
    group:group("crab_cakes_box_small_1_inf", 8)
    group:group("stuffed_clams_box_small_1_inf", 8)
    group:group("toast_bag_plastic_2", 12)
    group:group("PBJ_Toast_bag_plastic_2", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "diner_back", kind = "distribution" }
    group:group("pickle_jar_glass_sealed_2", 20)
    group:group("bacon_bag_plastic_2", 20)
    group:item("fries", 20)
    group:item("onion_rings", 20)
    group:item("sausage", 20)
    group:entry { item = "bratwurst_sausage", count = { 10, 10 }, probability = 10 }
    group:item("sweet_sausage", 5)
    group:group("hotdogs_frozen_bag_plastic_10", 20)
    group:group("corndogs_frozen_bag_plastic_2", 20)
    group:entry { item = "pancakes", count = { 4, 4 }, probability = 20 }
    group:item("waffles", 20)
    group:item("tomato", 20)
    group:entry { item = "lettuce", count = { 5, 5 }, probability = 20 }
    group:item("soup_veggy", 20)
    group:item("soup_meat", 20)
    group:item("soup_tomato", 20)
    group:group("crab_cakes_box_small_1_inf", 12)
    group:group("stuffed_clams_box_small_1_inf", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "keg_beer", kind = "distribution" }
    group:item("keg")
    group:entry { item = "beer", charges = { -1, -1 }, container = "keg", probability = 40 }
    group:entry { item = "drink_hard_seltzer", charges = { -1, -1 }, container = "keg", probability = 40 }
    group:entry { item = "belgian_ale", charges = { -1, -1 }, container = "keg", probability = 30 }
    group:entry { item = "european_pilsner", charges = { -1, -1 }, container = "keg", probability = 20 }
    group:entry { item = "wine_barley", charges = { -1, -1 }, container = "keg", probability = 17 }
    group:entry { item = "india_pale_ale", charges = { -1, -1 }, container = "keg", probability = 20 }
    group:entry { item = "pale_ale", charges = { -1, -1 }, container = "keg", probability = 20 }
    group:entry { item = "stout", charges = { -1, -1 }, container = "keg", probability = 10 }
    group:entry { item = "imperial_stout", charges = { -1, -1 }, container = "keg", probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flask_liquor", kind = "distribution" }
    group:item("flask_hip")
    group:entry { item = "whiskey", container = "flask_hip", probability = 40 }
    group:entry { item = "single_pot_whiskey", container = "flask_hip", probability = 20 }
    group:entry { item = "cheap_whiskey", container = "flask_hip", probability = 40 }
    group:entry { item = "canadian_whiskey", container = "flask_hip", probability = 40 }
    group:entry { item = "vodka", container = "flask_hip", probability = 30 }
    group:entry { item = "gin", container = "flask_hip", probability = 20 }
    group:entry { item = "rum", container = "flask_hip", probability = 20 }
    group:entry { item = "tequila", container = "flask_hip", probability = 20 }
    group:entry { item = "brandy", container = "flask_hip", probability = 10 }
    group:entry { item = "moonshine", container = "flask_hip", probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "butcher_raw_meat", kind = "distribution" }
    group:item("stomach_large", 2)
    group:item("stomach_boiled", 2)
    group:item("meat", 8)
    group:item("lunchmeat", 6)
    group:group("hotdogs_frozen_bag_plastic_10", 6)
    group:entry { item = "lung", count = { 5, 5 }, probability = 2 }
    group:entry { item = "kidney", count = { 5, 5 }, probability = 2 }
    group:entry { item = "liver", count = { 5, 5 }, probability = 4 }
    group:entry { item = "brain", count = { 5, 5 }, probability = 2 }
    group:entry { item = "sweetbread", count = { 2, 2 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "butcher_meat", kind = "distribution" }
    group:item("lunchmeat", 15)
    group:group("bologna_bag_plastic_10", 10)
    group:item("sausage", 4)
    group:item("sweet_sausage", 2)
    group:entry { item = "bratwurst_sausage", count = { 10, 10 }, probability = 4 }
    group:item("meat_salted", 2)
    group:item("meat_canned", 2)
    group:item("offal_canned", 2)
    group:item("meat_smoked", 2)
    group:group("meat_pickled_jar_glass_sealed_2", 2)
    group:group("offal_pickled_jar_glass_sealed_2", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "butcher_tools", kind = "distribution" }
    group:item("knife_small", 20, "knife_steak")
    group:item("knife_huge", 30, "knife_butcher")
    group:item("butchering_kit", 5)
    group:item("tongs", 10)
    group:item("carver_off", 5)
    group:item("meat", 1)
    group:item("hacksaw", 10)
    group:item("gloves_cut_resistant", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaurant_mexican_table", kind = "collection" }
    group:entry {
        distribution = {
            { item = "nachosc", container = "ceramic_bowl", probability = 60 },
            { item = "nachosmc", container = "ceramic_bowl", probability = 60 },
            { item = "nachosv", container = "bowl_plastic", probability = 60 },
            { item = "nachosvc", container = "ceramic_bowl", probability = 60 },
            { item = "nachosm", container = "ceramic_bowl", probability = 60 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "deluxe_beansnrice", container = "ceramic_bowl", probability = 60 },
            { item = "rice_cooked", container = "ceramic_bowl", probability = 60 },
            { item = "beans_cooked", container = "ceramic_bowl", probability = 60 },
            { item = "beansnrice", container = "ceramic_bowl", probability = 60 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "taco", count = { 1, 3 }, container = "wrapper", probability = 50 },
            { item = "homemade_burrito", container = "wrapper", probability = 60 },
            { item = "nopalitos", container = "ceramic_bowl", probability = 20 },
            { item = "quesadilla_cheese", count = { 1, 2 }, container = "wrapper", probability = 40 },
        },
        probability = 60,
    }
    group:entry {
        collection = {
            { item = "nachos", container = "ceramic_bowl" },
            { item = "salsa", container = "ceramic_bowl", probability = 90 },
        },
        probability = 60,
    }
    group:item("hot_sauce", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "food_mexican_truck", kind = "collection" }
    group:entry {
        distribution = {
            { item = "nachosc", container = "bowl_plastic", probability = 60 },
            { item = "nachosmc", container = "bowl_plastic", probability = 60 },
            { item = "nachosv", container = "bowl_plastic", probability = 60 },
            { item = "nachosvc", container = "bowl_plastic", probability = 60 },
            { item = "nachosm", container = "bowl_plastic", probability = 60 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "deluxe_beansnrice", container = "bowl_plastic", probability = 60 },
            { item = "rice_cooked", container = "bowl_plastic", probability = 60 },
            { item = "beans_cooked", container = "bowl_plastic", probability = 60 },
            { item = "beansnrice", container = "bowl_plastic", probability = 60 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "taco", count = { 1, 3 }, container = "wrapper", probability = 50 },
            { item = "homemade_burrito", container = "wrapper", probability = 60 },
            { item = "nopalitos", container = "bowl_plastic", probability = 20 },
            { item = "quesadilla_cheese", count = { 1, 2 }, container = "wrapper", probability = 40 },
        },
        probability = 60,
    }
    group:group("nachos_bowl_plastic_full", 30)
    group:item("hot_sauce", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kitchen_sealed_3L_jar", kind = "distribution", container = "jar_3l_glass_sealed" }
    group:entry { item = "meat_canned", count = { 12, 12 }, container = "null", probability = 4 }
    group:entry { item = "veggy_canned", count = { 12, 12 }, container = "null", probability = 4 }
    group:entry { item = "apple_canned", count = { 24, 24 }, probability = 4 }
    group:entry { item = "offal_canned", count = { 12, 12 }, container = "null", probability = 1 }
    group:entry { item = "can_tomato", count = { 24, 24 }, container = "null", probability = 8 }
    group:entry { item = "fish_pickled", count = { 12, 12 }, container = "null", probability = 2 }
    group:entry { item = "meat_pickled", count = { 12, 12 }, container = "null", probability = 2 }
    group:entry { item = "fish_pickled", count = { 12, 12 }, container = "null", probability = 2 }
    group:entry { item = "sauce_red", count = { 6, 6 }, container = "null", probability = 8 }
    group:entry { item = "kompot", count = { 12, 12 }, container = "null", probability = 4 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kitchen_plastic_bag", kind = "distribution", container = "bag_plastic" }
    group:entry { item = "dry_beans", count = { 1, 96 }, container = "null", probability = 4 }
    group:entry { item = "dry_rice", count = { 1, 48 }, container = "null", probability = 8 }
    group:entry { item = "dry_lentils", count = { 1, 32 }, container = "null", probability = 4 }
    group:entry { item = "tortilla_flour", count = { 1, 50 }, container = "null", probability = 4 }
    group:entry { item = "tortilla_corn", count = { 1, 50 }, container = "null", probability = 4 }
    group:entry { item = "oats", count = { 1, 8 }, container = "null", probability = 4 }
    group:entry { item = "flour", count = { 1, 100 }, container = "null", probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kitchen_sack", kind = "distribution", container = "bag_canvas" }
    group:entry { item = "potato", count = { 1, 40 }, container = "null", probability = 6 }
    group:entry { item = "carrot", count = { 1, 102 }, container = "null", probability = 4 }
    group:entry { item = "onion", count = { 1, 60 }, container = "null", probability = 4 }
    content.add(group)
end

do
    -- Large amounts of butter, milk, and eggs for use in baking.
    -- These are large-ish quantities for use in commercial bakeries.
    local group = content.ItemGroup { id = "bakery_dairy", kind = "collection" }
    group:entry { group = "milk_in_big_container_full", count = { 1, 3 }, probability = 50 }
    group:entry { group = "milk_in_big_container_full", count = { 2, 4 }, probability = 40 }
    group:entry { group = "butter_wrapper_8", count = { 2, 4 }, probability = 50 }
    group:entry { group = "butter_wrapper_8", count = { 2, 5 }, probability = 40 }
    group:entry { group = "eggs_in_carton", count = { 1, 2 }, probability = 50 }
    group:entry { group = "eggs_in_carton", count = { 1, 3 }, probability = 40 }
    content.add(group)
end
