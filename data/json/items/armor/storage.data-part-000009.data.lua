local ccb = require("ccb")

-- based on the condor deployment bag and it's derivatives, holds 6.4L and has dimensions 6in H x 5.5in D x 12in W, max item lengths determined by approximating a little less based on dimensions
ccb.content.define_item {
    id = "deployment_bag",
    name = ccb.content.text("deployment bag"),
    description = ccb.content.text("A durable nylon bag marketed towards military personnel.  It has clips on the top and back, making it easy to attach a strap and wear it comfortably as a fanny pack.  MOLLE webbing on the back lets you affix it to body armor or a backpack."),
    mass = "480 g",
    volume = "300 ml",
    price = "35 USD",
    survival_price = "5 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "fanny",
    color = "green",
    pockets = {
        {
            description = ccb.content.text("Center pocket."),
            kind = "CONTAINER",
            capacity = "3400 ml",
            mass_limit = "6 kg",
            max_item_length = "25 cm",
            moves = 100,
        },
        {
            description = ccb.content.text("Front pocket."),
            kind = "CONTAINER",
            capacity = "1800 ml",
            mass_limit = "6 kg",
            max_item_length = "22 cm",
            moves = 100,
        },
        {
            description = ccb.content.text("Side pocket."),
            kind = "CONTAINER",
            capacity = "600 ml",
            mass_limit = "6 kg",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            description = ccb.content.text("Side pocket."),
            kind = "CONTAINER",
            capacity = "600 ml",
            mass_limit = "6 kg",
            max_item_length = "15 cm",
            moves = 100,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "PALS_LARGE" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 2,
                volume_encumbrance = 0.3,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}

ccb.content.define_item {
    id = "dive_bag",
    name = ccb.content.text("dive bag"),
    description = ccb.content.text("A lightweight mesh backpack, commonly worn by swimmers and divers."),
    mass = "512 g",
    volume = "1500 ml",
    price = "109 USD",
    survival_price = "5 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "backpack",
    color = "yellow",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "30 L",
            mass_limit = "24 kg",
            max_item_length = "70 cm",
            moves = 300,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 2,
                volume_encumbrance = 0.19,
                coverage = 80,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- based on KastKing Regular Cyclone Seal Dry Bag
ccb.content.define_item {
    id = "dry_bag",
    repair_like = "backpack",
    name = ccb.content.text("dry bag"),
    description = ccb.content.text("A lightweight watertight backpack, commonly worn by swimmers and divers."),
    mass = "580 g",
    volume = "1750 ml",
    price = "139 USD",
    survival_price = "10 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "dive_bag",
    color = "blue",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "30 L",
            mass_limit = "30 kg",
            max_item_length = "70 cm",
            watertight = true,
            moves = 450,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 2,
                volume_encumbrance = 0.19,
                coverage = 80,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- items slipped under the top of a duffelbag not well secured
ccb.content.define_item {
    id = "duffelbag",
    name = ccb.content.text("duffel bag"),
    description = ccb.content.text("A canvas duffel bag.  Provides plenty of storage, but is fairly encumbering."),
    mass = "933 g",
    volume = "6 L",
    price = "120 USD",
    survival_price = "5 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "rucksack",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "60 L",
            mass_limit = "60 kg",
            max_item_length = "55 cm",
            magazine_well = "5 L",
            moves = 300,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "4 L",
            mass_limit = "6 kg",
            max_item_length = "100 cm",
            min_item_length = "40 cm",
            moves = 80,
            extra_encumbrance = 5,
            description = ccb.content.text("Tucked under the carry handles."),
            ripoff = 1,
            transparent = true,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        thickness = 1,
        portions = {
            {
                encumbrance = 5,
                volume_encumbrance = 0.25,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- based on Aonyx 60 Waterproof Duffel Bag
-- items slipped under the top of a duffelbag not well secured
ccb.content.define_item {
    id = "dry_duffelbag",
    name = ccb.content.text("dry duffel bag"),
    description = ccb.content.text("A huge watertight duffel bag.  Capable of floating.  Provides plenty of storage, but is severely encumbering."),
    mass = "1300 g",
    volume = "10500 ml",
    price = "180 USD",
    survival_price = "10 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "duffelbag",
    color = "blue",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "60 L",
            mass_limit = "90 kg",
            max_item_length = "65 cm",
            watertight = true,
            magazine_well = "5 L",
            moves = 450,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "4 L",
            mass_limit = "6 kg",
            max_item_length = "100 cm",
            min_item_length = "40 cm",
            moves = 80,
            extra_encumbrance = 5,
            description = ccb.content.text("Tucked under the carry handles."),
            ripoff = 1,
            transparent = true,
        },
    },
    flags = { "FLOTATION", "BELTED", "WATER_FRIENDLY", "OVERSIZE" },
    armor = {
        warmth = 10,
        thickness = 1,
        portions = {
            {
                encumbrance = 10,
                volume_encumbrance = 0.25,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "dump_pouch",
    name = ccb.content.plural_text("tactical dump pouch", "tactical dump pouches"),
    description = ccb.content.text("An expandable pouch secured with straps.  Provides a bit of extra storage with minimal encumbrance."),
    mass = "288 g",
    volume = "525 ml",
    price = "45 USD",
    survival_price = "2 USD 50 cent",
    materials = { "nylon", "plastic" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2 L",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            magazine_well = "500 ml",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

ccb.content.define_item {
    id = "fanny",
    name = ccb.content.text("fanny pack"),
    description = ccb.content.text("A small fabric bag worn on the waist, with the pouch in front for easy access.  Once used as a visual shorthand for unstylish geeks and silly tourists, it was making a decent comeback before the apocalypse."),
    mass = "272 g",
    volume = "1050 ml",
    price = "35 USD",
    survival_price = "1 USD",
    materials = { "nylon", "plastic" },
    symbol = "[",
    looks_like = "holster",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2500 ml",
            mass_limit = "5 kg",
            max_item_length = "25 cm",
            magazine_well = "1 L",
            moves = 80,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "OVERSIZE" },
    armor = {
        thickness = 0.1,
        portions = {
            {
                encumbrance = 1,
                volume_encumbrance = 0.3,
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}
