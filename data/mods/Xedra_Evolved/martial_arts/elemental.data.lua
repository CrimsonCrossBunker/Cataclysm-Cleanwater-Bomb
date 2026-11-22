local ccb = require("ccb")

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
