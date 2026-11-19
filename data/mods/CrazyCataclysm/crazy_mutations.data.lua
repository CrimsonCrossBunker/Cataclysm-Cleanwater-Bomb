local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LUCKY",
    name = ccb.content.text("Lucky"),
    points = 3,
    description = ccb.content.text("You're naturally quite lucky!"),
    starting_trait = true,
    valid = false,
    chargen_allow_npc = false,
    cancels = { "UNLUCKY" },
}

ccb.content.define_mutation {
    id = "UNLUCKY",
    name = ccb.content.text("Unlucky"),
    points = -3,
    description = ccb.content.text("You're naturally quite unlucky."),
    starting_trait = true,
    valid = false,
    chargen_allow_npc = false,
    cancels = { "LUCKY" },
}

ccb.content.define_mutation { id = "TROGLO3", copy_from = "TROGLO3", name = ccb.content.text("Gamer") }

ccb.content.define_mutation {
    id = "THRESH_TROGLOBITE",
    copy_from = "THRESH_TROGLOBITE",
    name = ccb.content.text("Basement Dweller"),
    description = ccb.content.text("It might not be your parents', but it's a home."),
}
