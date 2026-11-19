local ccb = require("ccb")

ccb.content.define_item {
    id = "item_clair_astral_projection_cord",
    name = ccb.content.plural_text("[Ψ]silver cord", "[Ψ]silver cord"),
    description = ccb.content.text("A thin silver cord, stretching off into the distance, connecting you to your body.  You could follow it back to return."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    symbol = "[",
    color = "light_gray",
    flags = {
        "PERSONAL", "UNBREAKABLE", "ZERO_WEIGHT", "ALLOWS_NATURAL_ATTACKS", "INTEGRATED", "PADDED",
        "SEMITANGIBLE", "WATER_FRIENDLY", "NO_DROP",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { environmental_protection = 0 },
}

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
        "TRADER_AVOID", "NO_DROP", "PADDED", "PERSONAL", "UNBREAKABLE", "SEMITANGIBLE", "NO_SALVAGE",
        "ZERO_WEIGHT", "NO_UNLOAD", "NO_RELOAD", "INTEGRATED", "MAGICAL",
    },
    max_worn = 1,
    qualities = { { id = "HACK", level = 0 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_2",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 1 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_3",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 2 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_4",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 3 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_5",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 4 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_6",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_7",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 6 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_8",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 7 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_9",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 8 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_10",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 9 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_11",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 10 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "electrokinetic_electrohack_12",
    name = ccb.content.plural_text("[Ψ]hacking interface", "[Ψ]hacking interfaces"),
    description = ccb.content.text("You can hack nearby devices."),
    copy_from = "electrokinetic_electrohack_1",
    qualities = { { id = "HACK", level = 11 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "item_photokinetic_radio",
    name = ccb.content.plural_text("[Ψ]radio sense (speaking)", "[Ψ]radio sense (speaking)"),
    description = ccb.content.text("Your powers allow you to communicate by radio waves.  With a moment's concentration, you may instead scan for radio signals."),
    mass = "0 g",
    volume = "0 ml",
    symbol = ";",
    color = "yellow",
    flags = {
        "TWO_WAY_RADIO", "UNBREAKABLE", "PERSONAL", "TRADER_AVOID", "ZERO_WEIGHT", "SEMITANGIBLE",
        "NO_DROP", "INTEGRATED", "PADDED",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            target = "item_photokinetic_radio_on",
            menu_text = ccb.content.text("Switch to scanning mode"),
        },
    },
}

ccb.content.define_item {
    id = "item_photokinetic_radio_on",
    copy_from = "item_photokinetic_radio",
    name = ccb.content.plural_text("[Ψ]radio sense (scanning)", "[Ψ]radio sense (scanning)"),
    description = ccb.content.text("Your powers allow you to listen for radio signals from the surrounding area.  With a moment's concentration, you may change frequency or switch to communicating by radio."),
    flags = {
        "TRADER_AVOID", "UNBREAKABLE", "PERSONAL", "SEMITANGIBLE", "ZERO_WEIGHT", "NO_DROP",
        "INTEGRATED", "PADDED",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        "RADIO_ON",
        {
            kind = "transform",
            target = "item_photokinetic_radio",
            menu_text = ccb.content.text("Switch to speaking mode"),
        },
    },
    tick_actions = { "RADIO_TICK" },
}
