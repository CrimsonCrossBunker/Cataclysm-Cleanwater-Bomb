local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_boomstick_blast",
    name = ccb.content.text("Boomstick Blast"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("People hit by shotgun blasts always seem to go flying in actions movies, but it doesn't work that way in real life.  At least, it didn't.\n\nWhen you damage a target within 2 squares using a shotgun and do at least 15 damage, your target will suffer knockback."),
    flags = { "PERK" },
}
