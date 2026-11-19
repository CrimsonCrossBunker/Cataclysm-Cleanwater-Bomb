local ccb = require("ccb")

ccb.content.define_mutation {
    id = "NUMB",
    name = ccb.content.text("Numb"),
    description = ccb.content.text("Your ability to feel or express emotion has been greatly hampered."),
    categories = { "MEDICAL", "INTERSTICE" },
    types = { "HUMAN_EMPATHY" },
    threshold_requirements = { "THRESH_MEDICAL", "THRESH_INTERSTICE" },
    replacements = { "INTERSTICE_MIND" },
    points = 0,
    purifiable = false,
    vitamin_cost = 160,
    flags = { "NUMB" },
}

ccb.content.define_mutation {
    id = "STIMBOOST",
    name = ccb.content.text("Stimulant Psychosis"),
    description = ccb.content.text("You have a unique history with stimulants (like coffee or amphetamines).  You can tolerate a lot more of them without overdosing, but if you indulge too much, you start seeing things…"),
    categories = { "MEDICAL" },
    cancels = { "NONADDICTIVE" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "PAINREC1",
    name = ccb.content.text("Pain Recovery"),
    description = ccb.content.text("You recover from pain slightly faster than normal."),
    categories = { "MEDICAL" },
    types = { "PAIN_RECOVERY" },
    replacements = { "PAINREC2" },
    points = 3,
    vitamin_cost = 160,
}
