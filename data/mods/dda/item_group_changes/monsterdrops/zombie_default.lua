local content = require("ccb").content

do
    -- items people could have carried in their bags prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_bags", kind = "collection" }
    group:group("default_zombie_items_bags_small")
    group:group("homebooks", 30)
    group:group("alcohol_bottled_canned", 10)
    group:group("vending_drink_items", 10)
    group:entry {
        item = "laptop",
        charges = { 0, 500 },
        contents = {
            { group = "civilian_laptop_efiles" },
        },
        probability = 10,
    }
    group:entry {
        item = "eink_tablet_pc",
        charges = { 0, 50 },
        contents = {
            { group = "civilian_einktablet_efiles" },
        },
        probability = 10,
    }
    group:item("teleumbrella", 10)
    group:item("thermos", 10)
    group:item("spray_can", 10)
    group:entry {
        distribution = {
            { group = "tools_common_small", count = { 1, 2 }, probability = 50 },
            { group = "tools_electronics", probability = 50 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "RPG_die", probability = 70 },
            { item = "dnd_handbook", probability = 30 },
            { item = "metal_RPG_die", probability = 10 },
        },
        probability = 1,
    }
    group:entry {
        distribution = {
            { item = "camera", charges = { 0, 50 }, probability = 40 },
            { item = "camera", charges = { 0, 50 }, container = "camera_bag", probability = 30 },
            { item = "camera_pro", charges = { 0, 50 }, probability = 10 },
            { item = "camera_pro", charges = { 0, 50 }, container = "camera_bag", probability = 20 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- items people could have carried in their small bags prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_bags_small", kind = "collection" }
    group:group("default_zombie_items_pockets", 50)
    group:group("sex_accessories_domestic", 1)
    group:item("file", 10)
    group:entry {
        distribution = {
            { item = "roadmap" },
            { item = "trailmap" },
            { item = "touristmap" },
            { item = "restaurantmap" },
            { item = "urbexmap" },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "talking_doll", charges = { 0, 50 }, probability = 33 },
            { item = "creepy_doll", charges = { 0, 50 }, probability = 33 },
            { item = "straw_doll", probability = 33 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- items that an average zombie carries around and drops on death
    -- any zombie could have died carrying a gun, or holding one
    local group = content.ItemGroup { id = "default_zombie_items", kind = "distribution" }
    group:entry {
        group = "large_bags",
        damage = { 1, 4 },
        contents = {
            { group = "default_zombie_items_bags" },
        },
        probability = 6,
    }
    group:entry {
        group = "small_bags",
        damage = { 1, 4 },
        contents = {
            { group = "default_zombie_items_bags_small" },
        },
        probability = 10,
    }
    group:group("bugout_bag", 1)
    group:group("default_zombie_items_pockets", 20)
    group:entry {
        distribution = {
            { item = "teargas_sprayer", charges = { 0, 8 }, probability = 10 },
            {
                collection = {
                    { item = "holster" },
                    { group = "guns_pistol_common_everyday_carry", damage = { 0, 2 } },
                },
                probability = 8,
            },
            {
                collection = {
                    { item = "holster" },
                    { item = "tazer", charges = { 0, 100 }, damage = { 0, 2 } },
                },
                probability = 5,
            },
        },
        probability = 2,
    }
    content.add(group)
end

do
    -- contains cloth for an average zombie
    local group = content.ItemGroup { id = "default_zombie_clothes", kind = "collection" }
    group:entry { group = "coats_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "common_gloves", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "hatstore_hats", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "scarfs_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry { item = "vampire_fangs", damage = { 1, 4 }, event = "halloween", probability = 25 }
    group:entry { item = "ring_wedding", damage = { 1, 4 }, probability = 33 }
    group:entry { group = "accesories_personal_unisex", damage = { 1, 4 }, probability = 15 }
    group:entry { group = "christmas_accesories_personal_unisex", damage = { 1, 4 }, event = "christmas", probability = 25 }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            { group = "male_underwear", damage = { 1, 4 }, probability = 99 },
                            { item = "union_suit", damage = { 1, 4 }, probability = 1 },
                        },
                    },
                    {
                        distribution = {
                            {
                                collection = {
                                    { group = "pants_male", damage = { 1, 4 }, probability = 60 },
                                    { group = "shirts_unisex", damage = { 1, 4 }, probability = 60 },
                                    {
                                        distribution = {
                                            { item = "leather_belt", damage = { 1, 4 }, probability = 85 },
                                            {
                                                group = "christmas_belts",
                                                damage = { 1, 4 },
                                                event = "christmas",
                                                probability = 25,
                                            },
                                        },
                                        probability = 30,
                                    },
                                },
                            },
                            { item = "suit", damage = { 1, 4 }, probability = 5 },
                            { item = "tux", damage = { 1, 4 }, probability = 1 },
                            { item = "thawb", damage = { 1, 4 }, probability = 1 },
                            { item = "cassock", damage = { 1, 4 }, probability = 1 },
                            { item = "haori", damage = { 1, 4 }, probability = 1 },
                            { group = "costume_suits", damage = { 1, 4 }, event = "halloween", probability = 25 },
                        },
                    },
                    { group = "neckties", damage = { 1, 4 }, probability = 15 },
                    { group = "shoes_unisex", damage = { 1, 4 }, probability = 30 },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                    { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 15 },
                },
            },
            {
                collection = {
                    { group = "female_underwear", damage = { 1, 4 }, probability = 90 },
                    { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
                    {
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
                                                            {
                                                                item = "stockings",
                                                                damage = { 1, 4 },
                                                                probability = 1,
                                                            },
                                                            {
                                                                item = "tights",
                                                                damage = { 1, 4 },
                                                                probability = 5,
                                                            },
                                                        },
                                                    },
                                                    { item = "garter_belt", damage = { 1, 4 }, probability = 1 },
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
                                            { item = "dress", damage = { 1, 4 }, probability = 80 },
                                            { item = "sundress", damage = { 1, 4 }, probability = 45 },
                                            {
                                                group = "christmas_dresses",
                                                damage = { 1, 4 },
                                                event = "christmas",
                                                probability = 50,
                                            },
                                            {
                                                group = "costume_dresses",
                                                damage = { 1, 4 },
                                                event = "halloween",
                                                probability = 50,
                                            },
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
                                            { item = "garter_belt", damage = { 1, 4 }, probability = 10 },
                                        },
                                    },
                                    { item = "long_glove_white", damage = { 1, 4 }, probability = 1 },
                                },
                                probability = 30,
                            },
                        },
                    },
                },
            },
        },
    }
    group:entry {
        distribution = {
            { item = "helmet_bike", damage = { 1, 4 }, probability = 50 },
            { group = "clothing_biker", damage = { 1, 4 }, probability = 50 },
        },
        probability = 3,
    }
    content.add(group)
