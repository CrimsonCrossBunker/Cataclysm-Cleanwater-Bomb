local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Mycology1",
    name = ccb.content.text("Mycology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in mycology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Mycology0Fake1",
    name = ccb.content.text("Mycology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in mycology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Mycology2",
    name = ccb.content.text("Mycology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mycology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Mycology1Fake2",
    name = ccb.content.text("Mycology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mycology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Mycology0Fake2",
    name = ccb.content.text("Mycology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mycology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
