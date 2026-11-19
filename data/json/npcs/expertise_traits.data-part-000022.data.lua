local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Entomology1",
    name = ccb.content.text("Entomology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in entomology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Entomology0Fake1",
    name = ccb.content.text("Entomology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in entomology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Entomology2",
    name = ccb.content.text("Entomology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in entomology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Entomology1Fake2",
    name = ccb.content.text("Entomology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in entomology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Entomology0Fake2",
    name = ccb.content.text("Entomology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in entomology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
