local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Veterinary1",
    name = ccb.content.text("Veterinary Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in veterinary medicine, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Veterinary0Fake1",
    name = ccb.content.text("Veterinary Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in veterinary medicine, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Veterinary2",
    name = ccb.content.text("Veterinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in veterinary medicine, a DVM or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Veterinary1Fake2",
    name = ccb.content.text("Veterinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in veterinary medicine, a DVM or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Veterinary0Fake2",
    name = ccb.content.text("Veterinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in veterinary medicine, a DVM or equivalent."),
    valid = false,
    purifiable = false,
}
