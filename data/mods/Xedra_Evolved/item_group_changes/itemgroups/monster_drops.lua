local content = require("ccb").content

do
    local group = content.ItemGroup { id = "harddrugs", kind = "distribution" }
    group:entry { item = "faewild", count = { 3, 12 }, wrapper = "bag_zipper", container = "null", probability = 15 }
    group:entry { item = "lotus_blossom", count = { 2, 16 }, wrapper = "bag_zipper", container = "null", probability = 15 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "default_zombie_children_clothes", kind = "collection" }
    group:entry { item = "wyld_candy", sealed = false, wrapper = "wrapper_wyld", container = "null", probability = 15 }
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 35 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "default_zombie_items_pockets", kind = "collection" }
    group:entry { item = "faewild", count = { 3, 12 }, wrapper = "bag_zipper", container = "null", probability = 5 }
    group:entry { item = "lotus_blossom", count = { 2, 16 }, wrapper = "bag_zipper", container = "null", probability = 5 }
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 15 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_scientist_death_drops", kind = "collection" }
    group:group("xe_datacores", 3)
    content.extend_item_group(group)
end

do
    -- high chance of Earthly clothes, low chance of Faerie clothes
    local group = content.ItemGroup { id = "changeling_death_drops", kind = "collection" }
    group:entry { group = "cufflinks_silver", damage = { 0, 4 }, probability = 30 }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "dress_shoes", damage = { 1, 4 }, probability = 70 },
                    { group = "dress_shop", damage = { 1, 4 }, probability = 70 },
                    { group = "underwear", damage = { 1, 4 } },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 } },
                },
                probability = 75,
            },
            {
                collection = {
                    { group = "gossamer_upper_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_lower_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_outerwear", damage = { 1, 4 }, probability = 25 },
                    { item = "loincloth_gossamer", damage = { 1, 4 } },
                    { group = "gossamer_socks", damage = { 1, 4 }, probability = 25 },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 }, probability = 10 },
                },
                probability = 25,
            },
        },
    }
    group:group("tiaras_silver", 5)
    group:group("pendant_necklaces_silver", 5)
    group:group("clothing_watch", 5)
    group:entry { group = "fae_furs", damage = { 0, 4 } }
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 }
    content.upsert_item_group(group)
end

do
    -- higher chance of Earthly clothes, lower chance of Faerie clothes
    local group = content.ItemGroup { id = "changeling_bannerman_death_drops", kind = "collection" }
    group:entry { group = "cufflinks_silver", damage = { 0, 4 }, probability = 30 }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "dress_shoes", damage = { 1, 4 }, probability = 70 },
                    { group = "dress_shop", damage = { 1, 4 }, probability = 70 },
                    { group = "underwear", damage = { 1, 4 } },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 } },
                },
                probability = 60,
            },
            {
                collection = {
                    { group = "gossamer_upper_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_lower_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_outerwear", damage = { 1, 4 }, probability = 25 },
                    { item = "loincloth_gossamer", damage = { 1, 4 } },
                    { group = "gossamer_socks", damage = { 1, 4 }, probability = 25 },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 }, probability = 10 },
                },
                probability = 40,
            },
        },
    }
    group:entry { group = "bannerman_armor", damage = { 2, 5 } }
    group:group("pendant_necklaces_silver", 5)
    group:group("clothing_watch", 5)
    group:item("hammer_fey_smith", 2)
    group:entry { group = "bannerman_weapons", damage = { 2, 5 } }
    group:item("baldric")
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 }
    content.upsert_item_group(group)
end

do
    -- equal chance of Earthly or Faerie clothes
    local group = content.ItemGroup { id = "changeling_redcap_aspirant_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "clothing_outdoor_shoes", damage = { 1, 4 }, probability = 70 },
                    { group = "clothing_outdoor_pants", damage = { 1, 4 }, probability = 70 },
                    { group = "underwear", damage = { 1, 4 } },
                    { group = "clothing_outdoor_torso", damage = { 1, 4 }, probability = 70 },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 } },
                },
                probability = 50,
            },
            {
                collection = {
                    { group = "gossamer_upper_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_lower_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_outerwear", damage = { 1, 4 }, probability = 25 },
                    { item = "loincloth_gossamer", damage = { 1, 4 } },
                    { group = "gossamer_socks", damage = { 1, 4 }, probability = 25 },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 }, probability = 10 },
                },
                probability = 50,
            },
        },
    }
    group:entry { group = "redcap_armor", damage = { 0, 4 }, probability = 20 }
    group:group("pendant_necklaces_silver", 5)
    group:entry { group = "redcap_weapons", damage = { 0, 5 }, probability = 50 }
    group:entry { item = "scrap_dreamdross", count = { 4, 8 }, probability = 75 }
    content.upsert_item_group(group)
