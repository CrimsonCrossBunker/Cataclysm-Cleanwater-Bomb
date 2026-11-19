local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Teaching1",
    name = ccb.content.text("Teaching Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in teaching, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Teaching0Fake1",
    name = ccb.content.text("Teaching Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in teaching, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Teaching2",
    name = ccb.content.text("Teaching Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in teaching, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Teaching1Fake2",
    name = ccb.content.text("Teaching Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in teaching, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Teaching0Fake2",
    name = ccb.content.text("Teaching Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in teaching, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
