local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_ninjutsu_takedown",
    name = ccb.content.text("Ninjutsu Takedown (unarmed)"),
    messages = {
        ccb.content.text("You quickly grab and bring %s to the ground"),
        ccb.content.text("<npcname> quickly grabs and brings %s to the ground"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    forbidden_buffs_all = { "buff_ninjutsu_onattack" },
    crit_tec = true,
    down_dur = 2,
    weighting = 3,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_ninjutsu_takedown_melee",
    name = ccb.content.text("Ninjutsu Takedown (melee)"),
    messages = {
        ccb.content.text("You quickly grab and bring %s to the ground"),
        ccb.content.text("<npcname> quickly grabs and brings %s to the ground"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    forbidden_buffs_all = { "buff_ninjutsu_onattack" },
    weapon_categories = { "KNIVES", "CLAWS" },
    crit_tec = true,
    down_dur = 2,
    weighting = 3,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_ninjutsu_staffdown",
    name = ccb.content.text("Bite the Dust"),
    messages = {
        ccb.content.text("You sweep %s to the ground"),
        ccb.content.text("<npcname> sweeps %s to the ground"),
    },
    skills = { { id = "melee", level = 3 } },
    required_buffs_all = { "buff_ninjutsu_onattack" },
    melee_allowed = true,
    weapon_categories = { "QUARTERSTAVES" },
    crit_ok = true,
    down_dur = 2,
    weighting = 2,
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_ninjutsu_downkill",
    name = ccb.content.text("Dirty Kill"),
    messages = {
        ccb.content.text("You strike and confine %s to the ground"),
        ccb.content.text("<npcname> strikes and confines %s to the ground"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_ok = true,
    weighting = 2,
    stun_dur = 2,
    disarms = true,
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The hand of %s is forced open!"),
        },
    },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_elbow",
        "vector_foot_heel",
        "vector_shin",
    },
    when = "allow_tec_ninjutsu_downkill",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> and <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
