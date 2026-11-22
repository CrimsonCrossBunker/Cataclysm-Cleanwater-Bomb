local ccb = require("ccb")

ccb.content.define_item {
    id = "jeans_vintage",
    name = ccb.content.plural_text("vintage jeans", "vintage jeans"),
    description = "A pair of vintage jeans that has started to lose its color.  It appears to be slightly heavier and thicker; but hey, don't let that stop you from wearing the fashion of the olden days!",
    symbol = "[",
    color = "light_blue",
    looks_like = "jeans",
    mass = "700 g",
    volume = "2 L",
    price = "115 USD",
    survival_price = "2 USD 50 cent",
    snippet_category = {
        {
            id = "vintage_jeans1",
            text = "A pair of vintage jeans that has been around for so long that very little remains of its once vibrant blue color.  Otherwise it's surprisingly well preserved though.",
        },
        {
            id = "vintage_jeans2",
            text = "A very old pair of black vintage jeans.  From paint marks here and there you assume this belonged to a painter.",
        },
        {
            id = "vintage_jeans3",
            text = "A groovy pair of stone washed denim jeans from the 80s.  It gets baggy around the ankles.  Perfect for pretending as if Cataclysm never happened and you are on your way to dance floor.",
        },
        {
            id = "vintage_jeans4",
            text = "A pair of vintage blue jeans that has been preserved perfectly.  You can see the leather brand on its behind of company that hasn't been around for a long while, even before the Cataclysm.  This would have made a fortune if; well, you know, it wasn't apocalypse.",
        },
    },
    flags = { "VARSIZE", "POCKETS" },
    materials = { "denim" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "5 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "5 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    faults = {
        { group = "fabric_denim" },
    },
    armor = {
        thickness = 0.8,
        warmth = 15,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 8, 12 },
            },
        },
    },
}

ccb.content.define_item {
    id = "jeans_skinny",
    name = ccb.content.plural_text("skinny jeans", "skinny jeans"),
    description = "A pair of skinny jeans with four pockets.",
    symbol = "[",
    color = "light_blue",
    looks_like = "jeans",
    mass = "500 g",
    volume = "1300 ml",
    price = "50 USD",
    survival_price = "50 cent",
    snippet_category = {
        {
            id = "jeans_skinny1",
            text = "A pair of blue skinny jeans with four pockets.",
        },
        {
            id = "jeans_skinny2",
            text = "A pair of black skinny jeans with four pockets.",
        },
        {
            id = "jeans_skinny3",
            text = "A pair of red skinny jeans with four pockets.",
        },
    },
    flags = { "VARSIZE", "POCKETS" },
    materials = { "denim" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "10 cm",
            moves = 60,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "10 cm",
            moves = 60,
        },
        {
            kind = "CONTAINER",
            capacity = "680 ml",
            mass_limit = "2 kg",
            max_item_length = "8 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "680 ml",
            mass_limit = "2 kg",
            max_item_length = "8 cm",
            moves = 80,
        },
    },
    faults = {
        { group = "fabric_denim" },
    },
    armor = {
        thickness = 0.52,
        warmth = 6,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 5, 7 },
            },
        },
    },
}
