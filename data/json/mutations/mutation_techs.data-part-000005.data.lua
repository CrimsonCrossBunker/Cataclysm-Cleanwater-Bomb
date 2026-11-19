local ccb = require("ccb")

-- This is just a kick for animal feet with no special characteristics
ccb.content.define_technique {
    id = "TECH_ANIMAL_FOOT_KICK",
    name = ccb.content.text("Kick"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You kick %s"), ccb.content.text("<npcname> kicks %s") },
    description = ccb.content.text("A basic kick"),
    attack_vectors = { "vector_digitigrade_paws", "vector_knee", "vector_shin" },
}

ccb.content.define_technique {
    id = "TECH_AVIAN_KICK",
    name = ccb.content.text("Kick"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You slash %s with your talons"),
        ccb.content.text("<npcname> slashes %s with their talons"),
    },
    description = ccb.content.text("A bird kick"),
    attack_vectors = { "vector_avian_talons", "vector_avian_talons_rear" },
}
