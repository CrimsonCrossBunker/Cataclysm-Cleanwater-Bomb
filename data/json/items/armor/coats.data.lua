local ccb = require("ccb")

ccb.content.define_item {
    id = "jacket_jean",
    name = "jean jacket",
    description = "A jacket made from denim.",
    symbol = "[",
    color = "light_blue",
    looks_like = "jacket_windbreaker",
    mass = "800 g",
    volume = "3250 ml",
    price = "80 USD",
    survival_price = "7 USD 50 cent",
    snippet_category = {
        {
            id = "patchedjacket",
            text = "A jacket made from denim.  This one is haphazardly covered with patches featuring metal band logos.",
        },
        { id = "blackjacket", text = "A jacket made from denim, dyed black." },
        {
            id = "patterned",
            text = "A denim jacket ornamented with yellow filament patterns.",
        },
        {
            id = "old",
            text = "An old denim jacket.  It has wears in several places and has lost its blue color, but its overall integrity is preserved.",
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    materials = { "denim" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
    },
    armor = {
        thickness = 0.95,
        warmth = 15,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = { 8, 10 },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 8, 8 },
            },
        },
    },
}

ccb.content.define_item {
    id = "vest_jean",
    name = "jean vest",
    description = "A vest made from denim.",
    symbol = "[",
    color = "light_blue",
    looks_like = "vest_leather",
    mass = "600 g",
    volume = "2450 ml",
    price = "65 USD",
    survival_price = "5 USD",
    snippet_category = {
        {
            id = "patchedvest",
            text = "A vest made from denim.  This one is haphazardly covered with patches featuring metal band logos.",
        },
        { id = "blackvest", text = "A vest made from denim, dyed black." },
        {
            id = "stonewashed",
            text = "A stone washed blue vest made from denim.",
        },
        {
            id = "ripped",
            text = "A vest made from denim.  Its armholes have filament and torn fabric sticking out, as if someone just ripped the sleeves off.",
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    materials = { "denim" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
    },
    armor = {
        thickness = 0.95,
        warmth = 25,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = { 8, 10 },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
            },
        },
    },
}
