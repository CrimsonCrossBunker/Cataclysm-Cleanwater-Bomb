local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Culinary1",
    name = ccb.content.text("Culinary Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in culinary arts, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Culinary0Fake1",
    name = ccb.content.text("Culinary Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in culinary arts, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Culinary2",
    name = ccb.content.text("Culinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in culinary arts, a professional chef or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Culinary1Fake2",
    name = ccb.content.text("Culinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in culinary arts, a professional chef or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Culinary0Fake2",
    name = ccb.content.text("Culinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in culinary arts, a professional chef or equivalent."),
    valid = false,
    purifiable = false,
}
