local content = require("ccb").content

do
    local group = content.ItemGroup { id = "stash_wood", kind = "distribution" }
    group:item("stick", 95)
    group:item("ax", 8)
    group:item("saw", 15)
    group:item("2x4", 60)
    group:item("plank_short", 40)
    group:item("plank_long", 25)
    group:item("wooden_post", 60)
    group:item("wooden_post_long", 25)
    group:item("wooden_post_short", 40)
    group:item("wood_block", 75)
    group:item("log", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stash_drugs", kind = "distribution" }
    group:group("pills_sleep_bottle_plastic_pill_prescription_1_10", 15)
    group:group("antihistamine_bottle_plastic_pill_supplement_1_30", 10)
    group:group("melatonin_tablet_bottle_plastic_pill_supplement_1_30", 5)
    group:group("oxycodone_bottle_plastic_pill_prescription_1_10", 4)
    group:entry { item = "morphine", count = { 1, 4 }, probability = 4 }
    group:group("xanax_bottle_plastic_pill_prescription_1_10", 10)
    group:group("adderall_bottle_plastic_pill_prescription_1_10", 10)
    group:item("pipe_tobacco", 2)
    group:group("tobacco_bag_plastic_1_20", 2)
    group:item("adrenaline_injector", 2)
    group:entry { item = "weed", count = { 1, 5 }, probability = 50 }
    group:item("joint", 10)
    group:item("seed_weed", 35)
    group:item("seed_tobacco", 15)
    group:item("rolling_paper", 9)
    group:item("pipe_glass", 17)
    group:group("coke_bag_zipper_1_8", 8)
    group:group("meth_bag_zipper_1_6", 2)
    group:group("heroin_bag_zipper_1_4", 1)
    group:group("crack_bag_zipper_1_4", 4)
    group:item("crackpipe", 7)
    group:item("pipe_water", 5)
    group:group("antifungal_bottle_plastic_pill_prescription_1_5", 1)
    group:group("antiparasitic_bottle_plastic_pill_prescription_1_10", 2)
    group:group("diazepam_bottle_plastic_pill_prescription_1_10", 1)
    group:entry { item = "lsd", count = { 1, 5 }, probability = 6 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stash_drugs_illegals", kind = "distribution" }
    group:group("oxycodone_bottle_plastic_pill_prescription_1_10", 4)
    group:entry { item = "morphine", count = { 1, 4 }, probability = 4 }
    group:group("xanax_bottle_plastic_pill_prescription_1_10", 10)
    group:group("adderall_bottle_plastic_pill_prescription_1_10", 10)
    group:item("pipe_tobacco", 2)
    group:group("tobacco_bag_plastic_1_20", 2)
    group:item("seed_tobacco", 15)
    group:item("rolling_paper", 9)
    group:item("pipe_glass", 17)
    group:group("coke_bag_zipper_1_8", 8)
    group:group("meth_bag_zipper_1_6", 2)
    group:group("heroin_bag_zipper_1_4", 1)
    group:group("crack_bag_zipper_1_4", 4)
    group:item("crackpipe", 7)
    group:group("diazepam_bottle_plastic_pill_prescription_1_10", 1)
    group:entry { item = "lsd", count = { 1, 5 }, probability = 6 }
    content.add(group)
end

do
    -- randomized assortment of possible bugout bags people would have as the apocalypse ramped up
    local group = content.ItemGroup { id = "bugout_bag", kind = "distribution" }
    group:entry {
        distribution = {
            { group = "small_bugout_bag_1" },
            { group = "small_bugout_bag_2" },
            { group = "small_bugout_bag_3" },
            { group = "small_bugout_bag_4" },
        },
        probability = 50,
    }
    group:group("medium_bugout", 40)
    group:group("heavy_bugout", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "small_bugout_bag_1",
        kind = "distribution",
        container = "backpack",
        overflow = "spill",
    }
    group:group("small_bugout")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "small_bugout_bag_2",
        kind = "distribution",
        container = "daypack",
        overflow = "spill",
    }
    group:group("small_bugout")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "small_bugout_bag_3",
        kind = "distribution",
        container = "backpack_leather",
        overflow = "spill",
    }
    group:group("small_bugout")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "small_bugout_bag_4",
        kind = "distribution",
        container = "backpack_denim",
        overflow = "spill",
    }
    group:group("small_bugout")
    content.add(group)
end

