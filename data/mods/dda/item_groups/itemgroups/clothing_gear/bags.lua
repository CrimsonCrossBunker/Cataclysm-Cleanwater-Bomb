local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bags", kind = "distribution" }
    group:group("small_bags", 92)
    group:item("backpack", 38)
    group:item("backpack_hiking", 3)
    group:item("backpack_hunting", 1)
    group:item("backpack_tactical_large", 1)
    group:item("bigback", 1)
    group:item("travelpack", 5)
    group:item("rucksack", 1)
    group:group("large_gym_bags", 5)
    group:item("leg_bag", 1)
    group:item("quiver_takedown_bow", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_gym_bags", kind = "distribution" }
    group:item("duffelbag_gym_xxs", 2)
    group:item("duffelbag_gym_xs", 5)
    group:item("duffelbag_gym_s", 20)
    group:item("duffelbag_gym_m", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "large_gym_bags", kind = "distribution" }
    group:item("duffelbag_gym_l", 10)
    group:item("duffelbag_gym_xl", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gym_bags", kind = "distribution" }
    group:group("small_gym_bags", 5)
    group:group("large_gym_bags", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gun_cases", kind = "distribution" }
    group:item("rifle_case_soft", 50)
    group:item("rifle_case_soft_leather", 30)
    group:item("rifle_case_soft_2", 40)
    group:item("rifle_case_soft_leather_2", 30)
    group:item("rifle_case_xl_soft_leather", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bags_trip", kind = "distribution" }
    group:item("suitcase_l", 37)
    group:item("suitcase_m", 55)
    group:item("duffelbag", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "large_duffelbags", kind = "distribution" }
    group:group("large_gym_bags")
    group:item("duffelbag_l_poly", 60)
    group:item("duffelbag_xl_nylon", 30)
    content.add(group)
end

do
    -- worn bags of all sorts for domestic buildings
    local group = content.ItemGroup { id = "bags_unisex", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "straw_basket", probability = 35 },
            { item = "suitcase_l", probability = 15 },
            { item = "suitcase_m", probability = 25 },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            { item = "2lcanteen", probability = 50 },
            { item = "camelbak", probability = 25 },
            { item = "canteen", probability = 70 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "fanny", probability = 60 },
            { item = "mbag", probability = 35 },
            { item = "runner_bag", probability = 45 },
            { item = "slingpack", probability = 65 },
            { item = "purse", probability = 70 },
            { item = "briefcase", probability = 40 },
            { item = "duffelbag", probability = 20 },
            { item = "leg_bag", probability = 1 },
            { item = "leg_small_bag", probability = 1 },
            { item = "armrig", probability = 1 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "case_violin", probability = 5 },
            { item = "bookstrap", probability = 5 },
            { item = "camera_bag", probability = 20 },
            { item = "quiver_takedown_bow", probability = 2 },
            { item = "nylon_quiver", probability = 12 },
            { item = "quiver", probability = 8 },
            { item = "quiver_large", probability = 15 },
            { item = "ammo_satchel", probability = 10 },
            { item = "ammo_pouch", probability = 10 },
            { item = "chestrig", probability = 20 },
            { item = "chestrig", variant = "flag_chestrig", probability = 2 },
            { item = "dive_bag", probability = 25 },
            { item = "dry_bag", probability = 25 },
            { item = "dry_duffelbag", probability = 25 },
            { item = "dry_bag_large", probability = 15 },
            { item = "chestrig", variant = "flag_chestrig", event = "independence_day", probability = 70 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "daypack", probability = 25 },
            { item = "backpack_leather", probability = 40 },
            { item = "backpack", probability = 85 },
            { item = "backpack_denim", probability = 5 },
            { item = "backpack_hiking", probability = 25 },
            { group = "gym_bags", probability = 80 },
            { item = "duffelbag", probability = 80 },
            { group = "large_duffelbags", probability = 10 },
            { item = "travelpack", probability = 25 },
            { group = "bugout_bag", probability = 1 },
        },
        probability = 80,
    }
    content.add(group)
end

do
    -- worn bags of all sorts for domestic buildings
    local group = content.ItemGroup { id = "bags_unisex_small", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "2lcanteen", probability = 50 },
            { item = "camelbak", probability = 25 },
            { item = "canteen", probability = 70 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "fanny", probability = 60 },
            { item = "mbag", probability = 35 },
            { item = "runner_bag", probability = 45 },
            { item = "slingpack", probability = 65 },
            { item = "purse", probability = 70 },
            { item = "leg_bag", probability = 1 },
            { item = "leg_small_bag", probability = 1 },
            { item = "armrig", probability = 1 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "case_violin", probability = 5 },
            { item = "bookstrap", probability = 5 },
            { item = "camera_bag", probability = 20 },
            { item = "quiver_takedown_bow", probability = 2 },
            { item = "nylon_quiver", probability = 12 },
            { item = "quiver", probability = 8 },
            { item = "quiver_large", probability = 15 },
            { item = "ammo_satchel", probability = 10 },
            { item = "ammo_pouch", probability = 10 },
            { item = "chestrig", probability = 20 },
            { item = "chestrig", variant = "flag_chestrig", probability = 2 },
            { item = "dive_bag", probability = 25 },
            { item = "dry_bag", probability = 25 },
            { item = "chestrig", variant = "flag_chestrig", event = "independence_day", probability = 70 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "daypack", probability = 25 },
            { item = "backpack_leather", probability = 40 },
            { item = "backpack", probability = 85 },
            { item = "backpack_denim", probability = 5 },
            { item = "travelpack", probability = 25 },
            { group = "small_gym_bags", probability = 40 },
            { group = "bugout_bag", probability = 1 },
        },
        probability = 80,
    }
    content.add(group)
end
