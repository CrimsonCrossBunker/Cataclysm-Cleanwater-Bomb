local ccb = require("ccb")

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
