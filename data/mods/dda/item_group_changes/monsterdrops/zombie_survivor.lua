local content = require("ccb").content

do
    local group = content.ItemGroup { id = "survivor_bashing", kind = "distribution" }
    group:item("bat_metal", 5)
    group:item("bwirebat", 20)
    group:item("crowbar", 5)
    group:item("nailboard", 25)
    group:item("makeshift_crowbar", 35)
    group:item("nailbat", 25)
    group:item("pipe", 10)
    group:item("spear_rebar", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_cutting", kind = "distribution" }
    group:item("ax", 5)
    group:item("hatchet", 5)
    group:item("machete", 5)
    group:item("makeshift_halberd", 5)
    group:item("makeshift_machete", 15)
    content.add(group)
end

do
    -- Survivor piercing weapons other than knives
    local group = content.ItemGroup { id = "survivor_stabbing", kind = "distribution" }
    group:item("spear_copper", 1)
    group:item("spear_steel", 1)
    group:item("spear_knife", 15)
    group:item("spear_pipe", 10)
    group:item("spear_spike", 15)
    group:item("spear_stone", 15)
    group:item("spear_rebar", 10)
    group:item("spear_wood", 20)
    group:item("spear_homemade_halfpike", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_survivor_death_drops", kind = "collection", with_magazine = 100 }
    group:entry { group = "survivor_basic_outfit", damage = { 1, 4 } }
    group:group("bugout_bag", 20)
    group:group("book_survival", 15)
    group:entry { group = "gear_survival", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "survivor_knife", damage = { 1, 4 }, probability = 50 }
    group:entry {
        distribution = {
            { group = "survivor_melee", damage = { 1, 4 }, probability = 70 },
            {
                group = "survivor_longguns",
                damage = { 1, 4 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 30,
            },
        },
        probability = 50,
    }
    group:group("survivor_grenades", 10)
    group:group("stash_food", 20)
    group:group("ammo_common_boxed_used", 35)
    group:group("stash_drugs", 25)
    group:group("gear_survival", 15)
    group:group("mil_food", 10)
    group:group("mil_food_nodrugs", 10)
    group:group("shelter", 3)
    group:group("mil_surplus", 15)
    group:group("default_zombie_items_bags", 15)
    group:group("default_zombie_items_pockets", 15)
    group:item("credit_card")
    group:entry {
        distribution = {
            { group = "full_survival_kit", damage = { 1, 4 } },
            { group = "used_survival_kit", damage = { 1, 4 } },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "teargas_sprayer", charges = { 0, 5 }, probability = 10 },
            {
                collection = {
                    { item = "holster" },
                    { group = "guns_pistol_common_everyday_carry", damage = { 0, 2 } },
                },
                probability = 10,
            },
            {
                collection = {
                    { item = "holster" },
                    { item = "tazer", charges = { 0, 100 }, damage = { 0, 2 } },
                },
                probability = 5,
            },
        },
        probability = 35,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_survivor_elite_death_drops", kind = "collection" }
    group:entry { group = "survivorzed_gloves", damage = { 1, 4 } }
    group:entry { group = "survivorzed_boots", damage = { 1, 4 } }
    group:entry { group = "survivorzed_head", damage = { 1, 4 } }
    group:entry { group = "survivorzed_extra", damage = { 1, 4 } }
    group:entry {
        distribution = {
            { group = "survivorzed_suits", damage = { 1, 4 }, probability = 25 },
            {
                collection = {
                    { group = "survivorzed_tops", damage = { 1, 4 }, probability = 25 },
                    { group = "survivorzed_bottoms", damage = { 1, 4 }, probability = 25 },
                },
                probability = 75,
            },
        },
    }
    group:entry {
        distribution = {
            { group = "underwear", damage = { 1, 4 }, probability = 1 },
            { group = "loincloth", damage = { 1, 4 }, probability = 2 },
        },
    }
    group:entry {
        distribution = {
            {
                distribution = {
                    { group = "guns_pistol_common" },
                    {
                        group = "guns_rifle_common_worn",
                        contents = {
                            { item = "shoulder_strap" },
                        },
                        probability = 20,
                    },
                    {
                        group = "guns_shotgun_common_worn",
                        contents = {
                            { item = "shoulder_strap_simple" },
                        },
                        probability = 40,
                    },
                },
                probability = 24,
            },
            { group = "grenades", probability = 10 },
            { group = "launchers", probability = 1 },
            { group = "stash_food", probability = 10 },
            { group = "ammo_common_boxed_used", probability = 26 },
            { group = "stash_drugs", probability = 28 },
            { group = "gear_survival", probability = 18 },
            { group = "mil_food", probability = 22 },
            { group = "mil_food_nodrugs", probability = 34 },
            { group = "shelter", probability = 8 },
            { group = "mil_surplus", probability = 6 },
        },
    }
    group:item("credit_card")
    content.add(group)
end
