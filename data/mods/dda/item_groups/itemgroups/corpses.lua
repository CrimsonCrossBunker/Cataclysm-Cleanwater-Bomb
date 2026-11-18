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
