local ccb = require("ccb")

ccb.content.define_item {
    id = "bead_bracelet",
    name = ccb.content.plural_text("beaded bracelet", "beaded bracelets"),
    description = ccb.content.text("A simple bracelet of string and wooden beads.  Also doubles as a set of prayer beads, if you're so inclined."),
    looks_like = "copper_bracelet",
    mass = "6 g",
    volume = "10 ml",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "wood" },
    symbol = "[",
    color = "brown",
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
    use_actions = { "MEDITATE" },
}

ccb.content.define_item {
    id = "bead_ear",
    name = ccb.content.plural_text("beaded earrings (pair)", "beaded earrings (pair)"),
    description = ccb.content.text("A simple pair of earrings made of string and wooden beads."),
    mass = "600 mg",
    volume = "1 ml",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "gold_ear",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "bead_necklace",
    name = ccb.content.plural_text("beaded necklace", "beaded necklaces"),
    description = ccb.content.text("A simple necklace made of string and wooden beads.  Also doubles as a set of prayer beads, if you're so inclined."),
    looks_like = "silver_necklace",
    mass = "18 g",
    volume = "30 ml",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "wood" },
    symbol = "u",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
    use_actions = { "MEDITATE" },
}

ccb.content.define_item {
    id = "bracelet_friendship",
    name = ccb.content.text("friendship bracelet"),
    description = ccb.content.text("A homemade bracelet crafted from colorful knickknacks.  It's not very expensive, but it's the effort that makes it special."),
    looks_like = "copper_bracelet",
    mass = "8 g",
    volume = "10 ml",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "wood", "plastic" },
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 30,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "bronze_medal",
    name = ccb.content.text("bronze medal"),
    description = ccb.content.text("A medal awarded for achieving third place in some event.  It might be worth something if it was made of bronze; this one is made from brass."),
    mass = "25 g",
    volume = "10 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "brass" },
    symbol = "[",
    looks_like = "copper_locket",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "cowrie_bracelet",
    copy_from = "bead_bracelet",
    name = ccb.content.text("cowrie bracelet"),
    description = ccb.content.text("A bracelet made of cowrie shells, valued in many African cultures such as the Yoruba.  If you want, you could meditate with this."),
    materials = { "bone" },
    color = "white",
    flags = { "NO_WEAR_EFFECT", "NO_SALVAGE" },
    armor = {},
}

ccb.content.define_item {
    id = "cowrie_hair_beads",
    copy_from = "wooden_hair_beads",
    name = ccb.content.plural_text("cowrie hair beads", "sets of cowrie hair beads"),
    description = ccb.content.text("An assortment of cowrie shells used to decorate locs or braids."),
    materials = { "bone" },
    color = "white",
    flags = { "NO_WEAR_EFFECT", "NO_SALVAGE" },
    armor = {},
}

