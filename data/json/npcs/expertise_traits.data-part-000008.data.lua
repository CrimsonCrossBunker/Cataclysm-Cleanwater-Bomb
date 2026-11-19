local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Botany1",
    name = ccb.content.text("Botany Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in botany, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Botany0Fake1",
    name = ccb.content.text("Botany Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in botany, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Botany2",
    name = ccb.content.text("Botany Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in botany, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Botany1Fake2",
    name = ccb.content.text("Botany Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in botany, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Botany0Fake2",
    name = ccb.content.text("Botany Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in botany, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}
