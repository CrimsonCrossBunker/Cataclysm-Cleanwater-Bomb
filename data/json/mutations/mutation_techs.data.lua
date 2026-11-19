local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_SLIME_KICK",
    name = ccb.content.text("Kick"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You smash %s"), ccb.content.text("<npcname> smashes %s") },
    description = ccb.content.text("A basic slime kick"),
    attack_vectors = { "vector_slime_kick" },
}
