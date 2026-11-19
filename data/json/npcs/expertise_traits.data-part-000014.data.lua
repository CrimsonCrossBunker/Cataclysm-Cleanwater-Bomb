local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Eng_Electrical1",
    name = ccb.content.text("Electrical Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in electrical engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Electrical0Fake1",
    name = ccb.content.text("Electrical Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in electrical engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Eng_Electrical2",
    name = ccb.content.text("Electrical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in electrical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Eng_Electrical1Fake2",
    name = ccb.content.text("Electrical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in electrical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Electrical0Fake2",
    name = ccb.content.text("Electrical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in electrical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}
