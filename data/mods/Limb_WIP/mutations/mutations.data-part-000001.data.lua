local ccb = require("ccb")

-- One changing limb per changed area
ccb.content.define_mutation_type {
    id = "CHANGING_LIMB_EYES",
}

ccb.content.define_mutation_type {
    id = "CHANGING_LIMB_HEAD",
}

ccb.content.define_mutation_type {
    id = "HEAD",
}
