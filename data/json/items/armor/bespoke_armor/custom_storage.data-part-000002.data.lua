local ccb = require("ccb")

-- Slightly lower encumbrance per volume as the base item is much more encumbering.  At max storage it still is more encumbering than the original item, but the difference is smaller than when empty.
ccb.content.define_item {
    id = "survivor_runner_pack",
    name = ccb.content.text("armored runner pack"),
    description = ccb.content.text("A small backpack armored with leather and fabric to make it resistant to being torn up by zombies.  Bulkier, but sturdier."),
    mass = "440 g",
    volume = "4200 ml",
    price = "240 USD",
    survival_price = "25 USD",
    materials = { "leather", "canvas" },
    symbol = "[",
    looks_like = "backpack",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "20 L",
            mass_limit = "16 kg",
            max_item_length = "40 cm",
            magazine_well = "4 L",
            moves = 250,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED" },
    armor = {
        warmth = 2,
        thickness = 2,
        portions = {
            {
                encumbrance = { 3, 12 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- custom-made, but the design is inspired by GVANCA Waterproof Dry Bag Backpack and Lee Valley Waterproof Dry Bag Backpack
-- Slightly lower encumbrance per volume as the base item is much more encumbering.  At max storage it still is more encumbering than the original item, but the difference is smaller than when empty.
-- water bottle pocket
-- water bottle pocket
-- dedicated tool loops. either a daisy chain, hooking to compression straps, or ice axe loop
-- dedicated tool loops. either a daisy chain, hooking to compression straps, or ice axe loop
ccb.content.define_item {
    id = "survivor_dry_bag",
    name = ccb.content.text("armored dry bag"),
    description = ccb.content.text("A reinforced waterproof backpack.  It's sturdier than before, but a little bulkier."),
    mass = "620 g",
    volume = "1850 ml",
    price = "300 USD",
    survival_price = "15 USD",
    materials = { "nylon", "plastic" },
    symbol = "[",
    looks_like = "dry_bag",
    color = "blue",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "35 L",
            mass_limit = "35 kg",
            max_item_length = "70 cm",
            watertight = true,
            moves = 450,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "510 ml",
            mass_limit = "1 kg",
            max_item_length = "24 cm",
            min_item_length = "18 cm",
            moves = 80,
            description = ccb.content.text("Small pocket for a water bottle."),
            ripoff = 2,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "510 ml",
            mass_limit = "1 kg",
            max_item_length = "24 cm",
            min_item_length = "18 cm",
            moves = 80,
            description = ccb.content.text("Small pocket for a water bottle."),
            ripoff = 2,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "4 L",
            mass_limit = "6 kg",
            max_item_length = "100 cm",
            min_item_length = "40 cm",
            moves = 300,
            extra_encumbrance = 1,
            description = ccb.content.text("Secured under compression straps or with a tool loop."),
            ripoff = 5,
            transparent = true,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "4 L",
            mass_limit = "6 kg",
            max_item_length = "100 cm",
            min_item_length = "40 cm",
            moves = 300,
            extra_encumbrance = 1,
            description = ccb.content.text("Secured under compression straps or with a tool loop."),
            ripoff = 5,
            transparent = true,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "15 cm",
            description = ccb.content.text("Small splashproof outer pocket."),
            moves = 250,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED", "OVERSIZE" },
    armor = {
        thickness = 2,
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

ccb.content.define_item {
    id = "survivor_rig",
    name = ccb.content.text("handmade distributed rigging"),
    description = ccb.content.text("A custom-built lightweight set of weight distributing pouches on the thighs and stomach.  This configuration is designed to be worn with a military harness or tactical vest."),
    mass = "440 g",
    volume = "3000 ml",
    price = "240 USD",
    survival_price = "25 USD",
    materials = { "nylon", "leather" },
    symbol = "[",
    looks_like = "legrig",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2 L",
            mass_limit = "6 kg",
            moves = 80,
            max_item_length = "30 cm",
            description = ccb.content.text("Upper leg pouch."),
        },
        {
            kind = "CONTAINER",
            capacity = "2 L",
            mass_limit = "6 kg",
            moves = 80,
            max_item_length = "30 cm",
            description = ccb.content.text("Upper leg pouch."),
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "3 kg",
            moves = 120,
            description = ccb.content.text("Tactical fanny pack."),
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "3 kg",
            moves = 200,
            description = ccb.content.text("Back tactical fanny pack."),
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED" },
    armor = {
        warmth = 1,
        thickness = 2,
        portions = {
            {
                encumbrance = { 1, 3 },
                coverage = 80,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
            {
                encumbrance = { 1, 3 },
                coverage = 70,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}
