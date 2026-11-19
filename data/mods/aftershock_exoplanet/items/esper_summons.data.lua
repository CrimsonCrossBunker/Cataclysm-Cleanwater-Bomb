local ccb = require("ccb")

ccb.content.define_item {
    id = "electrokinetic_electrohack_1",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    mass = "0 g",
    volume = "0 ml",
    symbol = "=",
    color = "cyan",
    looks_like = "spiral_stone",
    flags = {
        "TRADER_AVOID", "NO_DROP", "PADDED", "PERSONAL", "UNBREAKABLE", "SEMITANGIBLE", "HACK_NO_CHARGE",
        "NO_SALVAGE", "ZERO_WEIGHT", "NO_UNLOAD", "NO_RELOAD", "INTEGRATED", "MAGICAL",
    },
    max_worn = 1,
    qualities = { { id = "HACK", level = 1 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_2",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 2 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_3",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 3 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_4",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 4 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_5",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}
