local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_none",
    name = ccb.content.text("Not a technique at all"),
    attack_vectors = { "vector_null" },
    dummy = true,
}

ccb.content.define_technique {
    id = "tech_base_headbutt",
    name = ccb.content.text("Headbutt"),
    crit_ok = true,
    unarmed_allowed = true,
    messages = { ccb.content.text("You headbutt %s"), ccb.content.text("<npcname> headbutts %s") },
    description = ccb.content.text("A basic headbutt"),
    skills = { { id = "unarmed", level = 3 } },
    attack_vectors = { "vector_headbutt" },
    when = "allow_tech_bird_peck_grabbed",
}

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

-- Basic size filtering, if the target is grabbing you contested roll of strength vs grab strength
ccb.content.define_technique {
    id = "BRUTAL",
    name = ccb.content.text("Brutal Strike"),
    melee_allowed = true,
    crit_tec = true,
    skills = { { id = "melee", level = 2 } },
    stun_dur = 1,
    knockback_dist = 1,
    messages = { ccb.content.text("You send %s reeling"), ccb.content.text("<npcname> sends %s reeling") },
    description = ccb.content.text("Stun 1 turn, knockback 1 tile, crit only, min 2 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_brutal",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "RAPID",
    name = ccb.content.text("Rapid Strike"),
    manual_activation = true,
    melee_allowed = true,
    skills = { { id = "melee", level = 2 } },
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    messages = { ccb.content.text("You quickly strike %s"), ccb.content.text("<npcname> quickly strikes %s") },
    description = ccb.content.text("50% moves, 66% damage, min 2 melee"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "MOUNTED_CHARGE",
    name = ccb.content.text("Mounted Charge"),
    description = ccb.content.text("Charge forward while mounted and strike the first creature in your path."),
    manual_activation = true,
    cooldown = "10 s",
    melee_allowed = true,
    messages = { ccb.content.text("You charge into %s"), ccb.content.text("<npcname> charges into %s") },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "VORPAL",
    name = ccb.content.text("Vorpal Strike"),
    melee_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "cut", scale = 99 } },
    crit_tec = true,
    weighting = -250,
    messages = {
        ccb.content.text("Snicker-snack!  You slice through %s like a hot knife through butter"),
        ccb.content.text("Snicker-snack!  <npcname> slices through %s like a hot knife through butter"),
    },
    description = ccb.content.text("Cut damage multiply by 99, crit only"),
    attack_vectors = { "vector_null" },
}

