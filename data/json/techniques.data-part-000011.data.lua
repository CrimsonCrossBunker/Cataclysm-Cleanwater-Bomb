local ccb = require("ccb")

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_bojutsu_kneestrike",
    name = ccb.content.text("Knee Strike"),
    messages = {
        ccb.content.text("After blocking %s's attack you quickly strike at their knee"),
        ccb.content.text("After blocking %s's attack <npcname> quickly strikes at their knee"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    block_counter = true,
    crit_ok = true,
    down_dur = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

-- Similar size
ccb.content.define_technique {
    id = "tec_bojutsu_frontstrike",
    name = ccb.content.text("Overhead Front Strike"),
    messages = {
        ccb.content.text("You block %s's attack and counter with a Overhead Front Strike"),
        ccb.content.text("<npcname> blocks %s's attack and counter with a Overhead Front Strike"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    block_counter = true,
    crit_ok = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.4 } },
    attack_vectors = { "vector_null" },
    when = "allow_tec_bojutsu_frontstrike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar or smaller</info> size"),
}
