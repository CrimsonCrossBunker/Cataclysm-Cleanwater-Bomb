local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bag_chips", kind = "distribution" }
    group:entry { item = "chips", count = { 1, 1 }, variant = "plain", wrapper = "bag_chips_small", probability = 33 }
    group:entry { item = "chips", count = { 2, 2 }, variant = "plain", wrapper = "bag_chips_medium", probability = 33 }
    group:entry { item = "chips", count = { 3, 3 }, variant = "plain", wrapper = "bag_chips_large", probability = 33 }
    group:entry { item = "chips", count = { 1, 1 }, variant = "barbecue", wrapper = "bag_chips_small", probability = 21 }
    group:entry { item = "chips", count = { 2, 2 }, variant = "barbecue", wrapper = "bag_chips_medium", probability = 21 }
    group:entry { item = "chips", count = { 3, 3 }, variant = "barbecue", wrapper = "bag_chips_large", probability = 21 }
    group:entry { item = "chips", count = { 1, 1 }, variant = "onion", wrapper = "bag_chips_small", probability = 12 }
    group:entry { item = "chips", count = { 2, 2 }, variant = "onion", wrapper = "bag_chips_medium", probability = 12 }
    group:entry { item = "chips", count = { 3, 3 }, variant = "onion", wrapper = "bag_chips_large", probability = 12 }
    group:entry { item = "chips", count = { 1, 1 }, variant = "cheddar", wrapper = "bag_chips_small", probability = 10 }
    group:entry { item = "chips", count = { 2, 2 }, variant = "cheddar", wrapper = "bag_chips_medium", probability = 10 }
    group:entry { item = "chips", count = { 3, 3 }, variant = "cheddar", wrapper = "bag_chips_large", probability = 10 }
    group:entry { item = "chips", count = { 1, 1 }, variant = "vinegar", wrapper = "bag_chips_small", probability = 9 }
    group:entry { item = "chips", count = { 2, 2 }, variant = "vinegar", wrapper = "bag_chips_medium", probability = 9 }
    group:entry { item = "chips", count = { 3, 3 }, variant = "vinegar", wrapper = "bag_chips_large", probability = 9 }
    group:entry { item = "chips", count = { 1, 1 }, variant = "paprika", wrapper = "bag_chips_small", probability = 6 }
    group:entry { item = "chips", count = { 2, 2 }, variant = "paprika", wrapper = "bag_chips_medium", probability = 6 }
    group:entry { item = "chips", count = { 3, 3 }, variant = "paprika", wrapper = "bag_chips_large", probability = 6 }
    group:entry { item = "chips", count = { 1, 1 }, variant = "alldressed", wrapper = "bag_chips_small", probability = 6 }
    group:entry { item = "chips", count = { 2, 2 }, variant = "alldressed", wrapper = "bag_chips_medium", probability = 6 }
    group:entry { item = "chips", count = { 3, 3 }, variant = "alldressed", wrapper = "bag_chips_large", probability = 6 }
    group:entry { item = "chips", count = { 1, 1 }, variant = "mixed", wrapper = "bag_chips_small", probability = 5 }
    group:entry { item = "chips", count = { 2, 2 }, variant = "mixed", wrapper = "bag_chips_medium", probability = 5 }
    group:entry { item = "chips", count = { 3, 3 }, variant = "mixed", wrapper = "bag_chips_large", probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candy_chocolate", kind = "distribution" }
    group:group("chocolate_wrapper_3", 70)
    group:group("candy_bag_plastic_3", 70)
    group:group("candy2_bag_plastic_3", 70)
    group:group("candy3_bag_plastic_3", 70)
    group:group("candy4_bag_plastic_3", 70)
    group:group("cow_candy_bag_plastic_3", 20)
    group:group("maltballs_box_snack_4", 60)
    group:group("mintpatties_bag_plastic_3", 60)
    group:group("neccowafers_bag_plastic_3", 55)
    group:entry { item = "powder_candy", count = { 5, 5 }, probability = 50 }
    group:group("candycigarette_box_cigarette_3", 15)
    group:group("maple_candy_bag_plastic_2", 10)
    group:group("candy_bracelet_bag_plastic_3", 10)
    group:group("candy_coated_peanuts_box_snack_2", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "salty_snacks", kind = "distribution" }
    group:group("bag_chips", 195)
    group:group("pretzels_bag_plastic_3", 55)
    group:item("jerky", 55)
    group:group("porkstick_bag_plastic_4", 55)
    group:group("nachos_bag_plastic_full", 50)
    group:group("chocpretzels_bag_plastic_3", 40)
    group:group("popcorn_bag_various", 95)
    group:group("cracklins_bag_plastic_4", 25)
    group:group("fried_seeds_bag_plastic_4", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "snacks_fancy", kind = "distribution" }
    group:item("water_mineral", 30)
    group:item("sandwich_cucumber", 25)
    group:item("juice", 20)
    group:item("tomato_juice", 15)
    group:group("granola_bag_plastic_4", 15)
    group:group("mintpatties_bag_plastic_3", 8)
    group:group("choco_coffee_beans_bag_plastic_5", 8)
    group:group("fruit_leather_bag_plastic_full", 15)
    group:group("pine_nuts_bag_plastic_4", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dessert", kind = "distribution" }
    group:item("milkshake", 15)
    group:item("milkshake_deluxe", 5)
    group:item("icecream", 10)
    group:item("sundae_cup", 10)
    group:item("frozen_lemonade", 5)
    group:item("milkshake_choc", 7)
    group:item("milkshake_deluxe_choc", 2)
    group:item("icecream_choc", 5)
    group:item("icecream_candy", 8)
    group:item("icecream_custard", 4)
    group:item("icecream_sorbet", 4)
    group:item("icecream_gelato", 4)
    group:group("pie_box_small_8", 20)
    group:group("pie_veggy_box_small_8", 15)
    group:group("pie_meat_box_small_8", 15)
    group:group("pie_maple_box_small_8", 10)
    group:group("pecorino_cheese_wrapper_4", 10)
    group:item("tiramisu", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cookies_box_snack_4", kind = "collection", container = "box_snack" }
    group:entry { item = "cookies", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cookies_box_snack_1_4", kind = "collection", container = "box_snack" }
    group:entry { item = "cookies", count = { 1, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "oyster_crackers_box_20", kind = "collection", container = "box_small" }
    group:entry { item = "oyster_crackers", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "oyster_crackers_plastic_bag_vac_8",
        kind = "collection",
        container = "plastic_bag_vac",
    }
    group:entry { item = "oyster_crackers", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crackers_box_16", kind = "collection", container = "box_small" }
    group:entry { item = "crackers", count = { 16, 16 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toastems", kind = "distribution" }
    group:group("toastem_box_small_8")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toastem_box_small_8", kind = "collection", container = "box_small" }
    group:entry { item = "toastem", count = { 8, 8 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toasterpastryfrozen_box_snack_2", kind = "collection", container = "box_snack" }
    group:entry { item = "toasterpastryfrozen", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "brioche_box_small_6", kind = "collection", container = "box_small" }
    group:entry { item = "brioche", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "brownie_box_small_4", kind = "collection", container = "box_small" }
    group:entry { item = "brownie", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biscuit_box_small_10", kind = "collection", container = "box_small" }
    group:entry { item = "biscuit", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "onion_rings_box_6", kind = "collection", container = "box_small" }
    group:entry { item = "onion_rings", count = { 6, 6 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "choco_coffee_beans_bag_plastic_5",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "choco_coffee_beans", count = { 5, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "fruit_leather_bag_plastic_full",
        kind = "collection",
        container = "bag_plastic_small",
    }
    group:entry { item = "fruit_leather", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dry_lentils_bag_plastic_full", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "dry_lentils", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candy_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "candy", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candy2_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "candy2", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candy3_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "candy3", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candy4_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "candy4", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cow_candy_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cow_candy", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chocolate_wrapper_3", kind = "collection", container = "wrapper" }
    group:entry { item = "chocolate", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chocolate_wrapper_1_3", kind = "collection", container = "wrapper" }
    group:entry { item = "chocolate", count = { 1, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "neccowafers_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "neccowafers", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "maltballs_box_snack_4", kind = "collection", container = "box_snack" }
    group:entry { item = "maltballs", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mintpatties_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "mintpatties", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candycigarette_box_cigarette_3", kind = "collection", container = "box_cigarette" }
    group:entry { item = "candycigarette", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "maple_candy_bag_plastic_2", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "maple_candy", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candy_bracelet_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "candy_bracelet", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "candy_coated_peanuts_box_snack_2", kind = "collection", container = "box_snack" }
    group:entry { item = "candy_coated_peanuts", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "licorice_bag_plastic_4", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "licorice", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "licorice_bag_plastic_1_4", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "licorice", count = { 1, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pretzels_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "pretzels", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "porkstick_bag_plastic_4", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "porkstick", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chocpretzels_bag_plastic_3", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "chocpretzels", count = { 3, 3 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "popcorn_bag_various", kind = "distribution", container = "bag_plastic_small" }
    group:entry { item = "popcorn", count = { 4, 4 }, container = "null", probability = 1 }
    group:entry { item = "popcorn2", count = { 4, 4 }, container = "null", probability = 4 }
    group:entry { item = "popcorn3", count = { 4, 4 }, container = "null", probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fried_seeds_bag_plastic_4", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "fried_seeds", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cracklins_bag_plastic_4", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "cracklins", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pine_nuts_bag_plastic_4", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "pine_nuts", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "oats_bag_plastic_full", kind = "collection", container = "bag_plastic" }
    group:entry { item = "oats", count = { 2, 2 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "peanut_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "peanut", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "peanut_shelled_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "peanut_shelled", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chestnut_roasted_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "chestnut_roasted", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pistachio_shelled_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "pistachio_shelled", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pistachio_roasted_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "pistachio_roasted", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "almond_roasted_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "almond_roasted", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cashews_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "cashews", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pecan_shelled_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "pecan_shelled", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pecan_roasted_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "pecan_roasted", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "granola_bag_plastic_4", kind = "collection", container = "bag_plastic_small" }
    group:entry { item = "granola", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_any_box_12", kind = "distribution" }
    group:group("protein_bar_milk_box_12", 40)
    group:group("protein_bar_peanut_box_12", 40)
    group:group("protein_bar_zero_box_12", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_any_box_12_opened", kind = "distribution" }
    group:group("protein_bar_milk_box_12_opened", 40)
    group:group("protein_bar_peanut_box_12_opened", 40)
    group:group("protein_bar_zero_box_12_opened", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_box_of_evacuation_protein_bar", kind = "collection", container = "box_small" }
    group:entry { item = "protein_bar_evac", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_of_evacuation_protein_bar", kind = "collection", container = "box_small" }
    group:entry { item = "protein_bar_evac", count = { 1, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_zero_box_12", kind = "collection", container = "box_snack" }
    group:entry { item = "protein_bar_zero", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_zero_box_12_opened", kind = "collection", container = "box_snack" }
    group:entry { item = "protein_bar_zero", count = { 1, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_peanut_box_12", kind = "collection", container = "box_snack" }
    group:entry { item = "protein_bar_peanut", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_peanut_box_12_opened", kind = "collection", container = "box_snack" }
    group:entry { item = "protein_bar_peanut", count = { 1, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_milk_box_12", kind = "collection", container = "box_snack" }
    group:entry { item = "protein_bar_milk", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bar_milk_box_12_opened", kind = "collection", container = "box_snack" }
    group:entry { item = "protein_bar_milk", count = { 1, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chewing_gum_any", kind = "distribution" }
    group:group("chewing_gum_full", 10)
    group:group("chewing_gum_full_caff", 1)
    group:group("chewing_gum_full_nic", 1)
    group:group("chewing_gum_used", 30)
    group:group("chewing_gum_used_caff", 2)
    group:group("chewing_gum_used_nic", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chewing_gum_full",
        kind = "distribution",
        container = "blister_pack_small",
        container_variant = "blister_pack_gum",
    }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_peppermint", probability = 70 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_spearmint", probability = 60 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_wintergreen", probability = 60 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_bubblegum", probability = 50 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_strawberry", probability = 50 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_cherry", probability = 50 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_orange", probability = 50 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_watermelon", probability = 50 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_blueberry", probability = 50 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_pineapple", probability = 30 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_greenapple", probability = 30 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_mango", probability = 17 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_lemonade", probability = 40 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_pomegranate", probability = 30 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_raspberry", probability = 50 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_kiwi", probability = 20 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_peach", probability = 20 }
    group:entry { item = "gum", count = { 12, 12 }, variant = "gum_blackberry", probability = 35 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chewing_gum_full_caff",
        kind = "distribution",
        container = "blister_pack_small",
        container_variant = "blister_pack_gum",
    }
    group:entry { item = "caff_gum", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chewing_gum_full_nic",
        kind = "distribution",
        container = "blister_pack_small",
        container_variant = "blister_pack_gum",
    }
    group:entry { item = "nic_gum", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "oyster_crackers_plastic_bag_vac_1_inf",
        kind = "collection",
        container = "plastic_bag_vac",
    }
    group:entry { item = "oyster_crackers", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crackers_box_small_full", kind = "collection", container = "box_small" }
    group:entry { item = "crackers", count = { -1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "onion_rings_box_small_1_inf", kind = "collection", container = "box_small" }
    group:entry { item = "onion_rings", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chewing_gum_used",
        kind = "distribution",
        container = "blister_pack_small",
        container_variant = "blister_pack_gum",
    }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_peppermint", probability = 70 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_spearmint", probability = 60 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_wintergreen", probability = 60 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_bubblegum", probability = 50 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_strawberry", probability = 50 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_cherry", probability = 50 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_orange", probability = 50 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_watermelon", probability = 50 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_blueberry", probability = 50 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_pineapple", probability = 30 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_greenapple", probability = 30 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_mango", probability = 17 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_lemonade", probability = 40 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_pomegranate", probability = 30 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_raspberry", probability = 50 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_kiwi", probability = 20 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_peach", probability = 20 }
    group:entry { item = "gum", count = { 0, 12 }, variant = "gum_blackberry", probability = 35 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chewing_gum_used_caff",
        kind = "distribution",
        container = "blister_pack_small",
        container_variant = "blister_pack_gum",
    }
    group:entry { item = "caff_gum", count = { 0, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chewing_gum_used_nic",
        kind = "distribution",
        container = "blister_pack_small",
        container_variant = "blister_pack_gum",
    }
    group:entry { item = "caff_gum", count = { 0, 12 } }
    content.add(group)
end
