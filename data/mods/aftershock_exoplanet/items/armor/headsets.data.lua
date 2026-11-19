local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_combat_headset_off",
    category = "clothing",
    name = ccb.content.plural_text("tactical infovisor", "tactical infovisors"),
    description = ccb.content.text("An armored black headset that coalesces the feeds of several sensors into a single screen display.  It provides generalized assistance in combat, including targeting assistance for thrown and ranged weaponry, threat identification, conditional NV and thermal vision and protection against high intensity light sources.  It must be active to function."),
    mass = "170 g",
    volume = "750 ml",
    price = "7 kUSD",
    materials = { "nanoprinted_alloy" },
    symbol = "[",
    looks_like = "glasses_safety",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    flags = { "MUNDANE", "OUTER", "PADDED" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        portions = { { encumbrance = 5, coverage = 100, covers = { "eyes" } } },
        thickness = 1,
        environmental_protection = 15,
    },
    artifact = { enchantments = { "nvg_great", "THERMAL_VISION_GOOD", "ench_ballistic_assist" } },
    use_actions = {
        {
            kind = "transform",
            target = "afs_combat_headset",
            message = ccb.content.text("You lower the visor and flick the control dial to active."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_combat_headset",
    category = "clothing",
    copy_from = "afs_combat_headset_off",
    name = ccb.content.plural_text("tactical infovisor", "tactical infovisors"),
    description = ccb.content.text("An armored black headset that coalesces the feeds of several sensors into a single screen display.  It provides generalized assistance in combat, including targeting assistance for thrown and ranged weaponry, threat identification, conditional NV and thermal vision and protection against high intensity light sources."),
    flags = {
        "MUNDANE", "ZOOM", "WATCH", "ALARMCLOCK", "OUTER", "STURDY", "FLASH_PROTECTION", "SUN_GLASSES",
        "WATER_BREAK", "PADDED", "ELECTRONIC", "SPAWN_ACTIVE",
    },
    faults = { { group = "electronic_general" } },
    revert_to = "afs_combat_headset_off",
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "310 mW" },
    armor = {},
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "afs_combat_headset_off",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You flick the visor off, and push it off your face."),
        },
    },
}
