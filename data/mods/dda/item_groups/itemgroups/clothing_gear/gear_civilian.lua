local content = require("ccb").content

do
    -- Items that smoker would carry on them.
    -- Ratios roughly aqcuired from here: https://www.mass.gov/info-details/massachusetts-tobacco-statistics-at-a-glance
    local group = content.ItemGroup { id = "everyday_smoker", kind = "collection" }
    group:entry {
        distribution = {
            { group = "smoker_cigarette", probability = 66 },
            { group = "smoker_e_cigarette", probability = 42 },
            { group = "smoker_smokeless_tobacco", probability = 10 },
            {
                collection = {
                    { item = "cigar", count = { 0, 2 } },
                    {
                        distribution = {
                            { item = "cigar_cutter", probability = 50 },
                            { item = "cigar_punch", probability = 50 },
                        },
                        probability = 50,
                    },
                },
                probability = 27,
            },
        },
    }
    group:group("everyday_lighter", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "everyday_lighter", kind = "distribution" }
    group:item("lighter", 2)
    group:item("small_lighter", 2)
    group:item("ref_lighter", 2)
    group:item("ref_lighter_butane", 2)
    group:entry { item = "matches", charges = { 0, 20 }, probability = 1 }
    group:entry { item = "ref_matches", charges = { 0, 32 }, probability = 1 }
    content.add(group)
end

