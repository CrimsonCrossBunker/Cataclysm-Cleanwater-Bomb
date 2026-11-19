local ccb = require("ccb")

-- Mainlined from a mod originally written by Spencer Michaels
-- This group picks out several negative and positive traits
-- This implicitly extends if attempting to add to it for mod purposes
ccb.content.define_trait_group {
    id = "NPC_starting_traits",
    kind = "collection",
    entries = {
        { group = "trait_group_NONADDICTIVE", weight = 10 },
        { group = "trait_group_EASYSLEEPER", weight = 10 },
        { group = "trait_group_ANIMALEMPATH", weight = 10 },
        { group = "trait_group_FASTHEALER", weight = 15 },
        { group = "trait_group_FASTLEARNER", weight = 15 },
        { group = "trait_group_FASTREADER", weight = 10 },
        { group = "trait_group_FLEET", weight = 15 },
        { group = "trait_group_GOODHEARING", weight = 10 },
        { group = "trait_group_GOODMEMORY", weight = 10 },
        { group = "trait_group_DRUNKEN", weight = 10 },
        { group = "trait_group_GOODCARDIO", weight = 10 },
        { group = "trait_group_WAKEFUL", weight = 10 },
        { group = "trait_group_LIGHTSTEP", weight = 10 },
        { group = "trait_group_OPTIMISTIC", weight = 10 },
        { group = "trait_group_PACKMULE", weight = 10 },
        { group = "trait_group_PARKOUR", weight = 10 },
        { group = "trait_group_PRETTY", weight = 10 },
        { group = "trait_group_PSYCHOPATH", weight = 10 },
        { group = "trait_group_EAGLEEYED", weight = 10 },
        { group = "trait_group_MARTIAL_ARTS", weight = 15 },
        { group = "trait_group_LIAR", weight = 40 },
        { group = "trait_group_STRONGBACK", weight = 15 },
        { group = "trait_group_STRONGSTOMACH", weight = 10 },
        { group = "trait_group_TOUGH", weight = 20 },
        { group = "trait_group_WEAKSCENT", weight = 10 },
        { group = "trait_group_PAINRESIST", weight = 10 },
        { group = "trait_group_PROJUNK", weight = 5 },
        { trait = "DEFT", weight = 10 },
        { trait = "DISRESISTANT", weight = 10 },
        { trait = "ADRENALINE", weight = 10 },
        { trait = "INFRESIST", weight = 15 },
        { trait = "MASOCHIST", weight = 10 },
        { trait = "NIGHTVISION", weight = 10 },
        { trait = "OUTDOORSMAN", weight = 10 },
        { trait = "POISRESIST", weight = 10 },
        { trait = "QUICK", weight = 10 },
        { trait = "ROBUST", weight = 10 },
        { trait = "SPIRITUAL", weight = 10 },
        { trait = "TERRIFYING", weight = 10 },
        { trait = "TOUGH_FEET", weight = 10 },
        { trait = "ALBINO", weight = 1 },
        { trait = "ASTHMA", weight = 10 },
        { trait = "CHEMIMBALANCE", weight = 10 },
        { trait = "HEAVYSLEEPER", weight = 10 },
        { trait = "HYPEROPIC", weight = 10 },
        { trait = "GLASSJAW", weight = 10 },
        { trait = "ANTIFRUIT", weight = 10 },
        { trait = "MEATARIAN", weight = 5 },
        { trait = "HOARDER", weight = 10 },
        { trait = "JITTERY", weight = 10 },
        { trait = "LACTOSE", weight = 10 },
        { trait = "VEGETARIAN", weight = 15 },
        { trait = "MOODSWINGS", weight = 10 },
        { trait = "SAVANT", weight = 10 },
        { trait = "SCHIZOPHRENIC", weight = 1 },
        { trait = "SQUEAMISH", weight = 20 },
        { trait = "ANTIWHEAT", weight = 5 },
        { trait = "WOOLALLERGY", weight = 5 },
        { trait = "SEASONAL_ALLERGIES", weight = 8 },
        { trait = "SEASONAL_AFFECTIVE", weight = 5 },
    },
}

-- This group picks out one of the excluding traits.
ccb.content.define_trait_group {
    id = "trait_group_NONADDICTIVE",
    kind = "distribution",
    entries = { { trait = "NONADDICTIVE" }, { trait = "ADDICTIVE" } },
}

ccb.content.define_trait_group {
    id = "trait_group_EASYSLEEPER",
    kind = "distribution",
    entries = { { trait = "EASYSLEEPER" }, { trait = "INSOMNIA" } },
}

ccb.content.define_trait_group {
    id = "trait_group_ANIMALEMPATH",
    kind = "distribution",
    entries = { { trait = "ANIMALEMPATH" }, { trait = "ANIMALDISCORD" } },
}

ccb.content.define_trait_group {
    id = "trait_group_FASTHEALER",
    kind = "distribution",
    entries = { { trait = "FASTHEALER" }, { trait = "SLOWHEALER" } },
}

ccb.content.define_trait_group {
    id = "trait_group_FASTLEARNER",
    kind = "distribution",
    entries = { { trait = "FASTLEARNER" }, { trait = "SLOWLEARNER" } },
}

