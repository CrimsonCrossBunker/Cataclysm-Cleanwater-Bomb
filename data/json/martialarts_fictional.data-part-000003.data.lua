local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_biojutsu_takedown",
    name = ccb.content.text("Biojutsu Takedown"),
    messages = {
        ccb.content.text("You kick and slam %s to the ground"),
        ccb.content.text("<npcname> kicks and slams %s to the ground"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    weighting = 2,
    crit_ok = true,
    down_dur = 2,
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
    when = "allow_tec_biojutsu_takedown",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target"),
}
