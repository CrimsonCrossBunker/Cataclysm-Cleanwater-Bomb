local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_BROAD_PAW_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You smash %s"), ccb.content.text("<npcname> smashes %s") },
    description = ccb.content.text("A basic ursine punch"),
    attack_vectors = { "vector_broad_paw_punch" },
    when = "allow_tech_broad_paw_punch",
}
