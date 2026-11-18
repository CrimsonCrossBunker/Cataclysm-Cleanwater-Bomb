local content = require("ccb").content

do
    local group = content.ItemGroup { id = "feral_scientists_death_drops_scalpel", kind = "collection" }
    group:group("bionics", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_bio_op_death_drops",
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
                contents = {
                    { group = "sopmod" },
                },
                probability = 75,
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
    group:entry {
        distribution = {
            { group = "military_standard_grenades", count = { 1, 3 }, probability = 80 },
            { item = "40x46mm_m433", charges = { 1, 3 }, probability = 20 },
        },
        probability = 20,
    }
    group:group("military_patrol_food")
    group:entry {
        collection = {
            { group = "infantry_officer_gear", probability = 90 },
            { group = "infantry_medical_gear", probability = 80 },
        },
    }
    group:group("wallets", 10)
    group:group("pocket_cigar", 15)
    group:group("misc_smoking_legal", 30)
    group:item("dog_tag", 40)
    content.upsert_item_group(group)
end
