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

do
    local group = content.ItemGroup { id = "teashop_bulk_teas", kind = "distribution" }
    group:item("honey_bottled", 20)
    group:entry { item = "honey_glassed", count = { -1, -1 }, probability = 20 }
    group:item("con_milk", 10)
    group:group("bee_balm_jar_3l_glass_sealed_1_12", 20)
    group:entry {
        item = "jar_3l_glass_sealed",
        contents = {
            { group = "teashop_bulk_teas_no_stackable" },
        },
        probability = 40,
    }
    group:group("raw_burdock_jar_3l_glass_sealed_1_inf", 10)
    group:group("tea_raw_jar_glass_sealed_10_40", 60)
    group:group("tea_green_raw_jar_glass_sealed_10_40", 30)
    group:group("wild_herbs_jar_glass_sealed_20_inf", 50)
    group:group("raw_dandelion_jar_glass_sealed_1_inf", 10)
    group:group("milk_powder_various", 30)
    group:group("cinnamon_jar_glass_sealed_1_inf", 20)
    group:group("sugar_jar_glass_sealed_10_140", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_kitchen", kind = "distribution" }
    group:group("seasoning_italian_bulk", 23)
    group:group("seasoning_salt_bulk", 13)
    group:group("pepper_bulk", 5)
    group:group("yeast_bulk", 10)
    group:group("sugar_bulk", 9)
    group:entry { item = "cornmeal", count = { 4, -1 }, probability = 8 }
    group:group("flour_bulk", 25)
    group:item("cookbook", 3)
    group:item("cookbook_italian", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_condiments", kind = "distribution" }
    group:item("bag_plastic", 25)
    group:item("box_small", 30)
    group:entry { item = "honey_bottled", charges = { -1, -1 }, probability = 10 }
    group:entry { item = "honey_glassed", count = { -1, -1 }, probability = 10 }
    group:group("milk_in_container", 10)
    group:entry { item = "oat_milk", charges = { 1, -1 }, probability = 8 }
    group:group("milk_powder_various", 65)
    group:group("salt_various", 15)
    group:group("sugar_bulk", 70)
    group:group("artificial_sweetener_box_small_71", 15)
    group:group("tea_raw_bag_plastic_33", 15)
    group:group("tea_green_raw_bag_plastic_33", 10)
    group:item("wrapper", 75)
    group:entry { item = "wrapper_foil", count = { 5, 40 }, wrapper = "wrapper_foil_roll", probability = 5 }
    group:group("teabag_box", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_locker", kind = "distribution" }
    group:item("apron_cotton", 20)
    group:item("waist_apron_long", 5)
    group:item("waist_apron_short", 20)
    group:item("apron_leather", 5)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:item("hat_ball", 25)
    group:item("towel", 10)
    group:entry { item = "soap", charges = { 1, 10 }, probability = 8 }
    group:group("detergent_small_box_part", 4)
    group:group("borax_box_part", 4)
    group:item("cotton_patchwork", 15)
    group:item("broom", 8)
    group:group("bleach_jug_part", 8)
    group:item("hotplate", 1)
    group:entry { item = "vinegar", charges = { 1, -1 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fast_kitchen", kind = "distribution" }
    group:item("knife_huge", 30, "knife_butcher")
    group:group("bread_in_bag", 50)
    group:group("seasoning_salt_bulk", 50)
    group:group("seasoning_italian_bulk", 50)
    group:group("chicken_in_can", 30)
    group:group("sugar_bulk", 40)
    group:group("artificial_sweetener_box_small_71", 10)
    group:item("soysauce", 10)
    group:item("hot_sauce", 10)
    group:group("flour_bulk", 40)
    group:group("curry_powder_various", 40)
    group:entry { item = "cornmeal", count = { 10, -1 }, probability = 52 }
    group:group("oyster_crackers_plastic_bag_vac_1_inf", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fast_fridge", kind = "distribution" }
    group:group("hotdogs_frozen_bag_plastic_10", 30)
    group:group("cheese_bag_plastic", 60)
    group:item("fries", 40)
    group:group("chicken_in_can", 40)
    group:group("spam_in_can", 40)
    group:entry { item = "lettuce", count = { 5, 5 }, probability = 50 }
    group:group("irradiated_lettuce_bag_plastic_5", 10)
    group:item("tomato", 50)
    group:entry {
        item = "tomato",
        flags = {
            "IRRADIATED",
        },
        probability = 10,
    }
    group:item("onion", 50)
    group:entry {
        item = "onion",
        flags = {
            "IRRADIATED",
        },
        probability = 10,
    }
    group:entry { item = "chili_pepper", count = { 3, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fast_locker", kind = "distribution" }
    group:item("hat_ball", 30)
    group:item("knife_small", 20, "knife_steak")
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 40 }
    group:item("towel", 40)
    group:entry { item = "soap", charges = { 1, 10 }, probability = 30 }
    group:group("detergent_small_box_part", 15)
    group:group("borax_box_part", 15)
    group:item("cotton_patchwork", 30)
    group:group("bleach_jug_part", 30)
    group:entry { item = "vinegar", charges = { 1, -1 }, probability = 30 }
    group:item("backpack", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_bread", kind = "distribution" }
    group:group("bread_in_bag", 65)
    group:group("garlic_bread_in_bag", 20)
    group:group("brown_bread_in_bag", 50)
    group:entry { item = "cake2", count = { 12, 12 }, probability = 10 }
    group:entry { item = "cake3", count = { 12, 12 }, probability = 10 }
    group:group("cornbread_in_bag", 35)
    group:group("brioche_box_small_6", 50)
    group:entry { item = "hardtack", count = { 2, 2 }, probability = 30 }
    group:entry { item = "jihelucake", count = { 12, 12 }, probability = 10 }
    group:group("biscuit_box_small_10", 50)
    group:entry { item = "crackers", count = { -1, -1 }, probability = 40 }
    group:item("soybean_seed", 40)
    group:entry { item = "almond_shelled", count = { -1, -1 }, probability = 20 }
    group:entry { item = "pecan_shelled", count = { -1, -1 }, probability = 20 }
    group:entry { item = "cashews", count = { -1, -1 }, probability = 20 }
    group:entry { item = "pistachio_shelled", count = { -1, -1 }, probability = 20 }
    group:entry { item = "peanut_shelled", count = { -1, -1 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "groce_ingredient", kind = "distribution" }
    group:group("flour_various_full", 65)
    group:entry { item = "cornmeal", count = { -1, -1 }, probability = 50 }
    group:group("yeast_various_full", 40)
    group:group("yogurt_starter_culture_bag_plastic_4", 10)
    group:group("koji_bag_plastic_25", 2)
    group:group("powder_eggs_bottle_plastic_small_16", 55)
    group:group("milk_in_container_full", 15)
    group:item("milk_evap", 25)
    group:item("con_milk", 25)
    group:group("milk_powder_various_full", 45)
    group:group("salt_various_full", 50)
    group:item("soysauce", 25)
    group:item("hot_sauce", 25)
    group:group("sugar_various_full", 60)
    group:group("artificial_sweetener_box_small_71", 15)
    group:group("dry_rice_various", 65)
    group:group("dry_wild_rice_bag_plastic_full", 5)
    group:group("chem_citric_acid_bottle_glass_50", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaur_fridge", kind = "distribution" }
    group:entry { item = "water_clean", charges = { -1, -1 }, probability = 10 }
    group:entry { item = "water_mineral", charges = { -1, -1 }, probability = 10 }
    group:group("milk_in_container", 20)
    group:group("butter_wrapper_8_64", 35)
    group:entry { item = "ghee", charges = { 1, 64 }, sealed = false, container = "jar_glass_sealed", probability = 5 }
    group:item("yoghurt", 10)
    group:item("pudding", 15)
    group:item("apple", 10)
    group:item("sandwich_t", 15)
    group:item("mushroom", 20)
    group:item("tomato", 20)
    group:item("lettuce", 15)
    group:item("zucchini", 15)
    group:item("foodplace_food", 20)
    group:item("onion", 15)
    group:item("chili_pepper", 15)
    group:item("carrot", 15)
    group:item("potato", 15)
    group:entry {
        item = "tomato",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "lettuce",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "zucchini",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "onion",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "carrot",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:item("chili", 10)
    group:group("wines_worthy", 54)
    group:item("fish_fried", 7)
    group:item("cheese", 10)
    group:item("mozzarella_cheese", 10)
    group:item("lemon", 15)
    group:group("pickle_jar_glass_sealed_2", 10)
    group:item("lutefisk", 15)
    group:item("fries", 15)
    group:item("cheese_fries", 10)
    group:item("onion_rings", 10)
    group:item("royal_beef", 1)
    group:item("sauce_red", 8)
    group:item("tofu", 8)
    group:item("sausage", 10)
    group:item("bratwurst_sausage", 10)
    group:item("syrup", 10)
    group:item("syrup_corn", 5)
    group:item("sweet_sausage", 2)
    group:item("soup_meat", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sea_restaur_fridge", kind = "distribution" }
    group:entry { item = "water_clean", charges = { -1, -1 }, probability = 10 }
    group:entry { item = "water_mineral", charges = { -1, -1 }, probability = 10 }
    group:group("milk_in_container", 20)
    group:item("egg_bird_unfert", 20)
    group:group("butter_wrapper_8_64", 35)
    group:entry { item = "ghee", charges = { 1, 64 }, sealed = false, container = "jar_glass_sealed", probability = 5 }
    group:item("apple", 10)
    group:item("fish_sandwich", 15)
    group:item("lobster_roll", 15)
    group:item("mushroom", 20)
    group:item("tomato", 20)
    group:item("lettuce", 15)
    group:item("zucchini", 15)
    group:item("onion", 15)
    group:item("chili_pepper", 15)
    group:item("carrot", 15)
    group:item("potato", 15)
    group:entry {
        item = "tomato",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "lettuce",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "zucchini",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "onion",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "carrot",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:group("wines_worthy", 54)
    group:item("fish_fried", 7)
    group:item("fish", 80)
    group:item("egg_fish", 10)
    group:item("lobster", 40)
    group:item("lobster_cooked", 10)
    group:item("lemon", 20)
    group:group("pickle_jar_glass_sealed_2", 10)
    group:item("fries", 15)
    group:item("crab_cakes", 20)
    group:item("stuffed_clams", 20)
    group:item("onion_rings", 10)
    group:item("sauce_red", 8)
    group:item("syrup", 10)
    group:item("syrup_corn", 10)
    group:item("soup_fish", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaur_kitchen", kind = "distribution" }
    group:item("vinegar", 20)
    group:entry { item = "jam_fruit", container = "jar_3l_glass_sealed", probability = 5 }
    group:group("bread_in_bag", 17)
    group:item("confit_meat", 14)
    group:item("meat", 20)
    group:group("cornbread_in_bag", 7)
    group:item("biscuit", 8)
    group:group("seasoning_salt_bulk", 15)
    group:group("seasoning_italian_bulk", 15)
    group:item("garlic", 10)
    group:group("garlic_powder_various", 10)
    group:item("thyme", 10)
    group:item("can_chicken", 10)
    group:item("ghee", 15)
    group:group("pepper_bulk", 15)
    group:group("salt_bulk", 20)
    group:group("sugar_bulk", 5)
    group:group("flour_bulk", 30)
    group:item("soysauce", 25)
    group:item("hot_sauce", 25)
    group:group("vegetable_oil_bottle", 50)
    group:item("cookbook", 8)
    group:item("cookbook_italian", 9)
    group:entry { item = "cornmeal", count = { 10, -1 }, probability = 3 }
    group:item("knife_small", 15, "knife_steak")
    group:group("chilly-p_various", 15)
    group:group("curry_powder_various", 15)
    group:entry { item = "cheese_powder", count = { -1, -1 }, probability = 15 }
    group:entry { item = "macaroni_raw", count = { 4, -1 }, container = "bag_plastic", probability = 20 }
    group:entry { item = "spaghetti_raw", count = { 4, -1 }, container = "bag_plastic", probability = 20 }
    group:entry { item = "lasagne_raw", count = { 4, -1 }, probability = 20 }
    group:item("foodplace_food", 5)
    group:item("knife_huge", 10, "knife_butcher")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sea_restaur_kitchen", kind = "distribution" }
    group:item("vinegar", 20)
    group:item("mayonnaise", 20)
    group:group("bread_in_bag", 17)
    group:item("fish", 20)
    group:group("cornbread_in_bag", 7)
    group:item("biscuit", 8)
    group:group("seasoning_salt_bulk", 15)
    group:group("seasoning_italian_bulk", 15)
    group:item("garlic", 10)
    group:item("thyme", 10)
    group:group("fish_in_can", 10)
    group:group("lobster_in_can", 10)
    group:item("can_clams", 10)
    group:item("ghee", 15)
    group:group("pepper_bulk", 15)
    group:group("salt_bulk", 20)
    group:group("sugar_bulk", 5)
    group:group("flour_bulk", 25)
    group:item("soysauce", 25)
    group:item("hot_sauce", 25)
    group:group("vegetable_oil_bottle", 40)
    group:item("cookbook", 8)
    group:item("cookbook_daintydishes", 9)
    group:entry { item = "cornmeal", count = { 10, -1 }, probability = 3 }
    group:item("knife_small", 15, "knife_steak")
    group:group("chilly-p_various", 15)
    group:group("curry_powder_various", 15)
    group:item("macaroni_raw", 20)
    group:item("knife_huge", 10, "knife_butcher")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaurant_mexican_fridge", kind = "collection" }
    group:entry { item = "water_clean", charges = { -1, -1 }, probability = 10 }
    group:entry { item = "water_mineral", charges = { -1, -1 }, probability = 10 }
    group:group("milk_in_container", 20)
    group:group("butter_wrapper_8_64", 35)
    group:entry { item = "ghee", charges = { 1, 64 }, sealed = false, container = "jar_glass_sealed", probability = 5 }
    group:item("cactus_pad", 20)
    group:item("papaya", 20)
    group:item("fish_cooked", 20)
    group:item("boiled_egg", 20)
    group:item("mango", 20)
    group:item("spinach", 10)
    group:item("celery", 10)
    group:item("corn", 20)
    group:item("chili_pepper", 20)
    group:item("cucumber", 5)
    group:item("garlic", 20)
    group:item("tomato", 20)
    group:item("bell_pepper", 8)
    group:item("sausage_raw", 8)
    group:item("bacon", 8)
    group:item("fish", 8)
    group:item("meat", 8)
    group:item("porkbelly", 8)
    group:item("bacon_uncut", 8)
    group:item("onion", 15)
    group:item("potato", 15)
    group:item("pineapple", 20)
    group:item("tallow", 25)
    group:item("mushroom_morel", 8)
    group:item("sausage_cooked", 8)
    group:item("mushroom", 20)
    group:item("tomato", 20)
    group:item("lettuce", 15)
    group:item("chili_pepper", 15)
    group:item("carrot", 15)
    group:entry {
        item = "tomato",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "lettuce",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "onion",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:entry {
        item = "carrot",
        flags = {
            "IRRADIATED",
        },
        probability = 4,
    }
    group:item("chili", 10)
    group:item("cheese", 10)
    group:item("lemon", 15)
    group:item("sauce_red", 8)
    group:item("tofu", 8)
    group:item("sausage", 10)
    group:item("syrup", 10)
    group:item("syrup_corn", 10)
    group:item("sweet_sausage", 2)
    group:item("soup_meat", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "restaurant_mexican_pantry", kind = "collection" }
    group:group("pantry_liquids", 30)
    group:entry { group = "tortilla_corn_bag_plastic_full", count = { 1, 3 }, probability = 50 }
    group:entry { group = "tortilla_flour_bag_plastic_full", count = { 1, 3 }, probability = 50 }
    group:item("sauce_red", 30)
    group:entry { group = "nachos_bag_plastic_full", count = { 1, 3 }, probability = 60 }
    group:entry { item = "cheese_hard", count = { 4, -1 }, probability = 40 }
    group:entry { group = "beans_in_can", count = { 1, 3 }, probability = 20 }
    group:entry { group = "dry_beans_bag_plastic_full", count = { 1, 3 }, probability = 60 }
    group:entry { item = "dry_mushroom", count = { 1, 3 }, probability = 40 }
    group:entry { group = "flatbread_in_bag_full", count = { 3, 9 }, probability = 20 }
    group:entry { group = "dry_rice_various", count = { 1, 3 }, probability = 60 }
    group:group("SUS_spice_collection", 70)
    group:entry { group = "big_canned_food", count = { 1, 2 }, probability = 20 }
    group:group("dry_goods", 30)
    content.add(group)
end

do
    -- might split this into two categories; condiments and seasonings, and preserves
    local group = content.ItemGroup { id = "groce_condiment", kind = "distribution" }
    group:item("mayonnaise", 40)
    group:group("ketchup_sealed_rng", 60)
    group:group("mustard_sealed_rng", 60)
    group:group("barbecue_sauce_sealed_rng", 40)
    group:group("honey_mustard_sealed_rng", 30)
    group:item("horseradish", 10)
    group:group("sprinkles_bottle_plastic_small_62", 20)
    group:item("honey_bottled", 35)
    group:entry { item = "honey_glassed", count = { -1, -1 }, probability = 35 }
    group:group("peanutbutter_jar_sealed", 60)
    group:group("jam_fruit_jar_sealed", 60)
    group:item("marshmallow_fluff", 35)
    group:group("pickle_jar_glass_sealed_2", 40)
    group:item("coffee_syrup", 35)
    group:group("coffee_raw_bag_plastic_20", 45)
    group:group("tea_raw_bag_plastic_33", 45)
    group:group("tea_green_raw_bag_plastic_33", 20)
    group:group("salt_various_full", 50)
    group:group("pepper_various_full", 50)
    group:item("soysauce", 50)
    group:item("hot_sauce", 50)
    group:group("cinnamon_various_full", 20)
    group:item("syrup", 50)
    group:item("syrup_corn", 5)
    group:group("seasoning_salt_various_full", 45)
    group:group("seasoning_italian_various_full", 50)
    group:group("curry_powder_various_full", 40)
    group:group("cheese_in_can", 30)
    group:item("sauce_red", 40)
    group:item("sauce_pesto", 20)
    group:group("oyster_crackers_plastic_bag_vac_1_inf", 30)
    group:group("teabag_box", 45)
    content.add(group)
end