ccb.content.define_trait_group {
    id = "trait_group_FASTREADER",
    kind = "distribution",
    entries = { { trait = "FASTREADER" }, { trait = "SLOWREADER" }, { trait = "ILLITERATE", weight = 5 } },
}

ccb.content.define_trait_group {
    id = "trait_group_FLEET",
    kind = "distribution",
    entries = { { trait = "FLEET" }, { trait = "SLOWRUNNER" } },
}

ccb.content.define_trait_group {
    id = "trait_group_GOODHEARING",
    kind = "distribution",
    entries = { { trait = "GOODHEARING" }, { trait = "BADHEARING" } },
}

ccb.content.define_trait_group {
    id = "trait_group_GOODMEMORY",
    kind = "distribution",
    entries = { { trait = "GOODMEMORY" }, { trait = "FORGETFUL" } },
}

ccb.content.define_trait_group {
    id = "trait_group_DRUNKEN",
    kind = "distribution",
    entries = { { trait = "TOLERANCE" }, { trait = "LIGHTWEIGHT" } },
}

ccb.content.define_trait_group {
    id = "trait_group_GOODCARDIO",
    kind = "distribution",
    entries = { { trait = "GOODCARDIO" }, { trait = "BADCARDIO" } },
}

ccb.content.define_trait_group {
    id = "trait_group_WAKEFUL",
    kind = "distribution",
    entries = { { trait = "WAKEFUL" }, { trait = "SLEEPY" } },
}

-- currently not used as NPC needs are a bit out of whack and disabled by default.
ccb.content.define_trait_group {
    id = "trait_group_LIGHTEATER",
    kind = "distribution",
    entries = { { trait = "LIGHTEATER" }, { trait = "HUNGER" } },
}

ccb.content.define_trait_group {
    id = "trait_group_LIGHTSTEP",
    kind = "distribution",
    entries = { { trait = "LIGHTSTEP" }, { trait = "CLUMSY" } },
}

ccb.content.define_trait_group {
    id = "trait_group_OPTIMISTIC",
    kind = "distribution",
    entries = { { trait = "OPTIMISTIC" }, { trait = "BADTEMPER" } },
}

ccb.content.define_trait_group {
    id = "trait_group_PACKMULE",
    kind = "distribution",
    entries = { { trait = "PACKMULE" }, { trait = "DISORGANIZED" } },
}

ccb.content.define_trait_group {
    id = "trait_group_PARKOUR",
    kind = "distribution",
    entries = { { trait = "GOODCARDIO" }, { trait = "BADKNEES" } },
}

ccb.content.define_trait_group {
    id = "trait_group_PRETTY",
    kind = "distribution",
    entries = { { trait = "PRETTY" }, { trait = "UGLY" } },
}

ccb.content.define_trait_group {
    id = "trait_group_PSYCHOPATH",
    kind = "distribution",
    entries = { { trait = "PSYCHOPATH" }, { trait = "PACIFIST" } },
}

ccb.content.define_trait_group {
    id = "trait_group_EAGLEEYED",
    kind = "distribution",
    entries = { { trait = "EAGLEEYED" }, { trait = "MYOPIC" } },
}

ccb.content.define_trait_group {
    id = "trait_group_MARTIAL_ARTS",
    kind = "distribution",
    entries = {
        { trait = "MARTIAL_ARTS" },
        { trait = "MARTIAL_ARTS2" },
        { trait = "MARTIAL_ARTS3" },
        { trait = "MARTIAL_ARTS5" },
    },
}

-- NOTE: These traits should be used as conditionals to affect the difficulty of NPCs lying about the expertise they have.
ccb.content.define_trait_group {
    id = "trait_group_LIAR",
    kind = "distribution",
    entries = { { trait = "LIAR" }, { trait = "TRUTHTELLER" } },
}

ccb.content.define_trait_group {
    id = "trait_group_STRONGBACK",
    kind = "distribution",
    entries = { { trait = "STRONGBACK" }, { trait = "BADBACK" } },
}

ccb.content.define_trait_group {
    id = "trait_group_STRONGSTOMACH",
    kind = "distribution",
    entries = { { trait = "STRONGSTOMACH" }, { trait = "WEAKSTOMACH" } },
}

ccb.content.define_trait_group {
    id = "trait_group_TOUGH",
    kind = "distribution",
    entries = { { trait = "TOUGH" }, { trait = "FLIMSY" }, { trait = "FLIMSY2" }, { trait = "FLIMSY3" } },
}

ccb.content.define_trait_group {
    id = "trait_group_WEAKSCENT",
    kind = "distribution",
    entries = { { trait = "WEAKSCENT" }, { trait = "SMELLY" } },
}

ccb.content.define_trait_group {
    id = "trait_group_PAINRESIST",
    kind = "distribution",
    entries = { { trait = "PAINRESIST" }, { trait = "MORE_PAIN" } },
}

ccb.content.define_trait_group {
    id = "trait_group_PROJUNK",
    kind = "distribution",
    entries = { { trait = "PROJUNK" }, { trait = "ANTIJUNK" } },
}
