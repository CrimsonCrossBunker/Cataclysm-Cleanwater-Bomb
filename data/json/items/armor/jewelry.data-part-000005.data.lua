local ccb = require("ccb")

ccb.content.define_item {
    id = "collarpin",
    name = ccb.content.text("collar pin"),
    description = ccb.content.text("A staple accessory for gentlemen.  Keeps your shirt collar in place and provides a more aesthetically pleasing arc to your necktie."),
    mass = "10 g",
    volume = "2 ml",
    price = "250 USD",
    survival_price = "10 cent",
    materials = { "silver" },
    symbol = "[",
    looks_like = "tieclip",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "copper_bracelet",
    name = ccb.content.text("copper bracelet"),
    description = ccb.content.text("An old-fashioned copper bracelet."),
    mass = "45 g",
    volume = "10 ml",
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "copper" },
    symbol = "[",
    looks_like = "silver_bracelet",
    color = "brown",
    flags = { "BELTED", "NO_WEAR_EFFECT", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "copper_ear",
    name = ccb.content.plural_text("copper earrings (pair)", "copper earrings (pair)"),
    description = ccb.content.text("A pair of copper earrings.  They're pretty heavy."),
    mass = "8 g",
    volume = "1 ml",
    price = "29 USD",
    survival_price = "10 cent",
    materials = { "copper" },
    symbol = "[",
    looks_like = "gold_ear",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "copper_hairpin",
    name = ccb.content.text("copper hairpin"),
    description = ccb.content.text("A hairpin made from copper."),
    copy_from = "hairpin",
    mass = "180 mg",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "copper" },
    looks_like = "tieclip",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "copper_locket",
    name = ccb.content.text("copper locket"),
    description = ccb.content.text("A circular copper locket.  It's been tarnished with use, and has gained some dull green spots."),
    mass = "45 g",
    volume = "10 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "copper" },
    symbol = "[",
    looks_like = "silver_necklace",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            mass_limit = "12 mg",
            capacity = "1 ml",
            description = ccb.content.text("Slot for a photograph"),
            allowed_items = { "wallet_photo" },
        },
    },
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "copper_necklace",
    name = ccb.content.text("copper necklace"),
    description = ccb.content.text("A simple chain of copper, with a clasp in the middle to create a necklace."),
    mass = "30 g",
    volume = "10 ml",
    price = "30 USD",
    survival_price = "10 cent",
    materials = { "copper" },
    symbol = "[",
    looks_like = "silver_necklace",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "copper_ring",
    name = ccb.content.text("copper ring"),
    description = ccb.content.text("A plain, copper ring.  Not very shiny, and not very popular."),
    mass = "8 g",
    volume = "1 ml",
    price = "20 USD",
    survival_price = "10 cent",
    materials = { "copper" },
    symbol = "[",
    looks_like = "ring_purity",
    color = "brown",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "cufflinks",
    name = ccb.content.plural_text("cufflinks (pair)", "cufflinks (pair)"),
    description = ccb.content.text("An unmarked pair of silver cufflinks.  Cufflinks are used to secure the cuffs of dress shirts - a must-have for men in formal wear."),
    mass = "10 g",
    volume = "1 ml",
    price = "30 USD",
    survival_price = "10 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "cufflinks_intricate",
    name = ccb.content.plural_text("intricate cufflinks (pair)", "intricate cufflinks (pair)"),
    description = ccb.content.text("An expensive pair of silver cufflinks, stylized with detailed overlays of gold gears and fractal patterns."),
    mass = "22 g",
    volume = "5 ml",
    price = "70 USD",
    survival_price = "50 cent",
    materials = { { id = "silver", portions = 8 }, { id = "gold", portions = 2 } },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("garnet and gold cufflinks", "garnet and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset garnets."),
    mass = "15 g",
    volume = "1 ml",
    price = "35 USD",
    survival_price = "50 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "cufflinks",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("diamond and gold cufflinks", "diamond and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset diamonds."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("amethyst and gold cufflinks", "amethyst and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("aquamarine and gold cufflinks", "aquamarine and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("emerald and gold cufflinks", "emerald and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("alexandrite and gold cufflinks", "alexandrite and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("ruby and gold cufflinks", "ruby and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("peridot and gold cufflinks", "peridot and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("sapphire and gold cufflinks", "sapphire and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("tourmaline and gold cufflinks", "tourmaline and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("citrine and gold cufflinks", "citrine and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("blue topaz and gold cufflinks", "blue topaz and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("opal and gold cufflinks", "opal and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("pearl and gold cufflinks", "pearl and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_cufflinks",
    copy_from = "garnet_gold_cufflinks",
    name = ccb.content.plural_text("onyx and gold cufflinks", "onyx and gold cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("garnet and silver cufflinks", "garnet and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset garnets."),
    mass = "9 g",
    volume = "1 ml",
    price = "35 USD",
    survival_price = "45 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "cufflinks",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("diamond and silver cufflinks", "diamond and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset diamonds."),
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("amethyst and silver cufflinks", "amethyst and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("aquamarine and silver cufflinks", "aquamarine and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("emerald and silver cufflinks", "emerald and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("alexandrite and silver cufflinks", "alexandrite and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset alexandrites."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("ruby and silver cufflinks", "ruby and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset rubies."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_cufflinks", weight = 99 },
        {
            id = "vampire_cufflinks",
            name = ccb.content.plural_text("vampire cufflinks", "vampire cufflinks"),
            description = ccb.content.text("A pair of cufflinks with inset blood-red rubies in the shape of a drop of blood."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("peridot and silver cufflinks", "peridot and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("sapphire and silver cufflinks", "sapphire and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("tourmaline and silver cufflinks", "tourmaline and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("citrine and silver cufflinks", "citrine and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("blue topaz and silver cufflinks", "blue topaz and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("opal and silver cufflinks", "opal and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("pearl and silver cufflinks", "pearl and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset pearls."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_cufflinks",
    copy_from = "garnet_silver_cufflinks",
    name = ccb.content.plural_text("onyx and silver cufflinks", "onyx and silver cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset onyx."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_cufflinks", weight = 99 },
        {
            id = "dark_cufflinks",
            name = ccb.content.plural_text("dark cufflinks", "dark cufflinks"),
            description = ccb.content.text("A pair of cufflinks with inset onyx and a couple of dark silver cat decorations."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("garnet and platinum cufflinks", "garnet and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset garnets."),
    mass = "15 g",
    volume = "1 ml",
    price = "35 USD",
    survival_price = "75 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "cufflinks",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("diamond and platinum cufflinks", "diamond and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset diamonds."),
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("amethyst and platinum cufflinks", "amethyst and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("aquamarine and platinum cufflinks", "aquamarine and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("emerald and platinum cufflinks", "emerald and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("alexandrite and platinum cufflinks", "alexandrite and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("ruby and platinum cufflinks", "ruby and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("peridot and platinum cufflinks", "peridot and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("sapphire and platinum cufflinks", "sapphire and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("tourmaline and platinum cufflinks", "tourmaline and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("citrine and platinum cufflinks", "citrine and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("blue topaz and platinum cufflinks", "blue topaz and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("opal and platinum cufflinks", "opal and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("pearl and platinum cufflinks", "pearl and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_cufflinks",
    copy_from = "garnet_platinum_cufflinks",
    name = ccb.content.plural_text("onyx and platinum cufflinks", "onyx and platinum cufflinks"),
    description = ccb.content.text("A pair of cufflinks with inset onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "ear_spool",
    name = ccb.content.text("plug"),
    description = ccb.content.text("One of those round things people plug into their earlobes as earrings, also called an \"ear plug\" or \"ear spool.\""),
    mass = "5 g",
    volume = "5 ml",
    price = "12 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "dark_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = { thickness = 1 },
}

ccb.content.define_item {
    id = "gold_bracelet",
    name = ccb.content.text("gold bracelet"),
    description = ccb.content.text("A fancy golden bracelet."),
    mass = "40 g",
    volume = "25 ml",
    price = "460 USD",
    survival_price = "50 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "BELTED", "NO_WEAR_EFFECT", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gold_dental_grill",
    name = ccb.content.text("gold dental grill"),
    description = ccb.content.text("Fake golden teeth, worn over the teeth.  Fits horribly, but looks very shiny."),
    mass = "19 g",
    volume = "5 ml",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "SKINTIGHT", "NO_WEAR_EFFECT" },
    melee_damage = { bash = 2, cut = 2 },
    armor = { portions = { { covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "gold_ear",
    name = ccb.content.plural_text("gold earrings (pair)", "gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny gold earrings."),
    mass = "19 g",
    volume = "1 ml",
    price = "130 USD",
    survival_price = "10 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_hairpin",
    name = ccb.content.text("gold hairpin"),
    description = ccb.content.text("A gold hairpin, designed by the rich, for the rich."),
    copy_from = "hairpin",
    price = "50 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_locket",
    name = ccb.content.text("gold locket"),
    description = ccb.content.text("A heart-shaped gold locket with a frame inside to store photographs or small objects."),
    mass = "57 g",
    volume = "25 ml",
    price = "200 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            mass_limit = "12 mg",
            capacity = "1 ml",
            description = ccb.content.text("Slot for a photograph"),
            allowed_items = { "wallet_photo" },
        },
    },
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_medal",
    name = ccb.content.text("gold medal"),
    description = ccb.content.text("A medal awarded for achieving first place in some event.  Before everything fell apart, this was likely a source of great pride for its owner.  Now it's just another shiny bauble."),
    mass = "57 g",
    volume = "25 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "service_medal",
    name = ccb.content.text("service medal"),
    description = ccb.content.text("A medal awarded to military personnel for heroism, wounds suffered in combat, or distinguished service."),
    mass = "50 g",
    volume = "25 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 1 }, { id = "bronze", portions = 4 } },
    symbol = "[",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_necklace",
    name = ccb.content.text("gold necklace"),
    description = ccb.content.text("A shiny, unadorned gold necklace."),
    mass = "57 g",
    volume = "25 ml",
    price = "400 USD",
    survival_price = "50 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_ring",
    name = ccb.content.text("gold ring"),
    description = ccb.content.text("A flashy gold ring."),
    mass = "18 g",
    volume = "1 ml",
    price = "300 USD",
    survival_price = "50 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "gold_watch",
    name = ccb.content.plural_text("gold watch", "gold watches"),
    description = ccb.content.text("A gold-plated steel self-winding wristwatch, suitable for a retirement present.  Tells the time and looks good."),
    mass = "150 g",
    volume = "90 ml",
    price = "500 USD",
    survival_price = "2 USD 50 cent",
    materials = { { id = "steel", portions = 9 }, { id = "gold" } },
    symbol = "[",
    color = "yellow",
    flags = { "WATCH", "ALARMCLOCK", "BELTED", "FRAGILE", "ALLOWS_NATURAL_ATTACKS", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "tieclip",
    name = ccb.content.text("tie clip"),
    description = ccb.content.text("A fancy silver tie clip, a great match for a necktie."),
    mass = "12 g",
    volume = "5 ml",
    price = "280 USD",
    survival_price = "10 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_watch",
    name = ccb.content.plural_text("silver watch", "silver watches"),
    description = ccb.content.text("An elegant silver watch, crafted from silver-plated stainless steel.  It's much cheaper than other metal watches, but more classy than an ordinary wristwatch."),
    mass = "130 g",
    volume = "90 ml",
    price = "180 USD",
    survival_price = "1 USD",
    materials = { { id = "steel", portions = 9 }, { id = "silver" } },
    symbol = "[",
    color = "light_gray",
    flags = {
        "WATCH",
        "ALARMCLOCK",
        "BELTED",
        "FRAGILE",
        "ALLOWS_NATURAL_ATTACKS",
        "WATER_FRIENDLY",
        "OVERSIZE",
    },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_bracelet",
    name = ccb.content.text("silver bracelet"),
    description = ccb.content.text("A nice silver bracelet."),
    mass = "30 g",
    volume = "25 ml",
    price = "250 USD",
    survival_price = "25 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_ear",
    name = ccb.content.plural_text("silver earrings (pair)", "silver earrings (pair)"),
    description = ccb.content.text("A pair of beautiful silver earrings."),
    mass = "10 g",
    volume = "1 ml",
    price = "80 USD",
    survival_price = "25 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

-- That's about the midpoint for a rolex.
ccb.content.define_item {
    id = "sf_watch",
    name = ccb.content.plural_text("fancy watch", "fancy watches"),
    description = ccb.content.text("A rather large and expensively-made wristwatch.  Tells the time in elegantly wrought gold with silver detailing.  It's really the only timepiece suitable for someone of your exquisitely discerning tastes."),
    mass = "150 g",
    volume = "100 ml",
    price = "22 kUSD",
    survival_price = "5 USD",
    materials = { "gold", "silver" },
    symbol = "[",
    color = "yellow",
    flags = {
        "WATCH",
        "ALARMCLOCK",
        "BELTED",
        "FRAGILE",
        "ALLOWS_NATURAL_ATTACKS",
        "WATER_FRIENDLY",
        "OVERSIZE",
    },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}
