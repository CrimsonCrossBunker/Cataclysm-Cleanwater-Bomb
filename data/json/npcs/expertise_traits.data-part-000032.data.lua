local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Psychology1",
    name = ccb.content.text("Psychology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in psychology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Psychology0Fake1",
    name = ccb.content.text("Psychology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in psychology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Psychology2",
    name = ccb.content.text("Psychology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in psychology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Psychology1Fake2",
    name = ccb.content.text("Psychology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in psychology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Psychology0Fake2",
    name = ccb.content.text("Psychology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in psychology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
