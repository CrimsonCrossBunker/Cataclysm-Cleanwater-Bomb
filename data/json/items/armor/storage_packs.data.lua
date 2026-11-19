local ccb = require("ccb")

-- inherit name and description from item
ccb.content.define_item {
    id = "backpack_small",
    name = ccb.content.text("small backpack"),
    description = ccb.content.text("A little <color> backpack, probably sized for a kid."),
    expand_snippets = true,
    mass = "333 g",
    volume = "2 L",
    price = "19 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            magazine_well = "750 ml",
            capacity = "12 L",
            mass_limit = "30 kg",
            max_item_length = "40 cm",
            moves = 300,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 300,
            description = ccb.content.text("A zipper pocket, meant for pens and pencils."),
        },
    },
    flags = { "BELTED" },
    variants = {
        { id = "color", weight = 17 },
        {
            id = "boy",
            name = ccb.content.text("boy's backpack"),
            description = ccb.content.text("A boy's backpack.  <boy_brand>"),
            expand_snippets = true,
        },
        {
            id = "girl",
            name = ccb.content.text("girl's backpack"),
            description = ccb.content.text("A girl's backpack.  <girl_brand>"),
            expand_snippets = true,
        },
        {
            id = "kid",
            name = ccb.content.text("kid's backpack"),
            description = ccb.content.text("A kid's backpack.  <kid_brand>"),
            expand_snippets = true,
        },
    },
    armor = {
        warmth = 6,
        thickness = 2,
        portions = {
            {
                encumbrance = 2,
                volume_encumbrance = 0.25,
                coverage = 40,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}
