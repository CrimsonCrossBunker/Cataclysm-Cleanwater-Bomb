local ccb = require("ccb")

--  stats taken from: https://www.patriotoutfitters.com/5-11-tactical-molle-radio-pouch?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "radio_pouch",
    name = ccb.content.plural_text("tactical radio pouch", "tactical radio pouches"),
    description = ccb.content.text("A pouch designed to keep your radio accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "200 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "13 cm",
            moves = 40,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "OVERSIZE", "PALS_SMALL" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-gadget-pouch-tan498-?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "gadget_pouch",
    name = ccb.content.plural_text("gadget pouch", "gadget pouches"),
    description = ccb.content.text("A pouch designed to keep gadgets and small items accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "250 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-h2o-pouch?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "h2o_pouch",
    name = ccb.content.plural_text("H2O pouch", "H2O pouches"),
    description = ccb.content.text("A pouch designed to hold a water bottle with an additional front tactical pocket.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "250 g",
    volume = "400 ml",
    price = "20 USD",
    survival_price = "4 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2048 ml",
            mass_limit = "5 kg",
            max_item_length = "254 mm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            capacity = "426 ml",
            mass_limit = "3 kg",
            max_item_length = "165 mm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

ccb.content.define_item {
    id = "canteen_pouch",
    name = ccb.content.plural_text("canteen pouch", "canteen pouches"),
    description = ccb.content.text("A pouch designed to keep your canteen accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "190 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "4 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "1751 ml",
            mass_limit = "3800 g",
            max_item_length = "23 cm",
            moves = 40,
            volume_encumbrance = 0.2,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-t-and-t-pouch?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "tool_pouch",
    name = ccb.content.plural_text("tactical tool pouch", "tactical tool pouches"),
    description = ccb.content.text("A low profile pouch designed to keep your tools accessible and secure.  Has MOLLE straps for attaching to a vest or can be strapped directly to your chest."),
    mass = "250 g",
    volume = "250 ml",
    price = "30 USD",
    survival_price = "6 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2753 ml",
            mass_limit = "8 kg",
            max_item_length = "305 mm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 10, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-flashlight-pouch?PMSRCH=MOLLE%20GEAR liberties were taken with this one so it would hold either flashlight
ccb.content.define_item {
    id = "flashlight_pouch",
    name = ccb.content.plural_text("flashlight pouch", "flashlight pouches"),
    description = ccb.content.text("A tiny pouch designed to keep your flashlight accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "37 cm",
            moves = 40,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}
