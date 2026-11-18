local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "mon_zombie_sailor_death_drops",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry { group = "clothing_navy", damage = { 0, 4 } }
    group:group("gear_soldier_sidearm", 10)
    group:group("tools_common", 20)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 25 }
    group:entry { item = "two_way_radio", charges = { 0, 300 }, probability = 25 }
    group:group("wallets_military", 5)
    group:entry { group = "clothing_glasses", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "pants_army", damage = { 0, 4 }, variant = "mil_pants_navy" }
    group:entry { item = "boots", damage = { 0, 4 } }
    group:entry { item = "tool_belt", damage = { 0, 4 }, probability = 40 }
    group:entry {
        distribution = {
            { item = "mask_gas", charges = { 0, 100 }, damage = { 1, 4 }, probability = 25 },
            {
                item = "mask_gas",
                charges = { 0, 100 },
                damage = { 1, 4 },
                contents = {
                    { group = "gasmask_inserts_in_use" },
                },
                probability = 25,
            },
            { group = "gasmask_bag_full", damage = { 1, 4 }, probability = 25 },
            { group = "gasmask_bag_used", damage = { 1, 4 }, probability = 60 },
        },
        probability = 5,
    }
    group:entry { item = "hat_navy", damage = { 0, 4 } }
    group:entry { item = "wristwatch", damage = { 0, 4 }, probability = 33 }
    group:group("pocket_cigar", 5)
    group:group("misc_smoking_legal", 10)
    group:item("dog_tag", 40)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_marine_death_drops",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry {
        distribution = {
            {
                group = "military_standard_assault_rifles",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 75,
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap_simple" },
                },
                probability = 10,
            },
            {
                group = "military_standard_shotguns",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 5,
            },
        },
        probability = 15,
    }
    group:entry { group = "clothing_navy", damage = { 0, 4 } }
    group:group("gear_soldier_sidearm", 10)
    group:entry { group = "loaded_webbing_belt", damage = { 0, 4 }, probability = 60 }
    group:entry { item = "pants_army", damage = { 0, 4 }, variant = "apants_MARPAT" }
    group:entry { item = "boots_combat", damage = { 0, 4 } }
    group:entry {
        item = "sheath",
        contents = {
            { item = "knife_combat_marine" },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "infantry_officer_gear" },
            { group = "infantry_medical_gear" },
        },
        probability = 25,
    }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 25 }
    group:entry { item = "two_way_radio", charges = { 0, 300 }, probability = 25 }
    group:group("wallets_military", 5)
    group:entry { group = "clothing_glasses", damage = { 0, 4 }, probability = 5 }
    group:entry {
        distribution = {
            { item = "mask_gas", charges = { 0, 100 }, damage = { 1, 4 }, probability = 25 },
            {
                item = "mask_gas",
                charges = { 0, 100 },
                damage = { 1, 4 },
                contents = {
                    { group = "gasmask_inserts_in_use" },
                },
                probability = 25,
            },
            { group = "gasmask_bag_full", damage = { 1, 4 }, probability = 25 },
            { group = "gasmask_bag_used", damage = { 1, 4 }, probability = 60 },
        },
        probability = 5,
    }
    group:entry { item = "wristwatch", damage = { 0, 4 }, probability = 33 }
    group:entry { group = "military_standard_grenades", count = { 1, 3 }, probability = 20 }
    group:group("military_patrol_food")
    group:group("pocket_cigar", 5)
    group:group("misc_smoking_legal", 10)
    group:entry { item = "elbow_pads", damage = { 0, 4 }, probability = 10 }
    group:entry { item = "knee_pads", damage = { 0, 4 }, probability = 85 }
    group:entry { item = "helmet_army", damage = { 0, 4 } }
    group:entry { item = "gloves_tactical", damage = { 0, 4 }, probability = 60 }
    group:entry { group = "military_ballistic_vest", damage = { 0, 4 } }
    group:entry { group = "molle_backpacks_and_accessories", damage = { 0, 4 }, probability = 85 }
    group:entry { group = "clothing_tactical_leg", damage = { 0, 4 }, probability = 15 }
    group:item("dog_tag", 40)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_officer_death_drops",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry { group = "clothing_navy_officer", damage = { 0, 4 } }
    group:group("infantry_officer_gear")
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 25 }
    group:entry { item = "two_way_radio", charges = { 0, 300 }, probability = 25 }
    group:item("militarymap", 10)
    group:group("wallets_military", 5)
    group:entry { group = "clothing_glasses", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "wristwatch", damage = { 0, 4 }, probability = 33 }
    group:group("pocket_cigar", 5)
    group:group("misc_smoking_legal", 10)
    group:item("dog_tag", 20)
    content.add(group)
end
