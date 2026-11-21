local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BIOLUM3",
    name = ccb.content.text("Bioluminescent Flare"),
    description = ccb.content.text("You can spit a wad of bioluminescent goo several meters away.  There it will light up its surroundings until it dissipates."),
    categories = { "INSECT" },
    types = { "BIOLUM" },
    prerequisites = { "BIOLUM2" },
    threshold_requirements = { "THRESH_INSECT" },
    points = 6,
    active = true,
    cost = 400,
    vitamin_cost = 210,
    consumes_calories = true,
    covered_encumbrance = { head = 5 },
    on_activate = "activate_biolum3",
}
