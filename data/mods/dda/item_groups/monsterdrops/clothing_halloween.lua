local content = require("ccb").content

do
    -- For use in halloween as special sets of zombie cloth drops.
    -- Current prob is based around the number of male/female/unisex sets of clothing, to be adjusted if more are added.
    local group = content.ItemGroup { id = "default_zombie_clothes_halloween", kind = "distribution" }
    group:group("halloween_male", 20)
    group:group("halloween_female", 30)
    group:group("halloween_unisex", 60)
    content.add(group)
end

do
    -- For use in halloween as special sets of zombie cloth drops for male zombies.
    local group = content.ItemGroup { id = "halloween_male", kind = "distribution" }
    group:group("sexy_santa_costume_male", 25)
    group:group("butler_costume_male", 25)
    group:group("groom_costume_male", 10)
    group:group("priest_costume_male", 15)
    content.add(group)
end

do
    -- For use in halloween as special sets of zombie cloth drops for female zombies.
    local group = content.ItemGroup { id = "halloween_female", kind = "distribution" }
    group:group("vampire_costume_female", 45)
    group:group("ninja_costume_female", 20)
    group:group("sexy_santa_costume_female", 25)
    group:group("bride_costume_female", 25)
    group:group("mummy_costume_female", 40)
    group:group("wizard_costume_female", 50)
    group:group("bee_costume_female", 20)
    group:group("cheerleader_costume_female", 35)
    group:group("maid_costume_female", 20)
    content.add(group)
end

do
    -- For use in halloween as special unisex sets of zombie cloth drops for zombies.
    local group = content.ItemGroup { id = "halloween_unisex", kind = "distribution" }
    group:group("vampire_costume_unisex", 45)
    group:group("ninja_costume_unisex", 20)
    group:group("mummy_costume_unisex", 40)
    group:group("wizard_costume_unisex", 50)
    group:group("skeleton_costume_unisex", 50)
    group:group("ghost_costume_unisex", 65)
    group:group("grim_reaper_costume_unisex", 35)
    group:group("clown_costume_unisex", 25)
    group:group("army_costume_unisex", 20)
    group:group("fbi_costume_unisex", 15)
    group:group("chef_costume_unisex", 20)
    group:group("leather_jacket_costume_unisex", 15)
    group:group("cowboy_costume_unisex", 25)
    group:group("japan_costume_unisex", 15)
    group:group("pirate_costume_unisex", 30)
    group:group("scientist_costume_unisex", 20)
    group:group("beekeeping_costume_unisex", 5)
    group:group("bondage_costume_unisex", 30)
    group:group("fursuit_costume_unisex", 30)
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for sexy male santa zombies
    local group = content.ItemGroup { id = "sexy_santa_costume_male", kind = "distribution" }
    group:entry {
        collection = {
            { item = "santa_hat", damage = { 1, 4 } },
            { item = "santa_belt", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "santa_beard", damage = { 1, 4 }, probability = 55 },
                    { group = "scarfs_unisex", damage = { 1, 4 }, probability = 45 },
                },
                probability = 15,
            },
            {
                distribution = {
                    { item = "gloves_white", damage = { 1, 4 }, probability = 20 },
                    { item = "santa_gloves", damage = { 1, 4 }, probability = 80 },
                },
                probability = 45,
            },
            {
                distribution = {
                    { item = "santa_jacket", damage = { 1, 4 }, probability = 10 },
                    { item = "santa_jacket_short", damage = { 1, 4 }, probability = 90 },
                },
                probability = 85,
            },
            {
                distribution = {
                    { item = "santa_pants", damage = { 1, 4 }, probability = 20 },
                    { item = "santa_shorts", damage = { 1, 4 }, probability = 80 },
                },
            },
            {
                distribution = {
                    { item = "boots_winter", damage = { 1, 4 }, probability = 50 },
                    { item = "boots_fur", damage = { 1, 4 }, probability = 30 },
                    { item = "boots", damage = { 1, 4 }, probability = 20 },
                },
            },
            { group = "male_underwear", damage = { 1, 4 } },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 40 },
            { group = "socks_unisex", damage = { 1, 4 } },
            { group = "accesories_personal_unisex", damage = { 1, 4 }, probability = 15 },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for sexy female santa zombies
    local group = content.ItemGroup { id = "sexy_santa_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { item = "santa_hat", damage = { 1, 4 } },
            { item = "santa_belt", damage = { 1, 4 }, probability = 75 },
            {
                distribution = {
                    { item = "santa_beard", damage = { 1, 4 }, probability = 10 },
                    { group = "scarfs_unisex", damage = { 1, 4 }, probability = 90 },
                },
                probability = 10,
            },
            {
                distribution = {
                    { item = "gloves_white", damage = { 1, 4 }, probability = 35 },
                    { item = "santa_gloves", damage = { 1, 4 }, probability = 35 },
                    { item = "long_glove_white", damage = { 1, 4 }, probability = 30 },
                },
                probability = 50,
            },
            {
                distribution = {
                    { item = "santa_dress", damage = { 1, 4 }, probability = 20 },
                    { item = "santa_dress_long", damage = { 1, 4 }, probability = 5 },
                    { item = "santa_dress_short", damage = { 1, 4 }, probability = 75 },
                },
            },
            {
                distribution = {
                    { item = "boots_winter", damage = { 1, 4 }, probability = 20 },
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 30 },
                    { item = "heels", damage = { 1, 4 }, probability = 25 },
                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 25 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 20 },
                },
            },
            { group = "female_underwear", damage = { 1, 4 } },
            { group = "shirts_summer_womens", damage = { 1, 4 }, probability = 10 },
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

