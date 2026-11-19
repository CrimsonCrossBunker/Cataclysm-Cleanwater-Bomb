local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_RADIATION_IMMUNE",
    name = ccb.content.text("In No Other Fire Shall I Burn"),
    points = 6,
    description = ccb.content.text("The Salamander is completely immune to radiation."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    secondary_prerequisites = { "SALAMANDER_MANA_BONUS" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    flags = { "NO_RADIATION" },
}
