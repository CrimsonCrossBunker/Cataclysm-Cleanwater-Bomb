local content = require("ccb").content

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_tool", kind = "collection" }
    group:entry { item = "hammer", damage = { 1, 3 } }
    group:group("mon_zombie_technician_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "feral_security_death_drops_9mm",
        kind = "collection",
        with_ammo = 20,
        with_magazine = 100,
    }
    group:entry { item = "m9", charges = { 0, 0 }, damage = { 2, 4 } }
    group:entry { item = "baton-extended", damage = { 2, 4 } }
    group:entry { group = "security_armor", damage = { 0, 2 }, probability = 30 }
    group:entry { group = "security_gear", damage = { 0, 2 }, probability = 50 }
    group:entry { group = "cop_gloves", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "security_pants", damage = { 1, 4 } }
    group:entry { group = "security_shoes", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "security_torso", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    group:entry { group = "wallets", damage = { 1, 4 } }
    group:entry { item = "throat_guard_cut_resistant", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "m9mag", count = { 0, 2 }, charges = { 0, 0 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "feral_security_death_drops_flashlight",
        kind = "collection",
        with_ammo = 20,
        with_magazine = 100,
    }
    group:entry { item = "heavy_flashlight", damage = { 2, 4 } }
    group:entry { item = "tazer", damage = { 2, 4 } }
    group:entry { group = "cop_gloves", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "security_pants", damage = { 1, 4 } }
    group:entry { group = "security_shoes", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "security_torso", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    group:entry { group = "wallets", damage = { 1, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_maids_death_drops_broom", kind = "collection" }
    group:entry { item = "broom", damage = { 0, 2 } }
    group:group("default_maid_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_maids_death_drops_candlestick", kind = "collection" }
    group:entry { item = "candlestick", damage = { 0, 2 } }
    group:group("default_maid_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_maids_death_drops_knife", kind = "collection" }
    group:entry {
        distribution = {
            { item = "knife_large", damage = { 0, 3 }, variant = "knife_chef", probability = 50 },
            { item = "knife_huge", damage = { 0, 3 }, variant = "knife_butcher", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { group = "default_maid_clothes", damage = { 1, 4 }, probability = 50 },
            { group = "default_chef_clothes", damage = { 1, 4 }, probability = 50 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_fancy_death_drops_rapier", kind = "collection" }
    group:entry { group = "rapiers", damage = { 2, 4 } }
    group:group("default_fancy_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_fancy_death_drops_rapier_fake", kind = "collection" }
    group:entry { item = "rapier_fake", damage = { 0, 2 } }
    group:group("default_fancy_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_armored_death_drops_mace", kind = "collection" }
    group:entry { group = "maces", damage = { 2, 4 } }
    group:group("default_armored_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_armored_death_drops_battleaxe", kind = "collection" }
    group:entry { group = "battleaxes", damage = { 2, 4 } }
    group:group("default_armored_clothes")
    content.add(group)
end

do
    -- contains cloth for a feral butler or maid
    local group = content.ItemGroup { id = "default_maid_clothes", kind = "collection" }
    group:entry { group = "scarfs_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "accesories_personal_unisex", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "glasses_monocle", damage = { 1, 4 }, probability = 20 }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            { group = "male_underwear", damage = { 1, 4 }, probability = 80 },
                            { item = "union_suit", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    { item = "tux", damage = { 1, 4 } },
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 80 },
                    { group = "common_gloves", damage = { 1, 4 }, probability = 60 },
                    { group = "neckties", damage = { 1, 4 }, probability = 45 },
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
                            { item = "dress_shoes", damage = { 1, 4 }, probability = 45 },
                            { item = "heels", damage = { 1, 4 }, probability = 45 },
                        },
                    },
                    {
                        distribution = {
                            {
                                collection = {
                                    { group = "mansion_maid_dress", damage = { 1, 4 } },
                                    { item = "maid_hat", damage = { 1, 4 }, probability = 80 },
                                    { item = "long_glove_white", damage = { 1, 4 }, probability = 60 },
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
                                },
                            },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- contains cloth for a feral chef
    local group = content.ItemGroup { id = "default_chef_clothes", kind = "collection" }
    group:entry { item = "hat_chef", damage = { 1, 4 }, probability = 80 }
    group:entry { group = "scarfs_unisex", damage = { 1, 4 }, probability = 5 }
    group:entry { group = "accesories_personal_unisex", damage = { 1, 4 }, probability = 15 }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            { group = "male_underwear", damage = { 1, 4 }, probability = 80 },
                            { item = "union_suit", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    { item = "jacket_chef", damage = { 1, 4 } },
                    {
                        distribution = {
                            { item = "pants", damage = { 1, 4 }, probability = 45 },
                            { item = "pants_checkered", damage = { 1, 4 }, probability = 55 },
                        },
                        probability = 85,
                    },
                    {
                        distribution = {
                            { item = "apron_cotton", damage = { 1, 4 }, probability = 60 },
                            { item = "waist_apron_long", damage = { 1, 4 }, probability = 30 },
                            { item = "waist_apron_short", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 80 },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                    { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 15 },
                },
            },
            {
                collection = {
                    { group = "female_underwear", damage = { 1, 4 }, probability = 90 },
                    { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 15 },
                    { item = "jacket_chef", damage = { 1, 4 } },
                    {
                        distribution = {
                            { item = "pants", damage = { 1, 4 }, probability = 45 },
                            { item = "pants_checkered", damage = { 1, 4 }, probability = 55 },
                        },
                        probability = 85,
                    },
                    {
                        distribution = {
                            { item = "apron_cotton", damage = { 1, 4 }, probability = 60 },
                            { item = "waist_apron_long", damage = { 1, 4 }, probability = 30 },
                            { item = "waist_apron_short", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 80 },
                },
            },
        },
    }
    content.add(group)
end

do
    -- contains cloth for a fancy feral
    local group = content.ItemGroup { id = "default_fancy_clothes", kind = "collection" }
    group:entry { group = "coats_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "gloves_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "hatstore_hats", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "scarfs_unisex", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "accesories_personal_unisex", damage = { 1, 4 }, probability = 45 }
    group:entry {
        distribution = {
            {
                collection = {
                    {
                        distribution = {
                            { group = "male_underwear", damage = { 1, 4 }, probability = 80 },
                            { item = "union_suit", damage = { 1, 4 }, probability = 10 },
                        },
                    },
                    {
                        distribution = {
                            {
                                collection = {
                                    { group = "pants_male", damage = { 1, 4 }, probability = 60 },
                                    { item = "dress_shirt", damage = { 1, 4 }, probability = 60 },
                                    { item = "leather_belt", damage = { 1, 4 }, probability = 30 },
                                },
                            },
                            { item = "suit", damage = { 1, 4 }, probability = 60 },
                            { item = "tux", damage = { 1, 4 }, probability = 20 },
                            { item = "haori", damage = { 1, 4 }, probability = 5 },
                        },
                    },
                    { item = "dress_shoes", damage = { 1, 4 }, probability = 80 },
                    { group = "neckties", damage = { 1, 4 }, probability = 15 },
                    { group = "socks_unisex", damage = { 1, 4 }, probability = 50 },
                    { group = "accesories_personal_mens", damage = { 1, 4 }, probability = 45 },
                },
            },
            {
                collection = {
                    { group = "female_underwear", damage = { 1, 4 }, probability = 90 },
                    { group = "accesories_personal_womens", damage = { 1, 4 }, probability = 65 },
                    { group = "dress_shoes", damage = { 1, 4 }, probability = 60 },
                    {
                        distribution = {
                            {
                                collection = {
                                    { group = "pants_female", damage = { 1, 4 }, probability = 60 },
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
                                probability = 10,
                            },
                            {
                                collection = {
                                    {
                                        distribution = {
                                            { item = "dress", damage = { 1, 4 }, probability = 75 },
                                            { item = "sundress", damage = { 1, 4 }, probability = 15 },
                                            { item = "santa_dress_long", damage = { 1, 4 }, probability = 5 },
                                            { item = "gown_sleeved", damage = { 1, 4 }, variant = "sinister", probability = 5 },
                                            { item = "long_dress_sleeved", damage = { 1, 4 }, variant = "witch_black", probability = 5 },
                                            { item = "long_dress_sleeved", damage = { 1, 4 }, variant = "sinister", probability = 5 },
                                            {
                                                collection = {
                                                    { item = "dress_wedding", damage = { 1, 4 } },
                                                    { item = "veil_wedding", damage = { 1, 4 } },
                                                },
                                                probability = 10,
                                            },
                                        },
                                    },
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
                                    { item = "long_glove_white", damage = { 1, 4 }, probability = 50 },
                                },
                                probability = 85,
                            },
                        },
                    },
                },
            },
        },
    }
    content.add(group)
end

do
    -- contains cloth for an armored (medieval) feral
    local group = content.ItemGroup { id = "default_armored_clothes", kind = "collection" }
    group:entry {
        distribution = {
            { group = "male_underwear", damage = { 1, 4 }, probability = 45 },
            { group = "female_underwear", damage = { 1, 4 }, probability = 45 },
            { item = "union_suit", damage = { 1, 4 }, probability = 10 },
        },
    }
    group:entry {
        distribution = {
            { item = "armor_plarmor", damage = { 1, 4 }, probability = 25 },
            { item = "armor_blarmor", damage = { 1, 4 }, probability = 25 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "armor_junk_plate", damage = { 2, 4 }, probability = 50 },
            { item = "armor_lorica", damage = { 2, 4 }, probability = 40 },
            { item = "armor_samurai", damage = { 2, 4 }, probability = 30 },
            { item = "armor_cuirass", damage = { 2, 4 }, probability = 30 },
            {
                distribution = {
                    { item = "armor_junk_lightplate", damage = { 2, 4 }, probability = 40 },
                    {
                        collection = {
                            { item = "cuirass_lightplate", damage = { 2, 4 }, probability = 80 },
                            { item = "armor_lc_armguard", damage = { 1, 4 }, probability = 60 },
                            { item = "armor_lc_leg_guard", damage = { 1, 4 }, probability = 60 },
                        },
                        probability = 60,
                    },
                },
                probability = 50,
            },
        },
    }
    group:entry {
        distribution = {
            { item = "helmet_plate", damage = { 1, 4 } },
            { item = "helmet_nasal", damage = { 1, 4 }, probability = 40 },
            { item = "helmet_barbute", damage = { 1, 4 }, probability = 40 },
            { item = "helmet_corinthian", damage = { 1, 4 }, probability = 40 },
            { item = "helmet_galea", damage = { 1, 4 }, probability = 40 },
            { item = "helmet_armet", damage = { 1, 4 }, probability = 40 },
            { item = "helmet_sallet", damage = { 1, 4 }, probability = 40 },
            { item = "helmet_kettle", damage = { 1, 4 }, probability = 20 },
            { item = "helmet_kabuto", damage = { 1, 4 }, probability = 20 },
            { item = "helmet_conical", damage = { 1, 4 }, probability = 20 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "boots_plate", damage = { 1, 4 }, probability = 50 },
            { item = "boots_larmor", damage = { 1, 4 }, probability = 20 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { item = "gloves_plate", damage = { 1, 4 }, probability = 60 },
        },
        probability = 60,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "starer_death_drops_axe", kind = "collection" }
    group:entry {
        distribution = {
            { item = "ax", damage = { 1, 3 }, probability = 50 },
            { item = "hatchet", damage = { 1, 3 }, probability = 25 },
            { item = "fire_ax", damage = { 2, 4 }, probability = 15 },
            { item = "iceaxe", damage = { 1, 3 }, probability = 5 },
            { item = "crash_axe", damage = { 1, 3 }, probability = 5 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "starer_death_drops_pipe", kind = "collection" }
    group:entry { item = "pipe", damage = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "starer_death_drops_crowbar", kind = "collection" }
    group:entry {
        distribution = {
            { item = "crowbar", damage = { 1, 3 }, probability = 40 },
            { item = "makeshift_crowbar", damage = { 1, 3 }, probability = 40 },
            { item = "heavy_crowbar", damage = { 2, 4 }, probability = 10 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_prepper_mace_death_drops", kind = "collection" }
    group:entry { item = "mace_pipe", damage = { 2, 4 } }
    group:group("mon_feral_prepper_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_prepper_knife_death_drops", kind = "collection" }
    group:entry { item = "knife_combat", damage = { 2, 4 } }
    group:group("mon_feral_prepper_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_autogun", kind = "distribution", with_ammo = 10, with_magazine = 100 }
    group:group("modular_m4a1", 500)
    group:group("modular_ar15", 500)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_jackboot_shotgun", kind = "distribution" }
    group:entry { item = "mossberg_500", charges = { 0, 0 }, probability = 33 }
    group:entry { item = "mossberg_590", charges = { 0, 0 }, probability = 3 }
    group:entry { item = "remington_870", charges = { 0, 0 }, probability = 35 }
    group:entry { item = "remington_870_express", charges = { 0, 0 }, probability = 18 }
    group:entry { item = "mossberg_930", charges = { 0, 0 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_feral_soldier_death_drops",
        kind = "collection",
        with_ammo = 0,
        with_magazine = 100,
    }
    group:entry {
        distribution = {
            { group = "clothing_soldier_set", damage = { 0, 3 }, probability = 65 },
            { group = "clothing_soldier_winter_set", damage = { 0, 3 }, probability = 35 },
        },
    }
    group:group("infantry_common_gear_feral")
    group:entry { group = "military_standard_grenades", count = { 1, 3 }, probability = 20 }
    group:group("military_patrol_food")
    group:entry {
        distribution = {
            { group = "infantry_officer_gear" },
            { group = "infantry_medical_gear" },
        },
        probability = 40,
    }
    group:group("wallets", 10)
    group:group("pocket_cigar", 15)
    group:group("misc_smoking_legal", 30)
    group:item("dog_tag", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_swimmer_death_drops_kickboard", kind = "collection" }
    group:entry { item = "stick", damage = { 2, 4 } }
    group:group("mon_zombie_swimmer_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_feral_jackboot_death_drops",
        kind = "collection",
        with_ammo = 20,
        with_magazine = 100,
    }
    group:entry {
        distribution = {
            { item = "jacket_leather", damage = { 1, 4 }, probability = 65 },
            { item = "trenchcoat_leather", damage = { 1, 4 }, probability = 65 },
            { item = "duster_leather", damage = { 1, 4 }, probability = 35 },
        },
    }
    group:entry {
        distribution = {
            { item = "longshirt", damage = { 1, 4 }, probability = 10 },
            { item = "polo_shirt", damage = { 1, 4 }, probability = 50 },
            { item = "tshirt", damage = { 1, 4 }, probability = 80 },
        },
    }
    group:entry { group = "feral_jackboot_shotgun", damage = { 1, 4 } }
    group:entry { group = "clothing_outdoor_shoes", damage = { 1, 4 } }
    group:entry { group = "clothing_outdoor_pants", damage = { 1, 4 } }
    group:entry { group = "socks_unisex", damage = { 1, 4 } }
    group:entry { group = "clothing_watch", damage = { 1, 4 }, probability = 5 }
    group:entry { item = "sunglasses", damage = { 1, 4 }, probability = 20 }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry { item = "gloves_leather", damage = { 1, 4 }, probability = 80 }
    group:entry { group = "salty_snacks", count = { 1, 3 }, probability = 50 }
    group:entry { group = "snacks", count = { 1, 3 }, probability = 60 }
    group:group("meth_bag_zipper_1_6", 20)
    group:group("meth_ingredients", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_sailor_death_drops", kind = "collection" }
    group:entry { item = "wrench_large", damage = { 0, 4 } }
    group:group("mon_zombie_sailor_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_sailor_axe_death_drops", kind = "collection" }
    group:entry { item = "crash_axe", damage = { 0, 4 } }
    group:group("mon_zombie_sailor_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_sailor_mop_death_drops", kind = "collection" }
    group:entry { item = "mop_folded", damage = { 0, 4 } }
    group:group("mon_zombie_sailor_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_sailor_lug_wrench_death_drops", kind = "collection" }
    group:entry { item = "lug_wrench", damage = { 0, 4 } }
    group:group("mon_zombie_sailor_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_feral_officer_death_drops",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry { group = "clothing_navy_officer", damage = { 0, 4 } }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 25 }
    group:entry { item = "two_way_radio", charges = { 0, 300 }, probability = 25 }
    group:item("militarymap", 10)
    group:group("wallets_military", 5)
    group:entry { group = "clothing_glasses", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "wristwatch", damage = { 0, 4 }, probability = 33 }
    group:group("pocket_cigar", 5)
    group:group("misc_smoking_legal", 10)
    group:entry { item = "m18", charges = { 0, 0 }, damage = { 0, 4 } }
    group:entry { item = "p320mag_17rd_9x19mm", charges = { 0, 0 }, probability = 50 }
    group:entry { item = "p320mag_17rd_9x19mm", charges = { 0, 0 }, probability = 50 }
    group:item("dog_tag", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_prisoner_death_drops", kind = "collection" }
    group:entry { item = "glass_shiv", damage = { 0, 4 } }
    group:group("mon_zombie_prisoner_death_drops")
    content.add(group)
end