do
    -- For use in halloween as a set of zombie cloth drops for cosplay butler zombies
    local group = content.ItemGroup { id = "butler_costume_male", kind = "distribution" }
    group:entry {
        collection = {
            { item = "glasses_monocle", damage = { 1, 4 }, probability = 55 },
            { item = "pocketwatch", damage = { 1, 4 }, probability = 35 },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            { item = "gloves_white", damage = { 1, 4 }, probability = 55 },
            {
                distribution = {
                    { item = "tux", damage = { 1, 4 }, probability = 50 },
                    { item = "suit", damage = { 1, 4 }, probability = 50 },
                },
            },
            {
                distribution = {
                    { item = "dress_shirt", damage = { 1, 4 }, probability = 95 },
                    { group = "shirts_unisex", damage = { 1, 4 }, probability = 5 },
                },
            },
            {
                distribution = {
                    { item = "cane", damage = { 1, 4 }, probability = 40 },
                    { item = "umbrella", damage = { 1, 4 }, probability = 30 },
                    { item = "sinister_cane", damage = { 1, 4 }, probability = 10 },
                    { item = "wizard_cane", charges = { 0, 100 }, damage = { 1, 4 }, probability = 5 },
                    { item = "wizard_cane_cheap", charges = { 0, 100 }, damage = { 1, 4 }, probability = 10 },
                    { item = "hollow_cane", damage = { 1, 4 }, probability = 4 },
                    { item = "sword_cane", damage = { 1, 4 }, container = "hollow_cane", probability = 1 },
                },
                probability = 20,
            },
            { group = "male_underwear", damage = { 1, 4 } },
            { item = "dress_shoes", damage = { 1, 4 }, probability = 90 },
            { group = "socks_unisex", damage = { 1, 4 } },
            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 95 },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for cosplay maid zombies
    local group = content.ItemGroup { id = "maid_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { item = "glasses_monocle", damage = { 1, 4 }, probability = 15 },
            { item = "pocketwatch", damage = { 1, 4 }, probability = 25 },
            { item = "broom", damage = { 1, 4 }, probability = 15 },
            { item = "maid_hat", damage = { 1, 4 } },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            {
                distribution = {
                    { item = "gloves_white", damage = { 1, 4 }, probability = 45 },
                    { item = "long_glove_white", damage = { 1, 4 }, probability = 55 },
                },
                probability = 60,
            },
            {
                distribution = {
                    { item = "maid_dress", damage = { 1, 4 }, probability = 20 },
                    { item = "maid_dress_short", damage = { 1, 4 }, probability = 80 },
                },
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "heels", damage = { 1, 4 }, probability = 35 },
                    { item = "dance_shoes", damage = { 1, 4 }, probability = 25 },
                },
            },
            {
                distribution = {
                    { group = "female_underwear", damage = { 1, 4 }, probability = 75 },
                    {
                        collection = {
                            { item = "bikini_top", damage = { 1, 4 }, variant = "maid_bikini_top" },
                            { item = "bikini_bottom", damage = { 1, 4 }, variant = "maid_bikini_bottom" },
                        },
                        probability = 25,
                    },
                },
            },
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
                            { item = "garter_belt", damage = { 1, 4 }, probability = 50 },
                        },
                    },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for cosplay groom zombies
    local group = content.ItemGroup { id = "groom_costume_male", kind = "distribution" }
    group:entry {
        collection = {
            { item = "ring_wedding", damage = { 1, 4 } },
            { item = "cufflinks_intricate", damage = { 1, 4 }, probability = 95 },
            { item = "tie_bow", damage = { 1, 4 }, probability = 85 },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            { item = "leather_belt", damage = { 1, 4 }, probability = 75 },
            { item = "dress_shirt", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "tux", damage = { 1, 4 }, probability = 60 },
                    { item = "suit", damage = { 1, 4 }, probability = 40 },
                },
            },
            {
                distribution = {
                    { item = "wristwatch", damage = { 1, 4 }, probability = 30 },
                    { item = "silver_watch", damage = { 1, 4 }, probability = 20 },
                    { item = "gold_watch", damage = { 1, 4 }, probability = 20 },
                    { item = "platinum_watch", damage = { 1, 4 }, probability = 10 },
                    { item = "sf_watch", damage = { 1, 4 }, probability = 15 },
                    { item = "pocketwatch", damage = { 1, 4 }, probability = 5 },
                },
                probability = 75,
            },
            {
                distribution = {
                    { item = "withered", damage = { 1, 4 }, probability = 95 },
                    { item = "bouquet", damage = { 1, 4 }, probability = 5 },
                },
                probability = 75,
            },
            { group = "male_underwear", damage = { 1, 4 } },
            { item = "dress_shoes", damage = { 1, 4 }, probability = 90 },
            { group = "socks_unisex", damage = { 1, 4 } },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for cosplay bride zombies
    local group = content.ItemGroup { id = "bride_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            { item = "ring_wedding", damage = { 1, 4 } },
            { group = "tiaras_silver", damage = { 1, 4 }, probability = 75 },
            { group = "earrings_silver", damage = { 1, 4 }, probability = 85 },
            { item = "veil_wedding", damage = { 1, 4 }, probability = 85 },
            { item = "dress_wedding", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "gloves_white", damage = { 1, 4 }, probability = 25 },
                    { item = "long_glove_white", damage = { 1, 4 }, probability = 75 },
                },
                probability = 75,
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "heels", damage = { 1, 4 }, probability = 40 },
                    { item = "dance_shoes", damage = { 1, 4 }, probability = 10 },
                },
            },
            {
                distribution = {
                    { item = "withered", damage = { 1, 4 }, probability = 25 },
                    { item = "bouquet", damage = { 1, 4 }, probability = 75 },
                },
                probability = 75,
            },
            { group = "female_underwear", damage = { 1, 4 } },
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
                            { item = "garter_belt", damage = { 1, 4 }, probability = 70 },
                        },
                    },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 20 },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for cosplay priest zombies
    local group = content.ItemGroup { id = "priest_costume_male", kind = "distribution" }
    group:entry {
        collection = {
            { item = "cassock", damage = { 1, 4 } },
            { item = "priest_collar", damage = { 1, 4 }, probability = 95 },
            { group = "costume_masks", damage = { 1, 4 }, probability = 25 },
            { item = "leather_belt", damage = { 1, 4 }, probability = 75 },
            { group = "shirts_unisex", damage = { 1, 4 } },
            { group = "pants_male", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "holybook_bible4", damage = { 1, 4 }, probability = 95 },
                    { group = "religious_books", damage = { 1, 4 }, probability = 5 },
                },
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 75 },
                    { group = "shoes_unisex", damage = { 1, 4 }, probability = 25 },
                },
            },
            { group = "male_underwear", damage = { 1, 4 } },
            { group = "socks_unisex", damage = { 1, 4 } },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for vampire female zombies
    local group = content.ItemGroup { id = "vampire_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { item = "sinister_cane", damage = { 1, 4 }, probability = 25 },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            { item = "vampire_fangs", damage = { 1, 4 } },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 80 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 20 },
                },
                probability = 75,
            },
            {
                distribution = {
                    { item = "gloves_black", damage = { 1, 4 }, probability = 80 },
                    { item = "gloves_claws", damage = { 1, 4 }, probability = 20 },
                },
                probability = 10,
            },
            {
                distribution = {
                    { item = "gown_sleeved", damage = { 1, 4 }, variant = "sinister", probability = 10 },
                    { item = "long_dress_sleeved", damage = { 1, 4 }, variant = "sinister", probability = 60 },
                    { item = "short_dress", damage = { 1, 4 }, variant = "sinister", probability = 30 },
                },
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "heels", damage = { 1, 4 }, probability = 60 },
                },
            },
            { group = "female_underwear", damage = { 1, 4 } },
            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
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

