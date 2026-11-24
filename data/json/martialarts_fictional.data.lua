local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MARTIAL_ARTS4",
    name = ccb.content.text("Venom Mob Protege"),
    points = 2,
    description = ccb.content.text("You are a pupil of the Venom Clan.  You start with one of the five deadly venoms: Centipede, Viper, Scorpion, Lizard, or Toad."),
    starting_trait = false,
    initial_martial_arts = { "style_centipede", "style_venom_snake", "style_scorpion", "style_lizard", "style_toad" },
    valid = false,
}

ccb.content.define_technique {
    id = "tec_biojutsu_disarm",
    name = ccb.content.text("Disarm"),
    messages = {
        ccb.content.text("You effortlessly disarm and stun %s"),
        ccb.content.text("<npcname> effortlessly disarms and stuns %s"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    weighting = 2,
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
    stun_dur = 1,
    attack_vectors = { "vector_grasp" },
}

ccb.content.define_technique {
    id = "tec_biojutsu_strike_melee",
    name = ccb.content.text("Measured Strike (melee)"),
    messages = {
        ccb.content.text("You make an efficient strike against %s"),
        ccb.content.text("<npcname> makes an efficient strike against %s"),
    },
    melee_allowed = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_biojutsu_strike_unarmed",
    name = ccb.content.text("Measured Strike (unarmed)"),
    messages = {
        ccb.content.text("You make an efficient strike against %s"),
        ccb.content.text("<npcname> makes an efficient strike against %s"),
    },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_biojutsu_impale",
    name = ccb.content.text("Biojutsu Impale"),
    messages = {
        ccb.content.text("You brutally impale %s with your weapon"),
        ccb.content.text("<npcname> brutally impales %s with their weapon"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    crit_tec = true,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    stun_dur = 1,
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_biojutsu_takedown",
    name = ccb.content.text("Biojutsu Takedown"),
    messages = {
        ccb.content.text("You kick and slam %s to the ground"),
        ccb.content.text("<npcname> kicks and slams %s to the ground"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    weighting = 2,
    crit_ok = true,
    down_dur = 2,
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
    when = "allow_tec_biojutsu_takedown",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target"),
}

ccb.content.define_technique {
    id = "tec_biojutsu_wide",
    name = ccb.content.text("Biojutsu Cleave"),
    messages = {
        ccb.content.text("You quickly cleave through %s and those nearby"),
        ccb.content.text("<npcname> quickly cleaves through %s and those nearby"),
    },
    skills = { { id = "melee", level = 5 } },
    weapon_categories = { "BIONIC_WEAPONRY" },
    melee_allowed = true,
    weighting = 2,
    crit_tec = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "tec_lizard_rapid",
    name = ccb.content.text("Lizard Strike"),
    messages = {
        ccb.content.text("You spearhand strike %s"),
        ccb.content.text("<npcname> spearhand strikes %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_lizard_tail",
    name = ccb.content.text("Lizard Tail"),
    messages = { ccb.content.text("You leap and kick %s"), ccb.content.text("<npcname> leaps and kicks %s") },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    crit_ok = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_lizard_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you outmaneuver it"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they outmaneuver it"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_lizard_walldive",
    name = ccb.content.text("Lizard Wall Dive"),
    messages = {
        ccb.content.text("You push off a nearby wall and strike down at %s"),
        ccb.content.text("<npcname> pushes off a nearby wall and strikes down at %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    wall_adjacent = true,
    stun_dur = 2,
    knockback_dist = 1,
    knockback_spread = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.5 } },
    attack_vectors = { "vector_shoulder" },
}

ccb.content.define_technique {
    id = "tec_venom_snake_feint",
    name = ccb.content.text("Viper Hiss"),
    messages = {
        ccb.content.text("You hiss threateningly at %s"),
        ccb.content.text("<npcname> hisses threateningly at %s"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_venom_snake_rapid",
    name = ccb.content.text("Viper Fist"),
    messages = { ccb.content.text("You quickly chop %s"), ccb.content.text("<npcname> quickly chops %s") },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_wrist" },
}

ccb.content.define_technique {
    id = "tec_venom_snake_bite",
    name = ccb.content.text("Viper Bite"),
    messages = {
        ccb.content.text("You lash out at %s with a Viper Bite"),
        ccb.content.text("<npcname> lashes out at %s with a Viper Bite"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 2,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_venom_snake_tail",
    name = ccb.content.text("Viper Tail"),
    messages = {
        ccb.content.text("You beat %s down with a powerful Viper Tail"),
        ccb.content.text("<npcname> beats %s down with a powerful Viper Tail"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    weighting = 2,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.5 } },
    attack_vectors = { "vector_punch" },
    when = "allow_tec_venom_snake_tail",
    condition_description = ccb.content.text("Requires a stunned target"),
}

ccb.content.define_technique {
    id = "tec_venom_snake_strike",
    name = ccb.content.text("Viper Strike"),
    messages = {
        ccb.content.text("You devastate %s with a spectacular Viper Strike"),
        ccb.content.text("<npcname> devastates %s with a spectacular Viper Strike"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    weighting = 2,
    crit_tec = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    attack_vectors = { "vector_punch" },
    when = "allow_tec_venom_snake_tail",
    condition_description = ccb.content.text("Requires a stunned target"),
}

ccb.content.define_technique {
    id = "tec_scorpion_roundhouse",
    name = ccb.content.text("Roundhouse Kick"),
    messages = {
        ccb.content.text("You roundhouse kick %s"),
        ccb.content.text("<npcname> roundhouse kicks %s"),
    },
    unarmed_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.2 } },
    attack_vectors = { "vector_foot_heel" },
}

ccb.content.define_technique {
    id = "tec_scorpion_brutal",
    name = ccb.content.text("Stinger Kick"),
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 2,
    knockback_dist = 3,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    messages = {
        ccb.content.text("Your Stinger Kick sends %s flying"),
        ccb.content.text("<npcname>'s Stinger Kick sends %s flying"),
    },
    attack_vectors = { "vector_foot_sole" },
}

ccb.content.define_technique {
    id = "tec_scorpion_precise",
    name = ccb.content.text("Pincer Fist"),
    messages = {
        ccb.content.text("You stun %s with your Pincer Fist"),
        ccb.content.text("<npcname> jabs %s with a Pincer Fist"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_scorpion_onmove" },
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = {
        "vector_foot_toes",
        "vector_avian_talons",
        "vector_hoof_kick",
        "vector_digitigrade_paws",
    },
}

ccb.content.define_technique {
    id = "tec_toad_cross",
    name = ccb.content.text("Toad Smack"),
    messages = {
        ccb.content.text("You give %s a hardy smack"),
        ccb.content.text("<npcname> gives %s a hardy smack"),
    },
    skills = { { id = "unarmed", level = 4 } },
    crit_ok = true,
    unarmed_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_toad_crit",
    name = ccb.content.text("Toad Slam"),
    messages = {
        ccb.content.text("You meet %s head-on with a stunning slam"),
        ccb.content.text("<npcname> meet %s head-on with a stunning slam"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.4 } },
    attack_vectors = { "vector_arm" },
}

ccb.content.define_technique {
    id = "tec_toad_grab",
    name = ccb.content.text("Toad's Tongue"),
    messages = {
        ccb.content.text("You snatch and slug %s"),
        ccb.content.text("<npcname> snatches and slug %s"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_toad_ongethit" },
    crit_ok = true,
    down_dur = 2,
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_biojutsu_takedown",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target"),
}

ccb.content.define_technique {
    id = "tec_centipede_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you skitter free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they skitter free"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_centipede_rapid",
    name = ccb.content.text("Centipede Strike"),
    messages = { ccb.content.text("You swiftly hit %s"), ccb.content.text("<npcname> swiftly hits %s") },
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.66 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    attack_vectors = { "vector_punch" },
}

ccb.content.define_technique {
    id = "tec_centipede_bite",
    name = ccb.content.text("Centipede Bite"),
    messages = {
        ccb.content.text("You palm strike %s with a painful Centipede Bite"),
        ccb.content.text("<npcname> palm strikes %s with a painful Centipede Bite"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    attack_vectors = { "vector_palm" },
    when = "allow_tec_biojutsu_takedown",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target"),
}

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
