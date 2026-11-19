local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ALPHA_COMPLEX",
    name = ccb.content.text("Superiority Complex"),
    description = ccb.content.text("You can't stand to prostrate yourself before your lessers and hate it when they don't immediately do what you say.  Persuasion is much more difficult, but you're better at lying and intimidating."),
    categories = { "ALPHA" },
    types = { "SOCIAL" },
    prerequisites = { "INT_ALPHA", "PER_ALPHA" },
    secondary_prerequisites = { "STR_ALPHA", "DEX_ALPHA" },
    threshold_requirements = { "THRESH_ALPHA" },
    points = 0,
    purifiable = false,
    vitamin_cost = 180,
    social_modifiers = { lie = 10, persuade = -25, intimidate = 10 },
}
