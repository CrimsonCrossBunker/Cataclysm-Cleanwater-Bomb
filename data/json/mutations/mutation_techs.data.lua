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

ccb.content.define_technique {
    id = "TECH_BEAR_BITE",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A bear bite."),
    attack_vectors = { "vector_bear_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "TECH_LUPINE_BITE",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A lupine bite."),
    attack_vectors = { "vector_lupine_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "TECH_REPTILE_BITE",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A reptilian bite."),
    attack_vectors = { "vector_reptile_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "TECH_RODENT_BITE",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A rodent bite."),
    attack_vectors = { "vector_rodent_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_rodent_bite",
}

ccb.content.define_technique {
    id = "TECH_RABBIT_BITE",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = -2,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A rabbit bite."),
    attack_vectors = { "vector_rabbit_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5625 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_rodent_bite",
}

ccb.content.define_technique {
    id = "TECH_RABBIT_BITE_GRABBED",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    description = ccb.content.text("A rabbit bite."),
    attack_vectors = { "vector_rabbit_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5625 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_rabbit_bite_grabbed",
}

ccb.content.define_technique {
    id = "TECH_BIRD_PECK",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = -2,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_bird_peck",
}

-- More likely to peck if you have wings
ccb.content.define_technique {
    id = "TECH_BIRD_PECK_IF_WINGS",
    name = ccb.content.text("Bite"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = 2,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_bird_peck_if_wings",
}

ccb.content.define_technique {
    id = "TECH_BIRD_PECK_GRABBED",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.45 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_bird_peck_grabbed",
}

ccb.content.define_technique {
    id = "TECH_BIRD_WOODPECKER_PECK",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = -2,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_woodpecker_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -2.5 },
        { stat = "movecost", scaling_stat = "dex", scale = -1 },
    },
}

ccb.content.define_technique {
    id = "TECH_BIRD_WOODPECKER_PECK_IF_WINGS",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    weighting = 2,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_woodpecker_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -2.5 },
        { stat = "movecost", scaling_stat = "dex", scale = -1 },
    },
}

ccb.content.define_technique {
    id = "TECH_BIRD_WOODPECKER_PECK_GRABBED",
    name = ccb.content.text("Peck"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    messages = { ccb.content.text("You peck %s"), ccb.content.text("<npcname> pecks %s") },
    description = ccb.content.text("A bird peck."),
    attack_vectors = { "vector_bird_woodpecker_peck" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "movecost", scaling_stat = "melee", scale = -2.5 },
        { stat = "movecost", scaling_stat = "dex", scale = -1 },
    },
    when = "allow_tech_bird_peck_grabbed",
}

ccb.content.define_technique {
    id = "TECH_GASTROPOD_TONGUE",
    name = ccb.content.text("Tongue Stab"),
    crit_ok = true,
    unarmed_allowed = true,
    reach_ok = true,
    messages = {
        ccb.content.text("You stab %s with your sharp tongue"),
        ccb.content.text("<npcname> stabs %s with their sharp tongue"),
    },
    description = ccb.content.text("A stabbing attack with your gastropod tongue."),
    attack_vectors = { "vector_gastropod_tongue" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "stab", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 0.25 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "TECH_SLIME_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You punch %s"), ccb.content.text("<npcname> punch %s") },
    description = ccb.content.text("A basic gooey punch"),
    attack_vectors = { "vector_slime_punch" },
}

-- This is just base punch for crabs
ccb.content.define_technique {
    id = "TECH_CRAB_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You snip %s with your pincer"),
        ccb.content.text("<npcname> snips %s with their pincer"),
    },
    description = ccb.content.text("A basic crustacean punch"),
    attack_vectors = { "vector_crab_pincer" },
}

ccb.content.define_technique {
    id = "TECH_BROAD_PAW_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You smash %s"), ccb.content.text("<npcname> smashes %s") },
    description = ccb.content.text("A basic ursine punch"),
    attack_vectors = { "vector_broad_paw_punch" },
    when = "allow_tech_broad_paw_punch",
}

ccb.content.define_technique {
    id = "TECH_LITTLE_PAW_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You punch %s"), ccb.content.text("<npcname> punch %s") },
    description = ccb.content.text("A basic lapine punch"),
    attack_vectors = { "vector_little_paw_punch" },
}

ccb.content.define_technique {
    id = "TECH_BROAD_PAW_PUNCH_WITH_CLAWS",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You claw %s"), ccb.content.text("<npcname> claws %s") },
    description = ccb.content.text("A basic ursine punch, with claws"),
    attack_vectors = { "vector_broad_paw_punch" },
    when = "allow_tech_broad_paw_punch_with_claws",
}

