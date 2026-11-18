local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "mon_zombie_soldier_death_drops",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry {
        distribution = {
            { group = "clothing_soldier_set", damage = { 1, 4 }, probability = 65 },
            { group = "clothing_soldier_winter_set", damage = { 1, 4 }, probability = 35 },
        },
    }
    group:entry {
        distribution = {
            {
                group = "military_standard_assault_rifles",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                probability = 65,
            },
            {
                collection = {
                    {
                        distribution = {
                            {
                                group = "military_grenadier_assault_rifles",
                                damage = { 0, 4 },
                                dirt = { 0, 6000 },
                                probability = 4,
                            },
                        },
                    },
                    { item = "40x46mm_m433", charges = { 1, 3 }, probability = 50 },
                },
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 4,
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                    { item = "acog_scope" },
                },
                probability = 6,
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
        probability = 10,
    }
    group:group("infantry_common_gear")
    group:entry { group = "military_standard_grenades", count = { 1, 3 }, probability = 20 }
    group:group("military_patrol_food")
    group:entry {
        distribution = {
            { group = "infantry_officer_gear" },
            { group = "infantry_medical_gear" },
        },
        probability = 25,
    }
    group:group("wallets", 10)
    group:group("pocket_cigar", 15)
    group:group("misc_smoking_legal", 30)
    group:item("dog_tag", 40)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_heavy_soldier_death_drops",
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
                probability = 25,
            },
            {
                collection = {
                    {
                        distribution = {
                            {
                                group = "military_grenadier_assault_rifles",
                                damage = { 0, 4 },
                                dirt = { 0, 6000 },
                                contents = {
                                    { item = "shoulder_strap" },
                                },
                                probability = 4,
                            },
                            {
                                group = "military_grenadier_assault_rifles",
                                damage = { 0, 4 },
                                dirt = { 0, 6000 },
                                contents = {
                                    { item = "shoulder_strap" },
                                    { item = "acog_scope" },
                                },
                                probability = 6,
                            },
                        },
                    },
                    { item = "40x46mm_m433", charges = { 1, 3 }, probability = 50 },
                },
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 4,
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                    { item = "acog_scope" },
                },
                probability = 6,
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
        probability = 10,
    }
    group:entry { group = "clothing_soldier_heavy_set", damage = { 0, 2 } }
    group:group("infantry_common_gear")
    group:entry {
        distribution = {
            { group = "military_standard_grenades", count = { 1, 3 }, probability = 80 },
            { item = "40x46mm_m433", charges = { 1, 3 }, probability = 20 },
        },
        probability = 20,
    }
    group:group("military_patrol_food")
    group:entry {
        distribution = {
            { group = "infantry_officer_gear" },
            { group = "infantry_medical_gear" },
        },
        probability = 25,
    }
    group:group("wallets", 10)
    group:group("pocket_cigar", 15)
    group:group("misc_smoking_legal", 30)
    group:item("dog_tag", 40)
    content.add(group)
end