end

do
    -- equal chance of Earthly or Faerie clothes
    local group = content.ItemGroup { id = "changeling_pooka_aspirant_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "clothing_outdoor_shoes", damage = { 1, 4 }, probability = 70 },
                    { group = "clothing_outdoor_pants", damage = { 1, 4 }, probability = 70 },
                    { group = "underwear", damage = { 1, 4 } },
                    { group = "clothing_outdoor_torso", damage = { 1, 4 }, probability = 70 },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 } },
                },
                probability = 50,
            },
            {
                collection = {
                    { group = "gossamer_upper_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_lower_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_outerwear", damage = { 1, 4 }, probability = 25 },
                    { item = "loincloth_gossamer", damage = { 1, 4 } },
                    { group = "gossamer_socks", damage = { 1, 4 }, probability = 25 },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 }, probability = 10 },
                },
                probability = 50,
            },
        },
    }
    group:entry { group = "pooka_armor", damage = { 0, 4 }, probability = 20 }
    group:group("pendant_necklaces_silver", 5)
    group:entry { group = "pooka_weapons", damage = { 0, 5 }, probability = 50 }
    group:item("scabbard")
    group:entry { item = "scrap_dreamdross", count = { 4, 8 }, probability = 75 }
    content.upsert_item_group(group)
end

do
    -- high chance of Faerie clothes, low chance of Earthly clothes
    local group = content.ItemGroup { id = "changeling_lord_death_drops", kind = "collection" }
    group:entry { group = "cufflinks_silver", damage = { 0, 4 }, probability = 30 }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "dress_shoes", damage = { 1, 4 }, probability = 70 },
                    { group = "dress_shop", damage = { 1, 4 }, probability = 70 },
                    { group = "underwear", damage = { 1, 4 } },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 } },
                },
                probability = 20,
            },
            {
                collection = {
                    { group = "gossamer_upper_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_lower_body", damage = { 1, 4 }, probability = 70 },
                    { group = "gossamer_outerwear", damage = { 1, 4 }, probability = 25 },
                    { item = "loincloth_gossamer", damage = { 1, 4 } },
                    { group = "gossamer_socks", damage = { 1, 4 }, probability = 25 },
                    { group = "clothing_glasses", probability = 5 },
                    { group = "fae_furs", damage = { 0, 4 }, probability = 10 },
                },
                probability = 80,
            },
        },
    }
    group:entry { group = "bannerman_armor", damage = { 0, 4 } }
    group:group("pendant_necklaces_silver", 5)
    group:item("hammer_fey_smith", 2)
    group:item("baldric")
    group:item("purity_crackers", 10)
    group:item("golden_bridle", 5)
    group:entry { item = "scrap_dreamdross", count = { 12, 24 }, probability = 75 }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "default_moroi_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            { group = "default_zombie_clothes", probability = 90 },
                            { group = "default_zombie_clothes_christmas", event = "christmas", probability = 10 },
                        },
                    },
                    {
                        distribution = {
                            { group = "default_zombie_items", probability = 80 },
                            { group = "default_zombie_items_pockets", probability = 20 },
                        },
                    },
                },
                probability = 96,
            },
            {
                collection = {
                    { group = "postman_gear", damage = { 1, 4 } },
                    { group = "default_zombie_items_pockets", probability = 10 },
                },
                probability = 2,
            },
            {
                collection = {
                    { group = "prof-plumbing_gear", damage = { 1, 4 } },
                    { group = "default_zombie_items_pockets", probability = 10 },
                },
                probability = 2,
            },
        },
    }
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 30 }
    group:group("blood_containers", 30)
    group:item("grimy_recipe", 55)
    group:item("vampire_hunter_map", 10)
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 35 }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "renfield_death_drops", kind = "collection" }
    group:group("default_zombie_clothes")
    group:entry { item = "scrap_dreamdross", count = { 1, 4 }, probability = 75 }
    group:group("blood_containers", 15)
    content.upsert_item_group(group)
end
