local ccb = require("ccb")

-- Scaling on these three is 50% of normal because it's explicitly a weak attack
ccb.content.define_technique {
    id = "SMALL_HORNS_RAM_BASH",
    name = ccb.content.text("Small Horns Ram Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You ram %s with your horns"),
        ccb.content.text("<npcname> rams %s with their horns"),
    },
    unarmed_allowed = true,
    weighting = -4,
    reach_ok = false,
    attack_vectors = { "vector_headbutt" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.03 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "SMALL_HORNS_RAM_NATURAL",
    name = ccb.content.text("Small Horns Ram Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You ram %s with your horns"),
        ccb.content.text("<npcname> rams %s with their horns"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_headbutt" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.03 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick_natural",
}

ccb.content.define_technique {
    id = "CURLED_HORNS_BASH",
    name = ccb.content.text("Curled Horns Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You ram %s with your curled horns"),
        ccb.content.text("<npcname> rams %s with their curled horns"),
    },
    unarmed_allowed = true,
    weighting = -4,
    reach_ok = false,
    attack_vectors = { "vector_headbutt" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.33 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "CURLED_HORNS_BASH_NATURAL",
    name = ccb.content.text("Curled Horns Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You ram %s with your curled horns"),
        ccb.content.text("<npcname> rams %s with their curled horns"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_headbutt" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.33 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick_natural",
}

ccb.content.define_technique {
    id = "POINTED_HORNS_STAB",
    name = ccb.content.text("Pointed Horns Stab"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You stab %s with your horns"),
        ccb.content.text("<npcname> stabs %s with their horns"),
    },
    unarmed_allowed = true,
    weighting = -4,
    reach_ok = false,
    attack_vectors = { "vector_headbutt" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.33 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "POINTED_HORNS_STAB_NATURAL",
    name = ccb.content.text("Pointed Horns Stab"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You stab %s with your horns"),
        ccb.content.text("<npcname> stabs %s with their horns"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_headbutt" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.33 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick_natural",
}

-- Scaling on these three is 75% of normal because it's explicitly a weaker attack
ccb.content.define_technique {
    id = "ANTLERS_BASH",
    name = ccb.content.text("Antlers Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You ram %s with your antlers"),
        ccb.content.text("<npcname> rams %s with their antlers"),
    },
    unarmed_allowed = true,
    weighting = -4,
    reach_ok = false,
    attack_vectors = { "vector_headbutt" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.6 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "ANTLERS_BASH_NATURAL",
    name = ccb.content.text("Antlers Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You ram %s with your antlers"),
        ccb.content.text("<npcname> rams %s with their antlers"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_headbutt" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.6 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick_natural",
}

ccb.content.define_technique {
    id = "TAIL_SCORPION_STING",
    name = ccb.content.text("Tail Sting"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You sting %s with your tail"),
        ccb.content.text("<npcname> stings %s with their tail"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_tail_sting" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "TAIL_SCORPION_STING_NATURAL",
    name = ccb.content.text("Tail Sting"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You sting %s with your tail"),
        ccb.content.text("<npcname> stings %s with their tail"),
    },
    unarmed_allowed = true,
    weighting = 1,
    reach_ok = false,
    attack_vectors = { "vector_tail_sting" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tail_scorpion_sting_natural",
}
