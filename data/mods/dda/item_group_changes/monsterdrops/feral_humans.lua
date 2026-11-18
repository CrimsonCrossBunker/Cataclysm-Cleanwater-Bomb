local content = require("ccb").content

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_axe", kind = "collection" }
    group:entry {
        distribution = {
            { item = "ax", damage = { 1, 3 }, probability = 50 },
            { item = "hatchet", damage = { 1, 3 }, probability = 25 },
            { item = "fire_ax", damage = { 2, 4 }, probability = 15 },
            { item = "iceaxe", damage = { 1, 3 }, probability = 5 },
            { item = "crash_axe", damage = { 1, 3 }, probability = 5 },
        },
    }
    group:entry { group = "default_zombie_death_drops", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_pipe", kind = "collection" }
    group:entry { item = "pipe", damage = { 0, 2 } }
    group:entry { group = "default_zombie_death_drops", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_crowbar", kind = "collection" }
    group:entry {
        distribution = {
            { item = "crowbar", damage = { 1, 3 }, probability = 60 },
            { item = "claw_bar", damage = { 1, 3 }, probability = 30 },
            { item = "heavy_crowbar", damage = { 2, 4 }, probability = 10 },
        },
    }
    group:entry { group = "default_zombie_death_drops", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_sapien_death_drops_spear", kind = "collection" }
    group:entry { group = "survivor_stabbing", damage = { 0, 3 } }
    group:entry { group = "underwear", damage = { 0, 3 } }
    group:entry { group = "survivor_basic_pants", damage = { 0, 3 } }
    group:entry { group = "survivor_basic_shirt", damage = { 0, 3 } }
    group:entry { group = "survivor_basic_hands", damage = { 0, 3 }, probability = 95 }
    group:entry { group = "survivor_basic_feet", damage = { 0, 3 } }
    group:entry { group = "clothing_glasses", damage = { 0, 3 }, probability = 5 }
    group:entry { group = "clothing_watch", damage = { 0, 3 }, probability = 5 }
    group:entry {
        distribution = {
            { item = "spearsling", damage = { 0, 3 }, probability = 50 },
            { item = "spearsling_canvas", damage = { 0, 3 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "police_belt", damage = { 0, 3 }, probability = 35 },
            { item = "fireman_belt", damage = { 0, 3 }, probability = 35 },
            { item = "tool_belt", damage = { 0, 3 }, probability = 30 },
        },
        probability = 50,
    }
    group:entry { item = "kevlar", damage = { 0, 3 }, probability = 35 }
    group:entry {
        distribution = {
            { item = "tac_helmet", damage = { 0, 3 }, probability = 35 },
            { item = "helmet_army", damage = { 0, 3 }, probability = 35 },
            { item = "helmet_riot", damage = { 0, 3 }, probability = 30 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "armor_riot", damage = { 0, 3 }, probability = 30 },
            { item = "duster_leather", damage = { 0, 3 }, probability = 10 },
            { item = "ballistic_vest_heavy", damage = { 0, 3 }, probability = 30 },
            {
                collection = {
                    { item = "level_3_vest", damage = { 0, 3 } },
                    { item = "armor_riot_arm", damage = { 0, 3 }, probability = 50 },
                    { item = "armor_riot_leg", damage = { 0, 3 }, probability = 50 },
                },
                probability = 30,
            },
        },
        probability = 95,
    }
    group:group("harddrugs", 15)
    group:group("stash_food", 15)
    group:group("ammo_common_boxed_used", 15)
    group:group("stash_drugs", 15)
    group:group("gear_survival", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_scientists_death_drops_scalpel", kind = "collection" }
    group:entry { item = "scalpel", damage = { 1, 3 } }
    group:entry { group = "lab_shoes", damage = { 1, 4 } }
    group:entry { group = "lab_torso", damage = { 1, 4 } }
    group:entry { group = "lab_pants", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry {
        collection = {
            { group = "harddrugs", probability = 25 },
            { group = "chem_lab", probability = 60 },
            { group = "teleport", probability = 6 },
            { group = "goo", probability = 20 },
            { group = "cloning_vat", probability = 1 },
            { group = "dissection", probability = 50 },
            { group = "electronics", probability = 40 },
            { item = "radio", probability = 15 },
            { group = "textbooks", probability = 25 },
            { group = "everyday_gear_lab", probability = 50 },
        },
    }
    group:entry { group = "wallets_science", damage = { 1, 4 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_feral_prepper_death_drops",
        kind = "collection",
        with_ammo = 20,
        with_magazine = 100,
    }
    group:entry { group = "guns_pistol_common", charges = { 1, 30 }, damage = { 0, 2 }, probability = 30 }
    group:entry { group = "clothing_outdoor_set", damage = { 1, 4 } }
    group:entry { group = "bags", damage = { 1, 4 } }
    group:group("book_survival", 40)
    group:entry { group = "survivor_knife", damage = { 1, 4 } }
    group:entry { group = "gear_survival", damage = { 1, 4 }, probability = 55 }
    group:entry { group = "survivor_bashing", damage = { 1, 4 } }
    group:group("stash_food", 35)
    group:group("mil_food_nodrugs", 10)
    group:entry { group = "used_survival_kit", damage = { 1, 4 }, probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_feral_survivalist_death_drops",
        kind = "collection",
        with_ammo = 15,
        with_magazine = 100,
    }
    group:entry { item = "flashlight", damage = { 2, 4 } }
    group:group("survivor_grenades", 20)
    group:entry { group = "clothing_outdoor_set", damage = { 1, 4 } }
    group:entry { group = "bags", damage = { 1, 4 } }
    group:group("book_survival", 60)
    group:entry { group = "survivorzed_gloves", damage = { 0, 4 } }
    group:entry { group = "survivor_knife", damage = { 1, 4 } }
    group:entry { group = "gear_survival", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "survivor_cutting", damage = { 1, 4 } }
    group:group("stash_food", 35)
    group:group("mil_food", 33)
    group:group("mil_food_nodrugs", 38)
    group:group("shelter", 16)
    group:entry { group = "used_survival_kit", damage = { 1, 4 }, probability = 90 }
    content.add(group)
end
