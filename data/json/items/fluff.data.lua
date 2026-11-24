local ccb = require("ccb")

-- The pom poms could make use of their own type of tick_action.
ccb.content.define_item {
    id = "pom_poms",
    name = ccb.content.plural_text("pom poms (pair)", "pom poms (pair)"),
    category = "other",
    mass = "150 g",
    color = "red",
    symbol = "O",
    description = ccb.content.text("A pair of red and silver pom poms with plastic handles.  Using them will make you start a cheerleading routine."),
    price = "6 USD",
    survival_price = "20 cent",
    materials = { "plastic" },
    volume = "250 ml",
    length = "10 cm",
    flags = { "SLEEP_IGNORE" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { thickness = 0.1 },
    use_actions = { { kind = "play_instrument" } },
    tick_actions = {
        {
            kind = "musical_instrument",
            speed_penalty = 10,
            volume = 10,
            fun = -5,
            fun_bonus = 2,
            description_interval = 20,
            player_messages = {
                "You make a skillful routine with the pom poms.",
                "You move with refinement while using the pom poms.",
            },
            npc_messages = {
                "makes a skillful routine with the pom poms.",
                "moves with refinement while using the pom poms.",
            },
        },
    },
}

ccb.content.define_item {
    id = "xedra_seismograph",
    name = ccb.content.text("portable seismograph"),
    description = ccb.content.text("A sturdy steel briefcase, containing what appears to be an old-fashioned drum seismograph.  The stenciled acronyms of its outer case imply it was used by XEDRA as some sort of recording device.\n\nThin parallel lines cover both ends of the drum, but as they approach the middle their vibrations intensify, until the ink fuses into a thick red stain."),
    mass = "5000 g",
    volume = "15750 ml",
    price = "240 USD",
    survival_price = "50 cent",
    accuracy = { grip = "none", length = "long", surface = "any", balance = "clumsy" },
    materials = { "steel" },
    symbol = "?",
    looks_like = "briefcase",
    color = "light_gray",
    flags = { "OVERSIZE", "BELTED", "RESTRICT_HANDS", "WATER_FRIENDLY" },
    melee_damage = { bash = 16 },
    armor = {
        sided = true,
        thickness = 2,
        portions = { { encumbrance = 45, coverage = 10, covers = { "arm_l", "arm_r", "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "incense",
    category = "other",
    name = ccb.content.plural_text("incense", "incense"),
    description = ccb.content.text("A small rod giving off a nice smell."),
    mass = "2 g",
    volume = "50 ml",
    length = "17 cm",
    price = "10 cent",
    survival_price = "2 cent",
    materials = { "wood" },
    symbol = "i",
    color = "brown",
    flags = { "NO_REPAIR" },
    ammunition = { type = "incense", count = 10 },
}
