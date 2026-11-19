local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_leg_weight_on",
    copy_from = "inventor_leg_weight",
    name = ccb.content.plural_text("leg weight suspension system", "leg weight suspension systems"),
    revert_to = "inventor_leg_weight",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "5 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            target = "inventor_leg_weight",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
        },
    },
}

ccb.content.define_item {
    id = "inventor_jump_boots",
    category = "armor",
    name = ccb.content.plural_text("jump driver", "jump drivers"),
    description = ccb.content.text("Heavily mechanized boots with small integrated battery slot inside.  Upon activation make you jump higher and farther."),
    mass = "1657 g",
    volume = "1500 ml",
    materials = { "leather", "kevlar", "rubber", "mc_steel" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_red",
    flags = { "MORPHIC", "STURDY", "OUTER", "SOFT", "MUNDANE", "INVENTOR_CRAFTED" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_MEDIUM" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 150, ammo_types = "battery" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.25 },
                    { id = "kevlar", coverage = 100, thickness = 1.25 },
                    { id = "mc_steel", coverage = 5, thickness = 1.25 },
                },
                encumbrance = 7,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
    use_actions = { { kind = "cast_spell", spell = "jump_boots_leap", no_fail = true, level = 0 } },
}
