local ccb = require("ccb")

ccb.content.define_technique {
    id = "mma_tec_stone_dragon_strike",
    name = ccb.content.text("Irresistible Mountain Strike"),
    messages = {
        ccb.content.text("You smash down on %s with a Mountain Strike"),
        ccb.content.text("<npcname> smashes down on %s with a Mountain Strike"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    attack_vectors = { "vector_null", "vector_wrist" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "mma_tec_stone_dragon_colossus",
    name = ccb.content.text("Colossus Strike"),
    messages = {
        ccb.content.text("You completely shatter %s with a Colossus Strike"),
        ccb.content.text("<npcname> completely shatters %s with a Colossus Strike"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_ok = true,
    down_dur = 1,
    knockback_dist = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.3 },
        { stat = "damage", damage_type = "cut", scale = 1.3 },
        { stat = "damage", damage_type = "stab", scale = 1.3 },
    },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_biojutsu_takedown",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target"),
}
