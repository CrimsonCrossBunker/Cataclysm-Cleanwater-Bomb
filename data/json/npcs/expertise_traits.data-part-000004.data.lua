local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Biology1",
    name = ccb.content.text("Biology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in general biology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Biology0Fake1",
    name = ccb.content.text("Biology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in general biology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Biology2",
    name = ccb.content.text("Biology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in general biology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Biology1Fake2",
    name = ccb.content.text("Biology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in general biology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Biology0Fake2",
    name = ccb.content.text("Biology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in general biology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
