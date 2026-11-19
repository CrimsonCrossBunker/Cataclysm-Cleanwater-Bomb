local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_blood_drinker",
    name = ccb.content.text("Hemophage"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You do not drink…wine.  You are immune to the negative consequences of drinking blood, such as parasitic infection."),
    flags = { "PERK", "HEMOVORE" },
}

ccb.content.define_mutation {
    id = "perk_blood_drinking_heal",
    name = ccb.content.text("The Blood is the Life"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Drinking blood makes you feel really good.  REALLY good.  So good that all your aches and pains just seem to fade away.  Every time you drink blood, you heal a bit of damage and lose a bit of pain."),
    flags = { "PERK" },
}
