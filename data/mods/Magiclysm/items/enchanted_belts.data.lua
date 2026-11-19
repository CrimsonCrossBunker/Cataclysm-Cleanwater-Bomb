local ccb = require("ccb")

ccb.content.define_item {
    id = "mbelt_pockets_lesser",
    copy_from = "mbelt_leather",
    name = ccb.content.plural_text("lesser dimensional toolbelt", "lesser dimensional toolbelts"),
    description = ccb.content.text("A sturdy workman's belt that fits around your waist, covered in easy to access pouches.  Like all dimensional spaces, they hold more than they should with a fair weight reduction."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "3 L",
            mass_limit = "9 kg",
            max_item_length = "70 cm",
            moves = 90,
            weight_multiplier = 0.5,
            volume_multiplier = 0.35,
        },
        {
            kind = "CONTAINER",
            capacity = "3 L",
            mass_limit = "9 kg",
            max_item_length = "70 cm",
            moves = 90,
            weight_multiplier = 0.5,
            volume_multiplier = 0.35,
        },
        {
            kind = "CONTAINER",
            capacity = "3 L",
            mass_limit = "9 kg",
            max_item_length = "70 cm",
            moves = 90,
            weight_multiplier = 0.5,
            volume_multiplier = 0.35,
        },
        {
            kind = "CONTAINER",
            capacity = "3 L",
            mass_limit = "9 kg",
            max_item_length = "70 cm",
            moves = 90,
            weight_multiplier = 0.5,
            volume_multiplier = 0.35,
        },
    },
    materials = { "leather" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                encumbrance = { 4, 10 },
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
}

ccb.content.define_item {
    id = "mbelt_pockets_greater",
    copy_from = "mbelt_leather",
    name = ccb.content.plural_text("greater dimensional toolbelt", "greater dimensional toolbelts"),
    description = ccb.content.text("A heavy-duty workman's belt that fits around your waist, covered in easy to access pouches.  Like all dimensional spaces, they hold far more than they should with a substantial weight reduction."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "12 kg",
            max_item_length = "125 cm",
            moves = 80,
            weight_multiplier = 0.3,
            volume_multiplier = 0.2,
        },
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "12 kg",
            max_item_length = "125 cm",
            moves = 80,
            weight_multiplier = 0.3,
            volume_multiplier = 0.2,
        },
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "12 kg",
            max_item_length = "125 cm",
            moves = 80,
            weight_multiplier = 0.3,
            volume_multiplier = 0.2,
        },
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "12 kg",
            max_item_length = "125 cm",
            moves = 80,
            weight_multiplier = 0.3,
            volume_multiplier = 0.2,
        },
    },
    materials = { "leather" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                encumbrance = { 6, 8 },
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
}

ccb.content.define_item {
    id = "mbelt_weaponry",
    copy_from = "mbelt_leather",
    name = ccb.content.plural_text("Belt of Weaponry", "Belts of Weaponry"),
    description = ccb.content.text("A wide girdle that fits around your waist, you can sheath or holster any weapon into it in the blink of an eye, and it seemingly stores them somewhere else."),
    pockets = {
        {
            holster = true,
            moves = 5,
            capacity = "4 L",
            mass_limit = "2500 g",
            max_item_length = "125 cm",
            weight_multiplier = 0.0,
        },
        {
            holster = true,
            moves = 5,
            capacity = "4 L",
            mass_limit = "2500 g",
            max_item_length = "125 cm",
            weight_multiplier = 0.0,
        },
        {
            holster = true,
            moves = 5,
            capacity = "4 L",
            mass_limit = "2500 g",
            max_item_length = "125 cm",
            weight_multiplier = 0.0,
        },
        {
            holster = true,
            moves = 5,
            capacity = "4 L",
            mass_limit = "2500 g",
            max_item_length = "125 cm",
            weight_multiplier = 0.0,
        },
    },
    materials = { "leather" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                encumbrance = { 3, 3 },
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stick what into your belt"),
            message = ccb.content.text("You tuck your %s into your %s"),
        },
    },
}

ccb.content.define_item {
    id = "mbelt_technomancer_toolbelt",
    name = ccb.content.plural_text("technomancer's toolbelt", "technomancer's toolbelts"),
    mass = "2000 g",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "3 kg",
            max_item_length = "70 cm",
            moves = 2,
            holster = true,
        },
    },
    symbol = "[",
    description = ccb.content.text("A custom-built leather utility belt that instantly creates any tool that you reach for.  Activate to sheathe/draw a weapon."),
    price = "5 kUSD",
    materials = { "leather", "steel" },
    volume = "4 L",
    flags = { "VARSIZE", "WATER_FRIENDLY", "STURDY", "BELTED", "OVERSIZE" },
    qualities = {
        { id = "HAMMER", level = 3 },
        { id = "PRY", level = 1 },
        { id = "SAW_M", level = 2 },
        { id = "SAW_W", level = 2 },
        { id = "WRENCH", level = 2 },
        { id = "AXE", level = 1 },
        { id = "SCREW", level = 1 },
        { id = "HAMMER_FINE", level = 1 },
        { id = "SAW_M_FINE", level = 1 },
        { id = "WRENCH_FINE", level = 1 },
        { id = "SCREW_FINE", level = 1 },
    },
    armor = {
        thickness = 4,
        portions = { { encumbrance = 4, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheath blade"),
            message = ccb.content.text("You sheath your %s"),
        },
        "CROWBAR",
    },
}

ccb.content.define_item {
    id = "mbelt_iron_whip",
    copy_from = "mbelt_leather",
    name = ccb.content.plural_text("Belt of The Iron Whip", "Belts of the Iron Whip"),
    volume = "1 L",
    materials = { "steel" },
    description = ccb.content.text("A braided but flexible belt seemingly made of metal.  You can activate it to transform it into a whip and flay your enemies."),
    flags = { "STURDY", "BELTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { thickness = 4 },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Extend"),
            target = "mwhip_iron",
            moves = 20,
            message = ccb.content.text("You grab the belt and it uncoils to become a flexible metal whip in your hand!"),
        },
    },
}
