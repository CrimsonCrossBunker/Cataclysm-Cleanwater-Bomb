local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a silverware drawer.
    local group = content.ItemGroup { id = "SUS_silverware", kind = "collection" }
    group:entry { item = "knife_butter", count = { 1, 6 } }
    group:entry { item = "knife_butter", count = { 1, 6 }, probability = 75 }
    group:entry { item = "knife_small", count = { 2, 6 }, variant = "knife_steak", probability = 85 }
    group:item("knife_small", 75, "knife_paring")
    group:entry { item = "fork", count = { 1, 6 } }
    group:entry { item = "fork", count = { 1, 6 }, probability = 75 }
    group:entry { item = "spoon", count = { 1, 6 } }
    group:entry { item = "spoon", count = { 1, 6 }, probability = 75 }
    group:entry { item = "chopsticks", count = { 1, 6 }, probability = 70 }
    group:entry {
        collection = {
            { item = "plastic_spoon", count = { 0, 6 } },
            { item = "plastic_knife", count = { 0, 6 } },
            { item = "plastic_fork", count = { 0, 6 } },
        },
        probability = 60,
    }
    group:entry {
        collection = {
            { item = "plastic_spoon", count = { 0, 6 } },
            { item = "plastic_knife", count = { 0, 6 } },
            { item = "plastic_fork", count = { 0, 6 } },
        },
        probability = 30,
    }
    group:entry { item = "plastic_spoon_kids", count = { 1, 6 }, probability = 35 }
    group:item("corkscrew", 75)
    group:item("bottle_opener", 75)
    group:entry { item = "plastic_straw", count = { 1, 6 }, probability = 50 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a regular stocked kitchen pantry.
    -- Frequency of pet food appearing based on percentage of Massachusetts homes with a pet.
    local group = content.ItemGroup { id = "SUS_pantry", kind = "collection" }
    group:entry { group = "pantry_liquids", count = { 1, 2 }, probability = 60 }
    group:entry { group = "pasta_ingredients", count = { 1, 3 }, probability = 70 }
    group:entry { group = "cannedfood", count = { 1, 6 } }
    group:entry { group = "big_canned_food", count = { 1, 2 }, probability = 20 }
    group:entry { group = "dry_goods", count = { 1, 3 }, probability = 80 }
    group:entry { group = "preserved_food", count = { 1, 2 }, probability = 20 }
    group:entry { group = "protein_bar_any_box_12_opened", count = { 1, 2 }, probability = 20 }
    group:entry { group = "baking_soda_box", count = { 1, 2 }, probability = 30 }
    group:entry { item = "garlic", count = { 1, 3 }, probability = 66 }
    group:entry { item = "onion", count = { 1, 3 }, probability = 66 }
    group:entry { item = "potato", count = { 2, 12 }, probability = 30 }
    group:group("pet_food_in_container", 50)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a dishwasher that may have an assortment of dishes in it.
    local group = content.ItemGroup { id = "SUS_dishwasher", kind = "collection" }
    group:entry { group = "dishes_dining", count = { 1, 20 }, probability = 50 }
    group:entry { group = "dishes_utility", count = { 1, 20 }, probability = 50 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for cupboard, drawer, or rack with spices.
    local group = content.ItemGroup { id = "SUS_spice_collection", kind = "collection" }
    group:entry { group = "salt_various", count = { 2, 4 } }
    group:group("pepper_various")
    group:group("cinnamon_various", 75)
    group:group("chilly-p_various", 75)
    group:group("sugar_various", 15)
    group:group("artificial_sweetener_box_small_71", 5)
    group:group("curry_powder_various", 25)
    group:group("garlic_powder_various", 25)
    group:group("sprinkles_bottle_plastic_small_62", 10)
    group:item("thyme", 65)
    group:group("seasoning_italian_various", 50)
    group:group("seasoning_salt_various", 50)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a drawer for haircare tools.
    local group = content.ItemGroup { id = "SUS_hair_drawer", kind = "collection" }
    group:entry { item = "hairbrush", count = { 1, 2 }, probability = 90 }
    group:entry { item = "comb_pocket", count = { 1, 2 }, probability = 75 }
    group:entry { item = "scissors", count = { 1, 2 }, probability = 60 }
    group:item("hair_dryer", 60)
    group:entry {
        collection = {
            { item = "curling_iron", count = { 1, 2 } },
            { item = "curler_hair" },
        },
        probability = 25,
    }
    group:entry { item = "elec_hairtrimmer", charges = { 0, 50 }, probability = 30 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for things you often find stored on or next to a toilet.
    local group = content.ItemGroup { id = "SUS_toilet", kind = "collection" }
    group:entry {
        distribution = {
            { item = "plunger_toilet", probability = 90 },
            { item = "plunger_futuristic", probability = 10 },
        },
        probability = 90,
    }
    group:item("brush_toilet", 75)
    group:entry { item = "toilet_paper", container = "wrapper", probability = 95 }
    group:item("bathroom_scale", 50)
    content.add(group)
end

do
    -- clothing and wearable items for domestic desks, tables, etc.
    local group = content.ItemGroup { id = "SUS_desks_bedroom_unisex", kind = "collection" }
    group:group("accesories_personal_unisex", 70)
    group:group("accesories_personal_womens", 50)
    group:group("accesories_personal_mens", 50)
    group:group("masks_unisex", 20)
    group:group("socks_unisex", 60)
    group:group("scarfs_unisex", 30)
    group:group("gloves_womens", 10)
    group:group("gloves_unisex", 30)
    group:group("hats_unisex", 50)
    content.add(group)
end

do
    -- clothing found in a man's wardrobe
    local group = content.ItemGroup { id = "SUS_wardrobe_mens", kind = "collection" }
    group:entry { group = "shoes_unisex", count = { 0, 3 } }
    group:item("sleeping_bag_roll", 5)
    group:entry { group = "coats_unisex", count = { 0, 3 }, probability = 50 }
    group:entry { group = "suits_unisex", count = { 0, 2 }, probability = 50 }
    group:entry { group = "suits_mens", count = { 0, 2 }, probability = 25 }
    group:group("SUS_dresser_mens")
    group:item("crutches", 1)
    content.add(group)
end

do
    -- clothing found in a woman's wardrobe
    local group = content.ItemGroup { id = "SUS_wardrobe_womens", kind = "collection" }
    group:entry { group = "shoes_unisex", count = { 1, 2 }, probability = 50 }
    group:entry { group = "shoes_womens", count = { 1, 2 }, probability = 60 }
    group:item("sleeping_bag_roll", 5)
    group:entry { group = "coats_unisex", count = { 0, 3 }, probability = 50 }
    group:entry { group = "suits_unisex", count = { 0, 2 }, probability = 50 }
    group:entry { group = "suits_womens", count = { 0, 2 }, probability = 25 }
    group:group("SUS_dresser_womens")
    group:item("crutches", 1)
    content.add(group)
end

do
    -- clothing found in a man's dresser
    local group = content.ItemGroup { id = "SUS_dresser_mens", kind = "collection" }
    group:group("accesories_personal_unisex", 10)
    group:group("accesories_personal_mens", 10)
    group:group("masks_unisex", 3)
    group:entry { group = "socks_unisex", count = { 7, 14 } }
    group:group("scarfs_unisex", 30)
    group:entry { group = "shirts_unisex", count = { 7, 14 } }
    group:entry { group = "underwear_mens", count = { 5, 7 } }
    group:entry { group = "underwear_unisex", count = { 3, 7 } }
    group:entry { group = "pants_unisex", count = { 4, 7 }, probability = 50 }
    group:entry { group = "pants_male", count = { 4, 7 }, probability = 5 }
    group:group("gloves_unisex", 30)
    group:group("hats_unisex", 10)
    group:group("bags_unisex", 50)
    group:entry { group = "SUS_dresser_mens_single_outfit", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    -- One specific set of clothing found in a man's dresser. Should not contain more than one shirt, more than one pants, etc. All of these should be wearable at once without anything being too strange.
    -- This is largely a copy of SUS_dresser_mens with the counts removed and inline distributions to make sure we only get one of each main clothing.
    local group = content.ItemGroup { id = "SUS_dresser_mens_single_outfit", kind = "collection", container = "outfit_storage" }
    group:entry {
        distribution = {
            { group = "accesories_personal_unisex", probability = 50 },
            { group = "accesories_personal_mens", probability = 50 },
        },
    }
    group:group("masks_unisex", 3)
    group:group("socks_unisex")
    group:group("scarfs_unisex", 30)
    group:group("shirts_unisex")
    group:entry {
        distribution = {
            { group = "underwear_mens", probability = 50 },
            { group = "underwear_unisex", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { group = "pants_male", probability = 50 },
            { group = "pants_unisex", probability = 5 },
        },
    }
    group:group("gloves_unisex", 30)
    group:group("hats_unisex", 10)
    group:group("bags_unisex", 50)
    content.add(group)
end

do
    -- clothing found in a man's dresser
    local group = content.ItemGroup { id = "SUS_dresser_mens_small_bags", kind = "collection" }
    group:group("accesories_personal_unisex", 10)
    group:group("accesories_personal_mens", 10)
    group:group("masks_unisex", 3)
    group:entry { group = "socks_unisex", count = { 7, 14 } }
    group:group("scarfs_unisex", 30)
    group:entry { group = "shirts_unisex", count = { 7, 14 } }
    group:entry { group = "underwear_mens", count = { 5, 7 } }
    group:entry { group = "underwear_unisex", count = { 3, 7 } }
    group:entry { group = "pants_unisex", count = { 4, 7 }, probability = 50 }
    group:entry { group = "pants_male", count = { 4, 7 }, probability = 5 }
    group:group("gloves_unisex", 30)
    group:group("hats_unisex", 10)
    group:group("bags_unisex_small", 50)
    content.add(group)
end

do
    -- clothing found in a woman's dresser
    local group = content.ItemGroup { id = "SUS_dresser_womens", kind = "collection" }
    group:group("accesories_personal_unisex", 30)
    group:group("accesories_personal_womens", 5)
    group:group("masks_unisex", 3)
    group:entry { group = "socks_unisex", count = { 7, 14 } }
    group:group("scarfs_unisex", 30)
    group:entry { group = "shirts_unisex", count = { 7, 14 } }
    group:entry { group = "shirts_womens", count = { 1, 4 }, probability = 50 }
    group:entry { group = "underwear_womens", count = { 4, 7 } }
    group:entry { group = "underwear_unisex", count = { 4, 7 } }
    group:entry { group = "pants_unisex", count = { 4, 7 } }
    group:entry { group = "pants_female", count = { 4, 7 } }
    group:group("gloves_womens", 5)
    group:group("gloves_unisex", 30)
    group:group("hats_unisex", 10)
    group:group("bags_unisex", 50)
    group:entry { group = "SUS_dresser_womens_single_outfit", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    -- One specific set of clothing found in a woman's dresser. Should not contain more than one shirt, more than one pants, etc. All of these should be wearable at once without anything being too strange.
    -- This is largely a copy of SUS_dresser_womens with the counts removed and inline distributions to make sure we only get one of each main clothing.
    local group = content.ItemGroup { id = "SUS_dresser_womens_single_outfit", kind = "collection", container = "outfit_storage" }
    group:entry {
        distribution = {
            { group = "accesories_personal_unisex", probability = 30 },
            { group = "accesories_personal_womens", probability = 5 },
        },
    }
    group:group("masks_unisex", 3)
    group:group("socks_unisex")
    group:group("scarfs_unisex", 30)
    group:entry {
        distribution = {
            { group = "shirts_unisex" },
            { group = "shirts_womens", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { group = "underwear_womens", probability = 50 },
            { group = "underwear_unisex", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { group = "pants_unisex", probability = 50 },
            { group = "pants_female", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { group = "gloves_womens", probability = 5 },
            { group = "gloves_unisex", probability = 30 },
        },
    }
    group:group("hats_unisex", 10)
    group:group("bags_unisex", 50)
    content.add(group)
end

do
    -- clothing found in a woman's dresser
    local group = content.ItemGroup { id = "SUS_dresser_womens_small_bags", kind = "collection" }
    group:group("accesories_personal_unisex", 30)
    group:group("accesories_personal_womens", 5)
    group:group("masks_unisex", 3)
    group:entry { group = "socks_unisex", count = { 7, 14 } }
    group:group("scarfs_unisex", 30)
    group:entry { group = "shirts_unisex", count = { 7, 14 } }
    group:entry { group = "shirts_womens", count = { 1, 4 }, probability = 50 }
    group:entry { group = "underwear_womens", count = { 4, 7 } }
    group:entry { group = "underwear_unisex", count = { 4, 7 } }
    group:entry { group = "pants_unisex", count = { 4, 7 } }
    group:entry { group = "pants_female", count = { 4, 7 } }
    group:group("gloves_womens", 5)
    group:group("gloves_unisex", 30)
    group:group("hats_unisex", 10)
    group:group("bags_unisex_small", 50)
    content.add(group)
end

do
    -- Random books for a random domestic bookshelf.
    local group = content.ItemGroup { id = "SUS_domestic_bookshelf", kind = "collection" }
    group:entry { group = "novels", count = { 7, 21 } }
    group:entry { group = "kids_books", count = { 3, 7 }, probability = 15 }
    group:entry { group = "literature", count = { 2, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "baking_soda_box", kind = "collection", container = "box_small" }
    group:entry { item = "chem_baking_soda", charges = { 1, 2 }, container = "null" }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a messy junk drawer.  The idea is that it should be filled with random crud, much of it obvious trash.  Like you might find in the home of someone with a small hoarding problem.
    local group = content.ItemGroup { id = "SUS_junk_drawer_messy", kind = "collection" }
    group:entry { item = "credit_card", count = { 1, 4 } }
    group:entry { item = "lighter", charges = { 0, 2 }, probability = 90 }
    group:group("bag_garbage_box_part", 95)
    group:item("bottle_opener", 90)
    group:entry { group = "pens", charges = { 1, 25 }, probability = 90 }
    group:item("coin_quarter", 90)
    group:entry {
        item = "toothbrush_plain",
        flags = {
            "FILTHY",
        },
        probability = 80,
    }
    group:entry { item = "matches", count = { 1, 5 }, charges = { 0, 2 }, probability = 80 }
    group:entry { item = "ref_matches", count = { 1, 5 }, charges = { 0, 2 }, probability = 80 }
    group:item("coin_nickel", 70)
    group:item("coin_quarter", 70)
    group:entry { item = "old_key", count = { 1, 7 }, probability = 70 }
    group:entry { item = "plastic_straw", count = { 1, 2 }, probability = 60 }
    group:item("plastic_spoon", 50)
    group:item("plastic_fork", 50)
    group:item("plastic_knife", 50)
    group:item("flyer", 70)
    group:entry { item = "feces_roach", count = { 4, 4 }, probability = 70 }
    group:entry { item = "lighter", charges = { 0, 9 }, probability = 65 }
    group:group("SUS_used_batteries", 60)
    group:entry { item = "bag_plastic", count = { 1, 5 }, probability = 60 }
    group:item("corkscrew", 60)
    group:item("stapler", 45)
    group:entry { item = "gum", count = { 1, 2 }, probability = 55 }
    group:item("can_opener", 55)
    group:item("ceramic_shard", 30)
    group:entry { item = "e_scrap", count = { 1, 5 }, probability = 50 }
    group:item("razor_blade", 40)
    group:entry { item = "flashlight", charges = { 2, 8 }, probability = 55 }
    group:item("bottle_plastic_small", 42)
    group:item("glowstick_dead", 30)
    group:item("condom", 40)
    group:item("razor_shaving", 40)
    group:item("scorecard", 40)
    group:item("gummy_vitamins", 40)
    group:item("survnote", 25)
    group:item("joint_roach", 30)
    group:item("file", 30)
    group:item("string_floss", 30)
    group:item("comb_pocket", 30)
    group:entry { item = "aluminum_foil", charges = { 1, 4 }, probability = 30 }
    group:item("fishing_hook_basic", 25)
    group:entry { item = "balloon", count = { 1, 2 }, probability = 20 }
    group:entry { item = "lighter", count = { 2, 7 }, charges = { 0, 12 }, probability = 25 }
    group:group("adhesive_bandages_box_used", 25)
    group:entry { item = "marble", charges = { 1, 3 }, probability = 20 }
    group:entry { item = "coin_nickel", count = { 1, 8 }, probability = 20 }
    group:entry { item = "button_plastic", charges = { 4, 12 }, probability = 40 }
    group:entry { item = "bearing", charges = { 1, 3 }, probability = 15 }
    group:group("adderall_bottle_plastic_pill_prescription_1_10", 15)
    group:entry { item = "lighter", charges = { 0, 90 }, probability = 10 }
    group:item("zipper_short_plastic", 10)
    group:item("bracelet_friendship", 10)
    group:entry { item = "paper", count = { 5, 20 }, probability = 10 }
    group:entry { item = "plastic_straw", count = { 20, 30 }, probability = 10 }
    group:entry { group = "pens", count = { 1, 30 }, charges = { 0, 15 }, probability = 10 }
    group:item("polaroid_photo", 10)
    group:item("RPG_die", 8)
    group:item("bead_necklace", 8)
    group:item("pipe_cleaner", 8)
    group:item("ring_engagement", 8)
    group:item("spoon", 8)
    group:item("magnifying_glass", 8)
    group:item("golf_tee", 8)
    group:item("golf_ball", 8)
    group:item("shuttlecock", 8)
    group:item("bronze_medal", 8)
    group:item("book_binder", 8)
    group:item("fp_loyalty_card", 8)
    group:entry { item = "coin_quarter", count = { 2, 12 }, probability = 6 }
    group:item("wristwatch", 6)
    group:item("copper_hairpin", 6)
    group:item("copper_necklace", 6)
    group:item("dog_whistle", 6)
    group:item("whistle_multitool", 6)
    group:item("slingshot", 5)
    group:group("weak_antibiotic_bottle_plastic_pill_prescription_1", 5)
    group:item("paint_brush", 5)
    group:item("chopsticks", 2)
    group:entry { item = "office_holepunch", count = { 1, 3 }, probability = 2 }
    group:entry { item = "nuts_bolts", count = { 3, 12 }, probability = 50 }
    group:entry { group = "melatonin_tablet_bottle_plastic_pill_supplement_10", count = { 1, 1 }, probability = 1 }
    group:item("bat_anklet", 10)
    group:item("flower_anklet", 10)
    group:item("woven_anklet", 10)
    group:item("gold_lip_ring_loop", 5)
    group:item("gold_lip_ring_stud", 5)
    group:item("silver_lip_ring_loop", 6)
    group:item("silver_lip_ring_stud", 6)
    group:item("gold_nose_ring_loop", 5)
    group:item("gold_nose_ring_stud", 5)
    group:item("silver_nose_ring_loop", 6)
    group:item("silver_nose_ring_stud", 6)
    group:item("gold_toe_ring", 5)
    group:item("silver_toe_ring", 6)
    group:group("sunscreen_bottle", 5)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a home crafter's junk drawer filled with art supplies.
    local group = content.ItemGroup { id = "SUS_junk_drawer_artsy", kind = "collection" }
    group:entry { item = "pen", count = { 1, 20 }, charges = { 70, -1 } }
    group:entry { item = "paper", charges = { 10, 30 } }
    group:item("scissors")
    group:item("scissors_wavy", 10)
    group:entry { item = "string_36", count = { 1, 4 }, probability = 80 }
    group:entry { item = "string_36", count = { 1, 4 }, probability = 70 }
    group:entry { item = "string_6", count = { 1, 20 }, probability = 70 }
    group:entry { item = "permanent_marker", count = { 1, 20 }, charges = { 70, -1 }, probability = 80 }
    group:item("office_holepunch", 70)
    group:item("stapler", 70)
    group:item("paint_brush", 70)
    group:item("xacto", 65)
    group:entry { item = "yarn", charges = { 60, 200 }, probability = 60 }
    group:entry { item = "razor_blade", count = { 1, 4 }, probability = 50 }
    group:entry { item = "cotton_patchwork", count = { 3, 4 }, probability = 50 }
    group:item("thread", 40)
    group:item("thread", 30)
    group:entry { item = "sewing_kit", charges = { 50, 150 }, probability = 25 }
    group:item("sewing_machine", 25)
    group:group("solder_wire_spool_part", 40)
    group:group("glue_weak_domestic", 20)
    group:group("glue_strong_domestic", 20)
    group:item("knitting_needles", 40)
    group:group("duct_tape_roll_part", 40)
    group:item("wax_paraffin", 10)
    group:item("zipper_short_plastic", 35)
    group:item("zipper_short_plastic", 15)
    group:entry { item = "felt_patch", count = { 1, 3 }, probability = 30 }
    group:item("bandana", 30)
    group:item("pin_reamer", 30)
    group:group("decks_of_cards", 30)
    group:item("glasses_reading", 30)
    group:entry { item = "button_plastic", charges = { 4, 52 }, probability = 90 }
    group:entry { item = "bracelet_friendship", count = { 3, 6 }, probability = 25 }
    group:item("boxcutter", 20)
    group:entry { item = "feather", count = { 1, 1 }, probability = 20 }
    group:entry { item = "tailors_kit", charges = { 50, 350 }, probability = 12 }
    group:item("electric_spinwheel", 12)
    group:item("polaroid_photo", 10)
    group:item("RPG_die", 10)
    group:item("chopsticks", 10)
    group:item("soldering_iron", 10)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 10 }
    group:entry { item = "pipe_cleaner", count = { 3, 15 }, probability = 10 }
    group:entry { item = "balloon", count = { 10, 20 }, probability = 8 }
    group:entry { item = "bead_bracelet", count = { 5, 9 }, probability = 5 }
    group:entry { item = "bead_necklace", count = { 5, 9 }, probability = 5 }
    group:entry { item = "old_key", count = { 1, 12 }, probability = 5 }
    group:item("office_letter_opener", 5)
    group:item("glowstick_dead", 5)
    group:item("bat_anklet", 10)
    group:item("flower_anklet", 10)
    group:item("woven_anklet", 10)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- The junk drawer of a DIYer who does her own home repairs.
    local group = content.ItemGroup { id = "SUS_junk_drawer_handy", kind = "collection" }
    group:entry { group = "tools_common", count = { 2, 2 } }
    group:group("glue_weak_domestic", 45)
    group:group("glue_strong_domestic", 45)
    group:item("boxcutter", 85)
    group:group("duct_tape_roll_part", 85)
    group:item("tape_measure", 70)
    group:entry { item = "flashlight", charges = { 100, 300 }, probability = 80 }
    group:entry {
        item = "toothbrush_plain",
        flags = {
            "FILTHY",
        },
        probability = 80,
    }
    group:item("bottle_opener", 75)
    group:item("pockknife", 75)
    group:item("cordless_drill", 70)
    group:item("corded_powerdrill", 20)
    group:item("scissors", 65)
    group:item("pliers", 65)
    group:entry { item = "permanent_marker", charges = { 50, -1 }, probability = 70 }
    group:group("adhesive_bandages_box_used", 60)
    group:entry { group = "pens", count = { 1, 3 }, charges = { 50, -1 }, probability = 55 }
    group:item("sandpaper", 50)
    group:item("old_key", 50)
    group:group("SUS_used_batteries", 65)
    group:item("ear_plugs", 40)
    group:item("screwdriver", 40)
    group:item("hammer", 40)
    group:item("dremel", 40)
    group:item("multitool", 35)
    group:item("can_opener", 35)
    group:entry { item = "hinge", count = { 3, 3 }, probability = 30 }
    group:entry { item = "bearing", charges = { 12, 75 }, probability = 25 }
    group:item("stapler", 25)
    group:item("soldering_iron", 25)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 } }
    group:item("xacto", 25)
    group:item("kevlar_shears", 10)
    group:item("tin_snips", 10)
    group:item("wristwatch", 25)
    group:entry { item = "old_key", count = { 1, 6 }, probability = 20 }
    group:item("office_letter_opener", 15)
    group:entry { item = "razor_blade", count = { 1, 3 }, probability = 15 }
    group:group("bottle_otc_painkiller_1_20", 15)
    group:entry { item = "reading_light", charges = { 0, 50 }, probability = 15 }
    group:item("book_binder", 15)
    group:item("paint_brush", 10)
    group:entry { item = "gum", count = { 1, 10 }, probability = 10 }
    group:item("comb_pocket", 10)
    group:item("picklocks", 5)
    group:item("fitness_band", 5)
    group:item("thermometer", 3)
    group:item("hygrometer", 3)
    group:item("barometer", 3)
    group:item("smart_lamp", 3)
    group:entry { item = "nuts_bolts", count = { 10, 20 }, probability = 95 }
    group:group("sunscreen_bottle", 5)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- A well-organized and deliberately selected collection of small objects useful to keep close at hand.
    local group = content.ItemGroup { id = "SUS_junk_drawer_tidy", kind = "collection" }
    group:entry { group = "pens", count = { 2, 2 }, charges = { 70, -1 } }
    group:entry { item = "paper", charges = { 25, 100 } }
    group:item("scissors", 80)
    group:item("stapler", 80)
    group:entry { item = "flashlight", charges = { 300, 300 }, probability = 80 }
    group:item("hairbrush", 80)
    group:item("office_letter_opener", 75)
    group:entry { item = "candle", count = { 1, 2 }, charges = { 70, -1 }, probability = 75 }
    group:group("small_candles_in_box", 25)
    group:item("corkscrew", 70)
    group:group("adhesive_bandages_box_used", 60)
    group:group("duct_tape_roll_part", 40)
    group:group("glue_weak_domestic", 15)
    group:group("glue_strong_domestic", 15)
    group:group("batteries", 50)
    group:group("SUS_used_batteries", 75)
    group:group("decks_of_cards", 50)
    group:item("teleumbrella", 50)
    group:group("bottle_otc_painkiller_20", 50)
    group:entry { item = "matches", charges = { 20, 20 }, probability = 50 }
    group:entry { item = "ref_matches", charges = { 32, 32 }, probability = 50 }
    group:item("dog_whistle", 40)
    group:entry { item = "gum", count = { 10, 10 }, probability = 40 }
    group:item("multitool", 40)
    group:item("hairpin", 40)
    group:item("candlestick", 30)
    group:item("gold_hairpin", 25)
    group:item("magnifying_glass", 25)
    group:item("bandana", 25)
    group:item("fitness_band", 15)
    group:item("gloves_light", 10)
    group:item("gloves_golf", 10)
    group:item("long_glove_white", 2)
    content.add(group)
end
