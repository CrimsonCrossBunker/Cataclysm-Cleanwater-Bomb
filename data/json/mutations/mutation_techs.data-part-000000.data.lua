local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_dbg_sting",
    name = ccb.content.text("CHOMP"),
    messages = {
        ccb.content.text("You sting %s with your bug-laden tail"),
        ccb.content.text("<npcname> stings %s with their bug-laden tail"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    weighting = 200,
    crit_ok = true,
    repeat_min = 1,
    repeat_max = 5,
    mult_bonuses = { { stat = "damage", damage_type = "bullet", scale = 15 } },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 5 },
        { stat = "arpen", damage_type = "bash", scale = 10 },
        { stat = "arpen", damage_type = "cut", scale = 10 },
        { stat = "movecost", scale = 40 },
    },
    effects = {
        {
            id = "bleed",
            chance = 100,
            duration_turns = 2000,
            permanent = true,
            on_damage = false,
            message = ccb.content.text("You bleed the %s dry!"),
        },
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            message = ccb.content.text("You bonk the %s real good"),
            when = "allow_tec_dbg_sting_effect_2",
        },
    },
    attack_vectors = { "test_test" },
}

ccb.content.define_technique {
    id = "FANGS_BITE",
    name = ccb.content.text("Fang Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    unarmed_allowed = true,
    weighting = -5,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    effects = {
        {
            id = "anticoagulant_draculin",
            chance = 70,
            duration_turns = 3000,
            on_damage = true,
            message = ccb.content.text("Saliva glistens across %s's wound!"),
            when = "allow_fangs_bite_effect_1",
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_fangs_bite",
}

-- Same as bite by higher weighting--it's easier to bite when your fangs stretch outside your mouth
ccb.content.define_technique {
    id = "FANGS_SPIDER_BITE",
    name = ccb.content.text("Fang Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    unarmed_allowed = true,
    weighting = -2,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    effects = {
        {
            id = "anticoagulant_draculin",
            chance = 70,
            duration_turns = 3000,
            on_damage = true,
            message = ccb.content.text("Saliva glistens across %s's wound!"),
            when = "allow_fangs_bite_effect_1",
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_fangs_bite",
}

ccb.content.define_technique {
    id = "FANGS_BITE_NATURAL",
    name = ccb.content.text("Fang Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    unarmed_allowed = true,
    weighting = -2,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    effects = {
        {
            id = "anticoagulant_draculin",
            chance = 70,
            duration_turns = 3000,
            on_damage = true,
            message = ccb.content.text("Saliva glistens across %s's wound!"),
            when = "allow_fangs_bite_effect_1",
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_fangs_bite_natural",
}

ccb.content.define_technique {
    id = "FANGS_BITE_CRIT",
    name = ccb.content.text("Critical Fang Bite"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You deliver a wicked bite to %s"),
        ccb.content.text("<npcname> delivers a wicked bite to %s"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_bite" },
    effects = {
        {
            id = "anticoagulant_draculin",
            chance = 90,
            duration_turns = 6000,
            on_damage = true,
            message = ccb.content.text("Saliva glistens across %s's wound!"),
            when = "allow_fangs_bite_effect_1",
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "VAMPIRE_BITE",
    name = ccb.content.text("Vampire Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    unarmed_allowed = true,
    weighting = -5,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    effects = {
        {
            id = "anticoagulant_draculin",
            chance = 90,
            duration_turns = 3000,
            on_damage = true,
            message = ccb.content.text("Saliva glistens across %s's wound!"),
            when = "allow_fangs_bite_effect_1",
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "VAMPIRE_BITE_NATURAL",
    name = ccb.content.text("Vampire Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    unarmed_allowed = true,
    weighting = -2,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    effects = {
        {
            id = "anticoagulant_draculin",
            chance = 90,
            duration_turns = 3000,
            on_damage = true,
            message = ccb.content.text("Saliva glistens across %s's wound!"),
            when = "allow_fangs_bite_effect_1",
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tail_scorpion_sting_natural",
}

ccb.content.define_technique {
    id = "VAMPIRE_BITE_CRIT",
    name = ccb.content.text("Critical Vampire Bite"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You sink your fangs deep into %s"),
        ccb.content.text("<npcname> sinks their fangs deep into %s"),
    },
    unarmed_allowed = true,
    weighting = -4,
    reach_ok = false,
    crit_tec = true,
    effects = {
        {
            id = "anticoagulant_draculin",
            chance = 100,
            duration_turns = 6000,
            on_damage = true,
            message = ccb.content.text("Saliva glistens across %s's wound!"),
            when = "allow_fangs_bite_effect_1",
        },
    },
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}
