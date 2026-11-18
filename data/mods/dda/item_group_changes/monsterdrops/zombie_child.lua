local content = require("ccb").content

do
    -- contains cloth for an average zombie child
    local group = content.ItemGroup { id = "default_zombie_children_clothes", kind = "collection" }
    group:entry {
        distribution = {
            {
                group = "coats_unisex",
                damage = { 1, 4 },
                flags = {
                    "UNDERSIZE",
                },
                probability = 90,
            },
            {
                item = "football_armor",
                damage = { 1, 4 },
                flags = {
                    "UNDERSIZE",
                },
                probability = 10,
            },
        },
        probability = 20,
    }
    group:entry {
        group = "common_gloves",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            {
                group = "hatstore_hats",
                damage = { 1, 4 },
                flags = {
                    "UNDERSIZE",
                },
                probability = 50,
            },
            {
                group = "child_hats",
                damage = { 1, 4 },
                flags = {
                    "UNDERSIZE",
                },
                probability = 50,
            },
        },
        probability = 20,
    }
    group:entry {
        group = "scarfs_unisex",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:entry {
        group = "accesories_personal_unisex_child",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
        probability = 15,
    }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            {
                                group = "male_underwear",
                                damage = { 1, 4 },
                                flags = {
                                    "UNDERSIZE",
                                },
                                probability = 90,
                            },
                            {
                                item = "union_suit",
                                damage = { 1, 4 },
                                flags = {
                                    "UNDERSIZE",
                                },
                                probability = 10,
                            },
                        },
                    },
                    {
                        distribution = {
                            {
                                collection = {
                                    {
                                        group = "pants_male",
                                        damage = { 1, 4 },
                                        flags = {
                                            "UNDERSIZE",
                                        },
                                        probability = 60,
                                    },
                                    {
                                        group = "shirts_unisex",
                                        damage = { 1, 4 },
                                        flags = {
                                            "UNDERSIZE",
                                        },
                                        probability = 60,
                                    },
                                    {
                                        item = "leather_belt",
                                        damage = { 1, 4 },
                                        flags = {
                                            "UNDERSIZE",
                                        },
                                        probability = 30,
                                    },
                                },
                            },
                            {
                                item = "suit",
                                damage = { 1, 4 },
                                flags = {
                                    "UNDERSIZE",
                                },
                                probability = 5,
                            },
                            {
                                item = "tux",
                                damage = { 1, 4 },
                                flags = {
                                    "UNDERSIZE",
                                },
                                probability = 5,
                            },
                        },
                    },
                    {
                        group = "neckties",
                        damage = { 1, 4 },
                        flags = {
                            "UNDERSIZE",
                        },
                        probability = 15,
                    },
                    {
                        distribution = {
                            {
                                group = "shoes_unisex",
                                damage = { 1, 4 },
                                flags = {
                                    "UNDERSIZE",
                                },
                                probability = 50,
                            },
                            {
                                group = "child_shoes",
                                damage = { 1, 4 },
                                flags = {
                                    "UNDERSIZE",
                                },
                                probability = 50,
                            },
                        },
                        probability = 30,
                    },
                    {
                        group = "socks_unisex",
                        damage = { 1, 4 },
                        flags = {
                            "UNDERSIZE",
                        },
                        probability = 50,
                    },
                    {
                        group = "accesories_personal_mens",
                        damage = { 1, 4 },
                        flags = {
                            "UNDERSIZE",
                        },
                        probability = 15,
                    },
                },
            },
            {
                collection = {
                    {
                        group = "female_underwear_child",
                        damage = { 1, 4 },
                        flags = {
                            "UNDERSIZE",
                        },
                        probability = 90,
                    },
                    {
                        group = "accesories_personal_womens_child",
                        damage = { 1, 4 },
                        flags = {
                            "UNDERSIZE",
                        },
                        probability = 15,
                    },
                    {
                        distribution = {
                            {
                                collection = {
                                    {
                                        group = "pants_female_child",
                                        damage = { 1, 4 },
                                        flags = {
                                            "UNDERSIZE",
                                        },
                                        probability = 60,
                                    },
                                    {
                                        distribution = {
                                            {
                                                group = "child_shoes",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 50,
                                            },
                                            {
                                                group = "shoes_unisex",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 30,
                                            },
                                            {
                                                group = "shoes_womens",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 20,
                                            },
                                        },
                                        probability = 30,
                                    },
                                    {
                                        group = "shirts_unisex",
                                        damage = { 1, 4 },
                                        flags = {
                                            "UNDERSIZE",
                                        },
                                        probability = 60,
                                    },
                                    {
                                        distribution = {
                                            {
                                                distribution = {
                                                    {
                                                        item = "stockings",
                                                        damage = { 1, 4 },
                                                        flags = {
                                                            "UNDERSIZE",
                                                        },
                                                        probability = 50,
                                                    },
                                                    {
                                                        item = "tights",
                                                        damage = { 1, 4 },
                                                        flags = {
                                                            "UNDERSIZE",
                                                        },
                                                        probability = 50,
                                                    },
                                                },
                                            },
                                            {
                                                group = "socks_unisex",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 50,
                                            },
                                        },
                                    },
                                },
                                probability = 70,
                            },
                            {
                                collection = {
                                    {
                                        distribution = {
                                            {
                                                item = "dress",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 70,
                                            },
                                            {
                                                item = "sundress",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 50,
                                            },
                                        },
                                    },
                                    {
                                        distribution = {
                                            {
                                                group = "dress_shoes",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 60,
                                            },
                                            {
                                                group = "child_shoes",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 20,
                                            },
                                            {
                                                group = "shoes_womens",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 20,
                                            },
                                        },
                                        probability = 30,
                                    },
                                    {
                                        collection = {
                                            {
                                                distribution = {
                                                    {
                                                        item = "stockings",
                                                        damage = { 1, 4 },
                                                        flags = {
                                                            "UNDERSIZE",
                                                        },
                                                        probability = 50,
                                                    },
                                                    {
                                                        item = "tights",
                                                        damage = { 1, 4 },
                                                        flags = {
                                                            "UNDERSIZE",
                                                        },
                                                        probability = 50,
                                                    },
                                                },
                                            },
                                        },
                                    },
                                },
                                probability = 20,
                            },
                            {
                                collection = {
                                    {
                                        group = "costume_cheerleader_set_any",
                                        damage = { 1, 4 },
                                        flags = {
                                            "UNDERSIZE",
                                        },
                                    },
                                    {
                                        item = "pom_poms",
                                        damage = { 1, 4 },
                                        flags = {
                                            "UNDERSIZE",
                                        },
                                        probability = 50,
                                    },
                                    {
                                        distribution = {
                                            {
                                                group = "shoes_unisex",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 60,
                                            },
                                            {
                                                group = "child_shoes",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 35,
                                            },
                                            {
                                                group = "shoes_womens",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 5,
                                            },
                                        },
                                        probability = 30,
                                    },
                                    {
                                        distribution = {
                                            {
                                                collection = {
                                                    {
                                                        distribution = {
                                                            {
                                                                item = "stockings",
                                                                damage = { 1, 4 },
                                                                flags = {
                                                                    "UNDERSIZE",
                                                                },
                                                                probability = 50,
                                                            },
                                                            {
                                                                item = "tights",
                                                                damage = { 1, 4 },
                                                                flags = {
                                                                    "UNDERSIZE",
                                                                },
                                                                probability = 50,
                                                            },
                                                        },
                                                    },
                                                },
                                            },
                                            {
                                                group = "socks_unisex",
                                                damage = { 1, 4 },
                                                flags = {
                                                    "UNDERSIZE",
                                                },
                                                probability = 50,
                                            },
                                        },
                                    },
                                },
                                probability = 10,
                            },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end