do
    -- a light bugout, stuff people would have on hand, not super full
    local group = content.ItemGroup { id = "small_bugout", kind = "collection" }
    group:group("bugout_meds_easy", 90)
    group:group("full_1st_aid", 20)
    group:group("guns_pistol_common", 45)
    group:group("bugout_tools", 50)
    group:entry { group = "bugout_food_easy", count = { 1, 2 }, probability = 60 }
    group:group("bugout_water", 50)
    group:group("bugout_bad_pack")
    content.add(group)
end

do
    -- a medium bugout, stuff people would have had if preppers, or they had foresight
    local group = content.ItemGroup {
        id = "medium_bugout",
        kind = "collection",
        container = "backpack_hiking",
        overflow = "spill",
    }
    group:entry { group = "bugout_meds_prepper", count = { 1, 2 }, probability = 75 }
    group:group("bugout_first_aid", 80)
    group:group("bugout_gun", 50)
    group:group("bugout_tools", 80)
    group:entry { group = "bugout_food_easy", count = { 1, 4 }, probability = 25 }
    group:entry { group = "bugout_food_1l", count = { 2, 6 }, probability = 80 }
    group:entry { group = "bugout_food_9l", count = { 1, 2 }, probability = 40 }
    group:entry { group = "bugout_water", count = { 1, 2 }, probability = 90 }
    group:entry { group = "bugout_extras", count = { 1, 4 } }
    group:group("prepper_maps", 80)
    group:group("civilian_armor", 35)
    content.add(group)
end

do
    -- a huge bugout, stuff for people waiting their whole lives for the apocalypse
    local group = content.ItemGroup {
        id = "heavy_bugout",
        kind = "collection",
        container = "backpack_tactical_large",
        overflow = "spill",
    }
    group:entry { group = "bugout_meds_prepper", count = { 2, 4 }, probability = 80 }
    group:entry { group = "bugout_first_aid", count = { 1, 1 }, probability = 90 }
    group:group("guns_pistol_common", 70)
    group:group("bugout_long_gun", 20)
    group:group("bugout_tools", 80)
    group:entry { group = "bugout_food_easy", count = { 1, 2 }, probability = 25 }
    group:entry { group = "bugout_food_1l", count = { 2, 4 }, probability = 50 }
    group:entry { group = "bugout_food_9l", count = { 2, 4 }, probability = 90 }
    group:entry { group = "bugout_water", count = { 1, 2 }, probability = 20 }
    group:group("used_survival_kit", 60)
    group:entry { group = "bugout_extras", count = { 4, 12 } }
    group:entry { group = "civilian_armor", count = { 2, 2 }, probability = 35 }
    group:group("prepper_maps")
    group:group("bugout_large_extras", 40)
    content.add(group)
end

do
    -- Everything vaguely medical on hand quickly shoved into the bag.
    local group = content.ItemGroup { id = "bugout_meds_easy", kind = "collection" }
    group:entry { group = "adhesive_bandages_box_used", count = { 1, 2 }, probability = 95 }
    group:group("SUS_bathroom_medicine", 80)
    content.add(group)
end

