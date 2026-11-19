local ccb = require("ccb")

ccb.content.define_technique {
    id = "niten_water_cut",
    name = ccb.content.text("Flowing Water Cut"),
    messages = {
        ccb.content.text("You strike %s with the slow power of flowing water"),
        ccb.content.text("<npcname> strikes %s with the slow power of flowing water"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 1.75 },
        { stat = "damage", damage_type = "bash", scale = 2.0 },
        { stat = "damage", damage_type = "cut", scale = 2.0 },
    },
    attack_vectors = { "vector_null" },
}
