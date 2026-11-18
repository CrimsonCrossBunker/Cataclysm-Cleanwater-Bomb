local content = require("ccb").content

do
    -- Generic corpses that will definitely not get up again
    local group = content.ItemGroup { id = "corpses_verydead", kind = "distribution" }
    group:entry { group = "corpse_generic_male", damage = { 4, 4 }, probability = 30 }
    group:entry { group = "corpse_generic_female", damage = { 4, 4 }, probability = 30 }
    group:entry { group = "corpse_generic_boy", damage = { 4, 4 }, probability = 10 }
    group:entry { group = "corpse_generic_girl", damage = { 4, 4 }, probability = 10 }
    group:entry { group = "corpse_generic_human", damage = { 4, 4 }, probability = 10 }
    group:entry { group = "corpse_generic_gunned", damage = { 4, 4 }, probability = 30 }
    group:entry { group = "corpse_bloody", damage = { 4, 4 }, probability = 15 }
    group:entry { group = "corpse_painful", damage = { 4, 4 }, probability = 15 }
    group:entry { group = "corpse_scorched", damage = { 4, 4 }, probability = 15 }
    group:entry { group = "corpse_stabbed", damage = { 4, 4 }, probability = 15 }
    group:entry { group = "corpse_gunned", damage = { 4, 4 }, probability = 15 }
    group:entry { group = "corpse_halved_upper", damage = { 4, 4 }, probability = 15 }
    group:entry { group = "corpse_half_beheaded", damage = { 4, 4 }, probability = 15 }
    group:entry { group = "corpse_child_gunned", damage = { 4, 4 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpses_no_items", kind = "distribution" }
    group:entry { item = "corpse_generic_male", damage = { 0, 1 }, probability = 80 }
    group:entry { item = "corpse_generic_female", damage = { 0, 1 }, probability = 80 }
    group:entry { item = "corpse_generic_boy", damage = { 0, 1 }, probability = 15 }
    group:entry { item = "corpse_generic_girl", damage = { 0, 1 }, probability = 15 }
    group:entry { item = "corpse_generic_human", damage = { 0, 1 }, probability = 10 }
    group:entry { item = "corpse_generic_gunned", damage = { 1, 3 }, probability = 40 }
    group:item("corpse_generic_infected", 40)
    group:entry { item = "corpse_bloody", damage = { 1, 3 }, probability = 10 }
    group:entry { item = "corpse_painful", damage = { 0, 2 }, probability = 10 }
    group:entry { item = "corpse_scorched", damage = { 3, 4 }, probability = 10 }
    group:entry { item = "corpse_stabbed", damage = { 1, 3 }, probability = 10 }
    group:entry { item = "corpse_gunned", damage = { 1, 3 }, probability = 10 }
    group:entry { item = "corpse_halved_upper", damage = { 4, 4 }, probability = 10 }
    group:entry { item = "corpse_half_beheaded", damage = { 4, 4 }, probability = 10 }
    group:item("corpse_child_calm", 10)
    group:entry { item = "corpse_child_gunned", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "corpse_oldwoman_jewelry", damage = { 1, 3 }, probability = 10 }
    content.add(group)
end

do
    -- Generic empty corpses that will definitely not get up again
    local group = content.ItemGroup { id = "corpses_verydead_no_items", kind = "distribution" }
    group:entry { item = "corpse_generic_male", damage = { 4, 4 }, probability = 30 }
    group:entry { item = "corpse_generic_female", damage = { 4, 4 }, probability = 30 }
    group:entry { item = "corpse_generic_boy", damage = { 4, 4 }, probability = 10 }
    group:entry { item = "corpse_generic_girl", damage = { 4, 4 }, probability = 10 }
    group:entry { item = "corpse_generic_human", damage = { 4, 4 }, probability = 10 }
    group:entry { item = "corpse_generic_gunned", damage = { 4, 4 }, probability = 30 }
    group:entry { item = "corpse_bloody", damage = { 4, 4 }, probability = 15 }
    group:entry { item = "corpse_painful", damage = { 4, 4 }, probability = 15 }
    group:entry { item = "corpse_scorched", damage = { 4, 4 }, probability = 15 }
    group:entry { item = "corpse_stabbed", damage = { 4, 4 }, probability = 15 }
    group:entry { item = "corpse_gunned", damage = { 4, 4 }, probability = 15 }
    group:entry { item = "corpse_halved_upper", damage = { 4, 4 }, probability = 15 }
    group:entry { item = "corpse_half_beheaded", damage = { 4, 4 }, probability = 15 }
    group:entry { item = "corpse_child_gunned", damage = { 4, 4 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_in_body_bag", kind = "distribution", container = "bag_body_bag" }
    group:entry { group = "corpses_no_items", damage = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_male", kind = "distribution" }
    group:entry { group = "corpse_generic_male", damage = { 0, 1 } }
    group:entry { group = "corpse_bloody", damage = { 1, 3 } }
    group:entry { group = "corpse_painful", damage = { 0, 2 } }
    group:entry { group = "corpse_stabbed", damage = { 1, 3 }, probability = 10 }
    group:entry { group = "corpse_half_beheaded", damage = { 4, 4 } }
    group:entry { group = "corpse_generic_boy", damage = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_female", kind = "distribution" }
    group:entry { group = "corpse_generic_female", damage = { 0, 1 } }
    group:entry { group = "corpse_bloody", damage = { 1, 3 } }
    group:entry { group = "corpse_painful", damage = { 0, 2 } }
    group:entry { group = "corpse_gunned", damage = { 1, 3 } }
    group:entry { group = "corpse_half_beheaded", damage = { 4, 4 } }
    group:entry { group = "corpse_oldwoman_jewelry", damage = { 1, 3 } }
    group:entry { group = "corpse_generic_girl", damage = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_generic_male", kind = "distribution", container = "corpse_generic_male" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_generic_female", kind = "distribution", container = "corpse_generic_female" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_generic_boy", kind = "distribution", container = "corpse_generic_boy" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_generic_girl", kind = "distribution", container = "corpse_generic_girl" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_generic_gunned", kind = "distribution", container = "corpse_generic_gunned" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "corpse_generic_infected",
        kind = "distribution",
        container = "corpse_generic_infected",
    }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_bloody", kind = "distribution", container = "corpse_bloody" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_scorched", kind = "distribution", container = "corpse_scorched" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_stabbed", kind = "distribution", container = "corpse_stabbed" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_gunned", kind = "distribution", container = "corpse_gunned" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_halved_upper", kind = "distribution", container = "corpse_halved_upper" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_half_beheaded", kind = "distribution", container = "corpse_half_beheaded" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_child_calm", kind = "distribution", container = "corpse_child_calm" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_child_gunned", kind = "distribution", container = "corpse_child_gunned" }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "corpse_oldwoman_jewelry",
        kind = "distribution",
        container = "corpse_oldwoman_jewelry",
    }
    group:group("default_zombie_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "everyday_corpse", kind = "distribution" }
    group:entry { group = "everyday_corpse_male", damage = { 4, 4 }, probability = 80 }
    group:entry { group = "everyday_corpse_female", damage = { 4, 4 }, probability = 80 }
    group:entry { group = "everyday_corpse_child", damage = { 4, 4 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "everyday_corpse_male", kind = "collection", container = "corpse_generic_male" }
    group:group("everyday_corpse_generic")
    group:group("everyday_gear")
    group:entry { group = "coats_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "common_gloves", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "hatstore_hats", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "scarfs_unisex", damage = { 1, 4 }, probability = 20 }
    group:group("accesories_personal_unisex", 15)
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            { group = "male_underwear", damage = { 1, 4 }, probability = 90 },
                            { item = "union_suit", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        distribution = {
                            {
                                collection = {
                                    { group = "pants_male", damage = { 1, 4 }, probability = 60 },
                                    { group = "shirts_unisex", damage = { 1, 4 }, probability = 60 },
                                    { item = "leather_belt", damage = { 1, 4 }, probability = 30 },
                                },
                            },
                            { item = "suit", damage = { 1, 4 }, probability = 5 },
                            { item = "tux", damage = { 1, 4 }, probability = 5 },
                            { item = "thawb", damage = { 1, 4 }, probability = 10 },
                            { item = "cassock", damage = { 1, 4 }, probability = 10 },
                            { item = "haori", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    { group = "neckties", damage = { 1, 4 }, probability = 15 },
                    { group = "shoes_unisex", damage = { 1, 4 }, probability = 30 },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                    { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 15 },
                },
            },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "everyday_corpse_female", kind = "collection", container = "corpse_generic_female" }
    group:group("everyday_corpse_generic")
    group:entry { group = "female_underwear", damage = { 1, 4 }, probability = 90 }
    group:entry { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "pants_female", damage = { 1, 4 }, probability = 60 },
                    { group = "shoes_unisex", damage = { 1, 4 }, probability = 30 },
                    { group = "shirts_unisex", damage = { 1, 4 }, probability = 60 },
                    {
                        distribution = {
                            {
                                collection = {
                                    {
                                        distribution = {
                                            { item = "stockings", damage = { 1, 4 }, probability = 50 },
                                            { item = "tights", damage = { 1, 4 }, probability = 50 },
                                        },
                                    },
                                    { item = "garter_belt", damage = { 1, 4 }, probability = 50 },
                                },
                            },
                            { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                        },
                    },
                },
                probability = 70,
            },
            {
                collection = {
                    {
                        distribution = {
                            { item = "dress", damage = { 1, 4 }, probability = 8000 },
                            { item = "sundress", damage = { 1, 4 }, probability = 5000 },
                            { item = "cheongsam", damage = { 1, 4 }, probability = 6 },
                        },
                    },
                    { group = "dress_shoes", damage = { 1, 4 }, probability = 30 },
                    {
                        collection = {
                            {
                                distribution = {
                                    { item = "stockings", damage = { 1, 4 }, probability = 50 },
                                    { item = "tights", damage = { 1, 4 }, probability = 50 },
                                },
                            },
                            { item = "garter_belt", damage = { 1, 4 }, probability = 50 },
                        },
                    },
                    { item = "long_glove_white", damage = { 1, 4 }, probability = 20 },
                },
                probability = 20,
            },
            {
                collection = {
                    { item = "dress_wedding", damage = { 1, 4 } },
                    { item = "veil_wedding", damage = { 1, 4 } },
                    { group = "dress_shoes", damage = { 1, 4 }, probability = 30 },
                    {
                        collection = {
                            {
                                distribution = {
                                    { item = "stockings", damage = { 1, 4 }, probability = 50 },
                                    { item = "tights", damage = { 1, 4 }, probability = 50 },
                                },
                            },
                            { item = "garter_belt", damage = { 1, 4 }, probability = 50 },
                        },
                    },
                    { item = "long_glove_white", damage = { 1, 4 }, probability = 20 },
                },
                probability = 10,
            },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "everyday_corpse_child", kind = "collection", container = "corpse_child_calm" }
    group:group("everyday_corpse_generic")
    group:entry { group = "underwear", damage = { 0, 4 }, probability = 90 }
    group:entry { group = "pants", damage = { 0, 4 }, probability = 60 }
    group:entry { group = "shoes_unisex", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "shirts_unisex", damage = { 1, 4 }, probability = 60 }
    group:entry { group = "socks_unisex", damage = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "everyday_corpse_generic", kind = "collection" }
    group:group("everyday_gear")
    group:entry { group = "coats_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "common_gloves", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "hatstore_hats", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "scarfs_unisex", damage = { 1, 4 }, probability = 20 }
    group:group("accesories_personal_unisex", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "remains_human_generic", kind = "collection" }
    group:entry { item = "bone_human", count = { 5, 8 } }
    group:item("skull_human")
    group:entry { item = "human_flesh", count = { 5, 8 } }
    group:item("hstomach", 50)
    content.add(group)
end

do
    -- Adjusted mon_zombie_military_pilot_death_drops with bloody remains instead of a corpse.
    local group = content.ItemGroup { id = "remains_pilot", kind = "collection", with_ammo = 60, with_magazine = 100 }
    group:entry { group = "clothing_military_pilot", damage = { 1, 4 }, probability = 65 }
    group:entry { group = "gear_soldier_sidearm", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "military_patrol_food", damage = { 1, 4 }, probability = 50 }
    group:entry { item = "two_way_radio", charges = { 0, 100 }, damage = { 1, 4 }, probability = 50 }
    group:group("adderall_bottle_plastic_pill_prescription_10", 40)
    group:group("wallets_military", 5)
    group:item("militarymap", 5)
    group:group("mil_food", 15)
    group:entry { item = "bone_human", count = { 5, 8 } }
    group:entry { item = "human_flesh", count = { 5, 8 } }
    group:item("hstomach")
    group:group("pocket_cigar", 15)
    group:group("misc_smoking_legal", 30)
    group:item("dog_tag", 40)
    content.add(group)
end

do
    -- Adjusted mon_zombie_soldier_death_drops with bloody remains instead of a corpse and less heavy gear.
    local group = content.ItemGroup { id = "remains_soldier", kind = "collection", with_ammo = 60, with_magazine = 100 }
    group:entry {
        distribution = {
            { group = "clothing_soldier_set", damage = { 1, 4 }, probability = 65 },
            { group = "clothing_soldier_winter_set", damage = { 1, 4 }, probability = 35 },
        },
    }
    group:entry { group = "gear_soldier_sidearm", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "military_patrol_food", damage = { 1, 4 }, probability = 90 }
    group:entry {
        collection = {
            {
                distribution = {
                    { group = "guns_rifle_milspec", damage = { 1, 4 }, probability = 75 },
                    { group = "guns_shotgun_milspec", damage = { 1, 4 }, probability = 25 },
                },
            },
            {
                distribution = {
                    { item = "red_dot_sight" },
                    { item = "suppressor" },
                    { item = "laser_sight", probability = 50 },
                    {
                        collection = {
                            { item = "m320" },
                            { group = "ammo_launcher_grenade" },
                        },
                    },
                },
                probability = 30,
            },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            {
                distribution = {
                    { item = "mask_gas", charges = { 0, 100 }, damage = { 1, 4 }, probability = 25 },
                    { group = "gasmask_bag_full", damage = { 1, 4 }, probability = 25 },
                    { group = "gasmask_bag_used", damage = { 1, 4 }, probability = 50 },
                },
                probability = 10,
            },
            { item = "two_way_radio", charges = { 0, 100 }, probability = 50 },
            { item = "grenade", probability = 5 },
            { group = "wallets_military", probability = 5 },
            { group = "pocket_cigar", probability = 15 },
            { group = "misc_smoking_legal", probability = 30 },
        },
    }
    group:entry { item = "bone_human", count = { 5, 8 } }
    group:entry { item = "human_flesh", count = { 5, 8 } }
    group:item("hstomach")
    group:item("dog_tag", 40)
    content.add(group)
end

do
    -- Bc of corpses being partially hardcoded container-item in entries doesn't work so these get to be one group per corpse for now
    local group = content.ItemGroup { id = "corpse_generic_human", kind = "distribution", container = "corpse_generic_human" }
    group:group("default_zombie_death_drops")
    content.add(group)
end
