local content = require("ccb").content

do
    local group = content.ItemGroup { id = "child_items", kind = "distribution" }
    group:item("pointy_stick", 15)
    group:item("rock", 50)
    group:entry { item = "feather", count = { 1, 10 }, probability = 40 }
    group:entry { item = "hickory_nut", count = { 1, 10 }, probability = 20 }
    group:entry { item = "acorns", count = { 1, 10 }, probability = 20 }
    group:item("straw_doll", 5)
    group:item("bag_canvas_small", 10)
    group:entry { group = "tools_common_small", wrapper = "makeshift_sling", probability = 1 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "default_innawood_zombie_clothes_male", kind = "collection" }
    group:group("male_underwear_bottom", 95)
    group:group("male_underwear_top", 50)
    group:group("pants_male", 95)
    group:group("shirts", 40)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "default_innawood_zombie_clothes_female", kind = "collection" }
    group:group("female_underwear_bottom", 95)
    group:group("female_underwear_top", 95)
    group:group("pants_female", 95)
    group:group("shirts", 40)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "fae_furs", kind = "distribution" }
    group:item("hat_fur", 30)
    group:item("sleeveless_trenchcoat_fur", 10)
    group:item("sleeveless_duster_fur", 10)
    group:item("coat_fur", 30)
    group:item("gloves_fur", 30)
    group:item("boots_fur", 20)
    group:item("boots_glimmer_fur", 8)
    group:item("cloak_glimmer_fur", 10)
    group:item("coat_glimmer_fur", 1)
    group:item("duster_glimmer_fur", 1)
    group:item("sleeveless_duster_glimmer_fur", 1)
    group:item("sleeveless_trenchcoat_glimmer_fur", 1)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "blood_containers", kind = "distribution" }
    group:item("bowl_skull")
    group:entry { item = "blood", container = "waterskin", probability = 400 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "changeling_death_drops", kind = "collection" }
    group:entry { group = "cufflinks_silver", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "gossamer_clothes", damage = { 0, 4 } }
    group:group("tiaras_silver", 5)
    group:group("pendant_necklaces_silver", 5)
    group:group("clothing_watch", 5)
    group:entry { group = "fae_furs", damage = { 0, 4 } }
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "changeling_bannerman_death_drops", kind = "collection" }
    group:entry { group = "cufflinks_silver", damage = { 0, 4 }, probability = 30 }
    group:entry { group = "gossamer_clothes", damage = { 0, 4 } }
    group:entry { group = "bannerman_armor", damage = { 0, 5 }, probability = 20 }
    group:group("pendant_necklaces_silver", 5)
    group:entry { group = "bannerman_weapons", damage = { 0, 5 }, probability = 50 }
    group:item("baldric")
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "changeling_redcap_aspirant_death_drops", kind = "collection" }
    group:entry { group = "gossamer_clothes", damage = { 0, 4 } }
    group:entry { group = "redcap_armor", damage = { 0, 4 }, probability = 20 }
    group:group("pendant_necklaces_silver", 5)
    group:entry { group = "redcap_weapons", damage = { 0, 5 }, probability = 50 }
    group:entry { item = "scrap_dreamdross", count = { 4, 8 }, probability = 75 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "changeling_pooka_aspirant_death_drops", kind = "collection" }
    group:entry { group = "gossamer_clothes", damage = { 0, 4 } }
    group:entry { group = "pooka_armor", damage = { 0, 4 }, probability = 20 }
    group:group("pendant_necklaces_silver", 5)
    group:entry { group = "pooka_weapons", damage = { 0, 5 }, probability = 50 }
    group:item("scabbard")
    group:entry { item = "scrap_dreamdross", count = { 4, 8 }, probability = 75 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "changeling_lord_death_drops", kind = "collection" }
    group:entry { group = "cufflinks_silver", damage = { 0, 4 }, probability = 30 }
    group:entry { group = "gossamer_clothes", damage = { 0, 4 } }
    group:entry { group = "bannerman_armor", damage = { 0, 4 }, probability = 20 }
    group:group("pendant_necklaces_silver", 5)
    group:entry { item = "winter_lord_estoc", damage = { 0, 5 }, probability = 25 }
    group:item("baldric")
    group:item("purity_crackers", 10)
    group:item("golden_bridle", 5)
    group:entry { item = "scrap_dreamdross", count = { 12, 24 }, probability = 75 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "default_moroi_death_drops", kind = "collection" }
    group:entry { group = "default_innawood_zombie_clothes", damage = { 1, 4 }, probability = 90 }
    group:entry { group = "default_feral_armor", damage = { 2, 4 }, probability = 50 }
    group:group("default_innawood_zombie_items", 5)
    group:group("blood_containers", 30)
    group:item("grimy_recipe", 55)
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 35 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "renfield_death_drops", kind = "collection" }
    group:entry { group = "default_innawood_zombie_clothes", damage = { 1, 4 } }
    group:entry { group = "default_innawood_zombie_items", count = { 1, 2 }, probability = 30 }
    group:entry { group = "default_feral_weapons", damage = { 2, 4 }, probability = 75 }
    group:entry { group = "default_feral_armor", damage = { 2, 4 }, probability = 25 }
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 }
    group:group("blood_containers", 15)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "gossamer_clothes", kind = "collection" }
    group:group("gossamer_upper_body", 70)
    group:group("gossamer_lower_body", 70)
    group:group("gossamer_outerwear", 25)
    group:item("loincloth_gossamer", 80)
    group:group("gossamer_socks", 25)
    group:group("fae_furs", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "default_innawood_zombie_clothes", kind = "collection" }
    group:entry {
        distribution = {
            { group = "default_innawood_zombie_clothes_male", probability = 50 },
            { group = "default_innawood_zombie_clothes_female", probability = 50 },
        },
    }
    group:group("coats_unisex", 20)
    group:group("common_gloves", 20)
    group:group("hatstore_hats", 20)
    group:group("scarfs_unisex", 20)
    group:group("shoes_unisex", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "default_feral_weapons", kind = "distribution" }
    group:entry {
        collection = {
            { item = "shortbow" },
            {
                item = "quiver_birchbark",
                contents = {
                    { group = "quiver_bow_hunter" },
                },
            },
        },
        probability = 15,
    }
    group:item("primitive_axe", 35)
    group:entry {
        item = "sheath_birchbark",
        contents = {
            { item = "primitive_knife" },
        },
        probability = 15,
    }
    group:item("spear_stone", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "default_feral_armor", kind = "collection" }
    group:item("legguard_larmor", 50)
    group:item("vambrace_larmor", 50)
    group:item("helmet_larmor", 50)
    group:item("armor_larmor", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "default_innawood_zombie_items", kind = "distribution" }
    group:item("wicker_backpack", 2)
    group:entry { group = "tools_common_small", wrapper = "makeshift_sling", probability = 25 }
    group:item("bandages_birchbark", 5)
    group:group("trash_forest", 80)
    group:entry { group = "renfield_food", count = { 1, 3 }, probability = 30 }
    group:item("water_clean", 50)
    group:item("straw_doll", 3)
    group:entry {
        item = "wild_herbs",
        count = { 3, 12 },
        wrapper = "bag_canvas_small",
        container = "null",
        probability = 15,
    }
    group:entry { item = "faewild", count = { 3, 12 }, wrapper = "bag_canvas_small", container = "null", probability = 3 }
    group:entry {
        item = "lotus_blossom",
        count = { 2, 16 },
        wrapper = "bag_canvas_small",
        container = "null",
        probability = 3,
    }
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "renfield_food",
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
    local group = content.ItemGroup { id = "fetch_child_death_drops", kind = "distribution" }
    group:entry {
        group = "default_innawood_zombie_clothes",
        flags = {
            "UNDERSIZE",
        },
    }
    group:group("child_items", 65)
    content.add(group)
end
