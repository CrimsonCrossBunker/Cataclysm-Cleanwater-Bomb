local content = require("ccb").content

do
    -- contains cloth for an average zombie child
    local group = content.ItemGroup { id = "default_zombie_children_clothes", kind = "collection" }
    group:entry {
        distribution = {
            { group = "coats_unisex", damage = { 1, 4 }, probability = 90 },
        },
        probability = 20,
    }
    group:entry { group = "common_gloves", damage = { 1, 4 }, probability = 20 }
    group:entry {
        distribution = {
            { group = "hatstore_hats", damage = { 1, 4 }, probability = 50 },
        },
        probability = 20,
    }
    group:entry { group = "scarfs_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            { group = "male_underwear", damage = { 1, 4 }, probability = 90 },
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
                        },
                    },
                    {
                        distribution = {
                            { group = "shoes_unisex", damage = { 1, 4 }, probability = 50 },
                        },
                        probability = 30,
                    },
                },
            },
            {
                collection = {
                    { group = "female_underwear", damage = { 1, 4 }, probability = 90 },
                    {
                        distribution = {
                            {
                                collection = {
                                    { group = "pants_female", damage = { 1, 4 }, probability = 60 },
                                    {
                                        distribution = {
                                            { group = "shoes_unisex", damage = { 1, 4 }, probability = 30 },
                                        },
                                        probability = 30,
                                    },
                                    { group = "shirts_unisex", damage = { 1, 4 }, probability = 60 },
                                },
                                probability = 70,
                            },
                        },
                    },
                },
            },
        },
    }
    content.replace(group)
end
