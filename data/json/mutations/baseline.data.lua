local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HUMAN_ADDONS",
    name = ccb.content.text_without_extraction("No Extras"),
    description = ccb.content.text_without_extraction("You don't have any tails, whiskers, horns, or miscellaneous extra bits."),
    categories = { "HUMAN" },
    types = { "BIOLUM", "HORNS", "HAIR", "TAIL", "WHISKERS", "WINGS", "TUSKS", "BODY_ARMOR_MOD" },
    cancels = {
        "ARM_FEATHERS",
        "CF_HAIR",
        "HAIRROOTS",
        "INK_GLANDS",
        "THORNS",
        "TRANSPIRATION",
        "WEB_RAPPEL",
        "WEB_ROPE",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_ACCLIMATIZATION",
    name = ccb.content.text_without_extraction("Human Acclimatization"),
    description = ccb.content.text_without_extraction("Your temperature tolerance is more or less normal for a human."),
    categories = { "HUMAN" },
    cancels = {
        "INTERSTICE_RESISTCHILL_RESISTWARM", "INTERSTICE_RESISTCHILL_RESISTWARM_2",
        "STRONGER_RESISTCHILL", "STRONGER_RESISTWARM", "STRONGER_VULNERABLEWARM",
        "STRONGER_VULNERABLECHILL", "VULNERABLECHILL", "VULNERABLEWARM",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_APPEAL",
    name = ccb.content.text_without_extraction("Human Appeal"),
    description = ccb.content.text_without_extraction("Your attractiveness would be considered unremarkable by the average human."),
    categories = { "HUMAN" },
    types = { "ATTRACTIVENESS" },
    cancels = { "DEFORMED_INTERSTICE" },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_ARMS",
    name = ccb.content.text_without_extraction("Human Arms"),
    description = ccb.content.text_without_extraction("You have human arms."),
    categories = { "HUMAN" },
    types = { "ARMS" },
    prerequisites = { "HUMAN_HANDS" },
    cancels = { "BENDY1", "BENDY2", "BENDY3", "INTERSTICE_LIMBS" },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_BLOOD",
    name = ccb.content.text_without_extraction("Human Blood"),
    description = ccb.content.text_without_extraction("You have human blood."),
    categories = { "HUMAN" },
    types = { "BLOOD" },
    cancels = { "ACIDBLOOD" },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_STATS",
    name = ccb.content.text_without_extraction("Human Capabilities"),
    description = ccb.content.text_without_extraction("Your capabilities are pretty normal."),
    categories = { "HUMAN" },
    types = { "STR", "DEX", "PER", "INT", "BONES", "BUILD", "DURABILITY", "ECTOTHERMIC", "SIZE" },
    cancels = {
        "ACIDBLOOD", "ACIDPROOF", "BADBACK", "ELECTRORECEPTORS", "FAST_REFLEXES", "FRESHWATEROSMOSIS",
        "GASTROPOD_EXTREMITY1", "GLASSJAW", "INTERSTICE_PHYSIOLOGY", "INTERSTICE_POSTURE",
        "INTERSTICE_POSTURE_2", "M_BLOOM", "M_BLOSSOMS", "M_FERTILE", "M_SPORES", "NIGHT_RAIDER",
        "POISONOUS", "POISONOUS2", "RADIOGENIC", "RADIOPHILE", "RESISTCHILL", "RESISTCHILL_RESISTWARM",
        "RESISTWARM", "ROBUST", "RESTRICTED", "RESISTANT_GENETICS", "STOCKY_TROGLO", "STRONGBACK",
        "TUNNEL_FIGHTER", "UNSTABLE",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_EARS",
    name = ccb.content.text_without_extraction("Human Ears"),
    description = ccb.content.text_without_extraction("You have human ears and hearing."),
    categories = { "HUMAN" },
    types = { "EARS", "HEARING" },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_EYES",
    name = ccb.content.text_without_extraction("Human Eyes"),
    description = ccb.content.text_without_extraction("You have human eyes."),
    categories = { "HUMAN" },
    types = { "EYES", "VISION" },
    cancels = {
        "EAGLEEYED", "EYEBULGE", "INFRARED", "INTERSTICEEYES", "INTERSTICE_VISION", "INTERSTICE_VISION2",
        "MEMBRANE", "MYOPIC", "HYPEROPIC", "MESOPIC", "SEESLEEP",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_HANDS",
    name = ccb.content.text_without_extraction("Human Hands"),
    description = ccb.content.text_without_extraction("You have human hands."),
    categories = { "HUMAN" },
    types = { "HANDS", "CLAWS" },
    cancels = { "CLAWS_TENTACLE", "SLIME_HANDS" },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_HEALING",
    name = ccb.content.text_without_extraction("Human Healing"),
    description = ccb.content.text_without_extraction("You heal as fast as most humans do in this new world."),
    categories = { "HUMAN" },
    types = { "HEALING", "PAIN", "PAIN_RECOVERY" },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_IMMUNITY",
    name = ccb.content.text_without_extraction("Human Immunity"),
    description = ccb.content.text_without_extraction("Your immune system is more or less normal for a human."),
    categories = { "HUMAN" },
    cancels = {
        "DISIMMUNE", "DISRESISTANT", "INFIMMUNE", "INFRESIST", "NONADDICTIVE", "PARAIMMUNE",
        "POISRESIST", "STIMBOOST", "SEASONAL_ALLERGIES",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_LEGS",
    name = ccb.content.text_without_extraction("Human Legs"),
    description = ccb.content.text_without_extraction("You have human legs."),
    categories = { "HUMAN" },
    types = { "LEGS", "RUNNING", "FEET", "SOLES" },
    cancels = {
        "BADKNEES", "BENDY1", "BENDY2", "BENDY3", "CLUMSY", "FELINE_LEAP", "GASTROPOD_BALANCE",
        "INTERSTICE_LIMBS", "LEAPING_LEGS", "LEAPING_LEGS2", "LEG_TENT_BRACE", "SCUTTLE", "LIGHTSTEP",
        "STRONGKNEES",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_METABOLISM",
    name = ccb.content.text_without_extraction("Human Metabolism"),
    description = ccb.content.text_without_extraction("Your digestive system and cardio health are standard for a human."),
    categories = { "HUMAN" },
    types = { "METABOLISM", "CARDIO", "CONSTITUTION", "DIET", "GRAZING", "THIRST" },
    cancels = {
        "ALCMET", "ANTIJUNK", "CARNIVORE_FAKE", "DEFT", "FAT", "GOURMAND", "HIBERNATE", "PROJUNK",
        "QUICK", "ANTIWHEAT", "SAPROVORE", "PICKYEATER",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_MIND",
    name = ccb.content.text_without_extraction("Human Mind"),
    description = ccb.content.text_without_extraction("Your mind and brain chemistry are not mutated."),
    categories = { "HUMAN" },
    types = {
        "ANIMAL_EMPATHY",
        "SOCIAL",
        "ATTITUDE",
        "HUMAN_EMPATHY",
        "MASOCHISM",
        "MEMORY",
        "SLEEPINESS",
        "WANDERLUST",
    },
    cancels = {
        "ADDICTIVE", "ADRENALINE", "ADRENALINE2", "CHEMIMBALANCE", "HATES_WATER", "HEAVYSLEEPER",
        "HEAVYSLEEPER2", "INTERSTICE_RESONANCE_2", "JEKYLL", "JITTERY", "LIGHTWEIGHT", "MOODSWINGS",
        "MUT_JUNKIE", "NARCOLEPTIC", "NOPAIN", "SCHIZOPHRENIC", "TOLERANCE", "TREE_COMMUNION", "VANITY",
        "EMOTIONALVOLATILITY", "EMOTIONALFLATNESS",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_MOUTH",
    name = ccb.content.text_without_extraction("Human Mouth"),
    description = ccb.content.text_without_extraction("You have a human mouth with human teeth."),
    categories = { "HUMAN" },
    types = { "MUZZLE", "TEETH", "TONGUE" },
    cancels = { "SLIT_NOSTRILS", "LEAFNOSE", "BLOODLETTER" },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_SLEEP",
    name = ccb.content.text_without_extraction("Human Rest"),
    description = ccb.content.text_without_extraction("You sleep a normal amount for a human."),
    categories = { "HUMAN" },
    types = { "SLEEP" },
    cancels = { "DIRTSLEEPER", "WATERSLEEP", "WATERSLEEPER" },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_SKIN",
    name = ccb.content.text_without_extraction("Human Skin"),
    description = ccb.content.text_without_extraction("You have human skin and no distinct smell."),
    categories = { "HUMAN" },
    types = {
        "ARMOR",
        "BODY_ARMOR",
        "GILLS",
        "PHEROMONE",
        "SCENT",
        "SECRETION",
        "SKIN",
        "SUNLIGHT",
        "TORSO_ARMOR",
    },
    cancels = {
        "ALBINO", "BOMBADIER_BLAST", "CAMO1", "CAMO2", "MUCUS_SECRETION", "MUCUS_SECRETION2", "PALE",
        "SLIME_SPRAY", "SNAIL_TRAIL", "SORES", "SPOTS", "SUNBURN", "VISCOUS", "WEB_WALKER",
    },
    points = 0,
    dummy = true,
    player_display = false,
}

ccb.content.define_mutation {
    id = "HUMAN_VOICE",
    name = ccb.content.text_without_extraction("Human Voice"),
    description = ccb.content.text_without_extraction("Your voice doesn't sound especially abnormal."),
    categories = { "HUMAN" },
    types = { "VOICE_TONE" },
    cancels = { "BOOMING_VOICE", "SHOUT1", "SHOUT2", "SHOUT3" },
    points = 0,
    dummy = true,
    player_display = false,
}
