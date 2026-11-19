local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_debug_eoc_demo",
    name = ccb.content.text("Extreme Offensive Chop!"),
    unarmed_allowed = true,
    melee_allowed = true,
    skills = { { id = "speech", level = 10 } },
    weighting = 100,
    messages = {
        ccb.content.text("You strike %s with an Extreme Offensive Chop"),
        ccb.content.text("<npcname> strikes %s with an Extreme Offensive Chop"),
    },
    attack_vectors = { "vector_null", "vector_wrist" },
    on_apply = "technique_demo_surrender",
}
