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
