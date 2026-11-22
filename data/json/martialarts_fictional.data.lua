local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_centipede_disarm",
    name = ccb.content.text("Disarm"),
    messages = {
        ccb.content.text("You disarm %s with lightning speed"),
        ccb.content.text("<npcname> disarms %s with lightning speed"),
    },
    skills = { { id = "unarmed", level = 4 } },
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

ccb.content.define_martial_art {
    id = "style_biojutsu",
    name = "Bionic Combatives",
    description = "A modern combat style for the post-modern human.  Nicknamed \"Biojutsu\", Bionic Combatives combines integrated weaponry, armor, and augments into a consolidated fighting discipline.",
    initiate = {
        "BEGINNING BIONIC COMBATIVES PROGRAM.  INITIATING COMBAT PROTOCOLS.",
        "%s starts moving with swift robotic precision.",
    },
    leg_block = 3,
    arm_block = 2,
    arm_block_with_bio_armor_arms = true,
    leg_block_with_bio_armor_legs = true,
    techniques = {
        "tec_biojutsu_disarm",
        "tec_biojutsu_strike_unarmed",
        "tec_biojutsu_strike_melee",
        "tec_biojutsu_impale",
        "tec_biojutsu_takedown",
        "tec_biojutsu_wide",
    },
    weapon_category = { "BIONIC_WEAPONRY" },
    static_buffs = {
        {
            id = "buff_biojutsu_static",
            name = "Biojutsu Stance",
            description = "void player::ApplyBiojutsuStatic() {\n    blocks_left += 2;\n    set_hit_bonus( get_hit_bonus() + 1 );\n}\n\n+2 block attempts, +1 accuracy.",
            bonus_blocks = 2,
            unarmed_allowed = true,
            melee_allowed = true,
            flat_bonuses = {
                { stat = "hit", scale = 1.0 },
            },
        },
    },
    onblock_buffs = {
        {
            id = "buff_biojutsu_onblock",
            name = "Binary Hardening",
            description = "player@CDDA:/root$ sudo apt install improved-armor\nplayer@CDDA:/root$ sudo apt update\n\n+3 bash, cut, and stab armor.\nLasts 4 turns.  Stacks 3 times.",
            buff_duration = 4,
            max_stacks = 3,
            unarmed_allowed = true,
            melee_allowed = true,
            skill_requirements = {
                { name = "melee", level = 4 },
            },
            flat_bonuses = {
                { stat = "armor", scale = 3.0, type = "bash" },
                { stat = "armor", scale = 3.0, type = "cut" },
                { stat = "armor", scale = 3.0, type = "stab" },
            },
        },
    },
    onkill_buffs = {
        {
            id = "buff_biojutsu_onkill",
            name = "Optimization",
            description = ">10 LOCATE TARGET\n>20 EXECUTE TARGET\n>30 GOTO 10\n\n+1 accuracy, +15% damage.\nLasts 3 turns.  Stacks 3 times.",
            buff_duration = 3,
            max_stacks = 3,
            persists = true,
            unarmed_allowed = true,
            melee_allowed = true,
            skill_requirements = {
                { name = "melee", level = 4 },
            },
            flat_bonuses = {
                { stat = "hit", scale = 1.0 },
            },
            mult_bonuses = {
                { stat = "damage", scale = 1.15, type = "bash" },
                { stat = "damage", scale = 1.15, type = "cut" },
                { stat = "damage", scale = 1.15, type = "stab" },
            },
        },
    },
}

