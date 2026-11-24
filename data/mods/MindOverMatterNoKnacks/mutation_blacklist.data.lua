local ccb = require("ccb")

ccb.content.define_trait_migration {
    id = "MORE_PSI_ALPHA",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "BIOKINETIC",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "BIOKIN_NEEDS",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "CLAIRSENTIENT",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "CLAIR_SENSES",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "ELECTROKINETIC",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "ELECTRO_SHIELD",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "PHOTOKINETIC",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "PHOTO_EYES",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "PYROKINETIC",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "PYROKIN_ADAPTATION",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "TELEKINETIC",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "TELEKINETIC_GRAB_POCKETS",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "TELEPATH",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "TELEPATHIC_SUGGESTION",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "TELEPORTER",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "TELEPORTER_PROTECT",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "VITAKINETIC",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "VITAKINETIC_HEALTH",
    remove = true,
}

-- Migration doesn't prevent these from showing up in character gen so we need to override the starting trait field
ccb.content.define_mutation { id = "LIMITED_PSIONICS", copy_from = "LIMITED_PSIONICS", starting_trait = false }

ccb.content.define_mutation { id = "ALWAYS_GAIN_PSIONICS", copy_from = "ALWAYS_GAIN_PSIONICS", starting_trait = false }

ccb.content.define_mutation { id = "MOM_PSYCHIC_VAMPIRE", copy_from = "MOM_PSYCHIC_VAMPIRE", starting_trait = false }
