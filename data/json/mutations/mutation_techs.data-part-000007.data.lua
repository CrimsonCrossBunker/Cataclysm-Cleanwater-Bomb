local ccb = require("ccb")

ccb.content.define_technique {
    id = "TAIL_SCORPION_STING_CRIT",
    name = ccb.content.text("Critical Tail Sting"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You viciously sting %s with your tail"),
        ccb.content.text("<npcname> viciously stings %s with their tail"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_tail_sting" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.75 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.5 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}
