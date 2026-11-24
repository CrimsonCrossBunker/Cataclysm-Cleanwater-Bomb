local ccb = require("ccb")

ccb.content.define_technique {
    id = "mma_tec_desert_wind_strike",
    name = ccb.content.text("Burning Blade"),
    messages = {
        ccb.content.text("You unleash a fiery attack against %s"),
        ccb.content.text("<npcname> unleash a fiery attack against %s"),
    },
    melee_allowed = true,
    flat_bonuses = { { stat = "damage", damage_type = "heat", scale = 3.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_desert_wind_crit",
    name = ccb.content.text("Inferno Blade"),
    messages = {
        ccb.content.text("You strike %s with powerful inferno"),
        ccb.content.text("<npcname> strikes %s with powerful inferno"),
    },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    crit_tec = true,
    flat_bonuses = { { stat = "damage", damage_type = "heat", scale = 7.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_desert_wind_impale",
    name = ccb.content.text("Firesnake"),
    messages = {
        ccb.content.text("You strike through %s with a snaking flame"),
        ccb.content.text("<npcname> strikes through %s with a snaking flame"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_ok = true,
    aoe = "impale",
    flat_bonuses = { { stat = "damage", damage_type = "heat", scale = 7.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_desert_wind_spin",
    name = ccb.content.text("Ring of Fire"),
    messages = {
        ccb.content.text("You become a flaming blur as you strike %s and those around you"),
        ccb.content.text("<npcname> becomes a flaming blur as they strike %s and those around them"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_tec = true,
    aoe = "spin",
    flat_bonuses = { { stat = "damage", damage_type = "heat", scale = 10.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_desert_wind_wide",
    name = ccb.content.text("Flashing Sun"),
    messages = {
        ccb.content.text("You carve an arc through %s and those nearby"),
        ccb.content.text("<npcname> carve an arc through %s and those nearby"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_diamond_mind_strike",
    name = ccb.content.text("Insightful Strike"),
    messages = {
        ccb.content.text("You spot %s's weakpoint and strike"),
        ccb.content.text("<npcname> spot %s's weakpoint and strike"),
    },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    flat_bonuses = { { stat = "damage", damage_type = "stab", scaling_stat = "int", scale = 0.5 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_diamond_mind_crit",
    name = ccb.content.text("Greater Insightful Strike"),
    messages = {
        ccb.content.text("You spot %s's weakpoint and strike"),
        ccb.content.text("<npcname> spot %s's weakpoint and strike"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_tec = true,
    flat_bonuses = { { stat = "damage", damage_type = "stab", scaling_stat = "int", scale = 1.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_hylian_spin",
    name = ccb.content.text("Spin Attack"),
    messages = {
        ccb.content.text("You unleash a spin attack against %s and those nearby"),
        ccb.content.text("<npcname> unleashes a spin attack against %s and those nearby"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_any = { "mma_buff_hylian_onpause", "mma_buff_hylian_spin" },
    crit_ok = true,
    aoe = "spin",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_hylian_wide",
    name = ccb.content.text("Spin Attack"),
    messages = {
        ccb.content.text("You unleash a spin attack against %s and those nearby"),
        ccb.content.text("<npcname> unleashes a spin attack against %s and those nearby"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_any = { "mma_buff_hylian_onpause", "mma_buff_hylian_spin" },
    crit_ok = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_disarm",
    name = ccb.content.text("Disarming Strike"),
    messages = {
        ccb.content.text("You skillfully disarm %s"),
        ccb.content.text("<npcname> skillfully disarms %s"),
    },
    unarmed_allowed = true,
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
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_feint",
    name = ccb.content.text("Lightning Recovery"),
    messages = {
        ccb.content.text("You miss %s but recover in the blink of an eye"),
        ccb.content.text("<npcname> misses %s but recovers in the blink of an eye"),
    },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_execute",
    name = ccb.content.text("Finishing Move"),
    messages = {
        ccb.content.text("You finish off %s with a powerful slash"),
        ccb.content.text("<npcname> finishes off %s with a powerful slash"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_stun",
    name = ccb.content.text("Dazing Strike"),
    messages = { ccb.content.text("You harshly stun %s"), ccb.content.text("<npcname> harshly stuns %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_wide",
    name = ccb.content.text("Steel Wind"),
    messages = {
        ccb.content.text("You cleave through %s and those nearby like a steel wind"),
        ccb.content.text("<npcname> cleaves through %s and those nearby like a steel wind"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_wide_crit",
    name = ccb.content.text("Scything Blade"),
    messages = {
        ccb.content.text("You cleanly reap through %s and those nearby"),
        ccb.content.text("<npcname> cleanly reap through %s and those nearby"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_tec = true,
    aoe = "wide",
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_null" },
}

-- No translation on wiki.  It's a Somersault Kick.
ccb.content.define_technique {
    id = "mma_tec_panzer_somersault",
    name = ccb.content.text("Kumai Sharinraku"),
    messages = {
        ccb.content.text("You jump and somersault kick %s"),
        ccb.content.text("<npcname> jump and somersault kick %s"),
    },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = { "vector_null", "vector_foot_heel" },
}

-- Heart Strike.  Alita's signature attack.
ccb.content.define_technique {
    id = "mma_tec_panzer_precise",
    name = ccb.content.text("Herzschlag"),
    messages = {
        ccb.content.text("You hit %s with a powerful vibro-punch"),
        ccb.content.text("<npcname> hits %s with a powerful vibro-punch"),
    },
    skills = { { id = "unarmed", level = 5 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "per", scale = 1.0 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "per", scale = 1.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "per", scale = 1.0 },
    },
    mult_bonuses = {
        { stat = "movecost", scale = 1.2 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

-- Missile Blow.
ccb.content.define_technique {
    id = "mma_tec_panzer_rapid",
    name = ccb.content.text("Geschoss Schlag"),
    messages = {
        ccb.content.text("You launch a supersonic punch at %s"),
        ccb.content.text("<npcname> launches a supersonic punch at %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "mma_tec_pokken_kick",
    name = ccb.content.text("Mega Kick"),
    messages = {
        ccb.content.text("You use Mega Kick on %s"),
        ccb.content.text("<npcname> uses Mega Kick on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 2.0 },
        { stat = "damage", damage_type = "cut", scale = 2.0 },
        { stat = "damage", damage_type = "stab", scale = 2.0 },
    },
    attack_vectors = { "vector_foot_sole" },
}

ccb.content.define_technique {
    id = "mma_tec_pokken_lariat",
    name = ccb.content.text("Darkest Lariat"),
    messages = {
        ccb.content.text("You use Darkest Lariat on %s"),
        ccb.content.text("<npcname> uses Darkest Lariat on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 1.5 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 1.5 },
    },
    attack_vectors = { "vector_arm" },
}

ccb.content.define_technique {
    id = "mma_tec_pokken_strike",
    name = ccb.content.text("Smart Strike"),
    messages = {
        ccb.content.text("You use Smart Strike on %s"),
        ccb.content.text("<npcname> uses Smart Strike on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    flat_bonuses = { { stat = "hit", scale = 5.0 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_headbutt",
        "vector_shoulder",
    },
}

ccb.content.define_technique {
    id = "mma_tec_pokken_sweep",
    name = ccb.content.text("Low Sweep"),
    messages = {
        ccb.content.text("You use Low Sweep on %s"),
        ccb.content.text("<npcname> uses Low Sweep on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    down_dur = 1,
    attack_vectors = { "vector_foot_toes", "vector_avian_talons", "vector_hoof_kick", "vector_shin" },
    when = "allow_mma_tec_pokken_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size incapable of flight"),
}

ccb.content.define_technique {
    id = "mma_tec_setting_sun_stun",
    name = ccb.content.text("Hydra Slaying Strike"),
    messages = {
        ccb.content.text("You interrupt %s with a perfectly aimed strike"),
        ccb.content.text("<npcname> interrupt %s with a perfectly aimed strike"),
    },
    skills = { { id = "unarmed", level = 4 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "mma_tec_setting_sun_throw",
    name = ccb.content.text("Mighty Throw"),
    messages = {
        ccb.content.text("You toss %s aside with a Mighty Throw"),
        ccb.content.text("<npcname> tosses %s with a Mighty Throw"),
    },
    skills = { { id = "unarmed", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    required_buffs_all = { "mma_buff_setting_sun_onpause" },
    down_dur = 2,
    knockback_dist = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.33 },
        { stat = "damage", damage_type = "cut", scale = 1.33 },
        { stat = "damage", damage_type = "stab", scale = 1.33 },
    },
    attack_vectors = { "vector_grasp" },
    when = "allow_mma_tec_setting_sun_throw",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "mma_tec_setting_sun_throw_crit",
    name = ccb.content.text("Ballista Throw"),
    messages = {
        ccb.content.text("You spin and hurl %s away with a Ballista Throw"),
        ccb.content.text("<npcname> spins and hurls %s away with a Ballista Throw"),
    },
    skills = { { id = "unarmed", level = 5 } },
    melee_allowed = true,
    unarmed_allowed = true,
    required_buffs_all = { "mma_buff_setting_sun_onpause" },
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 4,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_grasp" },
    when = "allow_mma_tec_setting_sun_throw",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "mma_tec_shii_cho_disarm",
    name = ccb.content.text("Disarming Slash"),
    messages = {
        ccb.content.text("You disarm %s with a quick flick of your weapon"),
        ccb.content.text("<npcname> disarms %s with a quick flick of their weapon"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    crit_ok = true,
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
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_shii_cho_wide",
    name = ccb.content.text("Sarlacc Sweep"),
    messages = {
        ccb.content.text("You quickly sweep through %s and those nearby"),
        ccb.content.text("<npcname> quickly sweeps through %s and those nearby"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_ok = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_stone_dragon_hammer",
    name = ccb.content.text("Mountain Hammer"),
    messages = {
        ccb.content.text("You crush %s with the weight of your Mountain Hammer"),
        ccb.content.text("<npcname> crushes %s with the weight of their Mountain Hammer"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 0.5 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 0.5 },
    },
    attack_vectors = { "vector_null", "vector_wrist" },
}

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

ccb.content.define_technique {
    id = "mma_tec_tiger_claw_break",
    name = ccb.content.text("Wolverine Stance"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you thrash your way to freedom"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they thrash their way to freedom"),
    },
    melee_allowed = true,
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}
