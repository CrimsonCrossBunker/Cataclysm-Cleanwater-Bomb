local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Bookkeeping1",
    name = ccb.content.text("Bookkeeping Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in bookkeeping, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Bookkeeping0Fake1",
    name = ccb.content.text("Bookkeeping Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in bookkeeping, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Bookkeeping2",
    name = ccb.content.text("Bookkeeping Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in bookkeeping."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Bookkeeping1Fake2",
    name = ccb.content.text("Bookkeeping Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in bookkeeping."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Bookkeeping0Fake2",
    name = ccb.content.text("Bookkeeping Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in bookkeeping."),
    valid = false,
    purifiable = false,
}
