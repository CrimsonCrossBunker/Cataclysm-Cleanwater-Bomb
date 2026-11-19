local ccb = require("ccb")

ccb.content.define_technique {
    id = "tech_base_punch",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You punch %s"), ccb.content.text("<npcname> punches %s") },
    description = ccb.content.text("A basic punch"),
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tech_base_kick",
    name = ccb.content.text("Kick"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You kick %s"), ccb.content.text("<npcname> kicks %s") },
    description = ccb.content.text("A basic kick"),
    attack_vectors = { "vector_foot_toes", "vector_knee", "vector_shin" },
}

ccb.content.define_technique {
    id = "WBLOCK_1",
    name = ccb.content.text("Block"),
    dummy = true,
    mult_bonuses = { { stat = "movecost", scale = 0.0 } },
    messages = { ccb.content.text("You block %s"), ccb.content.text("<npcname> blocks %s") },
    description = ccb.content.text("Medium blocking ability"),
}

ccb.content.define_technique {
    id = "WBLOCK_2",
    name = ccb.content.text("Parry"),
    dummy = true,
    mult_bonuses = { { stat = "movecost", scale = 0.0 } },
    messages = { ccb.content.text("You parry %s"), ccb.content.text("<npcname> parries %s") },
    description = ccb.content.text("High blocking ability"),
}

ccb.content.define_technique {
    id = "WBLOCK_3",
    name = ccb.content.text("Shield"),
    dummy = true,
    mult_bonuses = { { stat = "movecost", scale = 0.0 } },
    messages = { ccb.content.text("You shield against %s"), ccb.content.text("<npcname> shields against %s") },
    description = ccb.content.text("Very high blocking ability"),
}

ccb.content.define_technique {
    id = "DEF_DISARM",
    name = ccb.content.text("Disarm"),
    melee_allowed = true,
    disarms = true,
    skills = { { id = "melee", level = 4 } },
    description = ccb.content.text("Unwield target's weapon, min 4 melee"),
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The weapon of %s has been forced out of their hands!"),
        },
    },
    attack_vectors = { "vector_grasp" },
}

-- not implemented -> empty name
ccb.content.define_technique {
    id = "GRAB",
    name = "",
    messages = { ccb.content.text("You grab %s"), ccb.content.text("<npcname> grabs %s") },
}

ccb.content.define_technique {
    id = "SPIN",
    name = ccb.content.text("Spinning Strike"),
    melee_allowed = true,
    skills = { { id = "melee", level = 4 } },
    crit_tec = true,
    messages = {
        ccb.content.text("You swing through %s and everyone nearby"),
        ccb.content.text("<npcname> swings through %s and everyone nearby"),
    },
    aoe = "spin",
    description = ccb.content.text("Attack adjacent enemies, crit only, min 4 melee"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "WIDE",
    name = ccb.content.text("Wide Strike"),
    melee_allowed = true,
    skills = { { id = "melee", level = 3 } },
    crit_tec = true,
    weighting = 2,
    messages = {
        ccb.content.text("You swing in a wide arc through %s"),
        ccb.content.text("<npcname> swings in a wide arc through %s"),
    },
    aoe = "wide",
    description = ccb.content.text("Attack in a wide arc, crit only, min 3 melee"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "IMPALE",
    name = ccb.content.text("Impaling Strike"),
    melee_allowed = true,
    skills = { { id = "melee", level = 4 } },
    crit_tec = true,
    messages = {
        ccb.content.text("You pierce straight through %s"),
        ccb.content.text("<npcname> pierces through %s"),
    },
    aoe = "impale",
    description = ccb.content.text("Attack target and another one behind it, crit only, min 4 melee"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "PENETRATE",
    name = ccb.content.text("Penetrating Strike"),
    melee_allowed = true,
    crit_tec = true,
    reach_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "melee", scale = 2.0 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "melee", scale = 2.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "melee", scale = 2.0 },
    },
    messages = {
        ccb.content.text("You find a weak spot in %s's armor"),
        ccb.content.text("<npcname> finds a weak spot in %s's armor"),
    },
    description = ccb.content.text("Increase armor penetration by 2 times melee skill"),
    attack_vectors = { "vector_null" },
}
