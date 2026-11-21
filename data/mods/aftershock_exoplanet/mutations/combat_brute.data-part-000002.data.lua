local ccb = require("ccb")

ccb.content.define_mutation {
    id = "AFS_COMBAT_DRUG_PRODUCTION",
    name = ccb.content.text("Stimulant biosynthesis"),
    description = ccb.content.text("You naturally produce combat-enhancing substances, and you might consciously trigger their release as you see fit."),
    vitamin_cost = 350,
    points = 15,
    active = true,
    cost = 800,
    consumes_calories = true,
    activation_message = ccb.content.text("You release the flood of combat-enhancing substances into your bloodstream."),
    on_activate = "activate_afs_combat_drug_production",
    categories = { "COMBAT_BRUTE" },
}