ccb.content.define_technique {
    id = "TECH_BROAD_PAW_CLAW",
    name = ccb.content.text("Smash"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You viciously claw %s"), ccb.content.text("<npcname> viciously claws %s") },
    description = ccb.content.text("A vicious clawed attack."),
    weighting = -2,
    attack_vectors = { "vector_broad_paw_punch" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "unarmed", scale = 0.25 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_broad_paw_punch_with_claws",
}

ccb.content.define_technique {
    id = "TECH_BROAD_PAW_SMASH_KNOCKBACK",
    name = ccb.content.text("Smash"),
    crit_tec = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You smash %s with your paw and send them reeling!"),
        ccb.content.text("<npcname> smashes %s and sends them reeling!"),
    },
    description = ccb.content.text("A vicious smashing attack."),
    weighting = -2,
    attack_vectors = { "vector_broad_paw_punch" },
    knockback_dist = 2,
    down_dur = 2,
    when = "allow_tech_broad_paw_smash_knockback",
}

ccb.content.define_technique {
    id = "TECH_PAW_PUNCH",
    name = ccb.content.text("Punch"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You punch %s"), ccb.content.text("<npcname> punches %s") },
    description = ccb.content.text("A basic pawed punch"),
    attack_vectors = { "vector_paw_punch", "vector_paw_rat_punch" },
    when = "allow_tech_broad_paw_punch",
}

ccb.content.define_technique {
    id = "TECH_PAW_PUNCH_WITH_CLAWS",
    name = ccb.content.text("Claw"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You claw %s"), ccb.content.text("<npcname> claw %s") },
    description = ccb.content.text("A basic clawed and pawed punch"),
    attack_vectors = { "vector_paw_punch", "vector_paw_rat_punch" },
    when = "allow_tech_broad_paw_punch_with_claws",
}

ccb.content.define_technique {
    id = "TECH_PAW_CLAW",
    name = ccb.content.text("Claw"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You viciously claw %s"), ccb.content.text("<npcname> viciously claws %s") },
    description = ccb.content.text("A vicious clawed attack."),
    weighting = -2,
    attack_vectors = { "vector_paw_punch", "vector_paw_rat_punch" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5625 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "unarmed", scale = 0.25 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_broad_paw_punch_with_claws",
}

ccb.content.define_technique {
    id = "TECH_WING_SLAP",
    name = ccb.content.text("Wing Slap"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You slap %s with your wings"),
        ccb.content.text("<npcname> slaps %s with their wings"),
    },
    description = ccb.content.text("A slap of the wings."),
    attack_vectors = { "vector_wing_slap" },
    flat_bonuses = { { stat = "movecost", scale = 20 } },
}

ccb.content.define_technique {
    id = "VINE_LIMB_WHIP",
    name = ccb.content.text("Vine whip"),
    messages = {
        ccb.content.text("You whip %s with your vines"),
        ccb.content.text("<npcname> whips %s with their vines"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    attack_vectors = { "vector_vine_limb" },
    flat_bonuses = {
        { stat = "movecost", scaling_stat = "melee", scale = -3.75 },
        { stat = "movecost", scaling_stat = "dex", scale = -1 },
    },
}

ccb.content.define_technique {
    id = "VINE_LIMB_TRIP",
    name = ccb.content.text("Vine trip"),
    messages = {
        ccb.content.text("Your vines snake around %s and knock them down"),
        ccb.content.text("<npcname> knocks down %s with their vines"),
    },
    weighting = -2,
    unarmed_allowed = true,
    reach_ok = false,
    attack_vectors = { "vector_vine_limb" },
    effects = {
        {
            id = "downed",
            chance = 100,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scale = -3 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_vine_limb_trip",
}

-- This is just a kick for animal feet with no special characteristics
ccb.content.define_technique {
    id = "TECH_ANIMAL_FOOT_KICK",
    name = ccb.content.text("Kick"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You kick %s"), ccb.content.text("<npcname> kicks %s") },
    description = ccb.content.text("A basic kick"),
    attack_vectors = { "vector_digitigrade_paws", "vector_knee", "vector_shin" },
}

ccb.content.define_technique {
    id = "TECH_AVIAN_KICK",
    name = ccb.content.text("Kick"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = {
        ccb.content.text("You slash %s with your talons"),
        ccb.content.text("<npcname> slashes %s with their talons"),
    },
    description = ccb.content.text("A bird kick"),
    attack_vectors = { "vector_avian_talons", "vector_avian_talons_rear" },
}

ccb.content.define_technique {
    id = "HOOVES_KICK",
    name = ccb.content.text("Hoof Kick"),
    messages = {
        ccb.content.text("You kick %s with your hooves"),
        ccb.content.text("<npcname> kicks %s with their hooves"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    attack_vectors = { "vector_hoof_kick" },
    effects = {
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick",
}

ccb.content.define_technique {
    id = "HOOVES_KICK_AGAINST_LARGE",
    name = ccb.content.text("Hoof Kick"),
    messages = {
        ccb.content.text("You kick %s with your hooves"),
        ccb.content.text("<npcname> kicks %s with their hooves"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    attack_vectors = { "vector_hoof_kick" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_against_large",
}

ccb.content.define_technique {
    id = "HOOVES_KICK_NATURAL",
    name = ccb.content.text("Hoof Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your hooves"),
        ccb.content.text("<npcname> kicks %s with their hooves"),
    },
    unarmed_allowed = true,
    weighting = 2,
    reach_ok = false,
    attack_vectors = { "vector_hoof_kick" },
    knockback_dist = 1,
    effects = {
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_natural",
}

ccb.content.define_technique {
    id = "HOOVES_KICK_NATURAL_AGAINST_LARGE",
    name = ccb.content.text("Hoof Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your hooves"),
        ccb.content.text("<npcname> kicks %s with their hooves"),
    },
    unarmed_allowed = true,
    weighting = 2,
    reach_ok = false,
    attack_vectors = { "vector_hoof_kick" },
    effects = {
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_natural_against_large",
}

ccb.content.define_technique {
    id = "HOOVES_KICK_CRIT",
    name = ccb.content.text("Critical Hoof Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your hooves, knocking them down."),
        ccb.content.text("<npcname> kick %s with their hooves, knocking them down."),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 1,
    attack_vectors = { "vector_hoof_kick" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_crit",
}

ccb.content.define_technique {
    id = "TOE_TALONS_KICK",
    name = ccb.content.text("Toe Talons Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your taloned feet"),
        ccb.content.text("<npcname> kicks %s with their taloned feet"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_foot_toes", "vector_foot_sole", "vector_foot_heel" },
    effects = {
        {
            id = "bleed",
            chance = 35,
            duration_turns = 60,
            on_damage = true,
            message = ccb.content.text("Your kick opens up bleeding gashes on %s!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick",
}

ccb.content.define_technique {
    id = "TOE_TALONS_KICK_NATURAL",
    name = ccb.content.text("Toe Talons Kick"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You kick %s with your taloned feet"),
        ccb.content.text("<npcname> kicks %s with their taloned feet"),
    },
    unarmed_allowed = true,
    weighting = -1,
    reach_ok = false,
    attack_vectors = { "vector_foot_toes", "vector_foot_sole", "vector_foot_heel" },
    effects = {
        {
            id = "bleed",
            chance = 35,
            duration_turns = 60,
            on_damage = true,
            message = ccb.content.text("Your kick opens up bleeding gashes on %s!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_toe_talons_kick_natural",
}

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

-- Scaling on these three is 75% of normal
ccb.content.define_technique {
    id = "TAIL_THICK_BASH",
    name = ccb.content.text("Thick Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You thwack %s with your tail"),
        ccb.content.text("<npcname> thwacks %s with their tail"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_tail_thick" },
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
    id = "TAIL_THICK_BASH_NATURAL",
    name = ccb.content.text("Thick Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You thwack %s with your tail"),
        ccb.content.text("<npcname> thwacks %s with their tail"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_tail_thick" },
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
    id = "TAIL_THICK_BASH_CRIT",
    name = ccb.content.text("Thick Tail Bash Crit"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slam %s with your tail"),
        ccb.content.text("<npcname> slams %s with their tail"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_tail_thick" },
    knockback_dist = 1,
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.6 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tail_thick_bash_crit",
}

ccb.content.define_technique {
    id = "TAIL_THICK_BASH_CRIT_VS_STUMBLE",
    name = ccb.content.text("Thick Tail Bash Crit"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slam %s with your tail and knock them down"),
        ccb.content.text("<npcname> slams %s with their tail and knock them down"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_tail_thick" },
    knockback_dist = 1,
    down_dur = 2,
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.375 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.75 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.6 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tail_thick_bash_crit_vs_stumble",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH",
    name = ccb.content.text("Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You bash %s with your club tail"),
        ccb.content.text("<npcname> bashes %s with their club tail"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_tail_club" },
    knockback_dist = 1,
    effects = {
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH_VS_LARGE",
    name = ccb.content.text("Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You bash %s with your club tail"),
        ccb.content.text("<npcname> bashes %s with their club tail"),
    },
    unarmed_allowed = true,
    weighting = -3,
    reach_ok = false,
    attack_vectors = { "vector_tail_club" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_against_large",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH_NATURAL",
    name = ccb.content.text("Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You bash %s with your club tail"),
        ccb.content.text("<npcname> bashes %s with their club tail"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_tail_club" },
    knockback_dist = 1,
    effects = {
        {
            id = "downed",
            chance = 50,
            duration_turns = 2,
            on_damage = true,
            message = ccb.content.text("%s is knocked to the ground!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_natural",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH_NATURAL_VS_LARGE",
    name = ccb.content.text("Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You bash %s with your club tail"),
        ccb.content.text("<npcname> bashes %s with their club tail"),
    },
    unarmed_allowed = true,
    weighting = 0,
    reach_ok = false,
    attack_vectors = { "vector_tail_club" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_natural_against_large",
}

ccb.content.define_technique {
    id = "TAIL_CLUB_BASH_CRIT",
    name = ccb.content.text("Critical Club Tail Bash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You brutally smash %s with your club tail"),
        ccb.content.text("<npcname> brutally smashes %s with their club tail"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 1,
    attack_vectors = { "vector_tail_club" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 0.5 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_hooves_kick_crit",
}

ccb.content.define_technique {
    id = "TECH_SLIME_KICK",
    name = ccb.content.text("Kick"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You smash %s"), ccb.content.text("<npcname> smashes %s") },
    description = ccb.content.text("A basic slime kick"),
    attack_vectors = { "vector_slime_kick" },
}
