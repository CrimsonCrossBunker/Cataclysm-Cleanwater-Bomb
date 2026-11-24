local ccb = require("ccb")

ccb.content.define_item {
    id = "biokin_hammerhand_item",
    name = ccb.content.plural_text("[Ψ]hammerhand", "[Ψ]hammerhand"),
    description = ccb.content.text("You can perform many common handy tasks with your bare hands."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    symbol = "$",
    color = "pink",
    flags = {
        "UNBREAKABLE", "ZERO_WEIGHT", "ALLOWS_NATURAL_ATTACKS", "INTEGRATED", "PADDED", "OUTER",
        "SEMITANGIBLE", "WATER_FRIENDLY", "NO_DROP",
    },
    max_worn = 1,
    qualities = {
        { id = "WRENCH", level = 1 },
        { id = "SCREW", level = 1 },
        { id = "HAMMER", level = 3 },
        { id = "HAMMER_FINE", level = 1 },
        { id = "HAMMER_SOFT", level = 1 },
        { id = "CHISEL_WOOD", level = 1 },
        { id = "PRYING_NAIL", level = 1 },
        { id = "PRY", level = 2 },
    },
    melee_damage = { bash = 6 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { portions = { { encumbrance = 0, coverage = 0, covers = { "hand_l", "hand_r" } } } },
}

ccb.content.define_item {
    id = "clair_sense_rad_item",
    name = ccb.content.text("[Ψ]radiation sense"),
    description = ccb.content.text("You can see ambient radiation as a faint, sinister glow."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    survival_price = "0 cent",
    symbol = "[",
    color = "dark_gray",
    flags = { "RAD_DETECT", "PERSONAL", "ZERO_WEIGHT" },
    armor = {},
}

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

ccb.content.define_item {
    id = "integrated_photo_eyes",
    category = "armor",
    name = ccb.content.plural_text("photon regulation", "photon regulation"),
    description = ccb.content.text("With a little concentration, you can control the light your eyes accept.  Protects you from glare and welding arcs."),
    mass = "1 g",
    volume = "1 ml",
    materials = { "light" },
    symbol = "[",
    color = "yellow",
    qualities = { { id = "GLARE", level = 1 } },
    flags = {
        "INTEGRATED", "UNBREAKABLE", "SOFT", "WATER_FRIENDLY", "SUN_GLASSES", "NO_REPAIR", "NO_SALVAGE",
        "PERSONAL", "SEMITANGIBLE",
    },
    armor = {
        portions = {
            {
                materials = { { id = "light", coverage = 100, thickness = 0.1 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

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

ccb.content.define_item {
    id = "pyrokinetic_torch_weld",
    name = "[Ψ]incandescent lance",
    description = "A thin, searing beam, almost too bright to look at.  You can use this to weld or cut through things.",
    symbol = "$",
    color = "red",
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    light = 50,
    flags = {
        "PERSONAL",
        "PADDED",
        "UNBREAKABLE",
        "INTEGRATED",
        "SEMITANGIBLE",
        "ZERO_WEIGHT",
        "FIRE",
        "NO_DROP",
        "NO_UNLOAD",
        "NO_RELOAD",
    },
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { noetic_charge_power = 1 },
        },
    },
    qualities = {
        { id = "WELD", level = 2 },
    },
    use_actions = {
        { kind = "firestarter", moves = 10 },
        "OXYTORCH",
        {
            kind = "repair_item",
            id = "repair_metal",
            skill = "fabrication",
            tool_quality = 10,
            move_cost = 500,
            cost_scaling = 0,
            materials = {
                "iron",
                "steel",
                "aluminum",
                "copper",
                "bronze",
                "fancy_bronze",
                "silver",
                "gold",
                "budget_steel",
                "lc_steel",
                "mc_steel",
                "hc_steel",
                "ch_steel",
                "lc_steel_chain",
                "mc_steel_chain",
                "hc_steel_chain",
                "ch_steel_chain",
                "platinum",
                "superalloy",
            },
        },
    },
    tool = { charges_per_use = 0 },
    armor = {
        portions = {
            {
                covers = { "hand_l", "hand_r" },
                coverage = 0,
                encumbrance = 0,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "telekinetic_container_1",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "2 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_2",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "5 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_3",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "8 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_4",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "12 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_5",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "17 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_6",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "23 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_7",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "30 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_8",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "38 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_9",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "47 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_10",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "57 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_11",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "68 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_12",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "80 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_13",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "93 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_14",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "107 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_15",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "122 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_16",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "138 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_17",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "155 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_18",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "173 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_19",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "192 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_20",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "212 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_21",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "233 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_22",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "255 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_23",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "278 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_24",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "302 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_25",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "327 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_26",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "353 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_27",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "380 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_28",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "408 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_29",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "437 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekinetic_container_30",
    name = ccb.content.plural_text("[Ψ]lifting field", "[Ψ]lifting fields"),
    description = ccb.content.text("You can lift one thing with your powers, removing its effect on your encumbrance."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "telekinetic_force" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "yellow",
    flags = { "INTEGRATED", "UNBREAKABLE", "AURA", "NO_SALVAGE", "TARDIS", "ZERO_WEIGHT" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "10000  L",
            mass_limit = "467 kg",
            max_item_length = "2000 cm",
            moves = 10,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0,
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_1",
    looks_like = "jack_makeshift",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    description = ccb.content.text("Using your powers, you can lift up a vehicle just enough to allow you to change the wheels."),
    materials = { "telekinetic_force" },
    symbol = ";",
    color = "yellow",
    mass = "0 g",
    volume = "0 L",
    flags = { "ZERO_WEIGHT", "INTEGRATED", "UNBREAKABLE", "PERSONAL" },
    qualities = { { id = "JACK", level = 1 }, { id = "LIFT", level = 1 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_2",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 2 }, { id = "LIFT", level = 2 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_3",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 3 }, { id = "LIFT", level = 3 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_4",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 4 }, { id = "LIFT", level = 4 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_5",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 5 }, { id = "LIFT", level = 5 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_6",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 6 }, { id = "LIFT", level = 6 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_7",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 7 }, { id = "LIFT", level = 7 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_8",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 8 }, { id = "LIFT", level = 8 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_9",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 9 }, { id = "LIFT", level = 9 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_10",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 10 }, { id = "LIFT", level = 10 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_11",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 11 }, { id = "LIFT", level = 11 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_12",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 12 }, { id = "LIFT", level = 12 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_13",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 13 }, { id = "LIFT", level = 13 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_14",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 14 }, { id = "LIFT", level = 14 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_15",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 15 }, { id = "LIFT", level = 15 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_16",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 16 }, { id = "LIFT", level = 16 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_17",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 17 }, { id = "LIFT", level = 17 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_18",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 18 }, { id = "LIFT", level = 18 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_19",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 19 }, { id = "LIFT", level = 19 } },
    tool = {},
}

ccb.content.define_item {
    id = "telekin_lifting_jack_20",
    looks_like = "jack_makeshift",
    copy_from = "telekin_lifting_jack_1",
    name = ccb.content.plural_text("[Ψ]telekinetic jack", "[Ψ]telekinetic jacks"),
    qualities = { { id = "JACK", level = 20 }, { id = "LIFT", level = 20 } },
    tool = {},
}
