local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_ENTANGLING_STRIKE",
    name = ccb.content.text("Entangling Strike"),
    messages = {
        ccb.content.text("As you strike %s, roots burst from the ground around them"),
        ccb.content.text("<npcname> hits %s and roots burst from the ground around them"),
    },
    skills = { { id = "unarmed", level = 3 }, { id = "gramarye", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    melee_allowed = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes", "vector_null" },
    effects = { { id = "effect_hungry_roots", chance = 100, duration_turns = 10, on_damage = true } },
    flat_bonuses = {
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_xe_ma_arvore_entangling_strike",
    condition_description = ccb.content.text("Must be outdoors and your opponent must be on diggable ground."),
}

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_VENOM_ATTACK",
    name = ccb.content.text("Nightshade's Touch"),
    messages = {
        ccb.content.text("As you strike %s, you infuse them with the essence of nightshade."),
        ccb.content.text("<npcname> hits %s."),
    },
    skills = { { id = "unarmed", level = 3 }, { id = "gramarye", level = 4 } },
    unarmed_allowed = true,
    crit_ok = true,
    melee_allowed = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes", "vector_null" },
    required_buffs_any = { "xe_ma_buff_arvore_block", "xe_ma_buff_arvore_block_increase" },
    on_apply = "arvore_venom_applied",
}

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_DISARM",
    name = ccb.content.text("Curling Fronds"),
    messages = {
        ccb.content.text("You reach out toward %s and pull their weapon away"),
        ccb.content.text("<npcname> reaches towards %s and pulls their weapon away"),
    },
    skills = { { id = "unarmed", level = 4 }, { id = "gramarye", level = 4 } },
    unarmed_allowed = true,
    crit_ok = true,
    melee_allowed = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes", "vector_null" },
    disarms = true,
    flat_bonuses = {
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_xe_ma_arvore_disarm",
    condition_description = ccb.content.text("Must have Writhing Vines active or be wielding a heartvine whip"),
}

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_COUNTER_TRIP",
    name = ccb.content.text("Obstructing Roots"),
    messages = {
        ccb.content.text("You lash out at %s and knock them to the ground"),
        ccb.content.text("<npcname> knocks %s to the ground"),
    },
    skills = { { id = "unarmed", level = 5 }, { id = "gramarye", level = 4 } },
    unarmed_allowed = true,
    crit_ok = true,
    melee_allowed = true,
    block_counter = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes", "vector_null" },
    down_dur = 2,
    on_apply = "arvore_counter_trip_applied",
    when = "allow_arvore_counter_trip",
}

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_BENEATH_FALLING_TREE",
    name = ccb.content.text("Beneath the Falling Tree"),
    messages = {
        ccb.content.text("You punch through %s's armor with a mighty blow"),
        ccb.content.text("<npcname> punches through %s's armor with a mighty blow"),
    },
    skills = { { id = "unarmed", level = 5 }, { id = "gramarye", level = 5 } },
    weighting = 2,
    unarmed_allowed = true,
    crit_ok = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes" },
    required_buffs_any = { "xe_ma_buff_arvore_burrowing_ivy" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "gramarye", scale = 0.75 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "gramarye", scale = 0.75 },
    },
    on_apply = "arvore_falling_tree_applied",
}

