local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Sanitation1",
    name = ccb.content.text("Sanitation Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in sanitation, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Sanitation0Fake1",
    name = ccb.content.text("Sanitation Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in sanitation, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Sanitation2",
    name = ccb.content.text("Sanitation Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in sanitation."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Sanitation1Fake2",
    name = ccb.content.text("Sanitation Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in sanitation."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Sanitation0Fake2",
    name = ccb.content.text("Sanitation Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in sanitation."),
    valid = false,
    purifiable = false,
}
