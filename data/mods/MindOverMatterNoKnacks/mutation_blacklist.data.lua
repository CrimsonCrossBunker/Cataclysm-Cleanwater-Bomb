local ccb = require("ccb")

-- Migration doesn't prevent these from showing up in character gen so we need to override the starting trait field
ccb.content.define_mutation { id = "LIMITED_PSIONICS", copy_from = "LIMITED_PSIONICS", starting_trait = false }

ccb.content.define_mutation { id = "ALWAYS_GAIN_PSIONICS", copy_from = "ALWAYS_GAIN_PSIONICS", starting_trait = false }

ccb.content.define_mutation { id = "MOM_PSYCHIC_VAMPIRE", copy_from = "MOM_PSYCHIC_VAMPIRE", starting_trait = false }