ccb.content.define_martial_art {
    id = "xe_ma_style_arvore_elemental",
    name = "Lashing Bough",
    description = "This style of combat emulates the storm-whipped branches, entangling vines, concealing leaves, and stone-breaking roots of the depths of the forest.  Its attacks are also capable of inflicting poisons on your enemies.  It may not be used with weapons, though the Bloodthorne Druids have adapted it to their heartwhips.  Some attacks are more effective, or only effective, on natural terrain.",
    initiate = {
        "You open yourself up to the power of nature.",
        "%s stands tall like a mighty oak.",
    },
    primary_skill = "gramarye",
    learn_difficulty = 5,
    arm_block = 2,
    nonstandard_block = 3,
    techniques = {
        "TECH_XE_MA_ARVORE_ENTANGLING_STRIKE",
        "TECH_XE_MA_ARVORE_VENOM_ATTACK",
        "TECH_XE_MA_ARVORE_BENEATH_FALLING_TREE",
        "TECH_XE_MA_ARVORE_DISARM",
        "TECH_XE_MA_ARVORE_COUNTER_TRIP",
    },
    weapons = { "heartvine_whip" },
    onpause_buffs = {
        {
            id = "xe_ma_buff_arvore_taking_root",
            name = "Taking Root",
            description = "Planting yourself like the mighty tree, you prepare to endure an onslaught.\n\n+1 bonus block, +0.5 bash armor, +0.25 cut/stab armor per gramarye skill level.\nLasts 3 turns.",
            buff_duration = 4,
            max_stacks = 2,
            bonus_blocks = 1,
            unarmed_allowed = true,
            melee_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 2 },
                { name = "gramarye", level = 3 },
            },
            flat_bonuses = {
                { stat = "armor", scale = 0.5, type = "bash", scaling_stat = "gramarye" },
                { stat = "armor", scale = 0.25, type = "cut", scaling_stat = "gramarye" },
                { stat = "armor", scale = 0.25, type = "stab", scaling_stat = "gramarye" },
            },
        },
    },
    ondodge_buffs = {
        {
            id = "xe_ma_buff_arvore_dodge",
            name = "Reed in the Wind",
            description = "Bending like the supple reed, you prepare to strike back.\n\n+1 crit chance per gramarye skill level.\nLasts 3 turns.  Max 3 stacks.",
            buff_duration = 3,
            max_stacks = 3,
            unarmed_allowed = true,
            melee_allowed = true,
            forbidden_buffs_all = { "xe_ma_buff_arvore_block" },
            skill_requirements = {
                { name = "unarmed", level = 2 },
                { name = "gramarye", level = 3 },
            },
            flat_bonuses = {
                { stat = "crit_chance", scale = 1.0, scaling_stat = "gramarye" },
            },
        },
    },
    onblock_buffs = {
        {
            id = "xe_ma_buff_arvore_block",
            name = "Grasping Brambles",
            description = "Like thick brambles slowing a forester, you prepare to strike after a block.\n\n+1 crit chance per gramarye skill level.\nLasts 3 turns.  Max 3 stacks.",
            buff_duration = 3,
            max_stacks = 3,
            unarmed_allowed = true,
            melee_allowed = true,
            forbidden_buffs_all = { "xe_ma_buff_arvore_dodge" },
            skill_requirements = {
                { name = "unarmed", level = 2 },
                { name = "gramarye", level = 3 },
            },
            flat_bonuses = {
                { stat = "crit_chance", scale = 1.0, scaling_stat = "gramarye" },
            },
        },
    },
    ongethit_buffs = {
        {
            id = "xe_ma_buff_arvore_block_increase",
            name = "Dense Thicket",
            description = "As a thicket returns to form after an animal pushes through, you renew your defenses after a hit.\n\n+0.75 blocked damage per unarmed skill level, +1 block effectiveness per gramarye skill level.\nLasts 3 turns.",
            buff_duration = 4,
            max_stacks = 1,
            unarmed_allowed = true,
            melee_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 2 },
                { name = "gramarye", level = 4 },
            },
            flat_bonuses = {
                { stat = "block", scale = 0.75, scaling_stat = "unarmed" },
                { stat = "block_effectiveness", scale = 1, scaling_stat = "gramarye" },
            },
        },
    },
    oncrit_buffs = {
        {
            id = "xe_ma_buff_arvore_burrowing_ivy",
            name = "Burrowing Ivy",
            description = "Ivy does not destroy a wall all at once, but patiently over the years.\n\n+0.5 biological damage per gramarye skill level.\nLasts 4 turns.",
            buff_duration = 3,
            max_stacks = 2,
            unarmed_allowed = true,
            melee_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 3 },
                { name = "gramarye", level = 3 },
            },
            flat_bonuses = {
                { stat = "damage", scale = 0.5, type = "biological", scaling_stat = "gramarye" },
            },
        },
    },
}
