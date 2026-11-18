local content = require("ccb").content

do
    -- mainly used for places for general clothing (like a dresser or a clothing store warehouse)
    local group = content.ItemGroup { id = "christmas_all_clothing", kind = "distribution" }
    group:group("christmas_coats_unisex", 25)
    group:group("christmas_common_gloves", 10)
    group:group("christmas_hats", 50)
    group:group("christmas_accesories_personal_unisex", 25)
    group:group("christmas_belts", 5)
    group:group("christmas_pants_male", 15)
    group:group("christmas_dresses", 15)
    content.add(group)
end

do
    -- For use in christmas with the group coats_unisex
    local group = content.ItemGroup { id = "christmas_coats_unisex", kind = "distribution" }
    group:item("santa_jacket", 80)
    group:item("santa_jacket_short", 20)
    content.add(group)
end

do
    -- For now it works the same as christmas_coats_unisex, but this group is exclusive to jackets
    local group = content.ItemGroup { id = "christmas_jackets", kind = "distribution" }
    group:item("santa_jacket", 80)
    group:item("santa_jacket_short", 20)
    content.add(group)
end

do
    -- For use in christmas with the group common_gloves
    local group = content.ItemGroup { id = "christmas_common_gloves", kind = "distribution" }
    group:item("santa_gloves", 50)
    group:item("gloves_white", 50)
    content.add(group)
end

do
    -- For use in christmas as substitute of any group of normal hats
    local group = content.ItemGroup { id = "christmas_hats", kind = "distribution" }
    group:item("santa_hat")
    content.add(group)
end

do
    -- For use in christmas for all miscellaneous accessories
    local group = content.ItemGroup { id = "christmas_accesories_personal_unisex", kind = "distribution" }
    group:item("santa_beard")
    content.add(group)
end

do
    -- For use in christmas for all kind of belts, used as alternative of a leather belt
    local group = content.ItemGroup { id = "christmas_belts", kind = "distribution" }
    group:item("santa_belt")
    content.add(group)
end

do
    -- For use in christmas with the group pants_male
    local group = content.ItemGroup { id = "christmas_pants_male", kind = "distribution" }
    group:item("santa_pants", 80)
    group:item("santa_shorts", 20)
    content.add(group)
end

do
    -- For use in christmas with the zombie drops for female zombies
    local group = content.ItemGroup { id = "christmas_dresses", kind = "distribution" }
    group:item("santa_dress", 70)
    group:item("santa_dress_long", 20)
    group:item("santa_dress_short", 10)
    content.add(group)
end

do
    -- For use in christmas as special sets of zombie cloth drops, for now it only includes santas, but it can be used for elves and christmas reindeer cosplays too.
    local group = content.ItemGroup { id = "default_zombie_clothes_christmas", kind = "distribution" }
    group:group("santa_male")
    group:group("santa_female")
    content.add(group)
end

do
    -- For use in christmas as a set of zombie cloth drops for male santa zombies
    local group = content.ItemGroup { id = "santa_male", kind = "distribution" }
    group:entry {
        collection = {
            { item = "santa_hat", damage = { 1, 4 } },
            { item = "santa_belt", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "santa_beard", damage = { 1, 4 }, probability = 80 },
                    { group = "scarfs_unisex", damage = { 1, 4 }, probability = 20 },
                },
                probability = 90,
            },
            {
                distribution = {
                    { item = "gloves_white", damage = { 1, 4 }, probability = 80 },
                    { item = "santa_gloves", damage = { 1, 4 }, probability = 20 },
                },
                probability = 90,
            },
            {
                distribution = {
                    { item = "santa_jacket", damage = { 1, 4 }, probability = 80 },
                    { item = "santa_jacket_short", damage = { 1, 4 }, probability = 20 },
                },
            },
            {
                distribution = {
                    { item = "santa_pants", damage = { 1, 4 }, probability = 80 },
                    { item = "santa_shorts", damage = { 1, 4 }, probability = 20 },
                },
            },
            {
                distribution = {
                    { item = "boots_winter", damage = { 1, 4 }, probability = 70 },
                    { item = "boots_fur", damage = { 1, 4 }, probability = 20 },
                    { item = "boots", damage = { 1, 4 }, probability = 10 },
                },
            },
            {
                distribution = {
                    { group = "male_underwear", damage = { 1, 4 }, probability = 80 },
                    { item = "union_suit", damage = { 1, 4 }, probability = 20 },
                },
            },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 60 },
            { group = "socks_unisex", damage = { 1, 4 } },
            { group = "accesories_personal_unisex", damage = { 1, 4 }, probability = 20 },
        },
    }
    content.add(group)
end

do
    -- For use in christmas as a set of zombie cloth drops for female santa zombies
    local group = content.ItemGroup { id = "santa_female", kind = "distribution" }
    group:entry {
        collection = {
            { item = "santa_hat", damage = { 1, 4 } },
            { item = "santa_belt", damage = { 1, 4 }, probability = 75 },
            {
                distribution = {
                    { item = "santa_beard", damage = { 1, 4 }, probability = 20 },
                    { group = "scarfs_unisex", damage = { 1, 4 }, probability = 80 },
                },
                probability = 20,
            },
            {
                distribution = {
                    { item = "gloves_white", damage = { 1, 4 }, probability = 60 },
                    { item = "santa_gloves", damage = { 1, 4 }, probability = 20 },
                    { item = "long_glove_white", damage = { 1, 4 }, probability = 20 },
                },
                probability = 90,
            },
            {
                distribution = {
                    { item = "santa_dress", damage = { 1, 4 }, probability = 60 },
                    { item = "santa_dress_long", damage = { 1, 4 }, probability = 25 },
                    { item = "santa_dress_short", damage = { 1, 4 }, probability = 15 },
                },
            },
            {
                distribution = {
                    { item = "boots_winter", damage = { 1, 4 }, probability = 20 },
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "heels", damage = { 1, 4 }, probability = 40 },
                },
            },
            { group = "female_underwear", damage = { 1, 4 } },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 60 },
            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 20 },
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
                            { item = "garter_belt", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                },
            },
        },
    }
    content.add(group)
end
