local ccb = require("ccb")

ccb.content.define_technique {
    id = "TOE_TALONS_KICK_CRIT",
    name = ccb.content.text("Critical Toe Talon Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You deliver a wicked kick to %s with your taloned feet"),
        ccb.content.text("<npcname> delivers a wicked kick to %s with your taloned feet"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_foot_toes", "vector_foot_sole", "vector_foot_heel" },
    effects = {
        {
            id = "bleed",
            chance = 70,
            duration_turns = 60,
            on_damage = true,
            message = ccb.content.text("Your kick opens up bleeding gashes on %s!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.24 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "unarmed", scale = 0.5 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}
