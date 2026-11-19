local ccb = require("ccb")

ccb.content.define_technique {
    id = "tech_wing_slap",
    name = ccb.content.text("Wing Slap"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You slap %s with your wings"),
        ccb.content.text("<npcname> slaps %s with their wings"),
    },
    description = ccb.content.text("A slap of the wings."),
    attack_vectors = { "vector_ravenfolk_wing_slap" },
    flat_bonuses = { { stat = "movecost", scale = 20 } },
}