do
    -- First aid supplies, if you had time to prepare.
    local group = content.ItemGroup { id = "bugout_first_aid", kind = "collection" }
    group:entry {
        distribution = {
            { group = "full_1st_aid", probability = 50 },
            { group = "used_1st_aid", probability = 50 },
        },
        probability = 90,
    }
    group:entry {
        distribution = {
            { group = "full_ifak", probability = 70 },
            { group = "used_ifak", probability = 20 },
            { group = "full_ipok", probability = 10 },
        },
        probability = 70,
    }
    group:entry { group = "tools_medical", count = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    -- a long weapon of some kind.
    local group = content.ItemGroup { id = "bugout_long_gun", kind = "distribution" }
    group:group("guns_rifle_common", 120)
    group:group("guns_shotgun_common", 3)
    content.add(group)
end

do
    -- a gun or two of some kind.
    local group = content.ItemGroup { id = "bugout_gun", kind = "distribution" }
    group:group("guns_pistol_common")
    group:group("bugout_long_gun", 20)
    content.add(group)
end

do
    -- hastily-gathered items for eating and survival.
    local group = content.ItemGroup { id = "bugout_tools", kind = "collection" }
    group:entry { item = "fork", count = { 1, 2 }, probability = 95 }
    group:entry { item = "knife_butter", count = { 1, 2 }, probability = 90 }
    group:entry { item = "knife_small", count = { 1, 2 }, probability = 80 }
    group:entry { item = "spoon", count = { 1, 2 }, probability = 90 }
    group:entry {
        distribution = {
            { item = "tin_plate", probability = 40 },
            { item = "plastic_plate", probability = 60 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "bottle_metal", probability = 50 },
            { item = "thermos", probability = 50 },
            { item = "canteen", probability = 20 },
            { item = "2lcanteen", probability = 20 },
            { item = "camelbak", probability = 10 },
        },
        probability = 80,
    }
    group:group("tools_lighting", 80)
    group:item("teleumbrella", 50)
    group:entry {
        distribution = {
            { item = "knife_large", probability = 120 },
            { item = "knife_cleaver", probability = 30 },
            { item = "boxcutter", probability = 60 },
            { item = "xacto", probability = 60 },
            { item = "knife_swissarmy", probability = 60 },
            { item = "pockknife", probability = 10 },
            { item = "switchblade", probability = 10 },
            { item = "knife_folding", probability = 10 },
            { item = "utility_knife_folding", probability = 5 },
            { item = "scalpel", probability = 5 },
        },
        probability = 20,
    }
    group:group("roadmap_stock", 5)
    group:item("trailmap", 5)
    group:item("whistle", 50)
    group:item("can_opener", 80)
    content.add(group)
end

do
    -- food easily found in a hurry.
    local group = content.ItemGroup { id = "bugout_food_easy", kind = "distribution" }
    group:entry { group = "canned_staples_1l", count = { 2, 6 } }
    group:entry { group = "groce_pasta", count = { 2, 6 } }
    group:entry { group = "dollar_food", count = { 2, 6 } }
    group:entry { group = "snacks", count = { 4, 4 } }
    content.add(group)
end

do
    -- about 1L worth of food with long shelf life
    local group = content.ItemGroup { id = "bugout_food_1l", kind = "distribution" }
    group:entry { item = "freeze_dried_meal", count = { 4, 4 } }
    group:entry { group = "MRE", count = { 1, 1 } }
    group:entry { group = "peanuts_ziploc", count = { 2, 2 } }
    group:entry { group = "jerky_ziploc", count = { 2, 2 } }
    group:entry { group = "pemmican_ziploc", count = { 2, 2 } }
    group:group("canned_staples_1l")
    group:entry { group = "dry_lentils_bag_plastic_full", count = { 2, 2 } }
    group:entry { group = "dry_rice_bag_plastic_full", count = { 2, 2 } }
    group:entry { group = "flatbread_in_bag_full", count = { 2, 2 } }
    group:entry { item = "peanutbutter", count = { 2, 2 } }
    group:entry { item = "jam_fruit", count = { 2, 2 } }
    group:entry { item = "protein_bar_evac", count = { 6, 6 } }
    content.add(group)
end

do
    -- about 9L/2 gallons worth of food with long shelf life
    local group = content.ItemGroup { id = "bugout_food_9l", kind = "distribution" }
    group:entry { group = "MRE", count = { 4, 4 } }
    group:entry { group = "freeze_dried_meal_box_any", count = { 4, 4 } }
    group:entry { group = "jerky_ziploc_gallon_irradiated", count = { 2, 2 } }
    group:entry { group = "pemmican_ziploc_gallon", count = { 2, 2 } }
    group:entry { group = "pemmican_ziploc_gallon_irradiated", count = { 2, 2 } }
    group:entry { group = "hardtack_ziploc_gallon", count = { 2, 2 } }
    group:entry { group = "can_beans_can_food_big_12", count = { 3, 3 } }
    group:entry { group = "full_box_of_evacuation_protein_bar", count = { 4, 4 } }
    content.add(group)
end

do
    -- a form of water, up to 3L or a gallon.
    local group = content.ItemGroup { id = "bugout_water", kind = "distribution" }
    group:entry { item = "water_clean", count = { 2, 6 }, probability = 60 }
    group:entry { item = "water_clean", charges = { -1, -1 }, container = "jug_plastic", probability = 20 }
    group:entry { item = "water_mineral", count = { 2, 6 }, probability = 40 }
    group:entry { item = "sports_drink", count = { 2, 6 }, probability = 40 }
    group:entry { item = "rehydration_drink", count = { 2, 6 }, probability = 5 }
    content.add(group)
end

do
    -- extra useful items for inside a bugout bag.
    local group = content.ItemGroup { id = "bugout_extras", kind = "distribution" }
    group:item("radio", 25)
    group:entry { group = "gear_survival", count = { 2, 2 }, probability = 50 }
    group:entry { group = "hiking", count = { 2, 2 }, probability = 75 }
    group:entry {
        collection = {
            { group = "camping_huntingweapon", probability = 2 },
            { group = "camping_lighting", probability = 80 },
            { group = "camping_cooking", probability = 10 },
            { group = "camping_blades", probability = 40 },
        },
        probability = 75,
    }
    group:group("bugout_bad_pack", 150)
    content.add(group)
end

do
    -- Large items of questionable use in a bugout bag.
    local group = content.ItemGroup { id = "bugout_large_extras", kind = "distribution" }
    group:item("folding_solar_panel")
    content.add(group)
end

do
    -- an item that wouldn't be super useful to the player, recreational items and such.
    local group = content.ItemGroup { id = "bugout_bad_pack", kind = "distribution" }
    group:entry { item = "towel", count = { 1, 1 }, probability = 50 }
    group:entry { group = "pet_food_in_container", count = { 1, 2 }, probability = 20 }
    group:group("SUS_book", 50)
    group:group("games", 20)
    group:group("bugout_memento", 50)
    group:entry { group = "jewelry_front", count = { 1, 4 }, probability = 40 }
    group:entry { group = "jewelry_safe", count = { 4, 12 }, probability = 10 }
    group:group("tampon_box_full", 20)
    group:group("menstrual_pad_box_full", 20)
    group:item("flyer_evac", 40)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "child_bugout_bag_1",
        kind = "distribution",
        container = "backpack_small",
        overflow = "spill",
    }
    group:group("child_bugout")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "child_bugout_bag_2",
        kind = "distribution",
        container = "backpack_leather",
        overflow = "spill",
    }
    group:group("child_bugout")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "child_bugout_bag_3",
        kind = "distribution",
        container = "backpack_denim",
        overflow = "spill",
    }
    group:group("child_bugout")
    content.add(group)