ccb.content.define_item {
    id = "cowrie_necklace",
    copy_from = "bead_necklace",
    name = ccb.content.text("cowrie necklace"),
    description = ccb.content.text("A necklace made of cowrie shells, valued in many African cultures such as the Yoruba.  If you want, you could meditate with this."),
    materials = { "bone" },
    color = "white",
    flags = { "NO_WEAR_EFFECT", "NO_SALVAGE" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_dental_grill",
    name = ccb.content.text("diamond dental grill"),
    description = ccb.content.text("Fake teeth inlaid with diamonds, worn over the teeth.  Fits horribly, but looks very shiny.  For that high-class gangsta rap look."),
    mass = "35 g",
    volume = "5 ml",
    price = "500 USD",
    survival_price = "50 cent",
    materials = { "gold" },
    symbol = "[",
    looks_like = "gold_dental_grill",
    color = "yellow",
    flags = { "SKINTIGHT", "NO_WEAR_EFFECT" },
    melee_damage = { bash = 3, cut = 3 },
    armor = { portions = { { encumbrance = 10, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "garnet_dental_grill",
    name = ccb.content.text("garnet dental grill"),
    description = ccb.content.text("Fake teeth inlaid with garnets, worn over the teeth.  It looks very shiny."),
    mass = "35 g",
    volume = "5 ml",
    price = "300 USD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    symbol = "[",
    looks_like = "gold_dental_grill",
    color = "red",
    flags = { "SKINTIGHT", "NO_WEAR_EFFECT" },
    melee_damage = { bash = 3, cut = 3 },
    armor = { portions = { { encumbrance = 10, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "amethyst_dental_grill",
    name = ccb.content.text("amethyst dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with amethysts, worn over the teeth.  It looks very shiny."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_dental_grill",
    name = ccb.content.text("aquamarine dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with aquamarines, worn over the teeth.  It looks very shiny."),
    color = "cyan",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_dental_grill",
    name = ccb.content.text("emerald dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with emeralds, worn over the teeth.  It looks very shiny."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_dental_grill",
    name = ccb.content.text("alexandrite dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with alexandrites, worn over the teeth.  It looks very shiny."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_dental_grill",
    name = ccb.content.text("ruby dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with rubies, worn over the teeth.  It looks very shiny."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_dental_grill",
    name = ccb.content.text("peridot dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with peridots, worn over the teeth.  It looks very shiny."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_dental_grill",
    name = ccb.content.text("sapphire dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with sapphires, worn over the teeth.  It looks very shiny."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_dental_grill",
    name = ccb.content.text("tourmaline dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with tourmaline, worn over the teeth.  It looks very shiny."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_dental_grill",
    name = ccb.content.text("citrine dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with citrines, worn over the teeth.  It looks very shiny."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "barrette",
    name = ccb.content.text("barrette"),
    description = ccb.content.text("A barrette with lots of ornaments."),
    mass = "5 g",
    volume = "50 ml",
    price = "8 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "pink",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_dental_grill",
    name = ccb.content.text("blue topaz dental grill"),
    copy_from = "garnet_dental_grill",
    description = ccb.content.text("Fake teeth inlaid with blue topaz, worn over the teeth.  It looks very shiny."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_ring",
    name = ccb.content.text("diamond and gold ring"),
    description = ccb.content.text("A gold ring with a sparkling diamond mounted on top of it.  Back in the old days, this could have been worth a fortune."),
    mass = "12 g",
    volume = "1 ml",
    price = "1 kUSD 900 USD",
    survival_price = "1 USD",
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    symbol = "[",
    looks_like = "ring_engagement",
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
    id = "diving_watch",
    name = ccb.content.plural_text("diver's watch", "diver's watches"),
    description = ccb.content.text("A waterproof, self-winding watch on a stainless steel watchband.  Tells the time and current temperature.  Activate to check the digital thermometer."),
    mass = "100 g",
    volume = "90 ml",
    price = "120 USD",
    survival_price = "7 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "gold_watch",
    color = "light_gray",
    flags = {
        "WATCH",
        "ALARMCLOCK",
        "WATER_FRIENDLY",
        "THERMOMETER",
        "BELTED",
        "ALLOWS_NATURAL_ATTACKS",
        "OVERSIZE",
    },
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
    use_actions = { "WEATHER_TOOL" },
}

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

ccb.content.define_item {
    id = "small_relic",
    name = ccb.content.plural_text("small relic", "small relics"),
    description = ccb.content.text("A small relic from a forgotten saint.  As extraordinary as the world has become, it may have some power yet."),
    mass = "60 g",
    volume = "15 ml",
    price = "10 USD",
    survival_price = "75 cent",
    materials = { { id = "bone", portions = 8 }, { id = "silver", portions = 2 } },
    symbol = "[",
    color = "white",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
    use_actions = { "MEDITATE" },
}

ccb.content.define_item {
    id = "wooden_hair_beads",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.plural_text("wooden hair beads", "sets of wooden hair beads"),
    description = ccb.content.text("An assortment of wooden beads used to decorate locs or braids."),
    mass = "6 g",
    volume = "10 ml",
    materials = { "wood" },
    symbol = ".",
    color = "brown",
    armor = {},
}

ccb.content.define_item {
    id = "holy_symbol",
    name = ccb.content.plural_text("holy symbol", "holy symbols"),
    description = ccb.content.text("A necklace made of fine gold chain, bearing the symbol of a forgotten faith."),
    mass = "57 g",
    volume = "25 ml",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "gold" },
    symbol = ",",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    variant_kind = "generic",
    variants = {
        {
            id = "cross_necklace",
            name = ccb.content.plural_text("cross necklace", "cross necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with a plain cross symbol as a pendant.  It is a symbol of Christian faith, no matter the denomination."),
            color = "yellow",
            weight = 100,
        },
        {
            id = "rosary",
            name = ccb.content.plural_text("rosary", "rosaries"),
            description = ccb.content.text("A necklace made of a fine gold chain, with 59 beads and crucifix on the end.  The Rosary is a sort of ritual prayer primarily done by Roman Catholics.  It consists of 5 decades, each made up of 10 Hail Marys, each followed by one Lord's Prayer.  It is said that praying a whole Rosary sends 1000 souls to Heaven."),
            color = "yellow",
            weight = 15,
        },
        {
            id = "jewish_necklace",
            name = ccb.content.plural_text("Star of David necklace", "Star of David necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Star of David symbol as a pendant.  It is a symbol of the Jewish faith.  The Star of David became officially associated with Judaism when it was chosen as the symbol to appear on a flag at the First Zionist Congress in 1897.  At that time, it became the symbol of the Jewish people, Zionism, and the Jewish communities throughout the world."),
            color = "yellow",
            weight = 15,
        },
        {
            id = "muslim_necklace",
            name = ccb.content.plural_text("Crescent Moon and Star necklace", "Crescent Moon and Star necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Crescent Moon and Star symbol as a pendant.  It is a symbol of both the Sunni and Shia Islam faith.  The crescent of the new moon signifies the beginning and end of fasting during Ramadan."),
            color = "yellow",
            weight = 5,
        },
        {
            id = "saint_necklace",
            expand_snippets = true,
            name = ccb.content.plural_text("Saint Medallion", "Saint Medallions"),
            description = ccb.content.text("A necklace made of a fine gold chain with a medallion bearing the image of a Catholic saint.  The back reads \"<catholic_saints>\"."),
            color = "yellow",
            weight = 5,
        },
        {
            id = "buddhist_necklace",
            name = ccb.content.plural_text("Dharmachakra necklace", "Dharmachakra necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Dharmachakra symbol as a pendant.  It is a symbol of the Hindu, Jain and Buddhist faiths.  Also known as Dharma Wheel, the circle, the round shape of the wheel, represents the perfection of the Dharma, the Buddha's teaching.  The rim of the wheel represents meditative concentration and mindfulness, which hold practice together.  The hub represents moral discipline."),
            color = "yellow",
            weight = 5,
        },
        {
            id = "odin_necklace",
            name = ccb.content.plural_text("Horn of Odin necklace", "Horn of Odin necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Horn of Odin symbol as a pendant.  It is a symbol of the Asatru faith.  The Horn of Odin is one of the most recognizable Norse symbols, consisting of three interlocking drinking horns and symbolizing poetic inspiration and wisdom.  It is also a nod to Viking drinking customs and the camaraderie derived from them."),
            color = "yellow",
            weight = 1,
        },
        {
            id = "zoroastrianist_necklace",
            name = ccb.content.plural_text("Faravahar necklace", "Faravahar necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Faravahar symbol as a pendant.  It is a symbol of the Zoroastrianism faith.  While there is no total understanding of the meanings of that ancient symbol, it depicts a bearded man with one hand reaching forward.  He stands above a pair of wings that are outstretched from a circle which are believed to represent eternity."),
            color = "yellow",
            weight = 1,
        },
        {
            id = "sikh_necklace",
            name = ccb.content.plural_text("Khanda necklace", "Khanda necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Khanda symbol as a pendant.  It is a symbol of the Sikh faith.  The Khanda symbol depicts the Sikh doctrine of Deg Tegh Fateh in emblematic form.  It is also part of the design of the 'Sikh national flag', the Nishan Sahib.  A double edged sword (also called Khanda) is placed at the top of a Nishan Sahib flag as an ornament or finial."),
            color = "yellow",
            weight = 1,
        },
        {
            id = "bahai_necklace",
            name = ccb.content.plural_text("Baha'i Star necklace", "Baha'i Star necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Baha'i Star symbol as a pendant.  It is a symbol of the Baha'i faith.  The Baha'i nine-pointed star reflects the importance of the number for the Faith.  The number nine is the highest single digit number, which symbolizes wholeness and the fulfillment of the expectations of all prior religions."),
            color = "yellow",
            weight = 1,
        },
        {
            id = "shinto_necklace",
            name = ccb.content.plural_text("Torii necklace", "Torii necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Torii symbol as a pendant.  It is a symbol of Shinto faith, where the Torii denotes the entrance to Shinto Shrines and the respect towards the Shinto beliefs and culture."),
            color = "yellow",
            weight = 1,
        },
        {
            id = "taoist_necklace",
            name = ccb.content.plural_text("Ying Yang necklace", "Ying Yang necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Ying Yang symbol as a pendant.  It is a symbol of both Confucian and Taoist faiths and philosophical systems.  Yin is a symbol of earth, femininity, darkness, passivity, and absorption.  It is present in even numbers, in valleys and streams, and is represented by the tiger, the color orange, and a broken line.  Yang is conceived of as heaven, maleness, light, activity, and penetration, and together, they represent balance between opposites."),
            color = "yellow",
            weight = 1,
        },
        {
            id = "caodaism_necklace",
            name = ccb.content.plural_text("Cao Dai necklace", "Cao Dai necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Cao Dai symbol as a pendant.  It is a symbol of Caodaism faith.  In Vietnamese, 'Cao' literally means 'high', while 'Dai' means 'tower', 'palace' or 'abode'. The combined verbal image is used to represent both a heavenly place and a Supreme Being envisioned as creating all religions and beings on the earth.  The visual symbol used by Caodaism followers for this Supreme Being is an all-seeing eye, the Cao Dai."),
            color = "yellow",
            weight = 1,
        },
        {
            id = "nativeamerican_necklace",
            name = ccb.content.plural_text("Zia Sun necklace", "Zia Sun necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Zia Sun symbol as a pendant.  It is a symbol of the strength and union of the Zia Native Americans.  The Zia Sun symbol represent the four cardinal directions, the four seasons of the year, the four period of each day (morning, noon, evening, and night), and the four seasons of life (childhood, youth, middle age, and old age)."),
            color = "yellow",
            weight = 1,
        },
        {
            id = "jain_necklace",
            name = ccb.content.plural_text("Hand of Ahimsa necklace", "Hand of Ahimsa necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Hand of Ahimsa symbol as a pendant.  It is a symbol of the Jainist faith and philosophical system.  The hand with a wheel on the palm symbolizes Ahimsa in Jainism.  The word in the middle is 'ahimsa' (non-injury).  The wheel represents the dharmachakra, which stands for the resolve to halt the samsara through the relentless pursuit of Ahimsa."),
            color = "yellow",
            weight = 5,
        },
        {
            id = "hinduist_necklace",
            name = ccb.content.plural_text("Om necklace", "Om necklaces"),
            description = ccb.content.text("A necklace made of a fine gold chain with the Om symbol as a pendant.  It is a symbol of the Hindu faith, as Om is a sacred sound, syllable, mantra, or an invocation in Hinduism.  Om is the prime symbol of Hinduism, variously said to be the essence of the supreme Absolute, consciousness, Atman, Brahman, or the Cosmic world.  In Indian traditions, Om serves as a sonic representation of the divine, a standard of Vedic authority and a central aspect of soteriological doctrines and practices."),
            color = "yellow",
            weight = 1,
        },
    },
    armor = {},
    use_actions = { "MEDITATE" },
}

ccb.content.define_item {
    id = "holy_symbol_wood",
    name = ccb.content.plural_text("handmade holy symbol", "handmade holy symbols"),
    description = ccb.content.text("A simple necklace representing a religious faith."),
    mass = "15 g",
    volume = "25 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "wood", "cotton" },
    symbol = ",",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
    use_actions = { "MEDITATE" },
}

ccb.content.define_item {
    id = "jade_brooch",
    name = ccb.content.plural_text("jade brooch", "jade brooches"),
    description = ccb.content.text("A hand-crafted jade brooch of Oriental origin."),
    mass = "2 g",
    volume = "1 ml",
    price = "900 USD",
    survival_price = "25 cent",
    materials = { "stone" },
    symbol = "[",
    color = "green",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "pearl_collar",
    name = ccb.content.text("pearl collar"),
    description = ccb.content.text("A collar made from round and lustrous pearls; its former owner must have been a wealthy individual."),
    mass = "200 g",
    volume = "200 ml",
    price = "5 kUSD 900 USD",
    survival_price = "25 cent",
    materials = { "stone" },
    symbol = "[",
    color = "white",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

-- far more expensive than gold watches, around $100,000 for most platinum watches
ccb.content.define_item {
    id = "platinum_watch",
    name = ccb.content.plural_text("platinum watch", "platinum watches"),
    description = ccb.content.text("Flex on those gold-watch wearers with this rare, expensive, and superior platinum watch.  This one is made from solid platinum."),
    mass = "180 g",
    volume = "100 ml",
    price = "100 kUSD",
    survival_price = "10 USD",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
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
    id = "platinum_bracelet",
    name = ccb.content.text("platinum bracelet"),
    description = ccb.content.text("A flawless platinum bracelet."),
    mass = "42 g",
    volume = "25 ml",
    price = "380 USD",
    survival_price = "1 USD",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
    flags = { "BELTED", "NO_WEAR_EFFECT", "OVERSIZE" },
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
    id = "platinum_dental_grill",
    name = ccb.content.text("platinum dental grill"),
    description = ccb.content.text("Fake platinum-and-silver teeth.  They may be cheaper than fake gold teeth, but they're much more rare.  Fits horribly, but looks very shiny."),
    mass = "21 g",
    volume = "5 ml",
    price = "150 USD",
    survival_price = "25 cent",
    materials = { "platinum", "silver" },
    symbol = "[",
    color = "white",
    flags = { "SKINTIGHT", "NO_WEAR_EFFECT" },
    melee_damage = { bash = 2, cut = 2 },
    armor = { portions = { { covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "platinum_ear",
    name = ccb.content.plural_text("platinum earrings (pair)", "platinum earrings (pair)"),
    description = ccb.content.text("A pair of plain platinum earrings - if gold is getting boring, just use another rare metal."),
    mass = "20 g",
    volume = "1 ml",
    price = "120 USD",
    survival_price = "50 cent",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "platinum_hairpin",
    name = ccb.content.text("platinum hairpin"),
    description = ccb.content.text("The ultimate in esoteric, metal hair accessories, this hairpin is made from pure platinum."),
    copy_from = "hairpin",
    mass = "300 mg",
    price = "35 USD",
    survival_price = "50 cent",
    materials = { "platinum" },
    color = "white",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "platinum_locket",
    name = ccb.content.text("platinum locket"),
    description = ccb.content.text("A small, platinum locket for storing photographs or other small objects."),
    mass = "65 g",
    volume = "40 ml",
    price = "160 USD",
    survival_price = "50 cent",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
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
    id = "platinum_necklace",
    name = ccb.content.text("platinum necklace"),
    description = ccb.content.text("A platinum necklace, with a small, empty heart-shaped frame hanging from a chain."),
    mass = "42 g",
    volume = "25 ml",
    price = "500 USD",
    survival_price = "50 cent",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "platinum_ring",
    name = ccb.content.text("platinum ring"),
    description = ccb.content.text("A platinum ring, engraved with all manner of swirls and spirals."),
    mass = "21 g",
    volume = "1 ml",
    price = "240 USD",
    survival_price = "50 cent",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "ring_engagement",
    name = ccb.content.text("engagement ring"),
    description = ccb.content.text("This ring is an intricate gold band with a small cluster of diamonds set in the center.  Before the world broke down, this ring would've cost a small fortune."),
    mass = "14 g",
    volume = "1 ml",
    price = "1 kUSD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "ring_purity",
    name = ccb.content.text("purity ring"),
    description = ccb.content.text("Also known as a promise ring, this ring is worn as a sign of chastity.  This one bears the inscription, \"Love is patient.\""),
    mass = "6 g",
    volume = "1 ml",
    price = "17 USD",
    survival_price = "10 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "ring_signet",
    name = ccb.content.text("signet ring"),
    description = ccb.content.text("A gold and silver ring with a wide stamp attached to the band.  A long time ago, the stamp was legible, but now the pattern is too worn to discern its former use."),
    mass = "14 g",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { "gold", "silver" },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "ring_wedding",
    name = ccb.content.text("wedding ring"),
    description = ccb.content.text("A flawless ring, ensnaring a diamond with twists of pure gold.  It's a constant reminder that the wearer is married."),
    mass = "19 g",
    volume = "2 ml",
    price = "1 kUSD 500 USD",
    survival_price = "50 cent",
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_necklace",
    name = ccb.content.text("silver necklace"),
    description = ccb.content.text("A nice silver necklace."),
    mass = "30 g",
    volume = "25 ml",
    price = "120 USD",
    survival_price = "25 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_hairpin",
    name = ccb.content.text("silver hairpin"),
    description = ccb.content.text("A shiny silver hairpin with a tiny bee engraved onto it."),
    copy_from = "hairpin",
    mass = "180 mg",
    price = "20 USD",
    survival_price = "10 cent",
    materials = { "silver" },
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_locket",
    name = ccb.content.text("silver locket"),
    description = ccb.content.text("A small silver locket with a frame inside to store photographs or small objects."),
    mass = "30 g",
    volume = "25 ml",
    price = "40 USD",
    survival_price = "10 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
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
    id = "silver_medal",
    name = ccb.content.text("silver medal"),
    description = ccb.content.text("A medal awarded for achieving second place in some event.  Before everything fell apart, this was likely a source of pride for its owner.  Now it's just another shiny bauble."),
    mass = "50 g",
    volume = "25 ml",
    price = "50 USD",
    survival_price = "10 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_ring",
    name = ccb.content.text("silver ring"),
    description = ccb.content.text("A simple, silver ring."),
    mass = "10 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "10 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "leather_collar",
    name = ccb.content.text("leather collar"),
    description = ccb.content.text("A black leather 'collar' with a bell dangling from the front.  Don't worry, the bell is silent."),
    mass = "100 g",
    volume = "100 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { "leather" },
    symbol = "-",
    color = "dark_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "priest_collar",
    name = ccb.content.text("clerical collar"),
    description = ccb.content.text("A white plastic collar worn by Christian clergymen (or women).  Although it is most commonly associated with Catholic Priests, it is also worn by Anglicans, Lutherans, Presbyterians, and Methodists.  It represents the belief that the wearer is eternally bound in service to God"),
    mass = "100 g",
    volume = "100 ml",
    price = "0 USD",
    survival_price = "25 cent",
    materials = { "plastic" },
    symbol = "-",
    color = "white",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "wristwatch",
    name = ccb.content.plural_text("wrist watch", "wrist watches"),
    description = ccb.content.text("A simple wristwatch on a plastic band.  Tells the time and has an alarm clock feature."),
    mass = "100 g",
    volume = "100 ml",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    ascii_picture = "wristwatch",
    symbol = "[",
    color = "dark_gray",
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
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

-- These seem to be sold via subscription; makes a certain amount of sense, but low-bid seems a Bad Idea.
ccb.content.define_item {
    id = "rad_badge",
    name = ccb.content.text("radiation badge"),
    description = ccb.content.text("A plastic badge with an embedded filmstrip.  The text on the badge says the filmstrip changes color as it is exposed to radiation, and never goes back to how it initially looked.  Wear on your lapel so you can notice if it changes."),
    mass = "25 g",
    volume = "25 ml",
    price = "80 USD",
    survival_price = "5 USD",
    materials = { "plastic" },
    symbol = "[",
    color = "light_blue",
    flags = { "OVERSIZE", "RAD_DETECT" },
    armor = {},
}

-- NO_I18N
-- NO_I18N
-- typical badges are 1-4 oz and are usually brass with a possible very thin precious metal plating.
ccb.content.define_item {
    id = "badge_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("badge template"),
    description = ccb.content.text_without_extraction("This is a template for police/medical badges.  If found in a game, it is a bug."),
    mass = "60 g",
    volume = "8 ml",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "brass" },
    symbol = "[",
    color = "yellow",
    flags = { "ALLOWS_NATURAL_ATTACKS", "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = { thickness = 2 },
}

ccb.content.define_item {
    id = "badge_deputy",
    copy_from = "badge_abstract",
    name = ccb.content.text("deputy badge"),
    description = ccb.content.text("A tarnished silver star gives an air of authority to the wearer."),
    ascii_picture = "badge_deputy",
    armor = {},
}

ccb.content.define_item {
    id = "badge_detective",
    copy_from = "badge_abstract",
    name = ccb.content.text("detective badge"),
    description = ccb.content.text("A tarnished golden shield gives an air of authority to the wearer."),
    armor = {},
}

ccb.content.define_item {
    id = "badge_marshal",
    copy_from = "badge_abstract",
    name = ccb.content.text("marshal badge"),
    description = ccb.content.text("A bright silver star strikes fear into the eyes of ne'er-do-wells."),
    armor = {},
    inheritance = { scale = { price = 2 } },
}

ccb.content.define_item {
    id = "badge_swat",
    copy_from = "badge_abstract",
    name = ccb.content.text("SWAT badge"),
    description = ccb.content.text("A matte-finish silver shield identifies the wearer as an authority who goes in when the cops just aren't enough."),
    armor = {},
}

ccb.content.define_item {
    id = "badge_fbi",
    copy_from = "badge_abstract",
    name = ccb.content.text("FBI badge"),
    description = ccb.content.text("A gold-filled brass shield with an eagle perched atop it and Lady Justice emblazoned on its center.  In large, engraved lettering it reads, \"FEDERAL BUREAU OF INVESTIGATION-US DEPARTMENT OF JUSTICE\".  It identifies the wearer as an agent with federal authority throughout all the United States and her territories; that is, whatever is left of them."),
    armor = {},
}

ccb.content.define_item {
    id = "badge_doctor",
    copy_from = "badge_abstract",
    name = ccb.content.text("doctor badge"),
    materials = { "plastic" },
    mass = "50 g",
    volume = "50 ml",
    survival_price = "10 cent",
    description = ccb.content.text("A plastic name tag marking the wearer as a real doctor of the medical kind."),
    armor = {},
}

ccb.content.define_item {
    id = "badge_foodkid",
    copy_from = "badge_abstract",
    name = ccb.content.text("Foodkid badge"),
    materials = { "plastic" },
    survival_price = "10 cent",
    mass = "50 g",
    volume = "50 ml",
    description = ccb.content.text("A star-shaped plastic badge.  \"Foodkid\" is printed on it in bold letters.  This badge marks its wearer as Foodperson's trusty sidekick, and comes included with every kid's meal at Foodplace."),
    armor = {},
}

-- Measured my own pin.  Hopefully the NB ones are universal.
ccb.content.define_item {
    id = "pin_badge",
    copy_from = "badge_abstract",
    name = ccb.content.text("pin"),
    materials = { "steel" },
    price = "5 USD",
    survival_price = "10 cent",
    mass = "4 g",
    volume = "10 ml",
    description = ccb.content.text("A small piece of metal with a pin, meant to affix itself to an article of clothing.  It's mainly used on jackets or backpacks, as a way to show off what bands you listen to, or other things like your pronouns."),
    max_worn = 2147483647,
    variant_kind = "generic",
    armor = {},
}

ccb.content.define_item {
    id = "fur_cat_ears",
    name = ccb.content.plural_text("fuzzy cat ears (pair)", "fuzzy cat ears (pair)"),
    description = ccb.content.text("A fuzzy pair of brownish cat ears on a headband.  It does nothing, but there's no reason not to look good even if no one's looking."),
    mass = "100 g",
    volume = "100 ml",
    price = "15 USD",
    survival_price = "10 cent",
    materials = { "fur", "plastic" },
    symbol = "^",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "faux_fur_cat_ears",
    copy_from = "fur_cat_ears",
    name = ccb.content.plural_text("faux fur cat ears (pair)", "faux fur cat ears (pair)"),
    description = ccb.content.text("A fuzzy pair of garishly colored cat ears on a headband.  It does nothing, but there's no reason not to look good even if no one's looking."),
    materials = { "faux_fur" },
    color = "pink",
    variant_kind = "generic",
    variants = {
        { id = "faux_fur_cat_ears", color = "pink" },
        {
            id = "bunny_ears_white",
            name = ccb.content.plural_text("white bunny ears (pair)", "white bunny ears (pair)"),
            description = ccb.content.text("A fuzzy pair of white bunny ears.  It does nothing, but there's no reason not to look good even if no one's looking."),
            color = "light_gray",
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "fur_cat_tail",
    name = ccb.content.text("fuzzy cat tail"),
    description = ccb.content.text("A fuzzy tawny tail weighted down with tiny beads of plastic.  Sways behind you when you walk."),
    mass = "250 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "fur", "plastic" },
    symbol = "s",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    melee_damage = { bash = 4 },
    armor = {},
}

ccb.content.define_item {
    id = "faux_fur_cat_tail",
    copy_from = "fur_cat_tail",
    name = ccb.content.text("faux fur cat tail"),
    description = ccb.content.text("A fuzzy garishly colored tail weighted down with tiny beads of plastic.  Sways behind you when you walk."),
    materials = { "faux_fur", "plastic" },
    color = "pink",
    armor = {},
}

ccb.content.define_item {
    id = "fur_collar",
    name = ccb.content.text("fur kitty collar"),
    description = ccb.content.text("A decorative 'collar' made out of fur, complete with a little bell hanging from the front.  Don't worry, it's silent."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "fur" },
    symbol = "-",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "faux_fur_collar",
    copy_from = "fur_collar",
    name = ccb.content.text("faux fur kitty collar"),
    description = ccb.content.text("A decorative 'collar' made out of faux fur, complete with a little bell hanging from the front.  Don't worry, it's silent."),
    materials = { "faux_fur" },
    color = "pink",
    armor = {},
}

ccb.content.define_item {
    id = "leather_cat_ears",
    name = ccb.content.plural_text("leather cat ears (pair)", "leather cat ears (pair)"),
    description = ccb.content.text("A shiny pair of black cat ears on a headband.  It does nothing, but there's no reason not to look good even if no one's looking."),
    mass = "100 g",
    volume = "100 ml",
    price = "30 USD",
    survival_price = "10 cent",
    materials = { "leather", "plastic" },
    symbol = "^",
    color = "dark_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "leather_cat_tail",
    name = ccb.content.text("leather cat tail"),
    description = ccb.content.text("A glossy black leather tail weighted down with tiny beads of plastic.  Sways behind you when you walk."),
    mass = "250 g",
    volume = "250 ml",
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "leather", "plastic" },
    symbol = "s",
    color = "dark_gray",
    flags = { "NO_WEAR_EFFECT" },
    melee_damage = { bash = 4 },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("diamond and gold earrings (pair)", "diamond and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny diamond and gold earrings."),
    price = "130 USD",
    survival_price = "50 cent",
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_earring",
    name = ccb.content.plural_text("garnet and gold earrings (pair)", "garnet and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny garnet and gold earrings."),
    mass = "18 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "75 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "gold_ear",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("amethyst and gold earrings (pair)", "amethyst and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny amethyst and gold earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("aquamarine and gold earrings (pair)", "aquamarine and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny aquamarine and gold earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("emerald and gold earrings (pair)", "emerald and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny emerald and gold earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("alexandrite and gold earrings (pair)", "alexandrite and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny alexandrite and gold earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("ruby and gold earrings (pair)", "ruby and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny ruby and gold earrings."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("peridot and gold earrings (pair)", "peridot and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny peridot and gold earrings."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("sapphire and gold earrings (pair)", "sapphire and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny sapphire and gold earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("tourmaline and gold earrings (pair)", "tourmaline and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny tourmaline and gold earrings."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("citrine and gold earrings (pair)", "citrine and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny citrine and gold earrings."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("blue topaz and gold earrings (pair)", "blue topaz and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny blue topaz and gold earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("opal and gold earrings (pair)", "opal and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny opal and gold earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("pearl and gold earrings (pair)", "pearl and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny pearl and gold earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("onyx and gold earrings (pair)", "onyx and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny onyx and gold earrings."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("diamond and silver earrings (pair)", "diamond and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny diamond and silver earrings."),
    price = "80 USD",
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_earring",
    name = ccb.content.plural_text("garnet and silver earrings (pair)", "garnet and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny garnet and silver earrings."),
    mass = "10 mg",
    volume = "1 ml",
    price = "60 USD",
    survival_price = "45 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "silver_ear",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("amethyst and silver earrings (pair)", "amethyst and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny amethyst and silver earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("aquamarine and silver earrings (pair)", "aquamarine and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny aquamarine and silver earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("emerald and silver earrings (pair)", "emerald and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny emerald and silver earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("alexandrite and silver earrings (pair)", "alexandrite and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny alexandrite and silver earrings."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("ruby and silver earrings (pair)", "ruby and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny ruby and silver earrings."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_earring", weight = 99 },
        {
            id = "vampire_earring",
            name = ccb.content.plural_text("vampire earrings (pair)", "vampire earrings (pair)"),
            description = ccb.content.text("A pair of blood-red ruby and silver earrings, adorned with sinister motifs."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("peridot and silver earrings (pair)", "peridot and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny peridot and silver earrings."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("sapphire and silver earrings (pair)", "sapphire and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny sapphire and silver earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("tourmaline and silver earrings (pair)", "tourmaline and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny tourmaline and silver earrings."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("citrine and silver earrings (pair)", "citrine and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny citrine and silver earrings."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("blue topaz and silver earrings (pair)", "blue topaz and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny blue topaz and silver earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("opal and silver earrings (pair)", "opal and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny opal and silver earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("pearl and silver earrings (pair)", "pearl and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny pearl and silver earrings."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("onyx and silver earrings (pair)", "onyx and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny onyx and silver earrings."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_earring", weight = 99 },
        {
            id = "dark_earring",
            name = ccb.content.plural_text("dark earrings (pair)", "dark earrings (pair)"),
            description = ccb.content.text("A pair of dark silver earrings featuring onyx in the shape of two dark hearts."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("diamond and platinum earrings (pair)", "diamond and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny diamond and platinum earrings."),
    price = "120 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_earring",
    name = ccb.content.plural_text("garnet and platinum earrings (pair)", "garnet and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny garnet and platinum earrings."),
    mass = "19 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "platinum_ear",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("amethyst and platinum earrings (pair)", "amethyst and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny amethyst and platinum earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("aquamarine and platinum earrings (pair)", "aquamarine and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny aquamarine and platinum earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("emerald and platinum earrings (pair)", "emerald and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny emerald and platinum earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("alexandrite and platinum earrings (pair)", "alexandrite and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny alexandrite and platinum earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("ruby and platinum earrings (pair)", "ruby and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny ruby and platinum earrings."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("peridot and platinum earrings (pair)", "peridot and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny peridot and platinum earrings."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("sapphire and platinum earrings (pair)", "sapphire and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny sapphire and platinum earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("tourmaline and platinum earrings (pair)", "tourmaline and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny tourmaline and platinum earrings."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("citrine and platinum earrings (pair)", "citrine and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny citrine and platinum earrings."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("blue topaz and platinum earrings (pair)", "blue topaz and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny blue topaz and platinum earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("opal and platinum earrings (pair)", "opal and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny opal and platinum earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("pearl and platinum earrings (pair)", "pearl and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny pearl and platinum earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("onyx and platinum earrings (pair)", "onyx and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny onyx and platinum earrings."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_ring",
    name = ccb.content.text("garnet and gold ring"),
    description = ccb.content.text("A gold ring with a garnet mounted on top of it."),
    mass = "18 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "75 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "gold_ring",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("amethyst and gold ring"),
    description = ccb.content.text("A gold ring with an amethyst mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("aquamarine and gold ring"),
    description = ccb.content.text("A gold ring with an aquamarine mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("emerald and gold ring"),
    description = ccb.content.text("A gold ring with an emerald mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("alexandrite and gold ring"),
    description = ccb.content.text("A gold ring with an alexandrite mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("ruby and gold ring"),
    description = ccb.content.text("A gold ring with a ruby mounted on top of it."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("peridot and gold ring"),
    description = ccb.content.text("A gold ring with a peridot mounted on top of it."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("sapphire and gold ring"),
    description = ccb.content.text("A gold ring with a sapphire mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("tourmaline and gold ring"),
    description = ccb.content.text("A gold ring with a tourmaline mounted on top of it."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("citrine and gold ring"),
    description = ccb.content.text("A gold ring with a citrine mounted on top of it."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("blue topaz and gold ring"),
    description = ccb.content.text("A gold ring with a blue topaz mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("opal and gold ring"),
    description = ccb.content.text("A gold ring with an opal mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("pearl and gold ring"),
    description = ccb.content.text("A gold ring with a pearl mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("onyx and gold ring"),
    description = ccb.content.text("A gold ring with an onyx mounted on top of it."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("diamond and silver ring"),
    description = ccb.content.text("A silver ring with a diamond mounted on top of it."),
    price = "120 USD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_ring",
    name = ccb.content.text("garnet and silver ring"),
    description = ccb.content.text("A silver ring with a garnet mounted on top of it."),
    mass = "10 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "silver_ring",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("amethyst and silver ring"),
    description = ccb.content.text("A silver ring with an amethyst mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("aquamarine and silver ring"),
    description = ccb.content.text("A silver ring with an aquamarine mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("emerald and silver ring"),
    description = ccb.content.text("A silver ring with an emerald mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("alexandrite and silver ring"),
    description = ccb.content.text("A silver ring with an alexandrite mounted on top of it."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("ruby and silver ring"),
    description = ccb.content.text("A silver ring with a ruby mounted on top of it."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_ring", weight = 99 },
        {
            id = "vampire_ring",
            name = ccb.content.text("vampire ring"),
            description = ccb.content.text("A silver ring with a sinister claw clutching a blood-red ruby mounted on top of it."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("peridot and silver ring"),
    description = ccb.content.text("A silver ring with a peridot mounted on top of it."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("sapphire and silver ring"),
    description = ccb.content.text("A silver ring with a sapphire mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("tourmaline and silver ring"),
    description = ccb.content.text("A silver ring with a tourmaline mounted on top of it."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("citrine and silver ring"),
    description = ccb.content.text("A silver ring with a citrine mounted on top of it."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("blue topaz and silver ring"),
    description = ccb.content.text("A silver ring with a blue topaz mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("opal and silver ring"),
    description = ccb.content.text("A silver ring with an opal mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("pearl and silver ring"),
    description = ccb.content.text("A silver ring with a pearl mounted on top of it."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("onyx and silver ring"),
    description = ccb.content.text("A silver ring with an onyx mounted on top of it."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_ring", weight = 99 },
        {
            id = "dark_ring",
            name = ccb.content.text("dark ring"),
            description = ccb.content.text("A dark silver ring with skull decorations and a pitch-black onyx mounted on top of it."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("diamond and platinum ring"),
    description = ccb.content.text("A platinum ring with a diamond mounted on top of it."),
    price = "120 USD",
    survival_price = "50 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_ring",
    name = ccb.content.text("garnet and platinum ring"),
    description = ccb.content.text("A platinum ring with a garnet mounted on top of it."),
    mass = "19 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "platinum_ring",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("amethyst and platinum ring"),
    description = ccb.content.text("A platinum ring with an amethyst mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("aquamarine and platinum ring"),
    description = ccb.content.text("A platinum ring with an aquamarine mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("emerald and platinum ring"),
    description = ccb.content.text("A platinum ring with an emerald mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("alexandrite and platinum ring"),
    description = ccb.content.text("A platinum ring with an alexandrite mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("ruby and platinum ring"),
    description = ccb.content.text("A platinum ring with a ruby mounted on top of it."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("peridot and platinum ring"),
    description = ccb.content.text("A platinum ring with a peridot mounted on top of it."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("sapphire and platinum ring"),
    description = ccb.content.text("A platinum ring with a sapphire mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("tourmaline and platinum ring"),
    description = ccb.content.text("A platinum ring with a tourmaline mounted on top of it."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("citrine and platinum ring"),
    description = ccb.content.text("A platinum ring with a citrine mounted on top of it."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("blue topaz and platinum ring"),
    description = ccb.content.text("A platinum ring with a blue topaz mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("opal and platinum ring"),
    description = ccb.content.text("A platinum ring with an opal mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("pearl and platinum ring"),
    description = ccb.content.text("A platinum ring with a pearl mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("onyx and platinum ring"),
    description = ccb.content.text("A platinum ring with an onyx mounted on top of it."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("diamond and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling diamonds."),
    price = "2 kUSD",
    looks_like = "gold_bracelet",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_bracelet",
    name = ccb.content.text("garnet and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling garnets."),
    mass = "190 mg",
    volume = "10 ml",
    price = "150 USD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "gold_bracelet",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("amethyst and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("aquamarine and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("emerald and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("alexandrite and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("ruby and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("peridot and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("sapphire and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("tourmaline and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("citrine and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("blue topaz and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("opal and gold bracelet"),
    description = ccb.content.text("A gold bracelet with beautiful opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("pearl and gold bracelet"),
    description = ccb.content.text("A gold bracelet with beautiful pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("onyx and gold bracelet"),
    description = ccb.content.text("A gold bracelet with striking onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("diamond and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling diamonds."),
    price = "2 kUSD",
    looks_like = "silver_bracelet",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_bracelet",
    name = ccb.content.text("garnet and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling garnets."),
    mass = "100 mg",
    volume = "10 ml",
    price = "150 USD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "silver_bracelet",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("amethyst and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("aquamarine and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("emerald and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("alexandrite and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling alexandrites."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("ruby and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling rubies."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_bracelet", weight = 99 },
        {
            id = "vampire_bracelet",
            name = ccb.content.text("vampire bracelet"),
            description = ccb.content.text("A dark silver bracelet with blood-red rubies in the shape of two sinister-looking hearts."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("peridot and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("sapphire and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("tourmaline and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("citrine and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("blue topaz and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("opal and silver bracelet"),
    description = ccb.content.text("A silver bracelet with beautiful opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("pearl and silver bracelet"),
    description = ccb.content.text("A silver bracelet with beautiful pearls."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("onyx and silver bracelet"),
    description = ccb.content.text("A silver bracelet with striking onyx."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_bracelet", weight = 99 },
        {
            id = "dark_bracelet",
            name = ccb.content.text("dark bracelet"),
            description = ccb.content.text("A dark silver bracelet with occult decorations and one single onyx as the center of a dark eye."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("diamond and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling diamonds."),
    price = "2 kUSD",
    looks_like = "platinum_bracelet",
    survival_price = "50 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_bracelet",
    name = ccb.content.text("garnet and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling garnets."),
    mass = "190 g",
    volume = "10 ml",
    price = "150 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "platinum_bracelet",
    symbol = "[",
    color = "red",
    flags = { "BELTED", "NO_WEAR_EFFECT", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("amethyst and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("aquamarine and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("emerald and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("alexandrite and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("ruby and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("peridot and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("sapphire and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("tourmaline and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("citrine and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("blue topaz and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("opal and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with beautiful opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("pearl and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with beautiful pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("onyx and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with striking onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_pendant_necklace",
    name = ccb.content.text("garnet and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a garnet pendant."),
    mass = "70 g",
    volume = "15 ml",
    price = "500 USD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "gold_necklace",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("diamond and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a diamond pendant."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("amethyst and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an amethyst pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("aquamarine and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an aquamarine pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("emerald and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an emerald pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("alexandrite and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an alexandrite pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("ruby and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a ruby pendant."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("peridot and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a peridot pendant."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("sapphire and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a sapphire pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("tourmaline and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a tourmaline pendant."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("citrine and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a citrine pendant."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("blue topaz and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a blue topaz pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("opal and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an opal pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("pearl and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a pearl pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("onyx and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an onyx pendant."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_pendant_necklace",
    name = ccb.content.text("garnet and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a garnet pendant."),
    mass = "70 g",
    volume = "15 ml",
    price = "500 USD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "silver_necklace",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("diamond and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a diamond pendant."),
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("amethyst and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an amethyst pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("aquamarine and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an aquamarine pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("emerald and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an emerald pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("alexandrite and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an alexandrite pendant."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("ruby and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a ruby pendant."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_pendant_necklace", weight = 99 },
        {
            id = "vampire_necklace",
            name = ccb.content.text("vampire necklace"),
            description = ccb.content.text("A sinister silver necklace adorned with a blood-red ruby pendant."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("peridot and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a peridot pendant."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("sapphire and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a sapphire pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("tourmaline and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a tourmaline pendant."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("citrine and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a citrine pendant."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("blue topaz and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a blue topaz pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("opal and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an opal pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("pearl and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a pearl pendant."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("onyx and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an onyx pendant."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_pendant_necklace", weight = 99 },
        {
            id = "dark_necklace",
            name = ccb.content.text("dark necklace"),
            description = ccb.content.text("A dark silver necklace with an onyx pendant in the shape of a dark heart."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("garnet and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a garnet pendant."),
    mass = "70 g",
    volume = "15 ml",
    price = "500 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "platinum_necklace",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("diamond and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a diamond pendant."),
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("amethyst and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an amethyst pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("aquamarine and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an aquamarine pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("emerald and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an emerald pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("alexandrite and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an alexandrite pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("ruby and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a ruby pendant."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("peridot and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a peridot pendant."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("sapphire and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a sapphire pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("tourmaline and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a tourmaline pendant."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("citrine and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a citrine pendant."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("blue topaz and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a blue topaz pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("opal and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an opal pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("pearl and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a pearl pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("onyx and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an onyx pendant."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_tiara",
    name = ccb.content.text("garnet and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with garnets."),
    mass = "200 g",
    volume = "100 ml",
    price = "5 kUSD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "crown_golden",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
}

ccb.content.define_item {
    id = "diamond_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("diamond and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with diamonds."),
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("amethyst and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("aquamarine and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("emerald and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("alexandrite and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("ruby and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("peridot and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("sapphire and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("tourmaline and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("citrine and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("blue topaz and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("opal and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("pearl and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("onyx and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_tiara",
    name = ccb.content.text("garnet and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with garnets."),
    mass = "190 g",
    volume = "100 ml",
    price = "4 kUSD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "crown_golden",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
}

ccb.content.define_item {
    id = "diamond_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("diamond and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with diamonds."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("amethyst and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("aquamarine and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("emerald and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("alexandrite and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("ruby and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("peridot and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("sapphire and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("tourmaline and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("citrine and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("blue topaz and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("opal and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("pearl and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("onyx and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "gold_hair_beads",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.plural_text("gold hair beads", "sets of gold hair beads"),
    description = ccb.content.text("An assortment of gold beads used to decorate locs or braids."),
    mass = "15 g",
    volume = "25 ml",
    materials = { "gold" },
    symbol = ".",
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_tiara",
    name = ccb.content.text("garnet and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with garnets."),
    mass = "130 g",
    volume = "100 ml",
    price = "2 kUSD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "crown_golden",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
}

ccb.content.define_item {
    id = "diamond_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("diamond and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with diamonds."),
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("amethyst and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("aquamarine and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("emerald and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("alexandrite and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with alexandrites."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("ruby and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with rubies."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_tiara", weight = 99 },
        {
            id = "vampire_tiara",
            name = ccb.content.text("vampire tiara"),
            description = ccb.content.text("A sinister dark silver tiara adorned with blood-red rubies."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("peridot and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("sapphire and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("tourmaline and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("citrine and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("blue topaz and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("opal and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("pearl and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with pearls."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("onyx and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with onyx."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_tiara", weight = 99 },
        {
            id = "dark_tiara",
            name = ccb.content.text("dark tiara"),
            description = ccb.content.text("A dark silver tiara adorned with onyx."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "gold_anklet",
    name = ccb.content.text("gold anklet"),
    description = ccb.content.text("An anklet made from tiny chain links of gold."),
    mass = "6 g",
    volume = "10 ml",
    price = "200 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_anklet",
    name = ccb.content.text("silver anklet"),
    description = ccb.content.text("An anklet made from tiny chain links of silver."),
    mass = "6 g",
    volume = "10 ml",
    price = "150 USD",
    survival_price = "20 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "bat_anklet",
    name = ccb.content.text("bat charm anklet"),
    description = ccb.content.text("An anklet with tiny charms in the shape of bats and blood drops."),
    mass = "6 g",
    volume = "10 ml",
    price = "2 USD",
    survival_price = "2 cent",
    materials = { "plastic", "cotton" },
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "flower_anklet",
    name = ccb.content.text("flower charm anklet"),
    description = ccb.content.text("An anklet with tiny charms in the shape of flowers in an array of colors."),
    mass = "6 g",
    volume = "10 ml",
    price = "2 USD",
    survival_price = "2 cent",
    materials = { "plastic", "cotton" },
    symbol = "[",
    color = "pink",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "woven_anklet",
    name = ccb.content.text("woven anklet"),
    description = ccb.content.text("An anklet made from brightly colored cord woven into a repeating pattern."),
    mass = "5 g",
    volume = "10 ml",
    price = "2 USD",
    survival_price = "2 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "green",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gold_lip_ring_loop",
    name = ccb.content.text("gold lip ring loop"),
    description = ccb.content.text("An expensive gold lip ring loop."),
    mass = "18 mg",
    volume = "1 ml",
    price = "250 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = "o",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_lip_ring_stud",
    name = ccb.content.text("gold lip ring stud"),
    description = ccb.content.text("An expensive gold lip ring stud."),
    mass = "18 mg",
    volume = "1 ml",
    price = "250 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = ".",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_lip_ring_loop",
    name = ccb.content.text("silver lip ring loop"),
    description = ccb.content.text("An expensive silver lip ring loop."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = "o",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_lip_ring_stud",
    name = ccb.content.text("silver lip ring stud"),
    description = ccb.content.text("An expensive silver lip ring stud."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = ".",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_nose_ring_loop",
    name = ccb.content.text("gold nose ring loop"),
    description = ccb.content.text("An expensive gold nose ring loop."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "gold" },
    symbol = "o",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_nose_ring_stud",
    name = ccb.content.text("gold nose ring stud"),
    description = ccb.content.text("An expensive gold nose ring stud."),
    mass = "18 mg",
    volume = "1 ml",
    price = "250 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = ".",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_nose_ring_loop",
    name = ccb.content.text("silver nose ring loop"),
    description = ccb.content.text("An expensive silver nose ring loop."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = "o",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_nose_ring_stud",
    name = ccb.content.text("silver nose ring stud"),
    description = ccb.content.text("An expensive silver nose ring stud."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = ".",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_toe_ring",
    name = ccb.content.text("gold toe ring"),
    description = ccb.content.text("An expensive gold toe ring."),
    mass = "3 g",
    volume = "3 ml",
    price = "250 USD",
    survival_price = "25 cent",
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
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_toe_ring",
    name = ccb.content.text("silver toe ring"),
    description = ccb.content.text("An expensive silver toe ring."),
    mass = "3 g",
    volume = "3 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "simple_pistol_cartridge_necklace",
    name = "handgun-cartridge necklace",
    description = "A simple, if rather crude, piece of post-Cataclysm jewelry: a solitary bullet casing from a handgun cartridge or other such form of ammunition strung upon a length of string, cord, or twine to form a makeshift pendant.",
    symbol = "[",
    color = "yellow",
    looks_like = "gold_necklace",
    mass = "24 g",
    volume = "38 ml",
    length = "28 mm",
    price = "5 USD",
    survival_price = "0 cent",
    snippet_category = {
        {
            id = "pistol_pendent1",
            text = "A simple, if rather crude, piece of post-Cataclysm jewelry: a solitary bullet casing from a handgun cartridge or other such form of ammunition strung upon a length of string, cord, or twine to form a makeshift pendant.  The shell's neck has been daintily drilled through with two tiny holes on opposite sides, through which the cord has been fed and tied off to form a poor man's excuse for a chain, and from where the cartridge hangs, dimpled primer-down.",
        },
        {
            id = "pistol_pendent2",
            text = "A simple, if rather crude, piece of post-Cataclysm jewelry: a solitary bullet casing from a handgun cartridge or other such form of ammunition strung upon a length of string, cord, or twine to form a makeshift pendant.  The dimpled section of the shell's primer has been punched out, and a second hole has been drilled through the casing's side just shy of the base, with the ballistic accoutrement hanging from a section of tied-off cord that has been threaded through both entry points.",
        },
        {
            id = "pistol_pendent3",
            text = "A simple, if rather crude, piece of post-Cataclysm jewelry: a solitary bullet casing from a handgun cartridge or other such form of ammunition strung upon a length of string, cord, or twine to form a makeshift pendant.  The shell's throat has been twisted closed by a set of pliers, creating a spiraled taper where the neck would be, while a hole has been drilled on opposite hemispheres of the pendant's sides, through which a length of string has been threaded.  The cord's loose ends have been wrapped several times around the casing before being tied off, forming a sort of little bullet cocoon.",
        },
    },
    flags = { "NO_WEAR_EFFECT", "BELTED" },
    materials = {
        { id = "brass", portions = 2 },
        { id = "cotton" },
    },
    conditional_names = {
        { kind = "COMPONENT_ID", key = "22_casing", name = "light rifle-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "38_casing", name = "revolver-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "57mm_casing", name = "automatic-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "45colt_casing", name = "revolver-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "357mag_casing", name = "magnum-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "44_casing", name = "magnum-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "454_casing", name = "revolver-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "500_casing", name = "magnum-cartridge necklace" },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_neck" },
                coverage = 20,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "simple_rifle_cartridge_necklace",
    copy_from = "simple_pistol_cartridge_necklace",
    name = "rifle-cartridge necklace",
    description = "Rather crude and clearly put together on a budget, this is a piece of post-Cataclysmic—so-called—jewelry—little more than an unpolished, solitary rifle casing threaded on a length of cord, string, or twine to form a pendent necklace.",
    mass = "25 g",
    volume = "40 ml",
    length = "50 mm",
    snippet_category = {
        {
            id = "rifle_pendent1",
            text = "Rather crude and clearly put together on a budget, this is a piece of post-Cataclysmic—so-called—jewelry—little more than an unpolished, solitary rifle casing threaded on a length of cord, string, or twine to form a pendent necklace.  The cartridge's neck has been carefully drilled through, leaving behind a tiny hole on either side of the shell's throat through which the cord has been fed and tied off, forming a pedestrian facsimile of a chain from where the round hangs, primer-down.",
        },
        {
            id = "rifle_pendent2",
            text = "Rather crude and clearly put together on a budget, this is a piece of post-Cataclysmic—so-called—jewelry—little more than an unpolished, solitary rifle casing threaded on a length of cord, string, or twine to form a pendent necklace.  The primer's indented portion has been drilled away, with a second hole situated in the casing's side just shy of the base and a length of tied-off cordage looping through both entry points to form a makeshift chain for the apparel.",
        },
        {
            id = "rifle_pendent3",
            text = "Rather crude and clearly put together on a budget, this is a piece of post-Cataclysmic—so-called—jewelry—little more than an unpolished, solitary rifle casing threaded on a length of cord, string, or twine to form a pendent necklace.  The jaws of a set of pliers have twisted closed the cartridge's throat with a spiral flourish, while a hole has been drilled through opposite sides of the pendant's shoulder, through which a loop of cord has been threaded.  The string's loose ends have been wrapped several times around the casing in a vague X-pattern before being tied off, creating a form of mini-bullet cocoon.",
        },
    },
    conditional_names = {
        { kind = "COMPONENT_ID", key = "4570_casing", name = "brush gun-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "30carbine_casing", name = "carbine-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "123ln_casing", name = "alien-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "450_casing", name = "Thumper-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "50beowulf_casing", name = "Thumper-cartridge necklace" },
    },
    armor = {},
}

ccb.content.define_item {
    id = "simple_ordnance_cartridge_necklace",
    copy_from = "simple_pistol_cartridge_necklace",
    name = "ordnance-cartridge necklace",
    description = "An expedient means of flaunting one's gunnery prowess, or a crude attempt at overcompensating for matters best left undescribed, this article of craft-produced jewelry is, essentially, one part cordage and three parts mammoth bullet casing: the giant cartridge, either from a grenade round or some other form of heavy munitions, strung to hang upon the chest as a pendent.",
    mass = "37 g",
    volume = "43 ml",
    length = "85 mm",
    snippet_category = {
        {
            id = "ordinance_pendent1",
            text = "An expedient means of flaunting one's gunnery prowess, or a crude attempt at overcompensating for matters best left undescribed, this article of craft-produced jewelry is, essentially, one part cordage and three parts mammoth bullet casing: the giant cartridge, either from a grenade round or some other form of heavy munitions, strung to hang upon the chest as a pendent.  The shell's neck has been carefully tapped, leaving a hole on either side of the casing's throat through which the makeshift neck chain has been fed and tied off.",
        },
        {
            id = "ordinance_pendent2",
            text = "An expedient means of flaunting one's gunnery prowess, or a crude attempt at overcompensating for matters best left undescribed, this article of craft-produced jewelry is, essentially, one part cordage and three parts mammoth bullet casing: the giant cartridge, either from a grenade round or some other form of heavy munitions, strung to hang upon the chest as a pendent.  The center of the shell's struck primer has been punched out, and a second hole has been drilled shy of the rim, with a section of tied-off cordage stringing through both entry points to form a makeshift neck chain.",
        },
        {
            id = "ordinance_pendent3",
            text = "An expedient means of flaunting one's gunnery prowess, or a crude attempt at overcompensating for matters best left undescribed, this article of craft-produced jewelry is, essentially, one part cordage and three parts mammoth bullet casing: the giant cartridge, either from a grenade round or some other form of heavy munitions, strung to hang upon the chest as a pendent.  The jaws of a set of pliers have been laid to work, with the shell's neck twisted closed in a tapered spiral, while a hole has been bored through opposite sides of the cartridge's base, through which a loop of cord has been tugged.  The string's loose ends have been wrapped around the casing in a serpentine pattern before being tied off, creating a manner of bullet cocoon.",
        },
    },
    materials = {
        { id = "brass", portions = 3 },
        { id = "cotton" },
    },
    conditional_names = {
        { kind = "COMPONENT_ID", key = "40x46mm_m212_casing", name = "grenade-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "40x46mm_m118_casing", name = "grenade-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "40x46mm_m199_casing", name = "grenade-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "40x46mm_m195_casing", name = "grenade-cartridge necklace" },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_hornets_nest_22lr_casing",
            name = "grenade-cartridge necklace",
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_hornets_nest_410_casing",
            name = "grenade-cartridge necklace",
        },
        { kind = "COMPONENT_ID", key = "40x53mm_m169_casing", name = "grenade-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "shot_hull", name = "shotgun-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "410shot_hull", name = "shotgun-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "273x110casing", name = "alien-ordnance necklace" },
        { kind = "COMPONENT_ID", key = "273x44casing", name = "alien-ordnance necklace" },
    },
    armor = {},
}

ccb.content.define_item {
    id = "fancy_pistol_cartridge_necklace",
    name = "refined pistol-cartridge necklace",
    description = "The product of a gun nut and a fashionista proverbially shaking one another's hand, this plain, though elegant, necklace has been strung with a solitary, sparklingly polished casing from a handgun cartridge or other such form of ammunition.",
    symbol = "[",
    color = "yellow",
    looks_like = "gold_necklace",
    mass = "56 g",
    volume = "32 ml",
    length = "28 mm",
    price = "400 USD",
    survival_price = "50 cent",
    snippet_category = {
        {
            id = "fancy_pistol_pendent1",
            text = "The product of a gun nut and a fashionista proverbially shaking one another's hand, this plain, though elegant, necklace has been strung with a solitary, sparklingly polished casing from a handgun cartridge or other such form of ammunition.  The shell's primer and rim have been neatly sawed away, and in place of the projectile, a little gemstone has been wrapped with a length of fine-gauge wire and bedded into the casing's throat.  The rest of the wire's length trails back through the cartridge's body, feeding out the base and entwining with a link in the chain.",
        },
        {
            id = "fancy_pistol_pendent2",
            text = "The product of a gun nut and a fashionista proverbially shaking one another's hand, this plain, though elegant, necklace has been strung with a solitary, sparklingly polished casing from a handgun cartridge or other such form of ammunition.  The teeth of a saw have been put to work upon this shell, whose base and primer have been neatly cut away, and in the throat of which has been seated a small, shining gem.  A length of fine wire has been tightly wrapped around both the cartridge and gemstone in a top-down pattern, with the cord's loose ends eventually tugged through a small drill hole at the cartridge's base and finally wrapped among the neck chain's links.",
        },
    },
    flags = { "NO_WEAR_EFFECT", "BELTED" },
    materials = {
        { id = "brass", portions = 2 },
        { id = "gold", portions = 2 },
        { id = "gemstone" },
    },
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "22_casing",
            name = ccb.content.plural_text("Varmints' Bane", "Varmints' Bane"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "32_casing",
            name = ccb.content.plural_text("Short King", "Short King"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "38_casing",
            name = ccb.content.plural_text("Lawman's", "Lawman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "38super_casing",
            name = ccb.content.plural_text("Contestant's", "Contestant's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "40_casing",
            name = ccb.content.plural_text("Federal", "Federal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "10mm_casing",
            name = ccb.content.plural_text("Crockett's Vice", "Crockett's Vice"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "44_casing",
            name = ccb.content.plural_text("Holliday's", "Holliday's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "357mag_casing",
            name = ccb.content.plural_text("Big Iron", "Big Iron"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "45colt_casing",
            name = ccb.content.plural_text("Peacemaker's", "Peacemaker's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "454_casing",
            name = ccb.content.plural_text("Judge's Wrath", "Judge's Wrath"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "460sw_casing",
            name = ccb.content.plural_text("Hyper Velocity", "Hyper Velocity"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "45_casing",
            name = ccb.content.plural_text("God's Caliber", "God's Caliber"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "57mm_casing",
            name = ccb.content.plural_text("Needle Rain", "Needle Rain"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "500_casing",
            name = ccb.content.plural_text("Recoil-Rider", "Recoil-Rider"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "762_25_casing",
            name = ccb.content.plural_text("Revolutionary's", "Revolutionary's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "9mm_casing",
            name = ccb.content.plural_text("Sunrise Parabellum", "Sunrise Parabellum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "357sig_casing",
            name = ccb.content.plural_text("Schweitzer", "Schweitzer"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "9x18mm_casing",
            name = ccb.content.plural_text("Semin", "Semin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "380_casing",
            name = ccb.content.plural_text("Baby Browning", "Baby Browning"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "50ae_casing",
            name = ccb.content.plural_text("Fatman", "Fatman"),
        },
        { kind = "COMPONENT_ID", key = "diamond", name = "%s diamond necklace" },
        { kind = "COMPONENT_ID", key = "garnet", name = "%s garnet necklace" },
        { kind = "COMPONENT_ID", key = "amethyst", name = "%s amethyst necklace" },
        { kind = "COMPONENT_ID", key = "aquamarine", name = "%s aquamarine" },
        { kind = "COMPONENT_ID", key = "emerald", name = "%s emerald necklace" },
        { kind = "COMPONENT_ID", key = "alexandrite", name = "%s alexandrite necklace" },
        { kind = "COMPONENT_ID", key = "malachite", name = "%s malachite necklace" },
        { kind = "COMPONENT_ID", key = "pearl", name = "%s pearl necklace" },
        { kind = "COMPONENT_ID", key = "ruby", name = "%s ruby necklace" },
        { kind = "COMPONENT_ID", key = "peridot", name = "%s peridot necklace" },
        { kind = "COMPONENT_ID", key = "sapphire", name = "%s sapphire necklace" },
        { kind = "COMPONENT_ID", key = "opal", name = "%s opal necklace" },
        { kind = "COMPONENT_ID", key = "tourmaline", name = "%s tourmaline necklace" },
        { kind = "COMPONENT_ID", key = "citrine", name = "%s citrine necklace" },
        { kind = "COMPONENT_ID", key = "blue_topaz", name = "%s topaz necklace" },
        { kind = "COMPONENT_ID", key = "onyx", name = "%s onyx necklace" },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_neck" },
                coverage = 20,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "fancy_rifle_cartridge_necklace",
    copy_from = "fancy_pistol_cartridge_necklace",
    name = "refined rifle-cartridge necklace",
    description = "A gentlemanly article of craft-produced jewelry for the most spiffy ladies and gentlemen of the post-apocalypse, this plain chain of precious metal has been retrofitted with a fired rifle cartridge that hangs from it as a pendant.",
    mass = "57 g",
    volume = "35 ml",
    length = "50 mm",
    snippet_category = {
        {
            id = "fancy_rifle_pendent1",
            text = "A gentlemanly article of craft-produced jewelry for the most spiffy ladies and gentlemen of the post-apocalypse, this plain chain of precious metal has been retrofitted with a fired rifle cartridge that hangs from it as a pendant.  With its brass polished to a mirror-like sheen, the shell's primer and rim have been neatly extricated at the edge of a saw, with a little gemstone peeking out the casing's throat.  The gem's wrapped within the embrace of a length of fine-gauge wire, whose remaining length has been tugged back through the cartridge's body, fed out the base, and entwined with a link in the chain.",
        },
        {
            id = "fancy_rifle_pendent2",
            text = "A gentlemanly article of craft-produced jewelry for the most spiffy ladies and gentlemen of the post-apocalypse, this plain chain of precious metal has been retrofitted with a fired rifle cartridge that hangs from it as a pendant.  With its brass polished to a mirror-like sheen, the shell has grown shorter by virtue of its base having been sawed away, and a glittering jewel has been seated comfortably within the throat.  A length of wire is tightly wrapped around both cartridge and gemstone in a top-down pattern, forming an X-grid as it wines, with the cord's loose ends trailing through a small drill hole at the cartridge's base and tied to the chain's links.",
        },
    },
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "77arisaka_casing",
            name = ccb.content.plural_text("Rising Sun", "Rising Sun"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "545_casing",
            name = ccb.content.plural_text("Devil's Poison", "Devil's Poison"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "4570_casing",
            name = ccb.content.plural_text("Frontiersman's", "Frontiersman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "270win_casing",
            name = ccb.content.plural_text("Sportsman's", "Sportsman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "303_casing",
            name = ccb.content.plural_text("Fusilier's", "Fusilier's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "223_casing",
            name = ccb.content.plural_text("US Diplomacy", "US Diplomacy"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "3006_casing",
            name = ccb.content.plural_text("Old Soldier", "Old Soldier"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "762_51_casing",
            name = ccb.content.plural_text("Pig's Feed", "Pig's Feed"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "300blk_casing",
            name = ccb.content.plural_text("Cloak&Dagger", "Cloak&Dagger"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "762R_casing",
            name = ccb.content.plural_text("White Death", "White Death"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "762_casing",
            name = ccb.content.plural_text("Iron Curtain", "Iron Curtain"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "300_casing",
            name = ccb.content.plural_text("Kyle's Laser", "Kyle's Laser"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "50beowulf_casing",
            name = ccb.content.plural_text("Wolf's Voice", "Wolf's Voice"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "450_casing",
            name = ccb.content.plural_text("Cooper's Touch", "Cooper's Touch"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "30carbine_casing",
            name = ccb.content.plural_text("Paratrooper's", "Paratrooper's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "308_casing",
            name = ccb.content.plural_text("Marksman's", "Marksman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "123ln_casing",
            name = ccb.content.plural_text("Illegal Alien", "Illegal Alien"),
        },
        { kind = "COMPONENT_ID", key = "diamond", name = "%s diamond necklace" },
        { kind = "COMPONENT_ID", key = "garnet", name = "%s garnet necklace" },
        { kind = "COMPONENT_ID", key = "amethyst", name = "%s amethyst necklace" },
        { kind = "COMPONENT_ID", key = "aquamarine", name = "%s aquamarine" },
        { kind = "COMPONENT_ID", key = "emerald", name = "%s emerald necklace" },
        { kind = "COMPONENT_ID", key = "alexandrite", name = "%s alexandrite necklace" },
        { kind = "COMPONENT_ID", key = "malachite", name = "%s malachite necklace" },
        { kind = "COMPONENT_ID", key = "pearl", name = "%s pearl necklace" },
        { kind = "COMPONENT_ID", key = "ruby", name = "%s ruby necklace" },
        { kind = "COMPONENT_ID", key = "peridot", name = "%s peridot necklace" },
        { kind = "COMPONENT_ID", key = "sapphire", name = "%s sapphire necklace" },
        { kind = "COMPONENT_ID", key = "opal", name = "%s opal necklace" },
        { kind = "COMPONENT_ID", key = "tourmaline", name = "%s tourmaline necklace" },
        { kind = "COMPONENT_ID", key = "citrine", name = "%s citrine necklace" },
        { kind = "COMPONENT_ID", key = "blue_topaz", name = "%s topaz necklace" },
        { kind = "COMPONENT_ID", key = "onyx", name = "%s onyx necklace" },
    },
    armor = {},
}

ccb.content.define_item {
    id = "fancy_ordinance_cartridge_necklace",
    copy_from = "fancy_pistol_cartridge_necklace",
    name = "refined ordnance-cartridge necklace",
    description = "An article of hand-produced apparel that George Washington himself could look down upon with an approving smile, the daintiness of this necklace's precious metal chain looks rather comical when compared against the gargantuan pendant that hangs from it: an expended casing from a grenade round, shotgun cartridge, or some other form of sizable munition.",
    mass = "69 g",
    volume = "38 ml",
    length = "85 mm",
    snippet_category = {
        {
            id = "fancy_ordinance_pendent1",
            text = "An article of hand-produced apparel that George Washington himself could look down upon with an approving smile, the daintiness of this necklace's precious metal chain looks rather comical when compared against the gargantuan pendant that hangs from it: an expended casing from a grenade round, shotgun cartridge, or some other form of sizable munition.  With its brass polished to a mirror-like sheen and its rim cleanly extricated by the saw, a well-sized gemstone peers at the world from out of this shell's throat.  The jewel's wrapped within a length of fine-gauge wire, whose remaining length has been tugged through the cartridge's body, fed out the base, and entwined with a link in the chain.",
        },
        {
            id = "fancy_ordinance_pendent2",
            text = "An article of hand-produced apparel that George Washington himself could look down upon with an approving smile, the daintiness of this necklace's precious metal chain looks rather comical when compared against the gargantuan pendant that hangs from it: an expended casing from a grenade round, shotgun cartridge, or some other form of sizable munition.  The shell has, essentially, been rendered into a tiny brass pipe: its base and primer are neatly sawed off, and its head is capped by a large, glittering gemstone that regards the Cataclysm from its seat within the throat.  A length of wire is tightly wrapped around both the cartridge and jewel, with the cord's loose ends trailing through a small drill hole at the shell's base and linked to the neck chain.",
        },
    },
    materials = {
        { id = "brass", portions = 3 },
        { id = "gold", portions = 2 },
        { id = "gemstone" },
    },
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_m118_casing",
            name = ccb.content.plural_text("Grenadier's", "Grenadier's"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_m199_casing",
            name = ccb.content.plural_text("God's Boomstick", "God's Boomstick"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_m195_casing",
            name = ccb.content.plural_text("Tearjerker", "Tearjerker"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_m212_casing",
            name = ccb.content.plural_text("Gentle Persuasion", "Gentle Persuasion"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_hornets_nest_22lr_casing",
            name = ccb.content.plural_text("Beehive", "Beehive"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_hornets_nest_410_casing",
            name = ccb.content.plural_text("Metal Storm", "Metal Storm"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x53mm_m169_casing",
            name = ccb.content.plural_text("Meatgrinder", "Meatgrinder"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "50_casing",
            name = ccb.content.plural_text("Ma Deuce", "Ma Deuce"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "338lapua_casing",
            name = ccb.content.plural_text("Suomi Princess", "Suomi Princess"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "458wm_casing",
            name = ccb.content.plural_text("Huntsman's", "Huntsman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "shot_hull",
            name = ccb.content.plural_text("Street Howitzer", "Street Howitzer"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "410shot_hull",
            name = ccb.content.plural_text("Lancaster's Boar", "Lancaster's Boar"),
        },
        {
            kind = "COMPONENT_ID",
            key = "273x110casing",
            name = ccb.content.plural_text("Shock&Awe", "Shock&Awe"),
        },
        {
            kind = "COMPONENT_ID",
            key = "273x44casing",
            name = ccb.content.plural_text("Diyua Comet", "Diyua Comet"),
        },
        { kind = "COMPONENT_ID", key = "diamond", name = "%s diamond necklace" },
        { kind = "COMPONENT_ID", key = "garnet", name = "%s garnet necklace" },
        { kind = "COMPONENT_ID", key = "amethyst", name = "%s amethyst necklace" },
        { kind = "COMPONENT_ID", key = "aquamarine", name = "%s aquamarine" },
        { kind = "COMPONENT_ID", key = "emerald", name = "%s emerald necklace" },
        { kind = "COMPONENT_ID", key = "alexandrite", name = "%s alexandrite necklace" },
        { kind = "COMPONENT_ID", key = "malachite", name = "%s malachite necklace" },
        { kind = "COMPONENT_ID", key = "pearl", name = "%s pearl necklace" },
        { kind = "COMPONENT_ID", key = "ruby", name = "%s ruby necklace" },
        { kind = "COMPONENT_ID", key = "peridot", name = "%s peridot necklace" },
        { kind = "COMPONENT_ID", key = "sapphire", name = "%s sapphire necklace" },
        { kind = "COMPONENT_ID", key = "opal", name = "%s opal necklace" },
        { kind = "COMPONENT_ID", key = "tourmaline", name = "%s tourmaline necklace" },
        { kind = "COMPONENT_ID", key = "citrine", name = "%s citrine necklace" },
        { kind = "COMPONENT_ID", key = "blue_topaz", name = "%s topaz necklace" },
        { kind = "COMPONENT_ID", key = "onyx", name = "%s onyx necklace" },
    },
    armor = {},
}

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
