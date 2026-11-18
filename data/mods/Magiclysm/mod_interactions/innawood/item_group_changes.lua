local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bed", kind = "distribution" }
    group:item("grass_blanket", 2500)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "default_zombie_death_drops", kind = "collection" }
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
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "feral_goblin_death_drops", kind = "collection" }
    group:entry {
        group = "shoes_unisex",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 40,
    }
    group:entry {
        group = "npc_hat",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 10,
    }
    group:entry {
        group = "male_underwear_bottom",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
    }
    group:entry {
        group = "female_underwear_top",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
    }
    group:entry {
        item = "chestwrap_leather",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:entry {
        group = "pants_male",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 75,
    }
    group:entry {
        group = "npc_coat",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 2,
    }
    group:entry {
        group = "npc_gloves",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 50,
    }
    group:entry { item = "wicker_backpack", damage = { 1, 4 }, probability = 1 }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "goblin_armor_drops", kind = "collection" }
    group:item("helmet_larmor_xs", 40)
    group:item("xs_legguard_larmor", 40)
    group:item("xs_boots_larmor", 40)
    group:item("xs_armguard_larmor", 40)
    group:item("xs_gauntlets_larmor", 40)
    group:item("armor_larmor_chest_xs", 40)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "goblin_chieftan_weapon_drops", kind = "distribution" }
    group:group("survivor_stabbing", 99)
    group:item("rune_biomancer_weapon", 1)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "bugbear_stalker_weapon_drops", kind = "distribution" }
    group:group("survivor_stabbing")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "bugbear_armor_drops", kind = "collection" }
    group:item("xl_helmet_larmor", 20)
    group:item("xl_gauntlets_larmor", 20)
    group:item("xl_boots_larmor", 20)
    group:item("xl_armguard_larmor", 20)
    group:item("xl_legguard_larmor", 20)
    group:item("xl_armor_larmor_chest", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "orc_armor_drops", kind = "collection" }
    group:item("helmet_larmor", 40)
    group:item("legguard_larmor", 40)
    group:item("boots_larmor", 40)
    group:item("armguard_larmor", 40)
    group:item("gauntlets_larmor", 40)
    group:item("armor_larmor_chest", 40)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "orc_archer_melee_weapon_drops", kind = "distribution" }
    group:entry {
        item = "sheath",
        contents = {
            { item = "primitive_knife" },
        },
    }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "orc_archer_ranged_weapon_drops", kind = "collection" }
    group:item("longbow", 85)
    group:entry {
        item = "quiver_large",
        contents = {
            { group = "quiver_orc_archer" },
        },
        probability = 50,
    }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "orc_blood_warrior_weapon_drops", kind = "distribution" }
    group:item("lizardfolk_club")
    content.replace(group)
end

do
    -- a large pile of trash, made for goblin encampments.
    local group = content.ItemGroup { id = "midden_heap", kind = "collection" }
    group:group("trash_forest", 95)
    group:group("trash_forest", 70)
    group:group("trash_forest", 25)
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
    local group = content.ItemGroup { id = "quiver_orc_archer", kind = "collection" }
    group:entry { item = "arrow_heavy_fire_hardened_fletched", count = { 1, 6 }, charges = { 1, 10 } }
    content.replace(group)
end
