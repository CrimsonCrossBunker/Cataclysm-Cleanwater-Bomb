local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_kevlar_death_drops", kind = "distribution" }
    group:group("mon_zombie_heavy_soldier_death_drops", 80)
    group:group("mon_zombie_soldier_death_drops", 10)
    group:group("mon_zombie_cop_death_drops", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_soldier_lixa_police_death_drops",
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
            { group = "military_standard_assault_rifles", damage = { 0, 4 }, dirt = { 0, 6000 }, probability = 65 },
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
        },
        probability = 10,
    }
    group:group("infantry_common_gear")
    group:group("wallets", 10)
    group:group("pocket_cigar", 15)
    group:group("misc_smoking_legal", 30)
    group:item("dog_tag", 40)
    group:item("id_LIXA_mil", 75)
    content.add(group)
end
