local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PROF_AUTODOC",
    name = ccb.content.text("Autodoc Specialist"),
    points = 0,
    description = ccb.content.text("You're trained in proper operation of the Autodoc, an advanced machine used for surgical procedures.  Operations involving it will be moderately more likely to succeed."),
    valid = false,
    purifiable = false,
    profession = true,
}