do
    -- Tobacco products a cigarette smoker would carry on them.
    local group = content.ItemGroup { id = "smoker_cigarette", kind = "collection" }
    group:entry { group = "cig_box_cigarette_1_20", count = { 1, 3 }, probability = 80 }
    group:entry {
        collection = {
            { group = "tobacco_bag_plastic_1_20", count = { 1, 2 }, probability = 80 },
            { item = "rolling_paper", count = { 1, 20 }, probability = 80 },
            { item = "pipe_tobacco", probability = 10 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- Smokeless tobacoo products.
    local group = content.ItemGroup { id = "smoker_smokeless_tobacco", kind = "collection" }
    group:entry { group = "chaw_wrapper_1_20", count = { 1, 2 }, probability = 60 }
    group:entry { group = "nic_pouch_can_opened", count = { 1, 2 }, probability = 60 }
    group:group("nic_pouch_can_new", 20)
    content.add(group)
end

do
    -- ~10% of people carry knives on them - https://www.akti.org/wp-content/uploads/US-Knives-in-2015.pdf
    local group = content.ItemGroup { id = "everyday_knives", kind = "distribution" }
    group:item("multitool", 15)
    group:item("knife_swissarmy", 15)
    group:item("pockknife", 10)
    group:item("knife_folding", 10)
    content.add(group)
end

do
    -- Regular items for the homeless.
    local group = content.ItemGroup { id = "gear_homeless", kind = "distribution" }
    group:group("everyday_gear")
    group:group("donated_clothes", 50)
    group:group("gear_survival", 20)
    group:group("novels", 50)
    group:entry { group = "cannedfood", count = { 1, 3 }, probability = 60 }
    group:group("wallet_duct_tape_full", 1)
    group:item("ankle_wallet_pouch", 1)
    group:item("drink_hobo", 1)
    content.add(group)
end

do
    -- Stuff that kids would have in their pockets or otherwise carry on them when they turned. NOT for items that they could have been carrying in their hands - those would have fallen out of their grasp once they died.
    local group = content.ItemGroup { id = "child_items_pockets", kind = "distribution" }
    group:group("candy_chocolate", 200)
    group:group("toastems", 25)
    group:group("cookies_box_snack_1_4", 80)
    group:group("licorice_bag_plastic_1_4", 10)
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 30 }
    group:group("soda_in_small_container", 55)
    group:group("soda_in_container", 30)
    group:item("backpack", 48)
    group:item("backpack_denim", 8)
    group:item("purse", 20)
    group:item("slingpack", 19)
    group:item("travelpack", 10)
    group:item("petpack", 1)
    group:item("armrig", 3)
    group:item("leg_small_bag", 3)
    group:item("leg_bag", 1)
    group:item("bookstrap", 1)
    group:item("pockknife", 14)
    group:item("knife_swissarmy", 10)
    group:item("teleumbrella", 2)
    group:group("civilian_usb_drives", 10)
    group:group("writing_utensils", 40)
    group:group("child_schoolbag_1", 500)
    group:group("child_schoolbag_2", 150)
    group:group("child_schoolbag_3", 150)
    group:group("child_bugout_bag_1")
    group:group("child_bugout_bag_2", 25)
    group:group("child_bugout_bag_3", 5)
    group:item("novel_pulp", 16)
    group:item("elbow_pads", 20)
    group:item("knee_pads", 20)
    group:entry { item = "radiocontrol", charges = { 0, 100 }, probability = 5 }
    group:item("RPG_die", 1)
    group:item("metal_RPG_die", 1)
    group:group("decks_of_cards", 1)
    content.add(group)
end

do
    -- Hats for zombie children.
    local group = content.ItemGroup { id = "child_hats", kind = "distribution" }
    group:item("helmet_football", 30)
    group:item("helmet_ball", 30)
    group:item("hat_ball", 10)
    group:item("hat_golf", 5)
    group:item("helmet_bike", 70)
    group:item("helmet_riding", 5)
    group:group("helmet_bike_modified", 10)
    content.add(group)
end

do
    -- Shoes for zombie children.
    local group = content.ItemGroup { id = "child_shoes", kind = "distribution" }
    group:item("roller_shoes_off", 30)
    group:item("roller_shoes_on", 25)
    group:item("rollerskates", 40)
    group:item("roller_blades", 35)
    group:item("sneakers", 50)
    group:item("lowtops", 40)
    group:item("dance_shoes", 25)
    group:item("slippers", 30)
    group:item("flip_flops", 35)
    group:item("flip_flops_exp", 5)
    group:item("leathersandals", 40)
    group:item("espadrilles", 20)
    group:item("bastsandals", 20)
    group:item("sneakers_steel", 20)
    group:item("knee_high_boots", 20)
    group:item("thigh_high_boots", 15)
    group:item("boots", 25)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "child_schoolbag_1",
        kind = "distribution",
        container = "backpack_small",
        overflow = "spill",
    }
    group:group("child_schoolbag_contents")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "child_schoolbag_2",
        kind = "distribution",
        container = "backpack_leather",
        overflow = "spill",
    }
    group:group("child_schoolbag_contents")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "child_schoolbag_3",
        kind = "distribution",
        container = "backpack_denim",
        overflow = "spill",
    }
    group:group("child_schoolbag_contents")
    content.add(group)
end

do
    -- A list of items that would have had a decent chance to appear in a pre-apocalypse child schoolbag.
    local group = content.ItemGroup { id = "child_schoolbag_contents", kind = "collection" }
    group:group("pencil_case_with_contents", 70)
    group:group("book_school", 65)
    group:group("book_school", 55)
    group:group("kids_books", 15)
    group:group("lunchbox_with_contents", 45)
    group:group("candy_chocolate", 12)
    group:group("soda_in_small_container", 5)
    group:group("soda_in_container", 7)
    group:group("bugout_toys", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "lunchbox_with_contents",
        kind = "distribution",
        container = "lunchbox",
        overflow = "spill",
    }
    group:group("lunchbox_contents", 7)
    content.add(group)
end

do
    -- A list of items that would have had a decent chance to appear in a pre-apocalypse lunchbox, be it child or adult (but I did a pretty poor job at variety, I am not sure what could actually go there).
    local group = content.ItemGroup { id = "lunchbox_contents", kind = "collection" }
    group:group("lunchbox_food", 90)
    group:group("lunchbox_fruit", 35)
    group:item("plastic_fork", 30)
    group:item("plastic_knife", 30)
    group:item("plastic_spoon", 15)
    group:entry { item = "napkin", count = { 1, 5 }, probability = 15 }
    content.add(group)
end
