local ccb = require("ccb")

ccb.content.define_technique {
    id = "niten_red_leaf",
    name = ccb.content.text("Red Leaf's Cut"),
    messages = {
        ccb.content.text("Your strike knocks %s off balance"),
        ccb.content.text("<npcname>'s strike knocks %s off balance"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    down_dur = 1,
    attack_vectors = { "vector_null" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "niten_stone_cut",
    name = ccb.content.text("Fire and Stone's Cut"),
    messages = {
        ccb.content.text("You stun %s with the force of your cut"),
        ccb.content.text("<npcname> stuns %s with the force of their cut"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
