local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Eng_Software1",
    name = ccb.content.text("Software Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in software engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Software0Fake1",
    name = ccb.content.text("Software Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in software engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Eng_Software2",
    name = ccb.content.text("Software Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in software engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Eng_Software1Fake2",
    name = ccb.content.text("Software Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in software engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Software0Fake2",
    name = ccb.content.text("Software Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in software engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}
