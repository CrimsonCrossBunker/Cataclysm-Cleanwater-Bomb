local ccb = require("ccb")

ccb.content.define_mutation {
    id = "NO_CASTING_CHANNELING_SPELLS",
    name = ccb.content.text("School Deficiency: Channeling"),
    points = -2,
    description = ccb.content.text("No matter how hard you try, you never managed to master channeling spells.  You are unable to cast any spell of the channeling school."),
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NO_CASTING_CHANNELING_SPELLS" },
}

ccb.content.define_mutation {
    id = "NO_CASTING_EVOCATION_SPELLS",
    name = ccb.content.text("School Deficiency: Evocation"),
    points = -2,
    description = ccb.content.text("No matter how hard you try, you never managed to master evocation spells.  You are unable to cast any spell of the evocation school."),
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NO_CASTING_EVOCATION_SPELLS" },
}

ccb.content.define_mutation {
    id = "NO_CASTING_CONJURATION_SPELLS",
    name = ccb.content.text("School Deficiency: Conjuration"),
    points = -2,
    description = ccb.content.text("No matter how hard you try, you never managed to master conjuration spells.  You are unable to cast any spell of the conjuration school."),
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NO_CASTING_SUMMONING_SPELLS" },
}

ccb.content.define_mutation {
    id = "NO_CASTING_ENHANCEMENT_SPELLS",
    name = ccb.content.text("School Deficiency: Enhancement"),
    points = -2,
    description = ccb.content.text("No matter how hard you try, you never managed to master enhancement spells.  You are unable to cast any spell of the enhancement school."),
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NO_CASTING_ENHANCEMENT_SPELLS" },
}

ccb.content.define_mutation {
    id = "NO_CASTING_ENERVATION_SPELLS",
    name = ccb.content.text("School Deficiency: Enervation"),
    points = -2,
    description = ccb.content.text("No matter how hard you try, you never managed to master enervation spells.  You are unable to cast any spell of the enervation school."),
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NO_CASTING_ENERVATION_SPELLS" },
}

ccb.content.define_mutation {
    id = "NO_CASTING_CONVEYANCE_SPELLS",
    name = ccb.content.text("School Deficiency: Conveyance"),
    points = -2,
    description = ccb.content.text("No matter how hard you try, you never managed to master conveyance spells.  You are unable to cast any spell of the conveyance school."),
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NO_CASTING_CONVEYANCE_SPELLS" },
}

ccb.content.define_mutation {
    id = "NO_CASTING_RESTORATION_SPELLS",
    name = ccb.content.text("School Deficiency: Restoration"),
    points = -2,
    description = ccb.content.text("No matter how hard you try, you never managed to master restoration spells.  You are unable to cast any spell of the restoration school."),
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NO_CASTING_RESTORATION_SPELLS" },
}

ccb.content.define_mutation {
    id = "NO_CASTING_TRANSFORMATION_SPELLS",
    name = ccb.content.text("School Deficiency: Transformation"),
    points = -2,
    description = ccb.content.text("No matter how hard you try, you never managed to master transformation spells.  You are unable to cast any spell of the transformation school."),
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NO_CASTING_TRANSFORMATION_SPELLS" },
}
