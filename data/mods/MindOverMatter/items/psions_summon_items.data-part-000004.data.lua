local ccb = require("ccb")

ccb.content.define_item {
    id = "pyrokinetic_fire_tool_four_arms",
    name = ccb.content.plural_text("[Ψ]banked flames", "[Ψ]banked flames"),
    copy_from = "pyrokinetic_fire_tool",
    inheritance = { remove = { flags = { "RESTRICT_HANDS" } } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { portions = { { encumbrance = 12, coverage = 0, covers = { "hand_l" } } } },
}

ccb.content.define_item {
    id = "pyrokinetic_fire_tool_six_arms",
    name = ccb.content.plural_text("[Ψ]banked flames", "[Ψ]banked flames"),
    copy_from = "pyrokinetic_fire_tool",
    inheritance = { remove = { flags = { "RESTRICT_HANDS" } } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { portions = { { encumbrance = 8, coverage = 0, covers = { "hand_l" } } } },
}

ccb.content.define_item {
    id = "pyrokinetic_fire_tool_eight_arms",
    name = ccb.content.plural_text("[Ψ]banked flames", "[Ψ]banked flames"),
    copy_from = "pyrokinetic_fire_tool",
    inheritance = { remove = { flags = { "RESTRICT_HANDS" } } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { portions = { { encumbrance = 5, coverage = 0, covers = { "hand_l" } } } },
}

ccb.content.define_item {
    id = "pyrokinetic_fire_tool",
    name = ccb.content.plural_text("[Ψ]banked flames", "[Ψ]banked flames"),
    description = "Dancing flames hovering over your hand.  You can use this to provide heat and light when necessary.",
    symbol = "$",
    color = "red",
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    light = 20,
    flags = {
        "PERSONAL",
        "PADDED",
        "UNBREAKABLE",
        "INTEGRATED",
        "RESTRICT_HANDS",
        "ZERO_WEIGHT",
        "MUNDANE",
        "FIRE",
        "NO_DROP",
    },
    qualities = {
        { id = "BLOW_HOT_AIR", level = 1 },
    },
    use_actions = {
        { kind = "firestarter", moves = 30 },
        "HOTPLATE",
    },
    tool = {},
    armor = {
        portions = {
            {
                covers = { "hand_l" },
                coverage = 0,
                encumbrance = 25,
            },
        },
    },
    artifact = {
        enchantments = { "pyrokinetic_banked_fire_damage_enchant" },
    },
    subtype_order = { "tool", "armor", "artifact" },
}
