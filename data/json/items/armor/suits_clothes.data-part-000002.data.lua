local ccb = require("ccb")

-- delete jumpsuit variants
ccb.content.define_item {
    id = "flag_jumpsuit",
    copy_from = "jumpsuit",
    name = ccb.content.text("flag jumpsuit"),
    description = ccb.content.text("A jumpsuit embroidered with a pattern of the American flag.  Provides decent storage and is not very encumbering."),
    variants = {},
    color = "light_red",
    armor = {},
    inheritance = { add = { flags = { "HOOD", "COSPLAY_COSTUME" } }, offset = { mass = "50 g" } },
}

ccb.content.define_item {
    id = "jumpsuit_pocketless",
    name = ccb.content.text("pocketless jumpsuit"),
    description = ccb.content.text("A thin, short-sleeved jumpsuit without pockets, similar to those worn by prisoners.  Not very encumbering."),
    mass = "610 g",
    volume = "3500 ml",
    price = "89 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "jumpsuit",
    flags = { "VARSIZE" },
    variant_kind = "generic",
    variants = {
        {
            id = "white",
            name = ccb.content.text("white jumpsuit"),
            append = true,
            description = ccb.content.text("This one is white."),
            color = "white",
        },
        {
            id = "orange",
            name = ccb.content.text("orange jumpsuit"),
            append = true,
            description = ccb.content.text("This one is orange."),
            color = "yellow",
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 1, 2 } },
            { covers = { "arm_l", "arm_r" }, coverage = 50, encumbrance = { 1, 1 } },
            { covers = { "leg_l", "leg_r" }, coverage = 80, encumbrance = { 1, 2 } },
        },
        warmth = 15,
        thickness = 0.2,
    },
}

ccb.content.define_item {
    id = "jumpsuit",
    copy_from = "jumpsuit_pocketless",
    name = ccb.content.text("jumpsuit"),
    description = ccb.content.text("A thin, short-sleeved jumpsuit similar to those worn by prisoners.  Provides decent storage and is not very encumbering."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "700 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "700 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            max_item_length = "10 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            max_item_length = "10 cm",
            moves = 100,
        },
    },
    variant_kind = "generic",
    variants = {
        {
            id = "white",
            name = ccb.content.text("white jumpsuit"),
            append = true,
            description = ccb.content.text("This one is white."),
            color = "white",
        },
        {
            id = "green",
            name = ccb.content.text("green jumpsuit"),
            append = true,
            description = ccb.content.text("This one is green."),
            color = "green",
        },
        {
            id = "robofac",
            name = ccb.content.text("Hub 01 jumpsuit"),
            description = ccb.content.text("A brown jumpsuit worn by the staff of Hub 01."),
            color = "brown",
            weight = 0,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "POCKETS" } } },
}

ccb.content.define_item {
    id = "jumpsuit_xl",
    name = ccb.content.text("jumpsuit"),
    description = ccb.content.text("A thin, short-sleeved jumpsuit updated for the trans-human who needs full-body clothing.  Provides some storage and is adjustable to minimize encumbrance."),
    mass = "810 g",
    volume = "5 L",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "yellow",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "3 kg",
            max_item_length = "18 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "3 kg",
            max_item_length = "18 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            max_item_length = "10 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            max_item_length = "10 cm",
            moves = 100,
        },
    },
    flags = { "POCKETS", "OVERSIZE", "PREFIX_XL" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 1, 2 } },
            { covers = { "arm_l", "arm_r" }, coverage = 50, encumbrance = { 1, 1 } },
            { covers = { "leg_l", "leg_r" }, coverage = 80, encumbrance = { 1, 2 } },
        },
        warmth = 15,
        thickness = 1,
    },
}

-- delete jumpsuit variants
ccb.content.define_item {
    id = "jumpsuit_xs",
    copy_from = "jumpsuit",
    name = ccb.content.text("jumpsuit"),
    description = ccb.content.text("A thin, short-sleeved jumpsuit similar to those worn by prisoners.  Provides decent storage and is not very encumbering."),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
