local ccb = require("ccb")

-- NO_I18N
ccb.content.define_technique {
    id = "tec_devil_tail_puncture",
    name = ccb.content.text_without_extraction("TAIL_SHOT"),
    messages = {
        ccb.content.text("Your devil tail shoots itself into %s, penetrating its body like a bullet"),
        ccb.content.text("<npcname>'s devil tail shoots itself into %s, penetrating its body like a bullet"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    weighting = 2,
    crit_ok = true,
    repeat_min = 1,
    repeat_max = 1,
    block_counter = true,
    dodge_counter = true,
    flat_bonuses = {
        { stat = "damage", damage_type = "bullet", scale = 45 },
        { stat = "damage", damage_type = "cut", scale = -1 },
    },
    effects = {
        {
            id = "bleed",
            chance = 100,
            duration_turns = 2000,
            on_damage = true,
            message = ccb.content.text("%s is bleeding heavily!"),
        },
    },
}

-- NO_I18N
ccb.content.define_technique {
    id = "tec_devil_tail_wide",
    name = ccb.content.text_without_extraction("TAIL_SWEEP"),
    messages = {
        ccb.content.text("Your devil tail makes a fast move, heavily cutting everybody in front"),
        ccb.content.text("<npcname>'s devil tail makes a fast move, heavily cutting everybody in front"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    weighting = 2,
    crit_ok = true,
    repeat_min = 1,
    repeat_max = 1,
    block_counter = true,
    dodge_counter = true,
    aoe = "wide",
    flat_bonuses = { { stat = "damage", damage_type = "cut", scale = 1.5 } },
    effects = {
        {
            id = "bleed",
            chance = 100,
            duration_turns = 2000,
            on_damage = true,
            message = ccb.content.text("%s is bleeding heavily!"),
        },
    },
}

-- not an actual grab, but would be nice to be so
-- NO_I18N
ccb.content.define_technique {
    id = "tec_devil_tail_grab",
    name = ccb.content.text_without_extraction("TAIL_GRAB"),
    messages = {
        ccb.content.text("Your devil tail grabs %s and throws them to the ground"),
        ccb.content.text("<npcname>'s devil tail grabs %s and throws them to the ground"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    weighting = 2,
    crit_ok = true,
    repeat_min = 1,
    repeat_max = 1,
    block_counter = true,
    dodge_counter = true,
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 15 },
        { stat = "damage", damage_type = "cut", scale = -1 },
    },
    effects = {
        {
            id = "downed",
            chance = 100,
            duration_turns = 5,
            message = ccb.content.text("You smash %s and make him fall"),
        },
    },
}

ccb.content.define_technique {
    id = "CQB_BRUTAL",
    name = ccb.content.text("Pneumatic Strike"),
    unarmed_allowed = true,
    melee_allowed = true,
    crit_tec = true,
    needs_ammo = true,
    skills = { { id = "melee", level = 3 } },
    down_dur = 4,
    knockback_dist = 3,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 2.5 },
        { stat = "movecost", scale = 1.4 },
    },
    messages = { ccb.content.text("You send %s reeling"), ccb.content.text("<npcname> sends %s reeling") },
    description = ccb.content.text("Down 4 turns, knockback 3 tiles, 250% damage, 140% move, crit only, min 3 melee"),
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_cqb_brutal",
    condition_description = ccb.content.text("* Only works on target of <info>similar or bigger</info> size"),
}

-- true
ccb.content.define_technique {
    id = "PLASMA_AXE_WIDE",
    name = ccb.content.text("Wide Shot"),
    melee_allowed = true,
    crit_tec = true,
    skills = { { id = "melee", level = 4 } },
    aoe = "wide",
    mult_bonuses = {
        { stat = "damage", damage_type = "heat", scale = 1.5 },
        { stat = "movecost", scale = 1.2 },
    },
    messages = {
        ccb.content.text("In an instant you melt %s and those nearby with a sprawling attack"),
        ccb.content.text("In an instant <npcname> melts %s and those nearby with a sprawling attack"),
    },
    description = ccb.content.text("150% damage, 120% move, attack multiple enemies, crit only, min 4 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_cqb_brutal",
    condition_description = ccb.content.text("* Only works on target of <info>similar or bigger</info> size"),
}

ccb.content.define_technique {
    id = "TECH_SALAMANDER_WING_BUFFET",
    name = ccb.content.text("Wing Buffet"),
    crit_ok = true,
    unarmed_allowed = true,
    melee_allowed = true,
    skills = { { id = "gramarye", level = 3 } },
    messages = {
        ccb.content.text("You buffet %s with your burning wings"),
        ccb.content.text("<npcname> buffets %s with their burning wings"),
    },
    description = ccb.content.text("A slap of the wings."),
    attack_vectors = { "vector_salamander_wing_slap" },
    flat_bonuses = {
        { stat = "damage", damage_type = "heat", scaling_stat = "gramarye", scale = 1 },
        { stat = "movecost", scale = 20 },
    },
}