do
    -- For use in halloween as a set of zombie cloth drops for vampire zombies
    local group = content.ItemGroup { id = "vampire_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "sinister_cane", damage = { 1, 4 }, probability = 35 },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            { item = "vampire_fangs", damage = { 1, 4 } },
            { item = "cloak_vampire", damage = { 1, 4 } },
            { item = "dress_shirt", damage = { 1, 4 }, probability = 85 },
            { item = "pants", damage = { 1, 4 }, variant = "pants_black" },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 80 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 20 },
                },
                probability = 55,
            },
            {
                distribution = {
                    { item = "gloves_black", damage = { 1, 4 }, probability = 80 },
                    { item = "gloves_claws", damage = { 1, 4 }, probability = 20 },
                },
                probability = 10,
            },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                            { item = "dress_shoes", damage = { 1, 4 } },
                        },
                    },
                    {
                        collection = {
                            {
                                distribution = {
                                    { item = "dress_shoes", damage = { 1, 4 }, probability = 50 },
                                    { item = "heels", damage = { 1, 4 }, probability = 50 },
                                },
                            },
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for ninja female zombies
    local group = content.ItemGroup { id = "ninja_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bokken_fake", damage = { 1, 4 }, container = "scabbard", probability = 5 },
            { item = "gloves_black", damage = { 1, 4 }, probability = 50 },
            { item = "hood_ninja", damage = { 1, 4 }, probability = 75 },
            { group = "costume_masks", damage = { 1, 4 }, probability = 25 },
            {
                distribution = {
                    { item = "ninja_dress", damage = { 1, 4 }, probability = 60 },
                    { item = "ninja_dress_sleeveless", damage = { 1, 4 }, probability = 40 },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            {
                                distribution = {
                                    { item = "dress_shoes", damage = { 1, 4 }, probability = 20 },
                                    { item = "heels", damage = { 1, 4 }, probability = 20 },
                                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 35 },
                                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 25 },
                                },
                            },
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
                                            { item = "garter_belt", damage = { 1, 4 }, probability = 20 },
                                        },
                                    },
                                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                                },
                            },
                        },
                    },
                    {
                        collection = {
                            { item = "geta", damage = { 1, 4 } },
                            { item = "tabi_dress", damage = { 1, 4 } },
                        },
                        probability = 25,
                    },
                },
            },
            { group = "female_underwear", damage = { 1, 4 } },
            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for ninja zombies
    local group = content.ItemGroup { id = "ninja_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bokken_fake", damage = { 1, 4 }, container = "scabbard", probability = 5 },
            { item = "gloves_black", damage = { 1, 4 }, probability = 50 },
            { item = "hood_ninja", damage = { 1, 4 }, probability = 75 },
            { item = "jacket_ninja", damage = { 1, 4 } },
            { item = "trousers_ninja", damage = { 1, 4 } },
            { group = "costume_masks", damage = { 1, 4 }, probability = 25 },
            {
                distribution = {
                    {
                        collection = {
                            {
                                distribution = {
                                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                                    { item = "boots", damage = { 1, 4 }, probability = 40 },
                                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 10 },
                                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 10 },
                                },
                            },
                            { group = "socks_unisex", damage = { 1, 4 } },
                        },
                    },
                    {
                        collection = {
                            { item = "geta", damage = { 1, 4 } },
                            { item = "tabi_dress", damage = { 1, 4 } },
                        },
                        probability = 25,
                    },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for mummy female zombies
    local group = content.ItemGroup { id = "mummy_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { item = "mummy_dress", damage = { 1, 4 } },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 25 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 75 },
                },
                probability = 5,
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "heels", damage = { 1, 4 }, probability = 60 },
                },
            },
            { group = "female_underwear", damage = { 1, 4 } },
            { group = "socks_unisex", damage = { 1, 4 } },
            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for mummy zombies
    local group = content.ItemGroup { id = "mummy_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "mummy_jumpsuit", damage = { 1, 4 } },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 25 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 75 },
                },
                probability = 3,
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "boots", damage = { 1, 4 }, probability = 40 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 10 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 10 },
                },
            },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for wizard female zombies
    local group = content.ItemGroup { id = "wizard_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { item = "gloves_black", damage = { 1, 4 }, probability = 5 },
            {
                distribution = {
                    { item = "wizard_hat_costume", damage = { 1, 4 }, probability = 10 },
                    { item = "pointed_hat", damage = { 1, 4 }, probability = 90 },
                },
                probability = 60,
            },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 25 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 75 },
                },
                probability = 5,
            },
            {
                distribution = {
                    { item = "long_dress_sleeved", damage = { 1, 4 }, variant = "witch_black", probability = 25 },
                    { item = "dress_sleeved", damage = { 1, 4 }, variant = "witch_black", probability = 50 },
                    { item = "short_dress_sleeved", damage = { 1, 4 }, variant = "witch_black", probability = 25 },
                },
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "heels", damage = { 1, 4 }, probability = 60 },
                },
            },
            {
                distribution = {
                    { item = "cane", damage = { 1, 4 }, probability = 5 },
                    { item = "umbrella", damage = { 1, 4 }, probability = 5 },
                    { item = "sinister_cane", damage = { 1, 4 }, probability = 25 },
                    { item = "wizard_cane", charges = { 0, 100 }, damage = { 1, 4 }, probability = 30 },
                    { item = "wizard_cane_cheap", charges = { 0, 100 }, damage = { 1, 4 }, probability = 35 },
                },
                probability = 65,
            },
            { group = "female_underwear", damage = { 1, 4 } },
            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
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
                            { item = "garter_belt", damage = { 1, 4 }, probability = 20 },
                        },
                    },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for wizard zombies
    local group = content.ItemGroup { id = "wizard_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "gloves_black", damage = { 1, 4 }, probability = 5 },
            { item = "robe_wizard", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "wizard_hat_costume", damage = { 1, 4 }, probability = 80 },
                    { item = "pointed_hat", damage = { 1, 4 }, probability = 20 },
                },
                probability = 60,
            },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 25 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 75 },
                },
                probability = 5,
            },
            {
                distribution = {
                    { item = "cane", damage = { 1, 4 }, probability = 5 },
                    { item = "umbrella", damage = { 1, 4 }, probability = 5 },
                    { item = "sinister_cane", damage = { 1, 4 }, probability = 25 },
                    { item = "wizard_cane", charges = { 0, 100 }, damage = { 1, 4 }, probability = 30 },
                    { item = "wizard_cane_cheap", charges = { 0, 100 }, damage = { 1, 4 }, probability = 35 },
                },
                probability = 65,
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 30 },
                    { item = "boots", damage = { 1, 4 }, probability = 30 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 30 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 10 },
                },
            },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
                        },
                    },
                },
            },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 95 },
            { group = "pants_unisex", damage = { 1, 4 } },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for bee female zombies
    local group = content.ItemGroup { id = "bee_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { item = "gloves_black", damage = { 1, 4 }, probability = 15 },
            { item = "bee_dress", damage = { 1, 4 } },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "heels", damage = { 1, 4 }, probability = 60 },
                },
            },
            { group = "female_underwear", damage = { 1, 4 } },
            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
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
                            { item = "garter_belt", damage = { 1, 4 }, probability = 20 },
                        },
                    },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for cheerleader female zombies
    local group = content.ItemGroup { id = "cheerleader_costume_female", kind = "distribution" }
    group:entry {
        collection = {
            { group = "costume_cheerleader_set_any", damage = { 1, 4 } },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                    { item = "heels", damage = { 1, 4 }, probability = 60 },
                },
            },
            { group = "female_underwear", damage = { 1, 4 } },
            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 10 },
            { group = "socks_unisex", damage = { 1, 4 } },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for skeleton zombies
    local group = content.ItemGroup { id = "skeleton_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "gloves_skeleton", damage = { 1, 4 }, probability = 85 },
            { item = "jumpsuit_skeleton", damage = { 1, 4 } },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 25 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 75 },
                },
                probability = 5,
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 20 },
                    { item = "boots", damage = { 1, 4 }, probability = 10 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 60 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 10 },
                },
            },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
                        },
                    },
                },
            },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 55 },
            { group = "pants_unisex", damage = { 1, 4 }, probability = 55 },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for ghost zombies
    local group = content.ItemGroup { id = "ghost_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "gloves_skeleton", damage = { 1, 4 }, probability = 45 },
            { item = "jumpsuit_skeleton", damage = { 1, 4 }, probability = 30 },
            { item = "mask_skull", damage = { 1, 4 }, probability = 95 },
            { item = "mask_skull", damage = { 1, 4 } },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 25 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 75 },
                },
                probability = 5,
            },
            {
                distribution = {
                    { item = "ghost_robe", damage = { 1, 4 }, probability = 55 },
                    { item = "ghost_robe_sheet", damage = { 1, 4 }, probability = 45 },
                },
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 20 },
                    { item = "boots", damage = { 1, 4 }, probability = 10 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 60 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 10 },
                },
            },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
                        },
                    },
                },
            },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 75 },
            { group = "pants_unisex", damage = { 1, 4 }, probability = 85 },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for grim reaper zombies
    local group = content.ItemGroup { id = "grim_reaper_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "gloves_skeleton", damage = { 1, 4 }, probability = 95 },
            { item = "jumpsuit_skeleton", damage = { 1, 4 }, probability = 80 },
            { item = "mask_skull", damage = { 1, 4 }, probability = 55 },
            { item = "grim_reaper_robe", damage = { 1, 4 } },
            { item = "scythe_toy", damage = { 1, 4 }, probability = 75 },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 25 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 75 },
                },
                probability = 15,
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 30 },
                    { item = "boots", damage = { 1, 4 }, probability = 30 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 30 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 10 },
                },
            },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 25 },
                        },
                    },
                },
            },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 25 },
            { group = "pants_unisex", damage = { 1, 4 }, probability = 25 },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for clown zombies
    local group = content.ItemGroup { id = "clown_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "clown_wig", damage = { 1, 4 }, probability = 65 },
            { item = "clown_nose", damage = { 1, 4 }, probability = 70 },
            { item = "clown_suit", damage = { 1, 4 } },
            { item = "clownshoes", damage = { 1, 4 }, probability = 95 },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { group = "costume_jewelry_vampire", damage = { 1, 4 }, probability = 25 },
                    { group = "costume_jewelry_dark", damage = { 1, 4 }, probability = 75 },
                },
                probability = 15,
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 2 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 5 },
                        },
                    },
                },
            },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 75 },
            { group = "pants_unisex", damage = { 1, 4 }, probability = 95 },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for fbi zombies
    local group = content.ItemGroup { id = "fbi_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "hat_ball", damage = { 1, 4 }, variant = "hat_fbi", probability = 95 },
            { item = "jacket_windbreaker", damage = { 1, 4 }, variant = "windbreaker_fbi" },
            { item = "tie_clipon", damage = { 1, 4 }, probability = 70 },
            { item = "sunglasses", damage = { 1, 4 }, probability = 70 },
            { item = "dress_shirt", damage = { 1, 4 } },
            { item = "dress_shoes", damage = { 1, 4 }, probability = 95 },
            { item = "pants", damage = { 1, 4 }, variant = "pants_black", probability = 95 },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 2 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 5 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for army cosplay zombies
    local group = content.ItemGroup { id = "army_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "jacket_army", damage = { 1, 4 } },
            { item = "pants_army", damage = { 1, 4 } },
            { item = "leather_belt", damage = { 1, 4 } },
            { item = "beret", damage = { 1, 4 }, probability = 70 },
            { item = "mask_dust", damage = { 1, 4 }, variant = "camo_mask_dust", probability = 25 },
            { item = "leg_bag", damage = { 1, 4 }, variant = "camo_leg_bag", probability = 15 },
            { item = "sheath", damage = { 1, 4 }, probability = 20 },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "boots_combat", damage = { 1, 4 }, probability = 50 },
                    { item = "boots", damage = { 1, 4 }, probability = 30 },
                    { item = "boots_hiking", damage = { 1, 4 }, probability = 20 },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            { item = "tank_top", damage = { 1, 4 }, variant = "tank_top_camo", probability = 75 },
                            { group = "male_underwear_bottom", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { item = "tank_top", damage = { 1, 4 }, variant = "tank_top_camo", probability = 75 },
                            { item = "bikini_top", damage = { 1, 4 }, variant = "camo_bikini_top" },
                            { item = "bikini_bottom", damage = { 1, 4 }, variant = "camo_bikini_bottom" },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for chef cosplay zombies
    local group = content.ItemGroup { id = "chef_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "jacket_chef", damage = { 1, 4 } },
            { item = "pants_checkered", damage = { 1, 4 } },
            { item = "hat_chef", damage = { 1, 4 }, probability = 70 },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 75 },
            { group = "costume_masks", damage = { 1, 4 }, probability = 10 },
            { item = "knife_huge", damage = { 1, 4 }, variant = "knife_butcher", container = "sheath", probability = 60 },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "apron_cotton", damage = { 1, 4 }, probability = 50 },
                    { item = "waist_apron_long", damage = { 1, 4 }, probability = 30 },
                    { item = "waist_apron_short", damage = { 1, 4 }, probability = 20 },
                },
                probability = 75,
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 50 },
                    { item = "boots", damage = { 1, 4 }, probability = 10 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 40 },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for generic leather jacket cosplay zombies
    local group = content.ItemGroup { id = "leather_jacket_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bandana_head", damage = { 1, 4 }, probability = 65 },
            { item = "sunglasses", damage = { 1, 4 }, probability = 95 },
            { item = "gloves_leather", damage = { 1, 4 }, probability = 45 },
            { item = "leather_belt", damage = { 1, 4 } },
            { group = "costume_masks", damage = { 1, 4 }, probability = 20 },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "jacket_leather", damage = { 1, 4 }, probability = 70 },
                    { item = "leather_police_jacket", damage = { 1, 4 }, probability = 30 },
                },
            },
            {
                distribution = {
                    { item = "jeans", damage = { 1, 4 }, probability = 60 },
                    { item = "pants_leather", damage = { 1, 4 }, probability = 25 },
                    { item = "motorbike_pants", damage = { 1, 4 }, probability = 15 },
                },
            },
            {
                distribution = {
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 20 },
                    { item = "boots", damage = { 1, 4 }, probability = 50 },
                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 15 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 10 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 5 },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            { item = "tshirt", damage = { 1, 4 }, probability = 95 },
                            { group = "male_underwear_bottom", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 20 },
                        },
                    },
                    {
                        collection = {
                            { item = "tshirt", damage = { 1, 4 }, probability = 75 },
                            { item = "bikini_top", damage = { 1, 4 } },
                            { item = "bikini_bottom", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 35 },
                        },
                    },
                },
            },
            {
                distribution = {
                    { item = "bat", damage = { 1, 4 }, probability = 70 },
                    { item = "nailbat", damage = { 1, 4 }, probability = 15 },
                    { item = "bwirebat", damage = { 1, 4 }, probability = 15 },
                },
                probability = 10,
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for cowboy zombies
    local group = content.ItemGroup { id = "cowboy_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "cowboy_hat", damage = { 1, 4 } },
            { item = "sunglasses", damage = { 1, 4 }, probability = 35 },
            { item = "gloves_leather", damage = { 1, 4 }, probability = 75 },
            { item = "dress_shirt", damage = { 1, 4 } },
            { item = "chaps_leather", damage = { 1, 4 }, probability = 60 },
            { item = "leather_belt", damage = { 1, 4 } },
            { item = "rope_30", damage = { 1, 4 }, probability = 30 },
            { item = "bullwhip", damage = { 1, 4 }, probability = 35 },
            {
                item = "western_holster",
                contents = {
                    { group = "bandolier_cowboy" },
                },
                probability = 10,
            },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "jacket_leather", damage = { 1, 4 }, probability = 70 },
                    { item = "duster", damage = { 1, 4 }, probability = 30 },
                },
            },
            {
                distribution = {
                    { item = "jeans", damage = { 1, 4 }, probability = 60 },
                    { item = "pants_leather", damage = { 1, 4 }, probability = 25 },
                    { item = "pants", damage = { 1, 4 }, probability = 15 },
                },
            },
            {
                distribution = {
                    { item = "boots_western", damage = { 1, 4 }, probability = 50 },
                    { item = "boots", damage = { 1, 4 }, probability = 30 },
                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 10 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 10 },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for japanese cosplay zombies
    local group = content.ItemGroup { id = "japan_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { group = "scarfs_unisex", damage = { 1, 4 }, probability = 15 },
            { item = "sunglasses", damage = { 1, 4 }, probability = 35 },
            {
                distribution = {
                    {
                        collection = {
                            { item = "haori", damage = { 1, 4 }, probability = 45 },
                            { item = "hakama", damage = { 1, 4 }, probability = 45 },
                            { item = "kimono", damage = { 1, 4 } },
                        },
                    },
                    { item = "yukata", damage = { 1, 4 } },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            {
                                distribution = {
                                    { item = "dress_shoes", damage = { 1, 4 }, probability = 40 },
                                    { item = "boots", damage = { 1, 4 }, probability = 20 },
                                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 15 },
                                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 15 },
                                    { item = "sneakers", damage = { 1, 4 }, probability = 10 },
                                },
                            },
                            { group = "socks_unisex", damage = { 1, 4 } },
                        },
                        probability = 45,
                    },
                    {
                        collection = {
                            { item = "geta", damage = { 1, 4 } },
                            { item = "tabi_dress", damage = { 1, 4 } },
                        },
                        probability = 55,
                    },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for pirate zombies
    local group = content.ItemGroup { id = "pirate_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { group = "scarfs_unisex", damage = { 1, 4 }, probability = 15 },
            { item = "tricorne", damage = { 1, 4 }, probability = 75 },
            { item = "bandana_head", damage = { 1, 4 }, probability = 65 },
            { item = "eyepatch_leather", damage = { 1, 4 }, probability = 85 },
            { item = "tshirt", damage = { 1, 4 }, probability = 95 },
            { item = "pistol_flintlock", damage = { 1, 4 }, container = "baldric_holster", probability = 10 },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                collection = {
                    { item = "trenchcoat", damage = { 1, 4 }, probability = 45 },
                    { item = "trenchcoat_leather", damage = { 1, 4 }, probability = 35 },
                    { item = "jacket_leather", damage = { 1, 4 }, probability = 20 },
                },
            },
            {
                distribution = {
                    { item = "jeans", damage = { 1, 4 }, probability = 40 },
                    { item = "pants", damage = { 1, 4 }, variant = "pants_black", probability = 20 },
                    { item = "pants", damage = { 1, 4 }, variant = "pants_brown", probability = 15 },
                    { item = "pants_leather", damage = { 1, 4 }, probability = 10 },
                },
            },
            {
                distribution = {
                    { item = "santa_belt", damage = { 1, 4 }, probability = 60 },
                    { item = "leather_belt", damage = { 1, 4 }, probability = 40 },
                },
            },
            {
                distribution = {
                    { item = "boots", damage = { 1, 4 }, probability = 25 },
                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 40 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 25 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 10 },
                },
            },
            {
                collection = {
                    { item = "cutlass_fake", damage = { 1, 4 }, container = "scabbard", probability = 80 },
                    { item = "cutlass_inferior", damage = { 1, 4 }, container = "scabbard", probability = 19 },
                    { item = "cutlass", damage = { 1, 4 }, container = "scabbard", probability = 1 },
                },
                probability = 20,
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 5 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for scientist zombies
    local group = content.ItemGroup { id = "scientist_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { group = "scarfs_unisex", damage = { 1, 4 }, probability = 10 },
            { item = "goggles_chem", damage = { 1, 4 }, probability = 95 },
            { item = "coat_lab", damage = { 1, 4 } },
            { item = "gloves_rubber", damage = { 1, 4 }, probability = 75 },
            { item = "apron_plastic", damage = { 1, 4 }, probability = 45 },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 95 },
            { group = "pants_unisex", damage = { 1, 4 } },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "boots_rubber", damage = { 1, 4 }, probability = 35 },
                    { item = "boots", damage = { 1, 4 }, probability = 15 },
                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 20 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 15 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 15 },
                },
            },
            {
                collection = {
                    { item = "flask_glass", damage = { 1, 4 }, probability = 50 },
                    { item = "beaker", damage = { 1, 4 }, probability = 25 },
                    { item = "test_tube", damage = { 1, 4 }, probability = 20 },
                    { item = "scissors_medical", damage = { 1, 4 }, probability = 5 },
                },
                probability = 40,
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 5 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for beekeper zombies
    local group = content.ItemGroup { id = "beekeeping_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "beekeeping_hood", damage = { 1, 4 }, probability = 85 },
            { item = "beekeeping_suit", damage = { 1, 4 } },
            { item = "beekeeping_gloves", damage = { 1, 4 }, probability = 75 },
            { item = "honey_scraper", damage = { 1, 4 }, probability = 65 },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 95 },
            { group = "pants_unisex", damage = { 1, 4 } },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "boots_rubber", damage = { 1, 4 }, probability = 25 },
                    { item = "boots", damage = { 1, 4 }, probability = 15 },
                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 25 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 15 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 20 },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 5 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for bondage cosplay zombies
    local group = content.ItemGroup { id = "bondage_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bondage_mask", damage = { 1, 4 }, probability = 85 },
            { item = "leather_belt", damage = { 1, 4 }, probability = 75 },
            { item = "gloves_leather", damage = { 1, 4 }, probability = 65 },
            { item = "rope_6", damage = { 1, 4 }, probability = 35 },
            { item = "bullwhip", damage = { 1, 4 }, probability = 25 },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "bondage_suit", damage = { 1, 4 }, probability = 65 },
                    { item = "bodysuit_lycra", damage = { 1, 4 }, variant = "bondage_suit", probability = 45 },
                },
            },
            {
                distribution = {
                    { item = "heels", damage = { 1, 4 }, probability = 35 },
                    { item = "boots", damage = { 1, 4 }, probability = 15 },
                    { item = "thigh_high_boots", damage = { 1, 4 }, probability = 25 },
                    { item = "knee_high_boots", damage = { 1, 4 }, variant = "chelsea_boots", probability = 20 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 5 },
                },
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- For use in halloween as a set of zombie cloth drops for fursuit cosplay zombies
    local group = content.ItemGroup { id = "fursuit_costume_unisex", kind = "distribution" }
    group:entry {
        collection = {
            { item = "leather_belt", damage = { 1, 4 }, probability = 55 },
            { group = "shirts_unisex", damage = { 1, 4 }, probability = 65 },
            { group = "pants_unisex", damage = { 1, 4 } },
            { group = "socks_unisex", damage = { 1, 4 } },
            {
                distribution = {
                    { item = "fursuit", damage = { 1, 4 }, probability = 20 },
                },
            },
            {
                distribution = {
                    { item = "flip_flops", damage = { 1, 4 }, probability = 35 },
                    { item = "leathersandals", damage = { 1, 4 }, probability = 25 },
                    { item = "sneakers", damage = { 1, 4 }, probability = 65 },
                },
                probability = 30,
            },
            {
                distribution = {
                    {
                        collection = {
                            { group = "male_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        collection = {
                            { group = "female_underwear", damage = { 1, 4 } },
                            { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end