end

do
    -- a collection of items a kid could have haphazardly packed together before running away from home
    local group = content.ItemGroup { id = "child_bugout", kind = "collection" }
    group:group("bugout_toys", 50)
    group:group("bugout_child_snacks")
    group:group("bugout_water", 75)
    group:group("bugout_tools", 40)
    group:group("bugout_food_easy", 33)
    group:group("lunchbox_with_contents", 67)
    group:item("toothbrush_plain", 10)
    group:item("childnote", 33)
    content.add(group)
end

do
    -- this list is for toys that children may have wanted to take with themselves while preparing to run away for whatever reason.
    local group = content.ItemGroup { id = "bugout_toys", kind = "distribution" }
    group:item("talking_doll", 50)
    group:item("teddy_bear", 50)
    group:item("toy_figurine", 45)
    group:item("toy_figurine_large", 35)
    group:item("bath_toy", 30)
    group:item("yoyo", 30)
    group:item("fidget_spinner", 30)
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 30 }
    group:group("toy_radio_car", 10)
    group:group("toy_makerspace_kit", 10)
    group:group("toy_robot_kit", 10)
    group:group("toy_engine_kit", 10)
    group:item("shark_plushie", 2)
    group:item("air_launcher", 2)
    content.add(group)
end

do
    -- this list is for food that children may have wanted to take with themselves while preparing to run away for whatever reason.
    local group = content.ItemGroup { id = "bugout_child_snacks", kind = "distribution" }
    group:group("candy_chocolate", 75)
    group:group("salty_snacks", 75)
    group:group("soda_in_small_container", 55)
    group:group("soda_in_container", 45)
    group:group("cookies_box_snack_1_4", 30)
    group:group("toastems", 15)
    content.add(group)
end

do
    -- collected over the years by someone who anticipated the Internet going down
    local group = content.ItemGroup { id = "prepper_maps", kind = "collection" }
    group:group("roadmap_stock", 99)
    group:item("trailmap", 90)
    group:item("urbexmap", 25)
    group:item("subwaystationmap", 75)
    group:item("subwaymap", 10)
    group:item("sewermap", 10)
    content.add(group)
end

