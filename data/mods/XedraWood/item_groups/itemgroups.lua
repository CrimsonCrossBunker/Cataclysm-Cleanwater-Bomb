local content = require("ccb").content

do
    -- Very small chance of a powerful, non-resonant artifact
    local group = content.ItemGroup { id = "xedrawood_forest_tomb_artifact_wield", kind = "distribution" }
    group:entry {
        group = "nether_cult_items_wielded",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "nether_cult_items_wielded",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "nether_cult_items_wielded",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = false,
        },
        probability = 1,
    }
    content.add(group)
end

do
    -- Very small chance of a powerful, non-resonant artifact
    local group = content.ItemGroup { id = "xedrawood_forest_tomb_artifact_worn", kind = "distribution" }
    group:entry {
        group = "nether_cult_items_worn",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "nether_cult_items_worn",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "nether_cult_items_worn",
        artifact = {
            preset = "nether_cult_wield",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = false,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "default_skeleton_death_drops", kind = "collection" }
    group:entry { item = "sword_xiphos", damage = { 2, 4 } }
    group:item("skull_human", 80)
    group:entry { item = "bone_human", count = { 10, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hollow_warrior_death_drops", kind = "collection" }
    group:entry {
        item = "sheath_birchbark",
        contents = {
            { item = "primitive_knife" },
        },
        probability = 50,
    }
    group:entry { item = "spear_stone", damage = { 0, 1 } }
    group:entry { item = "helmet_larmor", damage = { 1, 4 }, probability = 80 }
    group:entry { item = "armor_larmor", damage = { 1, 4 }, probability = 80 }
    group:entry { item = "leathersandals", damage = { 1, 4 }, probability = 80 }
    group:entry { item = "legguard_larmor", damage = { 1, 4 }, probability = 80 }
    group:entry { item = "vambrace_larmor", damage = { 1, 4 }, probability = 80 }
    group:entry { group = "male_underwear_bottom", damage = { 1, 4 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hollow_one_death_drops", kind = "collection" }
    group:entry {
        item = "sheath_birchbark",
        contents = {
            { item = "primitive_knife" },
        },
        probability = 30,
    }
    group:entry { group = "shoes_unisex", damage = { 1, 4 } }
    group:entry { group = "npc_hat", damage = { 1, 4 } }
    group:entry { group = "male_underwear_bottom", damage = { 1, 4 } }
    group:entry { group = "female_underwear_top", damage = { 1, 4 } }
    group:entry { item = "chestwrap_leather", damage = { 1, 4 }, probability = 50 }
    group:entry { group = "pants_male", damage = { 1, 4 } }
    group:entry { group = "npc_coat", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "npc_gloves", damage = { 1, 4 } }
    group:entry { item = "wicker_backpack", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "jug_clay", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "tools_common_small", damage = { 1, 4 }, probability = 25 }
    group:entry { item = "primitive_axe", damage = { 1, 4 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hollow_hunter_death_drops", kind = "collection" }
    group:entry { item = "shortbow", damage = { 1, 2 } }
    group:entry {
        item = "quiver_birchbark",
        damage = { 1, 4 },
        contents = {
            { group = "quiver_bow_hunter" },
        },
    }
    group:entry {
        item = "sheath_birchbark",
        damage = { 1, 2 },
        contents = {
            { item = "primitive_knife" },
        },
    }
    group:entry { item = "chestwrap_leather", damage = { 1, 4 } }
    group:entry { item = "leathersandals", damage = { 1, 4 } }
    group:entry { group = "male_underwear_bottom", damage = { 1, 4 } }
    group:entry { group = "female_underwear_top", damage = { 1, 4 }, probability = 75 }
    group:entry { item = "legguard_larmor", damage = { 1, 4 } }
    group:entry { group = "pants_male", damage = { 1, 4 } }
    group:entry { item = "vambrace_larmor", damage = { 1, 4 } }
    group:entry { item = "grass_cloak", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "rope_loop", damage = { 1, 4 }, probability = 55 }
    group:item("water_clean", 50)
    group:entry { group = "hollow_one_food", count = { 2, 6 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hollow_one_death_drops_zombie", kind = "collection" }
    group:entry {
        item = "sheath_birchbark",
        contents = {
            { item = "primitive_knife" },
        },
        probability = 10,
    }
    group:entry { group = "shoes_unisex", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "npc_hat", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "male_underwear_bottom", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "female_underwear_top", damage = { 1, 4 }, probability = 60 }
    group:entry { item = "chestwrap_leather", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "pants_male", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "npc_coat", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "npc_gloves", damage = { 1, 4 }, probability = 60 }
    group:entry { item = "wicker_backpack", damage = { 1, 4 }, probability = 2 }
    group:entry { group = "tools_common_small", damage = { 1, 4 }, probability = 10 }
    group:entry { item = "primitive_axe", damage = { 1, 4 }, probability = 10 }
    group:item("water_clean", 25)
    group:entry { group = "hollow_one_food", count = { 1, 3 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_xw_chirurgeon_death_drops", kind = "collection" }
    group:entry { item = "robe", damage = { 1, 4 } }
    group:entry { item = "harfry_root", count = { 1, 2 }, probability = 75 }
    group:entry { item = "bandages_makeshift", count = { 2, 4 }, probability = 85 }
    group:entry { item = "bandages_makeshift", count = { 1, 2 }, probability = 45 }
    group:entry { item = "cattail_jelly", count = { 1, 3 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tanglevine_death_drops", kind = "collection" }
    group:item("tanglevine_root", 15)
    group:entry { item = "stick", count = { 1, 2 }, probability = 90 }
    group:entry { item = "leaves", count = { 2, 4 } }
    group:entry { item = "withered", count = { 10, 40 }, probability = 75 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dryad_death_drops", kind = "collection" }
    group:entry { item = "dryad_bark", count = { 1, 6 }, probability = 50 }
    group:entry { item = "splinter", count = { 20, 40 }, probability = 85 }
    group:entry { item = "stick", count = { 2, 4 }, probability = 90 }
    group:entry { item = "leaves", count = { 10, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "hollow_one_food",
        kind = "distribution",
        container = "bag_canvas_small",
        overflow = "spill",
    }
    group:item("dry_meat", 300)
    group:item("dry_veggy", 300)
    group:item("dry_fruit", 300)
    group:item("apple", 70)
    group:item("orange", 65)
    group:item("banana", 40)
    group:item("mushroom", 4)
    group:item("blueberries", 3)
    group:item("strawberries", 2)
    group:item("cucumber", 8)
    group:item("tomato", 9)
    group:item("pumpkin", 8)
    group:item("broccoli", 9)
    group:item("zucchini", 7)
    group:item("celery", 2)
    group:item("onion", 3)
    group:item("carrot", 3)
    group:item("potato", 10)
    group:item("pear", 65)
    group:item("grapefruit", 1)
    group:item("cherries", 5)
    group:item("plums", 9)
    group:item("grapes", 45)
    group:item("pineapple", 2)
    group:item("peach", 1)
    group:item("cranberries", 15)
    group:item("watermelon", 2)
    group:item("melon", 1)
    group:item("raspberries", 3)
    group:item("blackberries", 3)
    group:item("mango", 1)
    group:item("pomegranate", 1)
    group:item("rhubarb", 5)
    group:item("papaya", 1)
    group:item("kiwi", 2)
    group:item("apricot", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "hollow_village_foodstuffs",
        kind = "collection",
        container = "bag_canvas",
        overflow = "spill",
    }
    group:entry { item = "sausage_wasteland", count = { 6, 10 }, probability = 30 }
    group:entry { item = "honey_bottled", count = { 1, 2 }, container = "clay_pot", probability = 20 }
    group:entry { item = "meat_smoked", count = { 6, 10 }, probability = 50 }
    group:entry { item = "water_clean", count = { 4, 8 }, container = "clay_pot", probability = 60 }
    group:entry { item = "fish_smoked", count = { 6, 10 }, probability = 50 }
    group:entry { item = "dry_veggy", count = { 10, 20 }, probability = 75 }
    group:entry { item = "dry_fruit", count = { 10, 20 }, probability = 75 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hollow_village_storage", kind = "distribution" }
    group:entry { group = "hollow_village_foodstuffs", count = { 1, 2 }, probability = 70 }
    group:entry { group = "tools_common_small", count = { 1, 3 }, probability = 50 }
    group:entry { item = "arrow_fire_hardened_fletched", count = { 1, 5 }, probability = 40 }
    group:item("jug_clay", 50)
    group:item("bone_knife", 40)
    group:item("clay_pot", 50)
    group:item("bowl_wood", 60)
    group:item("skewer_bone", 20)
    group:item("spear_wood", 10)
    group:entry { item = "javelin", count = { 1, 8 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hollow_village_farm_tools", kind = "distribution" }
    group:item("digging_stick", 90)
    group:item("sharp_rock", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hollow_village_farming_seeds", kind = "distribution", container = "bag_canvas" }
    group:entry { item = "seed_oats", count = { 20, 40 }, probability = 80 }
    group:entry { item = "seed_carrot", count = { 20, 40 }, probability = 40 }
    group:entry { item = "seed_zucchini", count = { 20, 40 }, probability = 60 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "dry_meat_preserved_in_sack",
        kind = "collection",
        container = "bag_canvas_small",
        overflow = "discard",
    }
    group:entry { item = "dry_meat", count = { 5, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "dry_fish_preserved_in_sack",
        kind = "collection",
        container = "bag_canvas_small",
        overflow = "discard",
    }
    group:entry { item = "dry_fish", count = { 5, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "dry_veggy_preserved_in_sack",
        kind = "collection",
        container = "bag_canvas_small",
        overflow = "discard",
    }
    group:entry { item = "dry_veggy", count = { 5, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "dry_corn_preserved_in_sack",
        kind = "collection",
        container = "bag_canvas_small",
        overflow = "discard",
    }
    group:entry { item = "dry_corn", count = { 5, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "dry_fruit_preserved_in_sack",
        kind = "collection",
        container = "bag_canvas_small",
        overflow = "discard",
    }
    group:entry { item = "dry_fruit", count = { 5, 10 }, container = "null" }
    content.add(group)
end
