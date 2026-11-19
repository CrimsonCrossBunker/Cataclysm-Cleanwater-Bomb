local ccb = require("ccb")

ccb.content.define_item {
    id = "silver_hair_beads",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.plural_text("silver hair beads", "sets of silver hair beads"),
    description = ccb.content.text("An assortment of shiny silver beads used to decorate locs or braids."),
    mass = "10 g",
    volume = "20 ml",
    materials = { "silver" },
    symbol = ".",
    color = "white",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "necklace_teeth",
    name = ccb.content.text("teeth necklace"),
    description = ccb.content.text("A simple teeth necklace, this is sure to add some bite to an outfit."),
    symbol = "u",
    color = "white",
    price = "10 USD",
    survival_price = "10 cent",
    mass = "42 g",
    volume = "30 ml",
    materials = { "bone" },
    flags = { "NO_WEAR_EFFECT", "BELTED" },
    variants = {
        {
            id = "necklace_teeth_monster",
            name = ccb.content.text("monster teeth necklace"),
            description = ccb.content.text("The teeth hanging from this one look alien, with a hypnotizing, iridescent shine."),
            append = true,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "devil_horn_headband",
    name = ccb.content.plural_text("devil horns (pair)", "devil horns (pair)"),
    description = ccb.content.text("A red plastic headband adorned with a pair of cartoonish devil horns.  Delightfully devilish."),
    mass = "100 g",
    volume = "100 ml",
    price = "15 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "^",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "angel_halo_headband",
    name = ccb.content.text("angel halo"),
    description = ccb.content.text("A plastic headband adorned with a fluffy halo."),
    mass = "100 g",
    volume = "100 ml",
    price = "15 USD",
    survival_price = "10 cent",
    materials = { "plastic", "faux_fur" },
    symbol = "^",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "devil_tail",
    name = ccb.content.text("devil tail"),
    description = ccb.content.text("A slick and long red tail that ends in a pointy spade."),
    mass = "250 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "s",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "angel_wings",
    name = ccb.content.plural_text("angel wings (pair)", "angel wings (pair)"),
    description = ccb.content.text("A rather impressive pair of white wings.  While they may not give you the ability to fly, they make you look angelic."),
    mass = "633 g",
    volume = "2 L",
    length = "106 cm",
    price = "39 USD",
    survival_price = "25 cent",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "light_gray",
    flags = { "BELTED", "NO_WEAR_EFFECT" },
    armor = {
        warmth = 6,
        thickness = 2,
        portions = {
            {
                encumbrance = 15,
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "collar_playboy",
    name = ccb.content.plural_text("collar with bowtie", "collars with bowtie"),
    description = ccb.content.text("It's a detached collar with a bow tie, too.  It's usually worn with a sexy one-piece bunny suit and bunny ears headband."),
    mass = "50 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "-",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "cuffs",
    category = "armor",
    name = ccb.content.plural_text("cuffs (pair)", "cuffs (pair)"),
    description = ccb.content.text("A pair of white cuffs."),
    mass = "50 g",
    volume = "100 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        warmth = 1,
        thickness = 1,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 2,
                coverage = 10,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "bunny_ears_black",
    name = ccb.content.plural_text("black bunny ears (pair)", "black bunny ears (pair)"),
    description = ccb.content.text("A fuzzy pair of black bunny ears on a headband.  It does nothing, but there's no reason not to look good even if no one's looking."),
    mass = "75 g",
    volume = "100 ml",
    price = "15 USD",
    survival_price = "10 cent",
    materials = { "cotton", "plastic" },
    symbol = "^",
    color = "dark_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}
