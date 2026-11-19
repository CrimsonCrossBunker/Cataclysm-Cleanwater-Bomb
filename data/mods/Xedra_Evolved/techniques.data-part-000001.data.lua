local ccb = require("ccb")

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
