local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical1",
    name = ccb.content.text("Mechanical Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in mechanical engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical0Fake1",
    name = ccb.content.text("Mechanical Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in mechanical engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical2",
    name = ccb.content.text("Mechanical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mechanical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical1Fake2",
    name = ccb.content.text("Mechanical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mechanical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical0Fake2",
    name = ccb.content.text("Mechanical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mechanical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}
