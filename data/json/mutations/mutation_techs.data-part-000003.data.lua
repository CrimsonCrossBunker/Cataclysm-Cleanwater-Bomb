local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_LITTLE_PAW_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You punch %s"), ccb.content.text("<npcname> punch %s") },
    description = ccb.content.text("A basic lapine punch"),
    attack_vectors = { "vector_little_paw_punch" },
}