ccb.content.define_martial_art {
    id = "style_centipede",
    name = "Centipede Kung Fu",
    description = "One of the Five Deadly Venoms, used by Zhang Xiaotian.  Centipede Style uses an onslaught of rapid strikes.  Each attack you land increases your attack speed.  Critical hits increase your damage further.",
    initiate = {
        "You ready yourself to attack as fast as possible.",
        "%s assumes a centipede-like stance.",
    },
    learn_difficulty = 10,
    leg_block = 4,
    arm_block = 3,
    techniques = {
        "tec_centipede_rapid",
        "tec_centipede_break",
        "tec_centipede_bite",
        "tec_centipede_disarm",
    },
    onhit_buffs = {
        {
            id = "buff_centipede_onhit",
            name = "Centipede's Frenzy",
            description = "Your attacks are a blur of hands and legs that become faster as you strike your opponents without rest.\n\n-4 move cost.\nLasts 3 turns.  Stacks 4 times.",
            buff_duration = 3,
            max_stacks = 4,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 5 },
            },
            flat_bonuses = {
                { stat = "movecost", scale = -4.0 },
            },
        },
    },
    oncrit_buffs = {
        {
            id = "buff_centipede_oncrit",
            name = "Centipede's Venom",
            description = "Your venom burns your opponents at the worst of times.\n\n+15% damage.\nLasts 2 turns.",
            buff_duration = 2,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 1 },
            },
            mult_bonuses = {
                { stat = "damage", scale = 1.15, type = "bash" },
                { stat = "damage", scale = 1.15, type = "cut" },
                { stat = "damage", scale = 1.15, type = "stab" },
            },
        },
    },
}

ccb.content.define_martial_art {
    id = "style_lizard",
    name = "Lizard Kung Fu",
    description = "One of the Five Deadly Venoms, used by Pu Tianxia.  Lizard Style focuses on using walls to your advantage.  Standing near a wall enables stronger buffs and techniques.",
    initiate = {
        "You ready yourself to attack from any angle.",
        "%s assumes a lizard-like stance.",
    },
    learn_difficulty = 10,
    arm_block = 2,
    techniques = { "tec_lizard_rapid", "tec_lizard_break", "tec_lizard_walldive", "tec_lizard_tail" },
    static_buffs = {
        {
            id = "buff_lizard_static1",
            name = "Lizard's Cunning",
            description = "Through patience and observation, you know how to turn the tide of battle in your favor.\n\n+2 accuracy, +2 blocking effectiveness.",
            unarmed_allowed = true,
            flat_bonuses = {
                { stat = "block_effectiveness", scale = 2.0 },
                { stat = "hit", scale = 2.0 },
            },
        },
        {
            id = "buff_lizard_static2",
            name = "Lizard's Haven",
            description = "Staying near a wall further improves your chances to hit and avoid damage.\n\n+2 accuracy, +2 blocking effectiveness when near a wall.",
            unarmed_allowed = true,
            wall_adjacent = true,
            flat_bonuses = {
                { stat = "block_effectiveness", scale = 2.0 },
                { stat = "hit", scale = 2.0 },
            },
        },
    },
    onmove_buffs = {
        {
            id = "buff_lizard_onmove",
            name = "Lizard's Leap",
            description = "By briefly pushing off a nearby wall and leaping, you can make yourself more dangerous and evasive.\n\n+2.0 Dodging skill, +10% critical hit chance.\nLasts 2 turns.",
            buff_duration = 2,
            unarmed_allowed = true,
            flat_bonuses = {
                { stat = "crit_chance", scale = 10.0 },
                { stat = "dodge", scale = 2.0 },
            },
        },
    },
    onpause_buffs = {
        {
            id = "buff_lizard_onpause1",
            name = "Lizard's Perch",
            description = "From your high vantage point, you can strike downward and deal more damage.\n\n+10% damage while near a wall.\nLasts 3 turns.",
            buff_duration = 3,
            unarmed_allowed = true,
            wall_adjacent = true,
            skill_requirements = {
                { name = "unarmed", level = 5 },
            },
            mult_bonuses = {
                { stat = "damage", scale = 1.1, type = "bash" },
                { stat = "damage", scale = 1.1, type = "cut" },
                { stat = "damage", scale = 1.1, type = "stab" },
            },
        },
        {
            id = "buff_lizard_onpause2",
            name = "Lizard's Venom",
            description = "Your venom is a long-lasting pain that your opponents will never forget.\n\n+15% damage.\nLasts 5 turns.",
            buff_duration = 5,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 5 },
            },
            mult_bonuses = {
                { stat = "damage", scale = 1.15, type = "bash" },
                { stat = "damage", scale = 1.15, type = "cut" },
                { stat = "damage", scale = 1.15, type = "stab" },
            },
        },
    },
}

