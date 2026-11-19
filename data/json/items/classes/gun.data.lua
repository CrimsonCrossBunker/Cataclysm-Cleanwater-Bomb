local ccb = require("ccb")

-- this is the default handling for anything with a stock
-- NO_I18N
ccb.content.define_item {
    id = "underbarrel_base",
    abstract = true,
    name = ccb.content.text_without_extraction("base underbarrel gun"),
    symbol = "(",
    color = "light_gray",
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    gun = { reload_noise_volume = 10, handling = 10, damage = { type = "bullet", amount = 0 } },
}

-- NO_I18N
-- default handling for anything without a recoil stock
ccb.content.define_item {
    id = "launcher_base",
    abstract = true,
    name = ccb.content.text_without_extraction("base launcher"),
    symbol = "(",
    color = "light_gray",
    flags = { "RELOAD_ONE", "RELOAD_EJECT", "NEVER_JAMS" },
    faults = { { fault = "fault_gun_blackpowder" }, { fault = "fault_gun_dirt" } },
    gun = {
        skill = "launcher",
        reload_noise_volume = 10,
        modes = {
            {
                id = "DEFAULT",
                label = ccb.content.text("single"),
                quantity = 1,
                flags = { "NPC_AVOID" },
            },
        },
        handling = 20,
        mod_locations = { { id = "barrel", count = 1 }, { id = "sights", count = 1 }, { id = "sling", count = 1 } },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_handgun_manual",
    abstract = true,
    color = "light_gray",
    symbol = "⨽",
    weapon_categories = { "AUTOMATIC_PISTOLS" },
    melee_damage = { bash = 7 },
    accuracy = { grip = "solid", length = "hand", surface = "line", balance = "neutral" },
    flags = { "ALLOWS_BODY_BLOCK", "RELOAD_ONE", "NO_TURRET", "EASY_CLEAN", "RELOAD_EJECT" },
    name = ccb.content.text_without_extraction("base gun"),
    faults = { { fault = "fault_gun_blackpowder" }, { fault = "fault_gun_dirt" } },
    gun = {
        blackpowder_tolerance = 56,
        skill = "pistol",
        sight_dispersion = 60,
        durability = 8,
        handling = 10,
        reload_time = 200,
        reload_noise_volume = 10,
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_handgun_semi",
    abstract = true,
    color = "light_gray",
    symbol = "⨽",
    weapon_categories = { "AUTOMATIC_PISTOLS" },
    melee_damage = { bash = 7 },
    accuracy = { grip = "solid", length = "hand", surface = "line", balance = "neutral" },
    flags = { "ALLOWS_BODY_BLOCK" },
    name = ccb.content.text_without_extraction("base gun"),
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    gun = {
        skill = "pistol",
        sight_dispersion = 60,
        durability = 8,
        handling = 10,
        reload_time = 150,
        reload_noise_volume = 10,
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_22_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "6 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "22" }, min_cycle_recoil = 140 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_9mm_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "8 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "9mm" }, min_cycle_recoil = 480 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_10mm_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "7 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "10mm" }, min_cycle_recoil = 720 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_32_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "2 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "32" }, min_cycle_recoil = 135 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_40_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "8 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "40" }, min_cycle_recoil = 420 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_45_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "7 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "45" }, min_cycle_recoil = 550 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_57_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "7 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "57" }, min_cycle_recoil = 330 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_380_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "4 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "380" }, min_cycle_recoil = 280 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_357sig_semi_pistol",
    abstract = true,
    copy_from = "gun_base_handgun_semi",
    survival_price = "4 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "357sig" }, min_cycle_recoil = 540 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_rifle_manual",
    abstract = true,
    color = "light_gray",
    symbol = "⨽",
    weapon_categories = { "AUTOMATIC_RIFLES" },
    melee_damage = { bash = 13 },
    accuracy = { grip = "solid", length = "short", surface = "line", balance = "neutral" },
    name = ccb.content.text_without_extraction("base gun"),
    flags = { "RELOAD_ONE", "NO_TURRET", "EASY_CLEAN" },
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
    },
    gun = {
        skill = "rifle",
        sight_dispersion = 40,
        durability = 8,
        handling = 20,
        reload_time = 150,
        reload_noise_volume = 10,
        blackpowder_tolerance = 56,
    },
}

-- Buttstrokes aren't that good compared to a real melee weapon.
-- NO_I18N
ccb.content.define_item {
    id = "gun_base_rifle_semi",
    abstract = true,
    color = "light_gray",
    symbol = "⨽",
    weapon_categories = { "AUTOMATIC_RIFLES" },
    melee_damage = { bash = 13 },
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "uneven" },
    name = ccb.content.text_without_extraction("base gun"),
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    gun = {
        skill = "rifle",
        sight_dispersion = 40,
        durability = 8,
        handling = 20,
        reload_time = 150,
        reload_noise_volume = 10,
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_22_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "10 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "22" }, min_cycle_recoil = 140 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_9mm_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "11 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "9mm" }, min_cycle_recoil = 480 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_45_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "12 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "45" }, min_cycle_recoil = 550 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_50bmg_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "40 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "50" }, reload_time = 400, min_cycle_recoil = 23625 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_57_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "10 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "57" }, min_cycle_recoil = 330 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_223_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "15 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "223" }, min_cycle_recoil = 1350 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_308_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "18 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "308" }, min_cycle_recoil = 2700 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_762_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "9 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "762" }, min_cycle_recoil = 1830 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_3006_semi_rifle",
    abstract = true,
    copy_from = "gun_base_rifle_semi",
    survival_price = "12 USD",
    name = ccb.content.text_without_extraction("base gun"),
    gun = { ammunition = { "3006" }, min_cycle_recoil = 3420 },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_shotgun_manual",
    abstract = true,
    color = "light_gray",
    symbol = "⨽",
    weapon_categories = { "AUTOMATIC_RIFLES" },
    melee_damage = { bash = 13 },
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "uneven" },
    name = ccb.content.text_without_extraction("base gun"),
    survival_price = "5 USD",
    flags = { "RELOAD_ONE", "NO_TURRET", "EASY_CLEAN" },
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
    },
    gun = {
        ammunition = { "shot" },
        skill = "shotgun",
        sight_dispersion = 200,
        durability = 8,
        handling = 20,
        reload_time = 150,
        reload_noise_volume = 10,
        blackpowder_tolerance = 56,
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "gun_base_shotgun_semi",
    abstract = true,
    color = "light_gray",
    symbol = "⨽",
    weapon_categories = { "AUTOMATIC_RIFLES" },
    melee_damage = { bash = 13 },
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "uneven" },
    name = ccb.content.text_without_extraction("base gun"),
    survival_price = "7 USD",
    flags = { "RELOAD_ONE", "EASY_CLEAN" },
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    gun = {
        ammunition = { "shot" },
        skill = "shotgun",
        sight_dispersion = 40,
        durability = 8,
        handling = 20,
        reload_time = 150,
        reload_noise_volume = 10,
        min_cycle_recoil = 2400,
    },
}
