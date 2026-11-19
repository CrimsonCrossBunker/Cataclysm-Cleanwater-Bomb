local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Agriculture1",
    name = ccb.content.text("Agriculture Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in agriculture, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Agriculture0Fake1",
    name = ccb.content.text("Agriculture Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in agriculture, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Agriculture2",
    name = ccb.content.text("Agriculture Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in agriculture."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Agriculture1Fake2",
    name = ccb.content.text("Agriculture Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in agriculture."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Agriculture0Fake2",
    name = ccb.content.text("Agriculture Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in agriculture."),
    valid = false,
    purifiable = false,
}
