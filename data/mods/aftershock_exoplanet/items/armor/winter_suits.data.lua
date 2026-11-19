local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_cryopod_bodyglove",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("cryopod bodyglove", "cryopod bodygloves"),
    looks_like = "jumpsuit",
    description = ccb.content.text("A dark orange bodyglove, hundreds of tubes curl over its surface, tracing the contours of human musculature.  Meant to control body temperature during prolonged cryopreservation, it could easily keep you comfortable in any earthly climate.  Use it to activate its climate control functionality."),
    price = "15 kUSD",
    survival_price = "1 kUSD 500 USD",
    materials = { "nylon", "nanoprinted_alloy" },
    mass = "1250 g",
    volume = "4500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    flags = { "VARSIZE", "NORMAL", "RAINPROOF", "STURDY", "WATERPROOF", "PADDED" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 5, ammo_types = "battery" },
    armor = {
        warmth = 20,
        environmental_protection = 10,
        thickness = 1,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 3.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = {
                    "head",
                    "torso",
                    "eyes",
                    "mouth",
                    "leg_l",
                    "leg_r",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "nanoprinted_alloy", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r" },
            },
        },
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_cryopod_bodyglove_on",
            need_charges = 5,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_cryopod_bodyglove_on",
    copy_from = "afs_cryopod_bodyglove",
    repair_like = "afs_cryopod_bodyglove",
    name = ccb.content.plural_text("cryopod bodyglove (on)", "cryopod bodygloves (on)"),
    looks_like = "afs_cryopod_bodyglove",
    description = ccb.content.text("A dark orange bodyglove, hundreds of tubes curl over its surface, tracing the contours of human musculature.  Meant to control body temperature during prolonged cryopreservation, it could easily keep you comfortable in any earthly climate.  The temperature control units of this high-tech garment are currently active, and continuously draining battery power.  Use it to turn them off."),
    revert_to = "afs_cryopod_bodyglove",
    flags = {
        "VARSIZE", "SKINTIGHT", "RAINPROOF", "STURDY", "WATERPROOF", "PADDED", "THERMOMETER",
        "HYGROMETER", "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "90 W" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_cryopod_bodyglove",
        },
    },
}
