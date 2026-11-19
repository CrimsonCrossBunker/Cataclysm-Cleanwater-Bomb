local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_COUNTER_TRIP",
    name = ccb.content.text("Obstructing Roots"),
    messages = {
        ccb.content.text("You lash out at %s and knock them to the ground"),
        ccb.content.text("<npcname> knocks %s to the ground"),
    },
    skills = { { id = "unarmed", level = 5 }, { id = "gramarye", level = 4 } },
    unarmed_allowed = true,
    crit_ok = true,
    melee_allowed = true,
    block_counter = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes", "vector_null" },
    down_dur = 2,
    on_apply = "arvore_counter_trip_applied",
    when = "allow_arvore_counter_trip",
}
