local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Biochemistry1",
    name = ccb.content.text("Biochemistry Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in biochemistry, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Biochemistry0Fake1",
    name = ccb.content.text("Biochemistry Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in biochemistry, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Biochemistry2",
    name = ccb.content.text("Biochemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in biochemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Biochemistry1Fake2",
    name = ccb.content.text("Biochemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in biochemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Biochemistry0Fake2",
    name = ccb.content.text("Biochemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in biochemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
