local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_medievalpole_hook",
    name = ccb.content.text("Hook and Drag"),
    messages = {
        ccb.content.text("You hook and drag %s down"),
        ccb.content.text("<npcname> hooks and drags %s down"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    required_buffs_all = { "buff_medievalpole_onmiss" },
    crit_ok = true,
    reach_ok = true,
    weighting = 2,
    down_dur = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_medievalpole_execute",
    name = ccb.content.text("Colpo di Grazia"),
    messages = {
        ccb.content.text("You swing down hard and execute %s"),
        ccb.content.text("<npcname> swings down hard and executes %s"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_tec = true,
    reach_ok = true,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}

ccb.content.define_technique {
    id = "tec_judo_throw",
    name = ccb.content.text("Throw"),
    messages = {
        ccb.content.text("You throw %s to the ground"),
        ccb.content.text("<npcname> throws %s to the ground"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    crit_ok = true,
    down_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_judo_throw",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>identical</info> size"),
}

ccb.content.define_technique {
    id = "tec_judo_disarm",
    name = ccb.content.text("Disarming Throw"),
    messages = {
        ccb.content.text("You disarm and throw %s"),
        ccb.content.text("<npcname> disarms and throws %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    melee_allowed = true,
    disarms = true,
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The weapon of %s has been forced out of their hands!"),
        },
    },
    down_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_judo_throw",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>identical</info> size"),
}

ccb.content.define_technique {
    id = "tec_judo_backthrow",
    name = ccb.content.text("Back Throw"),
    messages = {
        ccb.content.text("You flip %s head over heels"),
        ccb.content.text("<npcname> flips %s head over heels"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    crit_tec = true,
    side_switch = true,
    down_dur = 1,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.5 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_judo_throw",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>identical</info> size"),
}
