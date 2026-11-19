local ccb = require("ccb")

ccb.content.define_technique {
    id = "tech_base_headbutt",
    name = ccb.content.text("Headbutt"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You headbutt %s"), ccb.content.text("<npcname> headbutts %s") },
    description = ccb.content.text("A basic headbutt"),
    skills = { { id = "unarmed", level = 3 } },
    attack_vectors = { "vector_headbutt" },
    when = "allow_tech_bird_peck_grabbed",
}
