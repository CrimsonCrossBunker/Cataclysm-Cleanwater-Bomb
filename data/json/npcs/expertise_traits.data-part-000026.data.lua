local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Medicine1",
    name = ccb.content.text("Medicine Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in medicine, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Medicine0Fake1",
    name = ccb.content.text("Medicine Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in medicine, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Medicine2",
    name = ccb.content.text("Medicine Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in medicine, an MD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Medicine1Fake2",
    name = ccb.content.text("Medicine Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in medicine, an MD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Medicine0Fake2",
    name = ccb.content.text("Medicine Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in medicine, an MD or equivalent."),
    valid = false,
    purifiable = false,
}
