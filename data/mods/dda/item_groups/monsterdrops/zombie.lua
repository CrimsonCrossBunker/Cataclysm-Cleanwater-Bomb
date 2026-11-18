local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_armored_death_drops", kind = "collection" }
    group:entry { item = "power_supply", count = { 0, 7 }, probability = 25 }
    group:entry { item = "element", count = { 0, 3 }, probability = 40 }
    group:group("cable_roll_part", 60)
    group:entry { item = "transponder", count = { 0, 1 }, probability = 25 }
    group:entry { item = "circuit", count = { 0, 8 }, probability = 40 }
    group:entry { item = "small_lcd_screen", count = { 0, 2 }, probability = 25 }
    group:entry { item = "RAM", count = { 0, 1 }, probability = 25 }
    group:entry { item = "combat_exoskeleton_armor_head_medium", count = { 0, 1 }, probability = 20 }
    group:entry { item = "combat_exoskeleton_armor_torso_medium", count = { 0, 1 }, probability = 20 }
    group:entry { item = "combat_exoskeleton_armor_arm_medium", count = { 0, 1 }, probability = 20 }
    group:entry { item = "combat_exoskeleton_armor_leg_medium", count = { 0, 1 }, probability = 20 }
    group:entry { item = "combat_exoskeleton_light_salvaged", count = { 0, 1 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_hazmat_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { group = "hazmat_full", damage = { 1, 4 }, probability = 20 },
            {
                collection = {
                    { group = "hazmat_torso", damage = { 1, 4 } },
                    { group = "hazmat_gloves", damage = { 1, 4 } },
                    { group = "hazmat_boots", damage = { 1, 4 } },
                    { group = "hazmat_mask", damage = { 1, 4 } },
                    { group = "hazmat_eyes", damage = { 1, 4 }, probability = 33 },
                },
                probability = 80,
            },
        },
    }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry {
        distribution = {
            { group = "rad_gear", probability = 1 },
        },
    }
    group:entry { group = "wallets", damage = { 1, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_blob_small_deathdrops", kind = "collection" }
    group:entry { item = "slime_scrap", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_fireman_death_drops", kind = "collection" }
    group:entry { group = "fireman_torso", damage = { 1, 4 } }
    group:entry { group = "fireman_pants", damage = { 1, 4 } }
    group:entry { group = "fireman_gloves", damage = { 1, 4 } }
    group:entry { group = "fireman_boots", damage = { 1, 4 } }
    group:entry { group = "fireman_mask", damage = { 1, 4 } }
    group:entry { group = "fireman_head", damage = { 1, 4 } }
    group:entry { group = "hazmat_eyes", damage = { 1, 4 }, probability = 33 }
    group:entry {
        distribution = {
            { group = "fireman_gear", probability = 1 },
        },
    }
    group:entry { group = "wallets", damage = { 1, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_swimmer_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { group = "swimmer_wetsuit", damage = { 1, 4 }, probability = 10 },
            { group = "bikini", damage = { 1, 4 }, probability = 25 },
            {
                collection = {
                    { group = "swimmer_torso_no_bikini", damage = { 1, 4 }, probability = 45 },
                    { group = "swimmer_pants_no_bikini", damage = { 1, 4 } },
                },
                probability = 65,
            },
        },
    }
    group:entry { group = "swimmer_head", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "swimmer_gloves", damage = { 1, 4 }, probability = 5 }
    group:entry { group = "swimmer_shoes", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "swimmer_accessories", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "swimmer_glasses", damage = { 0, 4 }, probability = 15 }
    group:group("swimmer_items", 5)
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 10 }
    group:entry { group = "civilian_phones_case", damage = { 0, 4 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_thorny_death_drops", kind = "collection" }
    group:entry { item = "cotton_patchwork", count = { 1, 4 }, damage = { 1, 4 } }
    group:entry { group = "pants", damage = { 1, 4 } }
    group:entry { group = "shoes", damage = { 1, 4 } }
    group:group("default_zombie_items")
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 10 }
    group:item("fighter_sting", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zombie_fursuits", kind = "distribution" }
    group:entry { item = "fursuit", damage = { 2, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zed_dust", kind = "collection" }
    group:entry { item = "corpse_ash", count = { 2, 3 } }
    group:entry { item = "skull_human_tainted", damage = { 1, 3 }, probability = 40 }
    group:entry { item = "bone_tainted", count = { 1, 3 }, damage = { 2, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zed_skin", kind = "collection" }
    group:entry { item = "raw_tainted_leather_scraps", count = { 5, 12 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 1, 4 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "bone_tainted", count = { 1, 4 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "sinew", count = { 1, 2 }, damage = { 2, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "explode_zed", kind = "collection" }
    group:entry { item = "skull_human_tainted", damage = { 2, 3 }, probability = 60 }
    group:entry { item = "arm_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 30 }
    group:entry { item = "leg_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 30 }
    group:entry { item = "blood_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "meat_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 1, 5 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "bone_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "tainted_marrow", count = { 1, 5 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "tainted_innards", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "raw_tainted_leather_scraps", count = { 2, 5 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "sinew", count = { 5, 10 }, damage = { 2, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "explode_zed_fungal", kind = "collection" }
    group:entry { item = "skull_human_tainted", damage = { 2, 3 }, probability = 60 }
    group:entry { item = "arm_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 20 }
    group:entry { item = "leg_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 20 }
    group:entry { item = "blood_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "meat_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 1, 5 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "bone_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "tainted_marrow", count = { 1, 5 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "veggy_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "raw_tainted_leather_scraps", count = { 2, 5 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "sinew", count = { 5, 10 }, damage = { 2, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "explode_zed_fungal_bone", kind = "collection" }
    group:entry { item = "skull_human_tainted", damage = { 2, 3 }, probability = 90 }
    group:entry { item = "arm_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 20 }
    group:entry { item = "leg_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 20 }
    group:entry { item = "blood_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "meat_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 1, 5 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "bone_tainted", count = { 15, 25 }, damage = { 2, 3 } }
    group:entry { item = "tainted_marrow", count = { 10, 15 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "veggy_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "raw_tainted_leather_scraps", count = { 1, 3 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "sinew", count = { 5, 10 }, damage = { 2, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "explode_zed_beast", kind = "collection" }
    group:entry { item = "leg_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "leg_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 40 }
    group:entry { item = "raw_tainted_leather_scraps", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "blood_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "meat_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 1, 5 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "bone_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "tainted_marrow", count = { 1, 5 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "tainted_innards", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "sinew", count = { 5, 10 }, damage = { 2, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "explode_gasbag", kind = "collection" }
    group:entry { item = "arm_zed", damage = { 2, 3 }, probability = 10 }
    group:entry { item = "leg_zed", damage = { 2, 3 }, probability = 10 }
    group:entry { item = "blood_tainted", count = { 3, 7 }, damage = { 2, 3 } }
    group:entry { item = "meat_tainted", count = { 3, 7 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 1, 3 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "bone_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "tainted_marrow", count = { 1, 2 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "tainted_innards", count = { 3, 7 }, damage = { 2, 3 } }
    group:entry { item = "raw_tainted_leather_scraps", count = { 2, 5 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "sinew", count = { 3, 7 }, damage = { 2, 3 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "explode_innards", kind = "collection" }
    group:entry { item = "blood_tainted", count = { 8, 15 }, damage = { 2, 3 } }
    group:entry { item = "meat_tainted", count = { 8, 15 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 3, 8 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "bone_tainted", count = { 1, 3 }, damage = { 2, 3 } }
    group:entry { item = "tainted_marrow", count = { 1, 2 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "tainted_innards", count = { 12, 24 }, damage = { 2, 3 } }
    group:entry { item = "raw_tainted_leather_scraps", count = { 2, 5 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "sinew", count = { 8, 15 }, damage = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "explode_innards_small", kind = "collection" }
    group:entry { item = "blood_tainted", count = { 3, 5 }, damage = { 2, 3 } }
    group:entry { item = "meat_tainted", count = { 2, 5 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 1, 3 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "bone_tainted", count = { 1, 3 }, damage = { 2, 3 } }
    group:entry { item = "tainted_marrow", count = { 1, 2 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "tainted_innards", count = { 1, 3 }, damage = { 2, 3 } }
    group:entry { item = "raw_tainted_leather_scraps", count = { 1, 3 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "sinew", count = { 1, 3 }, damage = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "explode_toad", kind = "collection" }
    group:entry { item = "leg_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 60 }
    group:entry { item = "leg_zed", count = { 1, 2 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "blood_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "meat_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "fat_tainted", count = { 1, 5 }, damage = { 2, 3 }, probability = 80 }
    group:entry { item = "bone_tainted", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "tainted_marrow", count = { 1, 5 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "sinew", count = { 5, 10 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "mutant_brain", count = { 1, 3 }, damage = { 2, 3 }, probability = 20 }
    group:entry { item = "mutant_lung", count = { 1, 5 }, damage = { 2, 3 }, probability = 50 }
    group:entry { item = "mutant_liver", count = { 5, 10 }, damage = { 2, 3 }, probability = 70 }
    group:entry { item = "tainted_innards", count = { 5, 10 }, damage = { 2, 3 } }
    group:entry { item = "raw_tainted_leather_scraps", count = { 2, 5 }, damage = { 2, 3 } }
    group:entry { item = "stomach_large", damage = { 2, 3 }, probability = 80 }
    content.add(group)
end
