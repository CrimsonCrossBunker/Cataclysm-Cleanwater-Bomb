local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_tiger_takedown",
    name = ccb.content.text("Tiger Takedown"),
    messages = {
        ccb.content.text("You slam %s to the ground"),
        ccb.content.text("<npcname> slams %s to the ground"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    down_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
