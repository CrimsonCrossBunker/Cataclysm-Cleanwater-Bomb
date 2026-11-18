local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hotdogs_frozen_bag_plastic_10", kind = "collection", container = "bowl_plastic" }
    group:entry { item = "hotdogs_frozen", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corndogs_frozen_bag_plastic_2", kind = "collection", container = "bowl_plastic" }
    group:entry { item = "corndogs_frozen", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chilidogs_wrapper_2", kind = "collection", container = "wrapper" }
    group:entry { item = "chilidogs", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corndogs_cooked_wrapper_2", kind = "collection", container = "wrapper" }
    group:entry { item = "corndogs_cooked", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "currywurst_wrapper_2", kind = "collection", container = "wrapper" }
    group:entry { item = "currywurst", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bacon_bag_plastic_2", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "bacon", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bologna_bag_plastic_10", kind = "collection", container = "bowl_plastic" }
    group:entry { item = "bologna", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stuffed_clams_box_small_5", kind = "collection", container = "box_small" }
    group:entry { item = "stuffed_clams", count = { 5, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "breakfast_cereal_in_box", kind = "distribution", container = "box_small" }
    group:entry { item = "cereal", count = { 1, 4 }, probability = 30 }
    group:entry { item = "cereal2", count = { 1, 4 }, probability = 30 }
    group:entry { item = "cereal3", count = { 1, 4 }, probability = 30 }
    group:entry { item = "cereal_fp1", count = { 1, 4 }, variant = "snicker", probability = 1 }
    group:entry { item = "cereal_fp1", count = { 1, 4 }, variant = "brantastic", probability = 1 }
    group:entry { item = "cereal_fp1", count = { 1, 4 }, variant = "honey", probability = 1 }
    group:entry { item = "cereal_fp1", count = { 1, 4 }, variant = "fructose", probability = 1 }
    group:entry { item = "cereal_fp1", count = { 1, 4 }, variant = "foodios", probability = 1 }
    group:entry { item = "cereal_fp2", count = { 1, 4 }, probability = 1 }
    group:entry { item = "cereal_fp4", count = { 1, 4 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "breakfast_cereal_in_box_full", kind = "distribution", container = "box_small" }
    group:entry { item = "cereal", count = { 4, 4 }, probability = 30 }
    group:entry { item = "cereal2", count = { 4, 4 }, probability = 30 }
    group:entry { item = "cereal3", count = { 4, 4 }, probability = 30 }
    group:entry { item = "cereal_fp1", count = { 4, 4 }, variant = "snicker", probability = 1 }
    group:entry { item = "cereal_fp1", count = { 4, 4 }, variant = "brantastic", probability = 1 }
    group:entry { item = "cereal_fp1", count = { 4, 4 }, variant = "honey", probability = 1 }
    group:entry { item = "cereal_fp1", count = { 4, 4 }, variant = "fructose", probability = 1 }
    group:entry { item = "cereal_fp1", count = { 4, 4 }, variant = "foodios", probability = 1 }
    group:entry { item = "cereal_fp2", count = { 4, 4 }, probability = 1 }
    group:entry { item = "cereal_fp4", count = { 4, 4 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "frozen_dinner_box_small_2", kind = "collection", container = "box_small" }
    group:entry { item = "frozen_dinner", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pemmican_bag_small", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "pemmican", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soup_box", kind = "distribution", container = "box_small" }
    group:entry { group = "soup_packet", count = { 1, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soup_packet", kind = "distribution", container = "bag_paper_powder" }
    group:entry { item = "soup_instant_chicken_noodle_powder", container = "null" }
    group:entry { item = "soup_instant_vegetable_powder", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "instant_gravy", kind = "distribution" }
    group:group("instant_gravy_tub", 1)
    group:entry { group = "instant_gravy_packets", count = { 1, 12 }, probability = 8 }
    content.add(group)
end

do
    -- Higher chance of vegan gravy as a lot of food services will keep vegan just because it's good enough and won't cause fuss with diet restrictions.
    -- Odd serving count as I really didn't feel like adding a specific gravy powder container
    local group = content.ItemGroup { id = "instant_gravy_tub", kind = "distribution", container = "plastic_bucket" }
    group:entry { item = "gravy_mix", count = { 850, 850 }, probability = 1 }
    group:entry { item = "vegan_gravy_mix", count = { 850, 850 }, probability = 7 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "instant_gravy_packets", kind = "distribution", container = "bag_paper_powder" }
    group:entry { item = "gravy_mix", count = { 8, 8 }, probability = 1 }
    group:entry { item = "vegan_gravy_mix", count = { 8, 8 }, probability = 7 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spread_peanutbutter_2", kind = "collection", container = "can_food" }
    group:entry { item = "spread_peanutbutter", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chicken_fried_box_6", kind = "collection", container = "box_small" }
    group:entry { item = "chicken_fried", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fchicken_box_small_4", kind = "collection", container = "box_small" }
    group:entry { item = "fchicken", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sushi_veggyroll_bowl_2", kind = "collection", container = "bowl_plastic" }
    group:entry { item = "sushi_veggyroll", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "fried_mozzarella_sticks_bag_plastic_4",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "fried_mozzarella_sticks", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "foodplace_food_box_small_4", kind = "collection", container = "box_small" }
    group:entry { item = "foodplace_food", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_meat_box_small_4", kind = "collection", container = "box_small" }
    group:entry { item = "pizza_meat", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_veggy_box_small_4", kind = "collection", container = "box_small" }
    group:entry { item = "pizza_veggy", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pizza_cheese_box_small_4", kind = "collection", container = "box_small" }
    group:entry { item = "pizza_cheese", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pie_box_small_8", kind = "collection", container = "box_small" }
    group:entry { item = "pie", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pie_meat_box_small_8", kind = "collection", container = "box_small" }
    group:entry { item = "pie_meat", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pie_veggy_box_small_8", kind = "collection", container = "box_small" }
    group:entry { item = "pie_veggy", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pie_maple_box_small_8", kind = "collection", container = "box_small" }
    group:entry { item = "pie_maple", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nachos_bowl_plastic_full", kind = "collection", container = "bowl_plastic" }
    group:entry { item = "nachos", count = { 9, 9 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nachos_bag_plastic_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "nachos", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "veggy_salad_bowl_2", kind = "collection", container = "bowl_plastic" }
    group:entry { item = "veggy_salad", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cabbage_bag_plastic_8", kind = "collection", container = "bag_plastic" }
    group:entry { item = "cabbage", count = { 8, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "carrot_bowl_plastic_2", kind = "collection", container = "bowl_plastic" }
    group:entry { item = "carrot", count = { 2, 2 } }
    content.add(group)
end
