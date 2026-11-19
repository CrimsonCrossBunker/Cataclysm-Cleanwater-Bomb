local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HOMULLUS_DOLL_FORM_TRAITS",
    name = ccb.content.text("Mannequin Form"),
    description = ccb.content.text("You are a doll in truth.  You do not need to eat or drink, and monsters will mostly ignore you, but you do not heal at all and crafting, as well as movement over any ground not almost-perfectly flat, is very difficult due to your stiff limbs."),
    points = 10,
    valid = false,
    appearance = { id = "mon_hallu_mannequin", tile_category = "monster" },
    enchantments = { "INLINE_ENCH_HOMULLUS_DOLL_FORM_TRAITS_0", "INLINE_ENCH_HOMULLUS_DOLL_FORM_TRAITS_1" },
    vitamin_intervals = { vitC = -900, iron = -900, calcium = -900 },
    flags = { "BLEED_IMMUNE", "CANNOT_CONSUME_DRUGS" },
}

-- -91 should be enough that even monsters with 100 aggression won't immediately attack, but they'll be on a hair trigger.
ccb.content.define_mutation {
    id = "HOMULLUS_DOLL_FORM_ANGER_RELATIONS",
    name = ccb.content.text_without_extraction("Mannequin Form Anger Relations"),
    description = ccb.content.text_without_extraction("Anger relations are here in a separate mutation so that they're removed on attacking a target or moving too quickly."),
    points = 2,
    valid = false,
    player_display = false,
    species_anger = {
        HUMAN = -91,
        BIRD = -91,
        MAMMAL = -91,
        ZOMBIE = -91,
        AMPHIBIAN = -91,
        REPTILE = -91,
        FISH = -91,
        KRAKEN = -91,
        MUTANT = -91,
        NETHER = -91,
        SLIME = -91,
        FUNGUS = -91,
        LEECH_PLANT = -91,
        MIGO = -91,
        INSECT = -91,
        CENTIPEDE = -91,
        INSECT_FLYING = -91,
        SPIDER = -91,
        PLANT = -91,
        MOLLUSK = -91,
        WORM = -91,
        FERAL = -91,
        ROBOT = -91,
        HORROR = -91,
        ABERRATION = -91,
        VAMPIRE = -91,
    },
}

ccb.content.define_mutation {
    id = "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER",
    name = ccb.content.text_without_extraction("Mannequin Form Anger Relations Attacker"),
    description = ccb.content.text_without_extraction("This blocks you from gaining the anger relations mutation so you can't just turn Mien of the Mannequin on and off between attacks."),
    points = 2,
    valid = false,
    player_display = false,
}

ccb.content.define_mutation { id = "SOCIAL1", copy_from = "SOCIAL1", add = { categories = { "HOMULLUS" } } }

ccb.content.define_mutation { id = "SOCIAL2", copy_from = "SOCIAL2", add = { categories = { "HOMULLUS" } } }

ccb.content.define_mutation {
    id = "PRETTY",
    copy_from = "PRETTY",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_SELKIE", "LILIN" } },
}

ccb.content.define_mutation {
    id = "BEAUTIFUL",
    copy_from = "BEAUTIFUL",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_SELKIE", "LILIN" } },
}

ccb.content.define_mutation {
    id = "BEAUTIFUL2",
    copy_from = "BEAUTIFUL2",
    add = {
        categories = { "HOMULLUS", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_SELKIE" },
        threshold_requirements = { "THRESH_HOMULLUS", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
    },
}

ccb.content.define_mutation {
    id = "BEAUTIFUL3",
    copy_from = "BEAUTIFUL3",
    add = {
        categories = { "HOMULLUS", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_SELKIE" },
        threshold_requirements = { "THRESH_HOMULLUS", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
    },
}

ccb.content.define_mutation {
    id = "STR_UP",
    copy_from = "STR_UP",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_TROW" } },
}

ccb.content.define_mutation {
    id = "STR_UP_2",
    copy_from = "STR_UP_2",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_TROW" } },
}

ccb.content.define_mutation {
    id = "STR_ALPHA",
    copy_from = "STR_ALPHA",
    add = { categories = { "HOMULLUS" }, threshold_requirements = { "THRESH_HOMULLUS" } },
}

ccb.content.define_mutation {
    id = "DEX_UP",
    copy_from = "DEX_UP",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_BROWNIE" } },
}

ccb.content.define_mutation {
    id = "DEX_UP_2",
    copy_from = "DEX_UP_2",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_BROWNIE" } },
}

ccb.content.define_mutation {
    id = "DEX_ALPHA",
    copy_from = "DEX_ALPHA",
    add = { categories = { "HOMULLUS" }, threshold_requirements = { "THRESH_HOMULLUS" } },
}

ccb.content.define_mutation { id = "INT_UP", copy_from = "INT_UP", add = { categories = { "HOMULLUS" } } }

ccb.content.define_mutation { id = "INT_UP_2", copy_from = "INT_UP_2", add = { categories = { "HOMULLUS" } } }

ccb.content.define_mutation {
    id = "INT_ALPHA",
    copy_from = "INT_ALPHA",
    add = { categories = { "HOMULLUS" }, threshold_requirements = { "THRESH_HOMULLUS" } },
}

ccb.content.define_mutation {
    id = "PER_UP",
    copy_from = "PER_UP",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_POOKA" } },
}

ccb.content.define_mutation {
    id = "PER_UP_2",
    copy_from = "PER_UP_2",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_POOKA" } },
}

ccb.content.define_mutation {
    id = "PER_ALPHA",
    copy_from = "PER_ALPHA",
    add = { categories = { "HOMULLUS" }, threshold_requirements = { "THRESH_HOMULLUS" } },
}