end

do
    -- items people could have carried in their pockets prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_pockets", kind = "collection" }
    group:entry {
        distribution = {
            { item = "pockknife", probability = 50 },
            { item = "knife_folding", probability = 30 },
            { item = "knife_swissarmy", probability = 10 },
            { item = "switchblade", probability = 10 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "meth", probability = 5 },
            { item = "coke", probability = 5 },
            { item = "lsd", probability = 2 },
            { item = "heroin", probability = 5 },
            {
                collection = {
                    { item = "crackpipe" },
                    { item = "crack" },
                },
                probability = 5,
            },
            {
                collection = {
                    { item = "weed" },
                    { item = "pipe_glass", probability = 50 },
                },
                probability = 10,
            },
            {
                distribution = {
                    { item = "joint", probability = 80 },
                    { item = "joint_roach", probability = 20 },
                },
                probability = 10,
            },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { group = "cigarettes_opened", wrapper = "box_cigarette", probability = 65 },
            { item = "chaw", probability = 5 },
            { item = "cigar", probability = 5 },
            { group = "pocket_cigar", probability = 1 },
            { item = "handrolled_cig", probability = 10 },
            { group = "chewing_gum_used_nic", probability = 10 },
            { item = "ecig", probability = 15 },
            {
                collection = {
                    { item = "tobacco" },
                    {
                        distribution = {
                            { item = "rolling_paper", probability = 80 },
                            { item = "pipe_tobacco", probability = 20 },
                        },
                    },
                },
                probability = 10,
            },
            {
                collection = {
                    { item = "advanced_ecig" },
                    { group = "nicotine_liquid_bottle_part" },
                },
                probability = 10,
            },
        },
        probability = 15,
    }
    group:entry {
        distribution = {
            { item = "lighter", charges = { 0, 100 } },
            { item = "ref_lighter", charges = { 0, 50 }, probability = 20 },
            { item = "matches", charges = { 0, 20 }, probability = 20 },
            { item = "small_lighter", charges = { 0, 50 }, probability = 40 },
            {
                collection = {
                    { item = "ref_lighter_butane" },
                    { item = "butane_can", charges = { 200, 400 } },
                },
                probability = 1,
            },
        },
        probability = 15,
    }
    group:entry {
        distribution = {
            { group = "chewing_gum_used", probability = 10 },
            { group = "chewing_gum_used_caff", probability = 1 },
        },
        probability = 30,
    }
    group:entry { item = "mp3", charges = { 0, 15 }, probability = 8 }
    group:entry { item = "portable_game", charges = { 0, 50 }, probability = 10 }
    group:entry { item = "game_watch", charges = { 0, 50 }, damage = { 1, 4 }, probability = 1 }
    group:item("usb_drive", 15)
    group:item("memory_card_unread", 3)
    group:item("flyer", 30)
    group:item("multitool", 5)
    group:entry { item = "permanent_marker", charges = { 0, 500 }, probability = 10 }
    group:group("softdrugs", 10)
    group:group("harddrugs", 5)
    group:group("civilian_phones", 85)
    group:group("vending_food_items", 5)
    content.add(group)
end
