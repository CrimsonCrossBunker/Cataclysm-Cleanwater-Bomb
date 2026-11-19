local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Geology1",
    name = ccb.content.text("Geology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in geology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Geology0Fake1",
    name = ccb.content.text("Geology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in geology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Geology2",
    name = ccb.content.text("Geology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in geology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Geology1Fake2",
    name = ccb.content.text("Geology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in geology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Geology0Fake2",
    name = ccb.content.text("Geology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in geology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