ccb.content.define_martial_art {
    id = "style_scorpion",
    name = "Scorpion Kung Fu",
    description = "One of the Five Deadly Venoms, used by Ding Jing.  Scorpion Style is a mysterious art which uses pincer-like hands and a stinger kick.  Moving enables a stunning pincer attack.  Critical hits do massive damage and knock your opponent back along with anyone your opponent comes in contact with.",
    initiate = {
        "You prepare to capture and sting your foes.",
        "%s assumes a scorpion-like stance.",
    },
    learn_difficulty = 10,
    arm_block = 3,
    techniques = { "tec_scorpion_roundhouse", "tec_scorpion_precise", "tec_scorpion_brutal" },
    static_buffs = {
        {
            id = "buff_scorpion_static",
            name = "Scorpion's Venom",
            description = "Your venom is a constant threat that nothing can escape from.\n\n+15% damage.",
            unarmed_allowed = true,
            mult_bonuses = {
                { stat = "damage", scale = 1.15, type = "bash" },
                { stat = "damage", scale = 1.15, type = "cut" },
                { stat = "damage", scale = 1.15, type = "stab" },
            },
        },
    },
    onmove_buffs = {
        {
            id = "buff_scorpion_onmove",
            name = "Scorpion's Charge",
            description = "Rush forward and catch your prey!\n\n+10% damage.\nEnables \"Pincer Fist\" technique.\nLasts 2 turns.  Stacks 2 times.",
            buff_duration = 2,
            max_stacks = 2,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 2 },
            },
            mult_bonuses = {
                { stat = "damage", scale = 1.1, type = "bash" },
                { stat = "damage", scale = 1.1, type = "cut" },
                { stat = "damage", scale = 1.1, type = "stab" },
            },
        },
    },
    onattack_buffs = {
        {
            id = "buff_scorpion_onattack",
            name = "Scorpion's Intimidation",
            description = "Nothing is scarier than an angry scorpion.  Your attacks can keep others at bay.\n\n+1 dodge attempt.\nLasts 1 turn.",
            buff_duration = 1,
            bonus_dodges = 1,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 1 },
            },
        },
    },
}

ccb.content.define_martial_art {
    id = "style_toad",
    name = "Toad Kung Fu",
    description = "One of the Five Deadly Venoms, used by Liang Sheng.  Masters of Toad Style can focus their Strength to protect against all attacks.  You have powerful armor against physical attacks, though you will lose focus when you move.  You can meditate by pausing, giving yourself more armor for a short time.",
    initiate = {
        "You pause for a moment and focus on your invincible body.",
        "%s assumes a toad-like stance.",
    },
    learn_difficulty = 10,
    arm_block = 3,
    techniques = { "tec_toad_cross", "tec_toad_crit", "tec_toad_grab" },
    static_buffs = {
        {
            id = "buff_toad_static",
            name = "Toad's Iron Skin",
            description = "Your body is as strong as iron, but only if you don't move.\n\nBash, cut, and stab armor increased by 100% of Strength.",
            unarmed_allowed = true,
            flat_bonuses = {
                { stat = "armor", scale = 1.0, type = "bash", scaling_stat = "str" },
                { stat = "armor", scale = 1.0, type = "cut", scaling_stat = "str" },
                { stat = "armor", scale = 1.0, type = "stab", scaling_stat = "str" },
            },
        },
    },
    onmove_buffs = {
        {
            id = "buff_toad_onmove",
            name = "Iron Skin Dissipation",
            description = "Moving causes you to lose your iron skin.\n\nBash, cut, and stab armor reduced by 20% of Strength.\nLasts 5 turns.  Stacks 5 times.",
            buff_duration = 5,
            max_stacks = 5,
            persists = true,
            unarmed_allowed = true,
            flat_bonuses = {
                { stat = "armor", scale = -0.2, type = "bash", scaling_stat = "str" },
                { stat = "armor", scale = -0.2, type = "cut", scaling_stat = "str" },
                { stat = "armor", scale = -0.2, type = "stab", scaling_stat = "str" },
            },
        },
    },
    onpause_buffs = {
        {
            id = "buff_toad_onpause",
            name = "Toad's Meditation",
            description = "By concentrating for a moment, you can bolster the strength of your iron skin.\n\nBash, cut, and stab armor increased by 50% of Strength.\nLasts 2 turns.",
            buff_duration = 2,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 5 },
            },
            flat_bonuses = {
                { stat = "armor", scale = 0.5, type = "bash", scaling_stat = "str" },
                { stat = "armor", scale = 0.5, type = "cut", scaling_stat = "str" },
                { stat = "armor", scale = 0.5, type = "stab", scaling_stat = "str" },
            },
        },
    },
    ongethit_buffs = {
        {
            id = "buff_toad_ongethit",
            name = "Toad's Venom",
            description = "Your venom is a harsh lesson about the strength of your iron body.\n\n+15% damage.\nLasts 3 turns.  Stacks 3 times.",
            buff_duration = 3,
            max_stacks = 3,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 2 },
            },
            mult_bonuses = {
                { stat = "damage", scale = 1.15, type = "bash" },
                { stat = "damage", scale = 1.15, type = "cut" },
                { stat = "damage", scale = 1.15, type = "stab" },
            },
        },
    },
}

