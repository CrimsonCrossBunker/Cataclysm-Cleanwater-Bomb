local ccb = require("ccb")

ccb.content.define_item {
    id = "pen",
    category = "tools",
    name = ccb.content.plural_text("pen", "pens"),
    description = ccb.content.text("A fine metal pen, of much better quality than a disposable model."),
    mass = "9 g",
    volume = "40 ml",
    length = "13 cm",
    price = "1 USD",
    survival_price = "15 cent",
    materials = { "steel" },
    symbol = ";",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { black_pen_ink = 100, blue_pen_ink = 100, red_pen_ink = 100, green_pen_ink = 100 },
            watertight = true,
            rigid = true,
        },
    },
    flags = { "FRAGILE_MELEE", "WRITE_MESSAGE", "ALLOWS_BODY_BLOCK" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = false,
            material_restricted = false,
        },
    },
}

ccb.content.define_item {
    id = "pencil",
    name = ccb.content.plural_text("pencil", "pencils"),
    description = ccb.content.text("A sharpened HB Number 2 graphite pencil, equipped with an eraser."),
    mass = "9 g",
    volume = "40 ml",
    length = "13 cm",
    price = "15 cent",
    survival_price = "10 cent",
    materials = { "wood" },
    symbol = "!",
    color = "yellow",
    looks_like = "survival_marker",
    flags = { "FRAGILE_MELEE", "WRITE_MESSAGE", "NO_RELOAD", "NO_UNLOAD", "ALLOWS_BODY_BLOCK" },
    tool = {},
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = false,
            material_restricted = false,
        },
    },
}

ccb.content.define_item {
    id = "black_pen",
    name = ccb.content.plural_text("black pen", "black pens"),
    description = ccb.content.text("A disposable ballpoint pen, offers a smooth writing experience on paper.  Has the same logo as those disposable lighters.  This one is black."),
    mass = "9 g",
    volume = "40 ml",
    length = "13 cm",
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "!",
    color = "dark_gray",
    looks_like = "pen",
    pockets = { { kind = "MAGAZINE", ammunition = { black_pen_ink = 100 }, watertight = true, rigid = true } },
    flags = { "FRAGILE_MELEE", "WRITE_MESSAGE", "NO_RELOAD", "ALLOWS_BODY_BLOCK" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = false,
            material_restricted = false,
        },
    },
}

ccb.content.define_item {
    id = "blue_pen",
    name = ccb.content.plural_text("blue pen", "blue pens"),
    description = ccb.content.text("A disposable ballpoint pen, offers a smooth writing experience on paper.  Has the same logo as those disposable lighters.  This one is blue."),
    mass = "9 g",
    volume = "40 ml",
    length = "13 cm",
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "!",
    color = "blue",
    looks_like = "pen",
    pockets = { { kind = "MAGAZINE", ammunition = { blue_pen_ink = 100 }, watertight = true, rigid = true } },
    flags = { "FRAGILE_MELEE", "WRITE_MESSAGE", "NO_RELOAD", "ALLOWS_BODY_BLOCK" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = false,
            material_restricted = false,
        },
    },
}

ccb.content.define_item {
    id = "red_pen",
    name = ccb.content.plural_text("red pen", "red pens"),
    description = ccb.content.text("A disposable ballpoint pen, offers a smooth writing experience on paper.  Has the same logo as those disposable lighters.  This one is red."),
    mass = "9 g",
    volume = "40 ml",
    length = "13 cm",
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "!",
    color = "red",
    looks_like = "pen",
    pockets = { { kind = "MAGAZINE", ammunition = { red_pen_ink = 100 }, watertight = true, rigid = true } },
    flags = { "FRAGILE_MELEE", "WRITE_MESSAGE", "NO_RELOAD", "ALLOWS_BODY_BLOCK" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = false,
            material_restricted = false,
        },
    },
}

ccb.content.define_item {
    id = "green_pen",
    name = ccb.content.plural_text("green pen", "green pens"),
    description = ccb.content.text("A disposable ballpoint pen, offers a smooth writing experience on paper.  Has the same logo as those disposable lighters.  This one is green."),
    mass = "9 g",
    volume = "40 ml",
    length = "13 cm",
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "!",
    color = "green",
    looks_like = "pen",
    pockets = { { kind = "MAGAZINE", ammunition = { green_pen_ink = 100 }, watertight = true, rigid = true } },
    flags = { "FRAGILE_MELEE", "WRITE_MESSAGE", "NO_RELOAD", "ALLOWS_BODY_BLOCK" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = false,
            material_restricted = false,
        },
    },
}

-- Binding
ccb.content.define_item {
    id = "leather_journal",
    category = "tools",
    name = ccb.content.plural_text("leather journal", "leather journals"),
    looks_like = "book_nonf_soft_psych_cggamers",
    description = ccb.content.text("A leather-back journal for preserving notes and maps, has a strap to keep loose pages contained."),
    volume = "300 ml",
    mass = "80 g",
    flags = { "TRADER_AVOID" },
    materials = { "leather" },
    symbol = "*",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = false,
            mass_limit = "2 kg",
            capacity = "2500 ml",
            max_item_length = "300 mm",
            moves = 150,
            allowed_flags = { "PAPER_SHAPED" },
        },
    },
    tool = {},
}
