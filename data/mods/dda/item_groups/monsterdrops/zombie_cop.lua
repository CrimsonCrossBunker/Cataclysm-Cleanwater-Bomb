local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "mon_zombie_cop_death_drops",
        kind = "collection",
        with_ammo = 40,
        with_magazine = 100,
    }
    group:entry { group = "cop_armor", damage = { 0, 2 }, probability = 70 }
    group:entry { group = "cop_other_clothes", damage = { 0, 2 }, probability = 70 }
    group:entry { group = "cop_gear", damage = { 0, 2 }, probability = 70 }
    group:entry { group = "cop_gloves", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "cop_helmet", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "cop_pants", damage = { 1, 4 } }
    group:entry { group = "cop_shoes", damage = { 1, 4 } }
    group:entry { group = "cop_torso", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    group:group("cop_pants_stuff")
    group:group("cop_armaments")
    group:entry {
        collection = {
            { item = "badge_deputy" },
            { item = "badge_detective", probability = 20 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- combination of armor and tools
    local group = content.ItemGroup { id = "cop_items", kind = "distribution" }
    group:group("cop_armor", 30)
    group:group("cop_gear", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_armor", kind = "distribution" }
    group:item("armor_riot", 65)
    group:item("armor_riot_arm", 5)
    group:item("armor_riot_leg", 5)
    group:item("armor_riot_torso", 10)
    group:item("kevlar")
    group:entry {
        item = "level_3_vest",
        variant = "police_armor_vest",
        contents = {
            { group = "some_steel_front_plates" },
        },
        probability = 75,
    }
    content.add(group)
end

do
    -- this group sorts out what the cop has for storage that might influence other stuff
    -- for example if the cop doesn't have a tacvest they can't have any additional magazines
    local group = content.ItemGroup { id = "cop_armaments", kind = "distribution" }
    group:entry {
        collection = {
            { item = "tacvest", damage = { 1, 4 } },
            {
                distribution = {
                    { group = "longguns_cop_in_field", probability = 10 },
                    { group = "longguns_cop_in_field_no_gun", probability = 90 },
                },
                probability = 50,
            },
            { group = "cop_holster_field", damage = { 1, 4 }, probability = 90 },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            { group = "longguns_cop", damage = { 0, 3 }, dirt = { 1500, 7050 }, probability = 10 },
            { group = "cop_holster", damage = { 0, 3 }, dirt = { 1500, 7050 }, probability = 90 },
        },
        probability = 90,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_gear", kind = "collection", container = "police_belt", overflow = "discard" }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 90 }
    group:entry { item = "two_way_radio", charges = { 0, 300 }, probability = 90 }
    group:item("tazer", 50)
    group:item("airhorn", 5)
    group:item("rope_30", 5)
    group:item("sm_extinguisher", 5)
    group:group("cop_melee", 60)
    group:entry { item = "teargas_sprayer", charges = { 1, 10 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_other_clothes", kind = "distribution" }
    group:item("armguard_cut_resistant", 2)
    group:item("balaclava_cut_resistant", 2)
    group:item("throat_guard_cut_resistant", 1)
    group:item("legpouch_large", 5)
    group:item("whistle", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet", kind = "distribution" }
    group:item("cowboy_hat", 10)
    group:item("helmet_riot")
    group:item("hat_ball")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants", kind = "distribution" }
    group:item("pants", 75)
    group:item("pants_tactical", 60)
    group:item("pants_cargo", 70)
    group:item("police_breeches", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants_stuff", kind = "collection" }
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 30 }
    group:group("default_zombie_items_pockets", 30)
    group:group("full_ipok", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes", kind = "distribution" }
    group:item("boots", 70)
    group:item("boots_steel", 50)
    group:item("sneakers_steel", 35)
    group:item("boots_hiking", 20)
    group:item("boots_western", 5)
    group:item("boots_combat", 10)
    group:item("motor_police_boots", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso", kind = "distribution" }
    group:item("dress_shirt", 50)
    group:item("postman_shirt", 45, "sheriff")
    group:item("jacket_light", 40)
    group:item("leather_police_jacket", 40, "leather_police_jacket")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_melee", kind = "distribution" }
    group:item("baton", 50)
    group:item("PR24-retracted", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_weapons", kind = "distribution" }
    group:group("longguns_cop", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_holster", kind = "distribution" }
    group:entry {
        item = "holster",
        contents = {
            { group = "sidearms_cop" },
        },
        probability = 10,
    }
    group:item("holster", 90)
    content.add(group)
end

do
    -- same as above but with the assumption that you have storage for magazines
    local group = content.ItemGroup { id = "cop_holster_field", kind = "distribution" }
    group:entry {
        collection = {
            { item = "holster" },
            { group = "sidearms_cop_in_field" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "holster" },
            { group = "sidearms_cop_in_field_no_gun" },
        },
        probability = 60,
    }
    group:item("holster", 60)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_swat_death_drops",
        kind = "collection",
        with_ammo = 40,
        with_magazine = 100,
    }
    group:entry { group = "swat_zombie_gear", damage = { 0, 2 } }
    group:entry { group = "swat_gloves", damage = { 0, 4 }, probability = 30 }
    group:entry { group = "swat_helmet", damage = { 0, 4 }, probability = 20 }
    group:entry { group = "swat_pants", damage = { 0, 4 } }
    group:entry { group = "swat_shoes", damage = { 0, 4 } }
    group:entry { group = "swat_torso", damage = { 0, 4 } }
    group:group("swat_weapons", 25)
    group:group("cop_holster", 70)
    group:entry { group = "underwear", damage = { 0, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 10)
    group:item("badge_swat", 10)
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_zombie_gear", kind = "collection" }
    group:entry {
        distribution = {
            { group = "adhesive_bandages_box_used", probability = 30 },
            { item = "bandages", count = { 1, 3 }, probability = 30 },
            { group = "full_1st_aid", probability = 20 },
        },
        probability = 25,
    }
    group:entry {
        collection = {
            { item = "heavy_flashlight", charges = { 0, 300 }, probability = 20 },
            { item = "airhorn", probability = 5 },
            { item = "two_way_radio", probability = 30 },
            { item = "whistle", probability = 5 },
            { item = "flashbang", probability = 10 },
            { item = "gasbomb", probability = 10 },
            { item = "sm_extinguisher", probability = 5 },
            { item = "rope_30", probability = 10 },
            { item = "teargas_sprayer", charges = { 1, 10 }, probability = 30 },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            { item = "holster", probability = 35 },
            { item = "chestpouch", probability = 15 },
            { item = "ammo_satchel", probability = 10 },
            { item = "bholster", probability = 25 },
            { item = "bandolier_shotgun", probability = 10 },
            { item = "legpouch_large", probability = 25 },
            { item = "police_belt", probability = 15 },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_gloves", kind = "distribution" }
    group:item("gloves_fingerless", 15)
    group:item("gloves_leather", 15)
    group:item("gloves_tactical", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_helmet", kind = "distribution" }
    group:item("mask_gas", 10)
    group:item("helmet_riot", 20)
    group:item("tac_helmet", 10)
    group:item("tac_fullhelmet", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_pants", kind = "distribution" }
    group:item("pants_tactical", 70)
    group:item("pants_cargo", 70)
    group:item("pants_army", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_shoes", kind = "distribution" }
    group:item("boots", 20)
    group:item("boots_steel", 40)
    group:item("sneakers_steel", 28)
    group:item("boots_hiking", 5)
    group:item("boots_combat", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_torso", kind = "collection" }
    group:entry {
        distribution = {
            { item = "armor_riot", probability = 30 },
            { item = "armor_riot_torso", probability = 15 },
            { group = "swat_ballistic_vest", probability = 80 },
        },
        probability = 65,
    }
    group:entry {
        distribution = {
            { item = "tank_top", probability = 30 },
            { item = "tank_top", variant = "tank_top_camo", probability = 40 },
            { item = "tshirt", probability = 20 },
            { item = "longshirt", probability = 10 },
            { item = "thermal_shirt", probability = 10 },
        },
        probability = 75,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_weapons", kind = "collection" }
    group:group("cop_melee", 25)
    group:group("guns_swat", 75)
    content.add(group)
end
