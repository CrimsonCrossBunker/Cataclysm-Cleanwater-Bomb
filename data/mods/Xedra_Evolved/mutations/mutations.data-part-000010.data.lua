local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOODHEAL",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Sanguine Restoration"),
    description = ccb.content.text("Your flesh heals visibly while blood disintegrates hidden inside your veins."),
    spells_learned = { spell_blood_heal = 1 },
}
