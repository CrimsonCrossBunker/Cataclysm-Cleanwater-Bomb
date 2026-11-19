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