-- Similar size, no wrapping tiny or very nonstandard targets
ccb.content.define_technique {
    id = "WRAP",
    name = ccb.content.text("Wrap Attack"),
    melee_allowed = true,
    skills = { { id = "melee", level = 4 } },
    stun_dur = 2,
    messages = { ccb.content.text("You wrap up %s"), ccb.content.text("<npcname> wraps up %s") },
    description = ccb.content.text("Stun 2 turns, min 4 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_wrap",
    condition_description = ccb.content.text("* Only works on a target of <info>similar size</info> with limbs to catch"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "SWEEP",
    name = ccb.content.text("Sweep Attack"),
    melee_allowed = true,
    skills = { { id = "melee", level = 3 } },
    down_dur = 2,
    messages = { ccb.content.text("You sweep %s"), ccb.content.text("<npcname> sweeps %s") },
    description = ccb.content.text("Down 2 turns, min 3 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

-- this should basically always happen if you get the crit
ccb.content.define_technique {
    id = "SWEETSPOT",
    name = ccb.content.text("Sweet Spot Hit"),
    melee_allowed = true,
    crit_tec = true,
    needs_ammo = true,
    stun_dur = 1,
    knockback_dist = 2,
    weighting = 10,
    mult_bonuses = {
        { stat = "movecost", scale = 1.1 },
        { stat = "damage", damage_type = "bash", scale = 2.5 },
        { stat = "damage", damage_type = "cut", scale = 2.5 },
        { stat = "damage", damage_type = "stab", scale = 2.5 },
    },
    messages = {
        ccb.content.text("With a loud crack the piston extends, sending %s reeling"),
        ccb.content.text("<npcname> sends %s reeling"),
    },
    description = ccb.content.text("Stun 1 turn, knockback 2 tile, crit only, requires ammo"),
    attack_vectors = { "vector_null" },
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "PRECISE",
    name = ccb.content.text("Precise Strike"),
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    crit_tec = true,
    messages = { ccb.content.text("You precisely hit %s"), ccb.content.text("<npcname> precisely hits %s") },
    stun_dur = 2,
    description = ccb.content.text("Stun 2 turns, crit only, min 3 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_precise",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "WHIP_DISARM",
    name = ccb.content.text("Disarm"),
    melee_allowed = true,
    disarms = true,
    messages = {
        ccb.content.text("You disarm %s using your whip"),
        ccb.content.text("<npcname> disarms %s using their whip"),
    },
    description = ccb.content.text("Unwield target's weapon"),
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
    id = "tec_feint",
    name = ccb.content.text("Feint"),
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    messages = { ccb.content.text("You feint at %s"), ccb.content.text("<npcname> feints at %s") },
}

ccb.content.define_technique {
    id = "tec_break",
    name = ccb.content.text("Grab Break"),
    melee_allowed = true,
    defensive = true,
    grab_break = true,
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you break its grab"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break its grab"),
    },
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_precise",
    name = ccb.content.text("Precise Strike"),
    melee_allowed = true,
    crit_tec = true,
    messages = { ccb.content.text("You jab deftly at %s"), ccb.content.text("<npcname> jabs deftly at %s") },
    stun_dur = 2,
    attack_vectors = { "vector_null" },
    when = "allow_tec_precise",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned humanoid</info> target of <info>similar or smaller</info> size"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_aikido_blockthrow",
    name = ccb.content.text("Counter Throw (block)"),
    messages = {
        ccb.content.text("You smoothly throw %s"),
        ccb.content.text("<npcname> blocks and smoothly throws %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_aikido_onblock" },
    crit_ok = true,
    down_dur = 1,
    knockback_dist = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.7 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_aikido_dodgethrow",
    name = ccb.content.text("Counter Throw (dodge)"),
    messages = {
        ccb.content.text("You smoothly throw %s"),
        ccb.content.text("<npcname> dodges and smoothly throws %s"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_aikido_ondodge" },
    crit_ok = true,
    down_dur = 1,
    knockback_dist = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.7 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_aikido_blockdisarm",
    name = ccb.content.text("Disarming Throw (block)"),
    messages = {
        ccb.content.text("You smoothly disarm %s"),
        ccb.content.text("<npcname> blocks and smoothly disarms %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_aikido_onblock" },
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
    down_dur = 1,
    knockback_dist = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.7 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_aikido_dodgedisarm",
    name = ccb.content.text("Disarming Throw (dodge)"),
    messages = {
        ccb.content.text("You smoothly disarm %s"),
        ccb.content.text("<npcname> dodges and smoothly disarms %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_aikido_ondodge" },
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
    down_dur = 1,
    knockback_dist = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.7 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

ccb.content.define_technique {
    id = "tec_aikido_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you smoothly break free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they smoothly break free"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_bojutsu_thrust",
    name = ccb.content.text("Front Thrust"),
    messages = { ccb.content.text("You thrust at %s"), ccb.content.text("<npcname> thrusts at %s") },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    attack_vectors = { "vector_null" },
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_bojutsu_kneestrike",
    name = ccb.content.text("Knee Strike"),
    messages = {
        ccb.content.text("After blocking %s's attack you quickly strike at their knee"),
        ccb.content.text("After blocking %s's attack <npcname> quickly strikes at their knee"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    block_counter = true,
    crit_ok = true,
    down_dur = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

-- Similar size
ccb.content.define_technique {
    id = "tec_bojutsu_frontstrike",
    name = ccb.content.text("Overhead Front Strike"),
    messages = {
        ccb.content.text("You block %s's attack and counter with a Overhead Front Strike"),
        ccb.content.text("<npcname> blocks %s's attack and counter with a Overhead Front Strike"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    block_counter = true,
    crit_ok = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.4 } },
    attack_vectors = { "vector_null" },
    when = "allow_tec_bojutsu_frontstrike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_bojutsu_rollingstrike",
    name = ccb.content.text("Rolling Strike"),
    messages = {
        ccb.content.text("Using your rolling staff you quickly strike %s"),
        ccb.content.text("Using their rolling staff <npcname> quickly strikes %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    required_buffs_all = { "buff_bojutsu_onmove" },
    weighting = 2,
    crit_ok = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_bojutsu_feint",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a strike at %s"),
        ccb.content.text("<npcname> fakes a strike at %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
}

ccb.content.define_technique {
    id = "tec_bojutsu_disarm",
    name = ccb.content.text("Hooking Disarm"),
    messages = {
        ccb.content.text("You're able to disarm %s by hooking their weapon"),
        ccb.content.text("<npcname> hooks %s's weapon and casts it away"),
    },
    skills = { { id = "melee", level = 5 } },
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
    id = "tec_barbaran_impale",
    name = ccb.content.text("Impaling Estocada"),
    messages = {
        ccb.content.text("You thrust your weapon through %s"),
        ccb.content.text("<npcname> thrusts their weapon through %s"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    weapon_categories = { "GREAT_SWORDS" },
    aoe = "impale",
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
        { stat = "movecost", scale = 1.2 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_barbaran_disarm",
    name = ccb.content.text("Swift Atajo"),
    messages = {
        ccb.content.text("You jab a quick blow at %s's grip"),
        ccb.content.text("<npcname> jabs a quick blow at %s's grip"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
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
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_boxing_cross",
    name = ccb.content.text("Cross"),
    messages = {
        ccb.content.text("You throw a heavy cross at %s"),
        ccb.content.text("<npcname> throws a cross at %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_boxing_counter",
    name = ccb.content.text("Cross Counter"),
    messages = {
        ccb.content.text("You cross-counter %s"),
        ccb.content.text("<npcname> throws a perfect counter at %s"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_boxing_ondodge" },
    weighting = 2,
    crit_tec = true,
    knockback_dist = 1,
    knockback_spread = 1,
    stun_dur = 1,
    down_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.5 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_boxing_rapid",
    name = ccb.content.text("Jab"),
    messages = { ccb.content.text("You quickly jab %s"), ccb.content.text("<npcname> quickly jabs at %s") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

-- Things of similar size in both directions that keep their heads high
ccb.content.define_technique {
    id = "tec_boxing_upper",
    name = ccb.content.text("Uppercut"),
    messages = { ccb.content.text("You uppercut %s"), ccb.content.text("<npcname> uppercuts %s") },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.4 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_boxing_upper",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar</info> size"),
}

ccb.content.define_technique {
    id = "tec_brawl_break_melee",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you force yourself free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break free"),
    },
    skills = { { id = "melee", level = 6 } },
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_brawl_break_unarmed",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you force yourself free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break free"),
    },
    skills = { { id = "unarmed", level = 6 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_brawl_feint_melee",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a strike at %s"),
        ccb.content.text("<npcname> fakes a strike at %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_brawl_feint_unarmed",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a strike at %s"),
        ccb.content.text("<npcname> fakes a strike at %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_brawl_disarm_melee",
    name = ccb.content.text("Disarm"),
    messages = {
        ccb.content.text("You knock %s's weapon away"),
        ccb.content.text("<npcname> knock %s's weapon away"),
    },
    skills = { { id = "melee", level = 6 } },
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
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_brawl_disarm_unarmed",
    name = ccb.content.text("Disarm"),
    messages = {
        ccb.content.text("You knock %s's weapon away"),
        ccb.content.text("<npcname> knock %s's weapon away"),
    },
    skills = { { id = "unarmed", level = 6 } },
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
    attack_vectors = { "vector_grasp" },
}

-- Similar size
ccb.content.define_technique {
    id = "tec_brawl_power",
    name = ccb.content.text("Power Hit"),
    messages = { ccb.content.text("You send %s reeling"), ccb.content.text("<npcname> sends %s reeling") },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    knockback_dist = 1,
    stun_dur = 1,
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_brawl_power",
    condition_description = ccb.content.text("* Only works on a <info>non-downed and non-stunned</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_brawl_trip",
    name = ccb.content.text("Trip"),
    messages = { ccb.content.text("You trip %s"), ccb.content.text("<npcname> trips %s") },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    down_dur = 1,
    attack_vectors = { "vector_shin" },
    when = "allow_tec_brawl_trip",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar</info> size"),
}

ccb.content.define_technique {
    id = "tec_capoeira_feint",
    name = ccb.content.text("Feint"),
    messages = { ccb.content.text("You fake a kick at %s"), ccb.content.text("<npcname> fakes a kick at %s") },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_capoeira_pushkick",
    name = ccb.content.text("Push Kick"),
    messages = { ccb.content.text("You push kick %s"), ccb.content.text("<npcname> push kicks %s") },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = { "vector_foot_sole" },
}

ccb.content.define_technique {
    id = "tec_capoeira_circlekick",
    name = ccb.content.text("Circle Kick"),
    messages = { ccb.content.text("You circle kick %s"), ccb.content.text("<npcname> circle kicks %s") },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_foot_sole" },
}

ccb.content.define_technique {
    id = "tec_capoeira_sweepkick",
    name = ccb.content.text("Sweep Kick"),
    messages = { ccb.content.text("You sweep kick %s"), ccb.content.text("<npcname> sweep kicks %s") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_capoeira_onmove" },
    weighting = 2,
    down_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
    when = "allow_tec_brawl_trip",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar</info> size"),
}

ccb.content.define_technique {
    id = "tec_capoeira_spinkick",
    name = ccb.content.text("Spin Kick"),
    messages = { ccb.content.text("You spin kick %s"), ccb.content.text("<npcname> spin kicks %s") },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_capoeira_onmove" },
    weighting = 2,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_foot_sole" },
    when = "allow_tec_capoeira_spinkick",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_crane_feint",
    name = ccb.content.text("Crane Wing"),
    messages = {
        ccb.content.text("You raise your arms intimidatingly at %s"),
        ccb.content.text("<npcname> performs the Crane Wing at %s"),
    },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_crane_precise",
    name = ccb.content.text("Crane Kick"),
    messages = { ccb.content.text("You leap and kick %s"), ccb.content.text("<npcname> leaps and kicks %s") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_crane_ondodge" },
    crit_ok = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_crane_break",
    name = ccb.content.text("Crane Flap"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you swing your arms and break free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they flap free"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

-- TODO: differentiate the stun from the damage, though 1.5x flat is excessive
ccb.content.define_technique {
    id = "tec_crane_strike",
    name = ccb.content.text("Crane Strike"),
    messages = {
        ccb.content.text("You hand-peck and strike %s"),
        ccb.content.text("<npcname> hand-pecks and strikes %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_crane_ondodge" },
    crit_ok = true,
    stun_dur = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_wrist" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_dragon_claw",
    name = ccb.content.text("Dragon Claw"),
    unarmed_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    messages = {
        ccb.content.text("You lash out at %s with a Dragon Claw"),
        ccb.content.text("<npcname> lashes out at %s with a Dragon Claw"),
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_dragon_tail",
    name = ccb.content.text("Dragon Tail"),
    messages = {
        ccb.content.text("You sweep %s with a quick Dragon Tail"),
        ccb.content.text("<npcname> sweeps %s with a quick Dragon Tail sweep"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_foot_heel" },
    when = "allow_tec_brawl_trip",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar</info> size"),
}

ccb.content.define_technique {
    id = "tec_dragon_strike",
    name = ccb.content.text("Dragon Strike"),
    messages = {
        ccb.content.text("You descend upon %s with a powerful Dragon Strike"),
        ccb.content.text("<npcname> descends upon %s with a powerful Dragon Strike"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}

ccb.content.define_technique {
    id = "tec_eskrima_round",
    name = ccb.content.text("Round Strike"),
    messages = { ccb.content.text("You round strike %s"), ccb.content.text("<npcname> round strikes %s") },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.6 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_eskrima_fan",
    name = ccb.content.text("Fan Strike"),
    messages = { ccb.content.text("You fan strike %s"), ccb.content.text("<npcname> fan strikes %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.75 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_eskrima_snap",
    name = ccb.content.text("Snap Strike"),
    messages = { ccb.content.text("You snap out at %s"), ccb.content.text("<npcname> snaps quickly at %s") },
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_eskrima_combination",
    name = ccb.content.text("Combination Strike"),
    messages = {
        ccb.content.text("You combination strike %s"),
        ccb.content.text("<npcname> combination strikes %s"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    required_buffs_all = { "buff_eskrima_oncrit" },
    crit_tec = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.8 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_eskrima_stun",
    name = ccb.content.text("Stunning Strike"),
    messages = {
        ccb.content.text("You deliver a stunning strike to %s"),
        ccb.content.text("<npcname> delivers a stunning strike to %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_eskrima_low",
    name = ccb.content.text("Low Strike"),
    messages = {
        ccb.content.text("Your weapon becomes a blur as you ground %s"),
        ccb.content.text("<npcname>'s weapon becomes a blur as they ground %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_tec = true,
    down_dur = 1,
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_fencing_feint",
    messages = {
        ccb.content.text("You steady your weapon and fake a thrust at %s"),
        ccb.content.text("<npcname> steadies their weapon and fakes a thrust at %s"),
    },
    name = ccb.content.text("Feint"),
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_fencing_lunge",
    name = ccb.content.text("Fencing Lunge"),
    messages = { ccb.content.text("You lunge at %s"), ccb.content.text("<npcname> lunges at %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    crit_ok = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_fencing_compound1",
    name = ccb.content.text("Compound Attack (Remise)"),
    messages = {
        ccb.content.text("Your feint leads to a compound attack against %s"),
        ccb.content.text("<npcname>'s feint leads to a compound attack against %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    required_buffs_all = { "buff_fencing_onmiss" },
    weighting = 4,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_fencing_compound2",
    name = ccb.content.text("Compound Attack (Counter Time)"),
    messages = {
        ccb.content.text("Your feint leads to a compound attack against %s"),
        ccb.content.text("<npcname>'s feint leads to a compound attack against %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_all = { "buff_fencing_onpause" },
    weighting = 4,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_fencing_riposte",
    name = ccb.content.text("Fencing Riposte"),
    messages = {
        ccb.content.text("You deliver a perfect riposte to %s"),
        ccb.content.text("<npcname> delivers a perfect riposte to %s"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    required_buffs_all = { "buff_fencing_onblock" },
    crit_ok = true,
    weighting = 2,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.66 },
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_medievalpole_counter",
    name = ccb.content.text("Displace and Hook"),
    messages = {
        ccb.content.text("You parry and hook %s down"),
        ccb.content.text("<npcname> parries and hooks %s down"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_all = { "buff_medievalpole_onblock" },
    crit_ok = true,
    weighting = 2,
    down_dur = 2,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_medievalpole_highround",
    name = ccb.content.text("High Round Strike"),
    messages = {
        ccb.content.text("You swing high and strike at %s"),
        ccb.content.text("<npcname> swings high and strikes %s"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    forbidden_buffs_all = { "buff_medievalpole_onmove" },
    reach_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_medievalpole_feint",
    name = ccb.content.text("High Round Feint"),
    messages = {
        ccb.content.text("You fake a high round strike at %s"),
        ccb.content.text("<npcname> feints at %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
}

ccb.content.define_technique {
    id = "tec_medievalpole_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you push away"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they push away"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

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

ccb.content.define_technique {
    id = "tec_judo_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you break their feeble grapple"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break its feeble grapple"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_karate_precise",
    name = ccb.content.text("Knifehand Strike"),
    messages = {
        ccb.content.text("You hit %s with a knifehand strike"),
        ccb.content.text("<npcname> hits %s with a knifehand strike"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_wrist" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_karate_rapid",
    name = ccb.content.text("Backfist Strike"),
    messages = {
        ccb.content.text("You quickly strike %s with the back of your fist"),
        ccb.content.text("<npcname> quickly strikes %s with the back of their fist"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_backhand" },
}

ccb.content.define_technique {
    id = "tec_karate_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_karate_staff",
    name = ccb.content.text("Staff Strike"),
    messages = {
        ccb.content.text("You strike %s with your staff"),
        ccb.content.text("<npcname> strikes %s with their staff"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    weapon_categories = { "QUARTERSTAVES" },
    mult_bonuses = { { stat = "movecost", scale = 0.9 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_karate_staff_crit",
    name = ccb.content.text("Heavy Staff Strike"),
    messages = {
        ccb.content.text("You swing your staff hard at %s"),
        ccb.content.text("<npcname> swings their staff hard at %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    weapon_categories = { "QUARTERSTAVES" },
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_kickboxing_rapid",
    name = ccb.content.text("Jab"),
    messages = { ccb.content.text("You quickly jab %s"), ccb.content.text("<npcname> quickly jabs at %s") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_kickboxing_cross",
    name = ccb.content.text("Cross"),
    messages = {
        ccb.content.text("You throw a heavy cross at %s"),
        ccb.content.text("<npcname> throws a cross at %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_kickboxing_push",
    name = ccb.content.text("Push Kick"),
    messages = {
        ccb.content.text("You shove %s back with a front kick"),
        ccb.content.text("<npcname> shoves %s back with a front kick"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    knockback_dist = 1,
    attack_vectors = { "vector_foot_sole" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

-- Things of similar size in both directions that keep their heads high
ccb.content.define_technique {
    id = "tec_kickboxing_upper",
    name = ccb.content.text("Uppercut"),
    messages = { ccb.content.text("You uppercut %s"), ccb.content.text("<npcname> uppercuts %s") },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.4 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_boxing_upper",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar</info> size"),
}

ccb.content.define_technique {
    id = "tec_kickboxing_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_krav_maga_rapid",
    messages = { ccb.content.text("You jab at %s"), ccb.content.text("<npcname> jabs at %s") },
    name = ccb.content.text("Jab"),
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_null", "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_krav_maga_disarm_simple",
    messages = {
        ccb.content.text("You quickly slap and disarm %s"),
        ccb.content.text("<npcname> quickly slaps and disarms %s"),
    },
    name = ccb.content.text("Disarming Slap"),
    skills = { { id = "unarmed", level = 2 } },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.9 } },
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
    attack_vectors = { "vector_null", "vector_grasp" },
}

ccb.content.define_technique {
    id = "tec_krav_maga_crit",
    name = ccb.content.text("Cheap Shot"),
    messages = {
        ccb.content.text("You hit %s where it hurts"),
        ccb.content.text("<npcname> hits %s with a cheap shot"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    weighting = 2,
    stun_dur = 1,
    attack_vectors = {
        "vector_null",
        "vector_headbutt",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_elbow",
        "vector_foot_toes",
        "vector_hoof_kick",
        "vector_avian_talons",
        "vector_digitigrade_paws",
        "vector_shin",
        "vector_knee",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_krav_maga_takedown",
    name = ccb.content.text("Takedown"),
    messages = {
        ccb.content.text("You force %s to the ground"),
        ccb.content.text("<npcname> forces %s to the ground"),
    },
    skills = { { id = "unarmed", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_ok = true,
    weighting = 2,
    down_dur = 1,
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_krav_maga_disarm",
    name = ccb.content.text("Bone Breaker"),
    messages = {
        ccb.content.text("*CRACK!* You brutally maim %s's arm"),
        ccb.content.text("*CRACK!* <npcname> brutally maims %s's arm"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    weighting = 3,
    crit_tec = true,
    effects = {
        {
            id = "maimed_arm",
            chance = 100,
            duration_turns = 44000,
            on_damage = true,
            message = ccb.content.text("The arm of %s is mangled beyond recognition!"),
        },
    },
    flat_bonuses = { { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.0 } },
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    attack_vectors = { "vector_arm_grapple" },
    when = "allow_tec_krav_maga_disarm",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> and <info>stunned</info> humanoid target"),
}

ccb.content.define_technique {
    id = "tec_krav_maga_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you wrestle free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they wrestle free"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_leopard_feint",
    name = ccb.content.text("Leopard Paw"),
    messages = {
        ccb.content.text("You paw aggressively at %s"),
        ccb.content.text("<npcname> paws aggressively at %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_leopard_precise",
    name = ccb.content.text("Leopard Fist"),
    messages = {
        ccb.content.text("You strike out at %s with your Leopard Fist"),
        ccb.content.text("<npcname> strikes out at %s with a Leopard Fist"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_leopard_rapid",
    name = ccb.content.text("Leopard Swipe"),
    messages = {
        ccb.content.text("You quickly swipe at %s"),
        ccb.content.text("<npcname> quickly swipes at %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_leopard_claw",
    name = ccb.content.text("Leopard Claw"),
    messages = {
        ccb.content.text("You savagely claw at %s"),
        ccb.content.text("<npcname> savagely claws at %s"),
    },
    unarmed_allowed = true,
    crit_tec = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.8 },
        { stat = "damage", damage_type = "bash", scale = 1.3 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_leopard_pounce",
    name = ccb.content.text("Leopard Pounce"),
    messages = {
        ccb.content.text("You leap and pounce on %s"),
        ccb.content.text("<npcname> leaps and pounces on %s"),
    },
    unarmed_allowed = true,
    required_buffs_all = { "buff_leopard_oncrit" },
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.8 },
        { stat = "damage", damage_type = "bash", scale = 2.0 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_leopard_pounce",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>identical or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_swordsmanship_ringen",
    name = ccb.content.text("Grab"),
    messages = {
        ccb.content.text("You wrestle %s to the ground"),
        ccb.content.text("<npcname> wrestles %s to the ground"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_all = { "buff_swordsmanship_onpause" },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.33 },
    },
    crit_tec = true,
    down_dur = 2,
    attack_vectors = { "vector_null" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_swordsmanship_lethal",
    name = ccb.content.text("Lethal Strike"),
    messages = {
        ccb.content.text("You drive the point of your blade into %s"),
        ccb.content.text("<npcname> drives their blade into %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    required_buffs_all = { "buff_swordsmanship_onpause" },
    crit_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 1.5 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 1.5 },
    },
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_swordsmanship_feint",
    name = ccb.content.text("Flow Drills"),
    messages = {
        ccb.content.text("With practiced movements, you transition from a failed strike into another strike"),
        ccb.content.text("With practiced movements, <npcname> transitions from a failed strike into another strike"),
    },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_muay_thai_rapid",
    name = ccb.content.text("Jab"),
    messages = { ccb.content.text("You quickly jab %s"), ccb.content.text("<npcname> quickly jabs at %s") },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_muay_thai_cross",
    name = ccb.content.text("Cross"),
    messages = {
        ccb.content.text("You throw a heavy cross at %s"),
        ccb.content.text("<npcname> throws a cross at %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_muay_thai_elbow",
    name = ccb.content.text("Elbow Strike"),
    messages = {
        ccb.content.text("You slam your elbow into %s"),
        ccb.content.text("<npcname> slams their elbow into %s"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    crit_tec = true,
    flat_bonuses = { { stat = "damage", damage_type = "cut", scale = 2 } },
    mult_bonuses = { { stat = "movecost", scale = 0.66 } },
    attack_vectors = { "vector_elbow" },
}

ccb.content.define_technique {
    id = "tec_muay_thai_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = {
        "vector_shin",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_muay_thai_push",
    name = ccb.content.text("Push Kick"),
    messages = {
        ccb.content.text("You shove %s back with a front kick"),
        ccb.content.text("<npcname> shoves %s back with a front kick"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    knockback_dist = 1,
    attack_vectors = { "vector_foot_sole" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_muay_thai_knee",
    name = ccb.content.text("Knee Strike"),
    messages = {
        ccb.content.text("You drive your knee into %s"),
        ccb.content.text("<npcname> drives their knee into %s"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.35 } },
    attack_vectors = { "vector_knee" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_muay_thai_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you break the clinch"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break the clinch"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_ninjutsu_swift",
    name = ccb.content.text("Swift Strike (normal)"),
    messages = { ccb.content.text("You swiftly strike %s"), ccb.content.text("<npcname> swiftly strikes %s") },
    skills = { { id = "melee", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_elbow",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
        "vector_shin",
    },
}

ccb.content.define_technique {
    id = "tec_ninjutsu_swift_crit",
    name = ccb.content.text("Swift Strike (crit)"),
    messages = { ccb.content.text("You swiftly strike %s"), ccb.content.text("<npcname> swiftly strikes %s") },
    skills = { { id = "melee", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_ninjutsu_onattack" },
    crit_tec = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_elbow",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
        "vector_shin",
    },
}

ccb.content.define_technique {
    id = "tec_ninjutsu_precise",
    name = ccb.content.text("Assassinate"),
    messages = {
        ccb.content.text("You attempt to slay %s in a single stroke"),
        ccb.content.text("<npcname> attempts to slay %s in a single stroke"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    forbidden_buffs_all = { "buff_ninjutsu_onattack" },
    crit_tec = true,
    weighting = 3,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.3 },
        { stat = "damage", damage_type = "cut", scale = 1.3 },
        { stat = "damage", damage_type = "stab", scale = 1.3 },
    },
    attack_vectors = { "vector_null" },
}

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

ccb.content.define_technique {
    id = "niten_water_cut",
    name = ccb.content.text("Flowing Water Cut"),
    messages = {
        ccb.content.text("You strike %s with the slow power of flowing water"),
        ccb.content.text("<npcname> strikes %s with the slow power of flowing water"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 1.75 },
        { stat = "damage", damage_type = "bash", scale = 2.0 },
        { stat = "damage", damage_type = "cut", scale = 2.0 },
    },
    attack_vectors = { "vector_null" },
}

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

ccb.content.define_technique {
    id = "niten_timing_attack",
    name = ccb.content.text("In-One Timing"),
    messages = {
        ccb.content.text("You strike at %s's weak spot"),
        ccb.content.text("<npcname> strikes at %s's weak spot"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    required_buffs_all = { "buff_niten_ondodge" },
    crit_ok = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "niten_feint",
    name = ccb.content.text("Feint"),
    messages = { ccb.content.text("You feint at %s"), ccb.content.text("<npcname> feints at %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
}

ccb.content.define_technique {
    id = "tec_pankration_cross",
    name = ccb.content.text("Cross"),
    messages = {
        ccb.content.text("You throw a heavy cross at %s"),
        ccb.content.text("<npcname> throws a cross at %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_pankration_kick",
    name = ccb.content.text("Kick"),
    messages = { ccb.content.text("You kick %s hard"), ccb.content.text("<npcname> kicks %s hard") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 2,
    attack_vectors = { "vector_foot_sole" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_pankration_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you wrestle free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they wrestle free"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_pankration_grabknee",
    name = ccb.content.text("Grab and Knee"),
    messages = { ccb.content.text("You grab and knee %s"), ccb.content.text("<npcname> grabs and knees %s") },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    weighting = 3,
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    attack_vectors = { "vector_knee" },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}

ccb.content.define_technique {
    id = "tec_pankration_grabdisarm",
    name = ccb.content.text("Arm Lock"),
    messages = {
        ccb.content.text("You disarm %s with an arm lock"),
        ccb.content.text("<npcname> disarms %s with an arm lock"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_ok = true,
    weighting = 3,
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
    flat_bonuses = { { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.0 } },
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_arm_grapple" },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_pankration_grabthrow",
    name = ccb.content.text("Grab and Throw"),
    messages = { ccb.content.text("You grab and throw %s"), ccb.content.text("<npcname> grabs and throws %s") },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    weighting = 3,
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 2,
    knockback_spread = 2,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

ccb.content.define_technique {
    id = "tec_silat_hamstring",
    name = ccb.content.text("Hamstring"),
    messages = {
        ccb.content.text("You ground %s with a low blow"),
        ccb.content.text("<npcname> grounds %s with a low blow"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    crit_tec = true,
    down_dur = 2,
    attack_vectors = { "vector_null" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_silat_precise",
    name = ccb.content.text("Vicious Precision"),
    messages = {
        ccb.content.text("You viciously wound %s"),
        ccb.content.text("<npcname> viciously wounds %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    crit_ok = true,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.33 },
        { stat = "damage", damage_type = "cut", scale = 1.33 },
        { stat = "damage", damage_type = "stab", scale = 1.33 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}

ccb.content.define_technique {
    id = "tec_silat_dirty",
    name = ccb.content.text("Dirty Hit"),
    messages = {
        ccb.content.text("You hit %s with a dirty blow"),
        ccb.content.text("<npcname> delivers a dirty blow to %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 2,
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_silat_brutal",
    name = ccb.content.text("Silat Brutality"),
    messages = {
        ccb.content.text("You brutally tear into %s"),
        ccb.content.text("<npcname> brutally tears into %s"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_ok = true,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.33 },
        { stat = "damage", damage_type = "cut", scale = 1.33 },
        { stat = "damage", damage_type = "stab", scale = 1.33 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_venom_snake_tail",
    condition_description = ccb.content.text("* Only works on a <info>stunned</info> target"),
}

ccb.content.define_technique {
    id = "tec_snake_swift",
    name = ccb.content.text("Snake Snap"),
    messages = { ccb.content.text("You swiftly jab %s"), ccb.content.text("<npcname> swiftly jabs %s") },
    unarmed_allowed = true,
    crit_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "per", scale = 0.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "per", scale = 0.5 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "per", scale = 0.5 },
    },
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_snake_feint",
    name = ccb.content.text("Snake Slide"),
    messages = {
        ccb.content.text("You make serpentine hand motions at %s"),
        ccb.content.text("<npcname> makes serpentine hand motions at %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_snake_break",
    name = ccb.content.text("Snake Slither"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you slither free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they slither free"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_snake_precise",
    name = ccb.content.text("Snake Strike"),
    messages = {
        ccb.content.text("You lash out at %s with a vicious Snake Strike"),
        ccb.content.text("<npcname> lashes out at %s with a vicious Snake Strike"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_snake_onpause" },
    crit_tec = true,
    stun_dur = 1,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "per", scale = 1.0 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "per", scale = 1.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "per", scale = 1.0 },
    },
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.5 } },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_sojutsu_shove",
    name = ccb.content.text("Shove"),
    messages = { ccb.content.text("You shove %s back"), ccb.content.text("<npcname> shoves %s back") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    knockback_dist = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_sojutsu_trip",
    name = ccb.content.text("Trip"),
    messages = { ccb.content.text("You deftly trip %s"), ccb.content.text("<npcname> deftly trips %s") },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    reach_ok = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.5 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_sojutsu_jab",
    name = ccb.content.text("Jab"),
    messages = { ccb.content.text("You quickly strike %s"), ccb.content.text("<npcname> quickly strikes %s") },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    reach_tec = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_sojutsu_feint",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a thrust at %s"),
        ccb.content.text("<npcname> fakes a thrust at %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_taekwondo_disarm",
    name = ccb.content.text("Snatch Weapon"),
    messages = {
        ccb.content.text("You snatch %s's weapon"),
        ccb.content.text("<npcname> snatches %s's weapon"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    weighting = 2,
    take_weapon = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 0.5 } },
    attack_vectors = { "vector_grasp" },
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_taekwondo_strong",
    name = ccb.content.text("Spinning Back Kick"),
    messages = {
        ccb.content.text("You spin and back-kick %s, right in the center of gravity"),
        ccb.content.text("<npcname> spins and back-kicks %s, right in the center of gravity"),
    },
    skills = { { id = "unarmed", level = 5 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 2,
    mult_bonuses = {
        { stat = "movecost", scale = 1.5 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_foot_heel" },
    when = "allow_tec_taekwondo_strong",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

ccb.content.define_technique {
    id = "tec_taekwondo_push",
    name = ccb.content.text("Side Kick"),
    messages = {
        ccb.content.text("You turn slightly and side-kick %s"),
        ccb.content.text("<npcname> turns slightly and side-kicks %s"),
    },
    melee_allowed = true,
    unarmed_allowed = true,
    knockback_dist = 1,
    attack_vectors = { "vector_foot_sole" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_taekwondo_sweep",
    name = ccb.content.text("Sweep Kick"),
    messages = {
        ccb.content.text("You crouch low and sweep-kick %s"),
        ccb.content.text("<npcname> crouches low and sweep-kicks %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_ok = true,
    down_dur = 1,
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
        "vector_shin",
    },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_taekwondo_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_taekwondo_feint",
    name = ccb.content.text("Feint"),
    messages = { ccb.content.text("You fake a kick at %s"), ccb.content.text("<npcname> fakes a kick at %s") },
    skills = { { id = "unarmed", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_taichi_disarm",
    name = ccb.content.text("Disarm"),
    messages = { ccb.content.text("You gently disarm %s"), ccb.content.text("<npcname> gently disarms %s") },
    skills = { { id = "unarmed", level = 3 } },
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
    attack_vectors = { "vector_grasp" },
}

ccb.content.define_technique {
    id = "tec_taichi_palm",
    name = ccb.content.text("Palm Strike"),
    messages = { ccb.content.text("You palm strike %s"), ccb.content.text("<npcname> palm strikes %s") },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_tai_chi_onpause" },
    knockback_dist = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = { "vector_palm" },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_taichi_counter",
    name = ccb.content.text("Grasp the Sparrow's Tail"),
    messages = {
        ccb.content.text("You divert %s's attack and lead them to the ground"),
        ccb.content.text("<npcname> diverts %s's attack and leads them to the ground"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_tai_chi_onblock" },
    crit_ok = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_taichi_precise",
    name = ccb.content.text("Double Palm Strike"),
    messages = {
        ccb.content.text("Your double-handed palm strikes %s"),
        ccb.content.text("<npcname>'s double-handed palm strikes %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    required_buffs_all = { "buff_tai_chi_onpause" },
    knockback_dist = 1,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 2.0 },
        { stat = "damage", damage_type = "cut", scale = 2.0 },
        { stat = "damage", damage_type = "stab", scale = 2.0 },
    },
    attack_vectors = { "vector_palm" },
    when = "allow_tec_taichi_precise",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_tiger_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you are too powerful to be caged"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they are too powerful to be caged"),
    },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_tiger_takedown",
    name = ccb.content.text("Tiger Takedown"),
    messages = {
        ccb.content.text("You slam %s to the ground"),
        ccb.content.text("<npcname> slams %s to the ground"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    down_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_tiger_palm",
    name = ccb.content.text("Tiger Palm"),
    messages = {
        ccb.content.text("You land a heavy tiger palm on %s"),
        ccb.content.text("<npcname> lands a heavy tiger palm on %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.0 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 1.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 1.0 },
    },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = { "vector_palm" },
}

ccb.content.define_technique {
    id = "tec_tiger_claw",
    name = ccb.content.text("Tiger Claw"),
    messages = {
        ccb.content.text("You viciously claw at %s"),
        ccb.content.text("<npcname> viciously claws at %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_tiger_wide",
    name = ccb.content.text("Tiger Rampage"),
    messages = {
        ccb.content.text("You slash wildly at %s and those nearby"),
        ccb.content.text("<npcname> slashes wildly at %s and those nearby"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    weighting = 3,
    aoe = "wide",
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.25 },
        { stat = "damage", damage_type = "cut", scale = 1.25 },
        { stat = "damage", damage_type = "stab", scale = 1.25 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_wingchun_punch",
    name = ccb.content.text("Straight Punch"),
    messages = {
        ccb.content.text("You deliver a straight vertical punch to %s"),
        ccb.content.text("<npcname> delivers a straight vertical punch to %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_wingchun_punch_knockback",
    name = ccb.content.text("Straight Punch (Knockback)"),
    messages = {
        ccb.content.text("You force %s back with a straight horizontal punch"),
        ccb.content.text("<npcname> forces %s back with a straight horizontal punch"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_wingchun_onpause" },
    weighting = 2,
    knockback_dist = 1,
    knockback_follow = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_kickboxing_push",
    condition_description = ccb.content.text("* Only works on a target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}

ccb.content.define_technique {
    id = "tec_wingchun_hook",
    name = ccb.content.text("L-hook"),
    messages = {
        ccb.content.text("You deliver a solid L-hook to %s"),
        ccb.content.text("<npcname> delivers a solid L-hook to %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_wingchun_hook_knockback",
    name = ccb.content.text("L-hook (Knockback)"),
    messages = {
        ccb.content.text("You knock %s back with a solid L-hook"),
        ccb.content.text("<npcname> knocks %s back with a solid L-hook"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_wingchun_onpause" },
    weighting = 2,
    crit_tec = true,
    down_dur = 1,
    knockback_dist = 1,
    knockback_follow = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_wingchun_hook_knockback",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets grabbing you"),
}

ccb.content.define_technique {
    id = "tec_wingchun_feint",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("Your attack misses %s but you don't let up"),
        ccb.content.text("<npcname>'s attack misses %s but they don't let up"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_zuiquan_feint",
    name = ccb.content.text("Drunken Feint"),
    messages = {
        ccb.content.text("You stumble and leer at %s"),
        ccb.content.text("<npcname> stumbles and leers at %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_zuiquan_fist",
    name = ccb.content.text("Drunk Fist"),
    messages = {
        ccb.content.text("You lurch, and your wild swing hits %s"),
        ccb.content.text("<npcname> lurches, and hits %s"),
    },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.2 },
        { stat = "damage", damage_type = "cut", scale = 1.2 },
        { stat = "damage", damage_type = "stab", scale = 1.2 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_zuiquan_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you stumble away"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they stumble away"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_zuiquan_spin",
    name = ccb.content.text("Whirling Strikes"),
    messages = {
        ccb.content.text("You spin, hitting %s and everyone around you"),
        ccb.content.text("<npcname> spins, hitting %s and everyone around them"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    aoe = "spin",
    mult_bonuses = {
        { stat = "movecost", scale = 1.5 },
        { stat = "damage", damage_type = "bash", scale = 1.3 },
        { stat = "damage", damage_type = "cut", scale = 1.3 },
        { stat = "damage", damage_type = "stab", scale = 1.3 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "RAPID_TEST",
    name = ccb.content.text("Rapid Strike Test"),
    melee_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    messages = { ccb.content.text("You quickly strike %s"), ccb.content.text("<npcname> quickly strikes %s") },
    description = ccb.content.text("50% moves, 66% damage"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_debug_slow",
    name = ccb.content.text("slow strike"),
    unarmed_allowed = true,
    skills = { { id = "unarmed", level = 3 } },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 3.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.1 },
    },
    flat_bonuses = {
        { stat = "movecost", scale = 100 },
        { stat = "movecost", scaling_stat = "str", scale = 10 },
    },
    messages = { ccb.content.text("You slowly strike %s"), ccb.content.text("<npcname> slowly strikes %s") },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
}

ccb.content.define_technique {
    id = "tec_debug_arpen",
    name = ccb.content.text("phasing strike"),
    unarmed_allowed = true,
    melee_allowed = true,
    skills = { { id = "melee", level = 3 } },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.2 },
        { stat = "damage", damage_type = "cut", scale = 0.2 },
        { stat = "damage", damage_type = "stab", scale = 0.2 },
        { stat = "movecost", scale = 0.3 },
    },
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scale = 10 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "per", scale = 1 },
    },
    crit_tec = true,
    messages = { ccb.content.text("You phase-strike %s"), ccb.content.text("<npcname> phase-strikes %s") },
    attack_vectors = { "vector_null", "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_debug_eoc_demo",
    name = ccb.content.text("Extreme Offensive Chop!"),
    unarmed_allowed = true,
    melee_allowed = true,
    skills = { { id = "speech", level = 10 } },
    weighting = 100,
    messages = {
        ccb.content.text("You strike %s with an Extreme Offensive Chop"),
        ccb.content.text("<npcname> strikes %s with an Extreme Offensive Chop"),
    },
    attack_vectors = { "vector_null", "vector_wrist" },
    on_apply = "technique_demo_surrender",
}