do
    -- 1L of calorie dense canned food, not things like tomatoes or pineapples
    local group = content.ItemGroup { id = "canned_staples_1l", kind = "distribution" }
    group:entry { group = "beans_in_can", count = { 2, 2 } }
    group:entry { group = "pork_beans_in_can", count = { 2, 2 } }
    group:entry { group = "chicken_in_can", count = { 2, 2 } }
    group:entry { group = "chili_in_can", count = { 2, 2 } }
    group:entry { group = "ravioli_in_can", count = { 2, 2 } }
    group:entry { group = "spam_in_can", count = { 2, 2 } }
    group:entry { item = "milk_evap", count = { 2, 2 } }
    group:entry { group = "tuna_in_can", count = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pemmican_ziploc", kind = "collection", container = "bag_zipper" }
    group:entry { item = "pemmican", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pemmican_ziploc_gallon", kind = "collection", container = "bag_zipper_gallon" }
    group:entry { item = "pemmican", count = { 37, 37 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hardtack_ziploc_gallon", kind = "collection", container = "bag_zipper_gallon" }
    group:entry { item = "hardtack", count = { 64, 64 } }
    content.add(group)
end

do
    -- A pessimist planning for a catastrophe, excluding serious first aid items.
    local group = content.ItemGroup { id = "bugout_meds_prepper", kind = "collection" }
    group:entry { group = "adhesive_bandages_box_full", count = { 1, 1 }, probability = 80 }
    group:entry { group = "alcohol_wipes_box_full", count = { 1, 1 }, probability = 50 }
    group:entry { group = "cotton_ball_bag_full", count = { 1, 1 }, probability = 60 }
    group:entry { item = "liq_bandage_spray", charges = { 1, -1 }, probability = 30 }
    group:entry { group = "vitc_tablet_bottle_full", count = { 1, 1 }, probability = 30 }
    group:entry {
        item = "calcium_tablet",
        count = { 30, -1 },
        wrapper = "bottle_plastic_pill_supplement",
        container = "null",
        probability = 30,
    }
    group:entry {
        item = "gummy_vitamins",
        count = { 25, -1 },
        wrapper = "bottle_plastic_pill_supplement",
        container = "null",
        probability = 20,
    }
    group:entry {
        item = "antibiotics",
        count = { 30, -1 },
        wrapper = "bottle_plastic_pill_supplement",
        container = "null",
        probability = 30,
    }
    group:entry {
        item = "iodine",
        count = { 30, -1 },
        wrapper = "bottle_plastic_pill_supplement",
        container = "null",
        probability = 30,
    }
    group:entry {
        item = "prussian_blue",
        count = { 12, -1 },
        wrapper = "bottle_plastic_pill_supplement",
        container = "null",
        probability = 20,
    }
    group:entry {
        item = "antifungal",
        count = { 30, -1 },
        wrapper = "bottle_plastic_pill_supplement",
        container = "null",
        probability = 10,
    }
    group:entry {
        item = "antiparasitic",
        count = { 30, -1 },
        wrapper = "bottle_plastic_pill_supplement",
        container = "null",
        probability = 10,
    }
    group:entry {
        item = "homeopathic_pills",
        count = { 30, -1 },
        wrapper = "bottle_plastic_pill_supplement",
        container = "null",
        probability = 10,
    }
    group:entry { group = "drugs_analgesic", count = { 1, 2 }, probability = 40 }
    group:entry { group = "drugs_misc", count = { 1, 2 }, probability = 5 }
    group:entry { group = "drugs_rare", count = { 1, 2 }, probability = 5 }
    group:entry { item = "wrapped_rad_badge", count = { 1, 4 }, probability = 5 }
    group:entry { group = "jar_weed", count = { 1, 1 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "peanuts_ziploc", kind = "collection", container = "bag_zipper" }
    group:entry { item = "peanut_shelled", count = { -1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "jerky_ziploc", kind = "collection", container = "bag_zipper" }
    group:entry { item = "jerky", count = { -1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "jerky_ziploc_gallon_irradiated",
        kind = "collection",
        container = "bag_zipper_gallon",
    }
    group:entry {
        item = "jerky",
        count = { -1, -1 },
        container = "null",
        flags = {
            "IRRADIATED",
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pemmican_ziploc_gallon_irradiated",
        kind = "collection",
        container = "bag_zipper_gallon",
    }
    group:entry {
        item = "pemmican",
        count = { 37, 37 },
        container = "null",
        flags = {
            "IRRADIATED",
        },
    }
    content.add(group)
end
