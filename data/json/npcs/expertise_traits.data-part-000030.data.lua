local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Physics1",
    name = ccb.content.text("Physics Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in physics, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Physics0Fake1",
    name = ccb.content.text("Physics Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in physics, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Physics2",
    name = ccb.content.text("Physics Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in physics, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Physics1Fake2",
    name = ccb.content.text("Physics Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in physics, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Physics0Fake2",
    name = ccb.content.text("Physics Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in physics, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
