local ccb = require("ccb")

ccb.content.define_trait_group {
    id = "NPC_starting_traits",
    kind = "collection",
    entries = { { group = "trait_group_PSION", weight = 100 } },
}

ccb.content.define_trait_group {
    id = "trait_group_PSION",
    kind = "distribution",
    entries = {
        { trait = "CANNOT_GAIN_PSIONICS", weight = 80 },
        { trait = "ALWAYS_GAIN_PSIONICS", weight = 3 },
        { group = "trait_group_NULL", weight = 15 },
        { group = "trait_group_PSION_AWAKENED", weight = 1 },
    },
}

-- This group picks out one of the traits, leading to a 1% chance for an NPC to be a psion.
ccb.content.define_trait_group {
    id = "trait_group_PSION_AWAKENED",
    kind = "distribution",
    entries = {
        { group = "trait_group_BIOKINETIC", weight = 1 },
        { group = "trait_group_CLAIRSENTIENT", weight = 1 },
        { group = "trait_group_ELECTROKINETIC", weight = 1 },
        { group = "trait_group_PHOTOKINETIC", weight = 1 },
        { group = "trait_group_PYROKINETIC", weight = 1 },
        { group = "trait_group_TELEKINETIC", weight = 1 },
        { group = "trait_group_TELEPATH", weight = 1 },
        { group = "trait_group_TELEPORTER", weight = 1 },
        { group = "trait_group_VITAKINETIC", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_NULL",
    kind = "collection",
    entries = {},
}

ccb.content.define_trait_group {
    id = "trait_group_BIOKINETIC",
    kind = "collection",
    entries = {
        { trait = "BIOKINETIC", weight = 100 },
        { trait = "BIOKIN_NEEDS", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_CLAIRSENTIENT",
    kind = "collection",
    entries = {
        { trait = "CLAIRSENTIENT", weight = 100 },
        { trait = "CLAIR_SENSES", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_ELECTROKINETIC",
    kind = "collection",
    entries = {
        { trait = "ELECTROKINETIC", weight = 100 },
        { trait = "ELECTRO_SHIELD", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_PHOTOKINETIC",
    kind = "collection",
    entries = {
        { trait = "PHOTOKINETIC", weight = 100 },
        { trait = "PHOTO_EYES", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_PYROKINETIC",
    kind = "collection",
    entries = {
        { trait = "PYROKINETIC", weight = 100 },
        { trait = "PYROKIN_ADAPTATION", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_TELEKINETIC",
    kind = "collection",
    entries = {
        { trait = "TELEKINETIC", weight = 100 },
        { trait = "TELEKINETIC_GRAB_POCKETS", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_TELEPATH",
    kind = "collection",
    entries = {
        { trait = "TELEPATH", weight = 100 },
        { trait = "TELEPATHIC_SUGGESTION", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_TELEPORTER",
    kind = "collection",
    entries = {
        { trait = "TELEPORTER", weight = 100 },
        { trait = "TELEPORTER_PROTECT", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_VITAKINETIC",
    kind = "collection",
    entries = {
        { trait = "VITAKINETIC", weight = 100 },
        { trait = "VITAKINETIC_HEALTH", weight = 100 },
        { trait = "LIMITED_PSIONICS", weight = 95 },
    },
}
