local content = require("ccb").content

do
    local group = content.ItemGroup { id = "void_spider_spiderling_skewered_drops", kind = "collection" }
    group:entry { item = "arrow_meteor", charges = { 1, 1 }, probability = 90 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_dragon_dummy_drops", kind = "collection" }
    group:entry { item = "paper", count = { 100, 300 } }
    group:entry { item = "stick", count = { 5, 8 } }
    group:entry { item = "cable", count = { 20, 50 } }
    group:entry { item = "amplifier", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "amigara_items", kind = "distribution" }
    group:item("art_robe")
    group:item("art_cloak")
    group:item("art_coat")
    group:item("art_mask")
    group:item("art_helm")
    group:item("art_gloves")
    group:item("art_boots")
    group:item("art_ring")
    group:item("art_staff")
    group:item("art_sword")
    group:item("art_harp")
    group:item("art_dagger")
    group:item("art_spear")
    group:item("art_club")
    content.add(group)
end

do
    -- items for zombie reenactor
    local group = content.ItemGroup { id = "zombie_reenactor_drops", kind = "collection" }
    group:entry {
        distribution = {
            { item = "pockknife", probability = 10 },
            {
                collection = {
                    { item = "pipe_tobacco" },
                    { item = "tobacco", count = { 0, 40 }, wrapper = "bag_plastic", container = "null" },
                },
                probability = 10,
            },
            { item = "hatchet", probability = 10 },
            { item = "hardtack", count = { 1, 3 }, probability = 10 },
            { item = "pipe_cleaner", probability = 10 },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "knee_high_boots", damage = { 1, 4 }, probability = 20 },
            { item = "breeches", damage = { 1, 4 }, probability = 50 },
            { item = "waistcoat", damage = { 1, 4 }, probability = 30 },
            { item = "peacoat", damage = { 1, 4 }, probability = 50 },
            { item = "leather_belt", damage = { 1, 4 }, probability = 10 },
            { item = "knit_scarf", damage = { 1, 4 }, probability = 10 },
            { item = "tricorne", damage = { 1, 4 }, probability = 30 },
            { item = "gloves_leather", damage = { 1, 4 }, probability = 10 },
            { item = "stockings", damage = { 1, 4 }, variant = "stockings_white", probability = 20 },
            { item = "long_underpants", damage = { 1, 4 } },
        },
    }
    group:entry {
        distribution = {
            {
                distribution = {
                    {
                        item = "rifle_flintlock",
                        charges = { 0, 1 },
                        contents = {
                            { item = "shoulder_strap_simple" },
                        },
                        probability = 50,
                    },
                    { item = "pistol_flintlock", charges = { 0, 1 }, probability = 20 },
                    {
                        item = "longrifle_flintlock",
                        charges = { 0, 1 },
                        contents = {
                            { item = "shoulder_strap_simple" },
                        },
                        probability = 30,
                    },
                },
                probability = 50,
            },
            {
                collection = {
                    { item = "flintlock_pouch", damage = { 1, 4 } },
                    { item = "flintlock_ammo", charges = { 0, 14 } },
                },
                probability = 30,
            },
            { item = "lamp_oil", charges = { 0, 250 }, container = "bottle_plastic_small", probability = 10 },
        },
    }
    content.add(group)
end