ccb.content.define_martial_art {
    id = "style_venom_snake",
    name = "Viper Kung Fu",
    description = "A legacy of the Five Deadly Venoms, used by Qi Dong.  Viper Style (originally called Snake Style) is punishing to stunned opponents.  Stunning a foe with a Viper Bite will allow you to finish them off with the legendary Viper Strike.",
    initiate = {
        "You prepare to strike your foes' weaknesses.",
        "%s assumes a viper-like stance.",
    },
    learn_difficulty = 10,
    arm_block = 1,
    techniques = {
        "tec_venom_snake_rapid",
        "tec_venom_snake_feint",
        "tec_venom_snake_bite",
        "tec_venom_snake_tail",
        "tec_venom_snake_strike",
    },
    static_buffs = {
        {
            id = "buff_venom_snake_static",
            name = "Viper's Patience",
            description = "Every snake waits for the perfect moment to strike.  Turn your opponents' mistakes into your opportunity to strike!\n\n+1 dodge attempt, +1 accuracy, +5% critical hit chance.",
            bonus_dodges = 1,
            unarmed_allowed = true,
            flat_bonuses = {
                { stat = "hit", scale = 1.0 },
                { stat = "crit_chance", scale = 5.0 },
            },
        },
    },
    onhit_buffs = {
        {
            id = "buff_venom_snake_onhit",
            name = "Viper's Rattle",
            description = "You are a terrifying monster on the battlefield!  Opponents will have a harder time fighting back.\n\n+1 accuracy, +1.0 Dodging skill.\nLasts 3 turns.  Stacks 2 times.",
            buff_duration = 3,
            max_stacks = 2,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 5 },
            },
            flat_bonuses = {
                { stat = "hit", scale = 1.0 },
                { stat = "dodge", scale = 1.0 },
            },
        },
    },
    oncrit_buffs = {
        {
            id = "buff_venom_snake_oncrit",
            name = "Viper's Venom",
            description = "Your venom is a harsh reminder to never tease a predator.\n\n+15% damage.\nLasts 4 turns.",
            buff_duration = 4,
            unarmed_allowed = true,
            skill_requirements = {
                { name = "unarmed", level = 1 },
            },
            mult_bonuses = {
                { stat = "damage", scale = 1.15, type = "bash" },
                { stat = "damage", scale = 1.15, type = "cut" },
                { stat = "damage", scale = 1.15, type = "stab" },
            },
        },
    },
}
