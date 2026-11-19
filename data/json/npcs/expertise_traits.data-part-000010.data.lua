local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Chemistry1",
    name = ccb.content.text("Chemistry Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in inorganic chemistry, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Chemistry0Fake1",
    name = ccb.content.text("Chemistry Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in inorganic chemistry, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Chemistry2",
    name = ccb.content.text("Chemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in inorganic chemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Chemistry1Fake2",
    name = ccb.content.text("Chemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in inorganic chemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Chemistry0Fake2",
    name = ccb.content.text("Chemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in inorganic chemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
