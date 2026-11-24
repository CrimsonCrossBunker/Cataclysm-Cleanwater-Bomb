local ccb = require("ccb")

ccb.content.define_mutation_type {
    id = "Cyberframe",
}

ccb.content.define_mutation_type {
    id = "Cybernetic",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "EXODII_WRATH",
    player_display = false,
    name = ccb.content.text_without_extraction("Exodii Wrath"),
    points = 0,
    description = ccb.content.text_without_extraction("Makes sure all the exodii mobs shoot you on sight."),
    valid = false,
    purifiable = false,
    species_anger = { CYBORG = 95 },
}

ccb.content.define_mutation {
    id = "CBM_Interface",
    name = ccb.content.text("Standard Neurobionic Interface"),
    points = 0,
    description = ccb.content.text("You have a matrix in your central nervous system that acts as a universal control and installation bus for compact bionic modules."),
    valid = false,
    purifiable = false,
    types = { "Cybernetic" },
    cancels = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "NL_CBM_Interface",
    name = ccb.content.text("AltarOS Neurobionic Interface"),
    points = 0,
    description = ccb.content.text("You have a matrix in your central nervous system that acts as a universal control and installation bus for compact bionic modules."),
    valid = false,
    purifiable = false,
    types = { "Cybernetic" },
    cancels = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "Hub01_CBM_Interface",
    name = ccb.content.text("Hub 01 Neurobionic Interface"),
    points = 0,
    description = ccb.content.text("You have a matrix in your central nervous system that acts as a universal control and installation bus for compact bionic modules.  You also have a USB port installed behind your ear."),
    valid = false,
    purifiable = false,
    types = { "Cybernetic" },
    cancels = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "CBM_Interface_brain_lesion",
    name = ccb.content.text("Minor brain lesion"),
    points = 0,
    description = ccb.content.text("You have a minor brain lesion and some leftover metal in your brain - the remnants of removing and reinstalling a CBM interface."),
    valid = false,
    purifiable = false,
    starting_trait = false,
    enchantments = { "INLINE_ENCH_CBM_Interface_brain_lesion_0" },
}

ccb.content.define_mutation {
    id = "CBM_Interface_brain_lesion_2",
    name = ccb.content.text("Major brain lesion"),
    points = 0,
    description = ccb.content.text("You have a major brain lesion and lots of leftover metal in your brain - the remnants of removing and reinstalling a CBM interface.  Twice.  Smart move."),
    valid = false,
    purifiable = false,
    starting_trait = false,
    enchantments = { "INLINE_ENCH_CBM_Interface_brain_lesion_2_0" },
}

ccb.content.define_mutation {
    id = "EXODII_CYBERFRAME_GENERIC",
    flags = { "Exodii_Body", "TOUGH_FEET" },
    name = ccb.content.text("Exodii-style cyborg"),
    points = 0,
    visibility = 10,
    ugliness = 10,
    mixed_effect = true,
    description = ccb.content.text("Your body has been reduced to your nervous system, sensory organs, core skeleton and musculature, and other critical internal meat-bits.  It can now only exist inside of an Exodii Cyberframe."),
    valid = false,
    purifiable = false,
    types = {
        "Cyberframe", "skin_tone", "SCENT", "ATTRACTIVENESS", "SIZE", "MUZZLE", "SOLES", "EYES", "HAIR",
        "HORNS", "HANDS", "LEGS", "FEET", "eye_color", "facial_hair", "hair_style", "hair_color", "SKIN",
        "BODY_ARMOR", "ARMOR", "BODY_ARMOR_MOD", "WINGS",
    },
    enchantments = { "INLINE_ENCH_EXODII_CYBERFRAME_GENERIC_0" },
    cancels = { "BENDY1", "BENDY2", "BENDY3", "INTERSTICE_POSTURE", "INTERSTICE_POSTURE_2" },
}

ccb.content.define_mutation {
    id = "EXODII_CYBERFRAME_LARGE",
    name = ccb.content.text("Bulky Bionics"),
    points = 0,
    description = ccb.content.text("Your Exodii Cyberframe is so large that you won't fit through very small spaces, and you cannot wear most normal-sized clothing and armor."),
    mixed_effect = true,
    valid = false,
    purifiable = false,
    flags = { "LARGE" },
    restricts_gear = {
        "torso",
        "leg_l",
        "leg_r",
        "arm_l",
        "arm_r",
        "hand_l",
        "hand_r",
        "head",
        "foot_l",
        "foot_r",
        "eyes",
    },
}

ccb.content.define_mutation {
    id = "EXODII_BODY_1",
    flags = { "Exodii_Body", "TOUGH_FEET", "LARGE" },
    name = ccb.content.text("Exodii cyborg framework - style 1a"),
    points = 0,
    visibility = 4,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your nervous system, sensory organs, and other critical internal meat-bits are shielded in an armored bipedal walker frame.  The armored plating is tough, but its bulkiness limits the sort of equipment you can wear."),
    valid = false,
    purifiable = false,
    types = {
        "Cyberframe", "skin_tone", "SCENT", "ATTRACTIVENESS", "SIZE", "MUZZLE", "SOLES", "EYES", "HAIR",
        "HORNS", "HANDS", "LEGS", "FEET", "eye_color", "facial_hair", "hair_style", "hair_color", "SKIN",
        "BODY_ARMOR", "ARMOR", "BODY_ARMOR_MOD", "WINGS",
    },
    enchantments = { "INLINE_ENCH_EXODII_BODY_1_0", "INLINE_ENCH_EXODII_BODY_1_1" },
    restricts_gear = {
        "torso",
        "leg_l",
        "leg_r",
        "arm_l",
        "arm_r",
        "hand_l",
        "hand_r",
        "head",
        "foot_l",
        "foot_r",
        "eyes",
    },
    armor = {
        {
            parts = {
                "torso_bionic_basic", "head_bionic_basic", "arm_bionic_basic_l", "arm_bionic_basic_r",
                "hand_bionic_basic_l", "hand_bionic_basic_r", "leg_bionic_basic_l", "leg_bionic_basic_r",
                "foot_bionic_basic_l", "foot_bionic_basic_r", "mouth_bionic_basic", "eyes_bionic_basic",
            },
            resistances = { cut = 30, bash = 30, stab = 30, bullet = 25 },
        },
    },
    cancels = { "BENDY1", "BENDY2", "BENDY3", "INTERSTICE_POSTURE", "INTERSTICE_POSTURE_2" },
}

ccb.content.define_mutation {
    id = "EXODII_BODY_1b",
    flags = { "Exodii_Body", "TOUGH_FEET" },
    name = ccb.content.text("Exodii cyborg framework - style 1b"),
    points = 0,
    visibility = 4,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your nervous system, sensory organs, and other critical internal meat-bits are shielded in a very human-like bipedal walker frame."),
    valid = false,
    purifiable = false,
    types = {
        "Cyberframe", "skin_tone", "SCENT", "ATTRACTIVENESS", "SIZE", "MUZZLE", "SOLES", "EYES", "HAIR",
        "HORNS", "HANDS", "LEGS", "FEET", "eye_color", "facial_hair", "hair_style", "hair_color", "SKIN",
        "BODY_ARMOR", "ARMOR", "BODY_ARMOR_MOD", "WINGS",
    },
    enchantments = { "INLINE_ENCH_EXODII_BODY_1b_0", "INLINE_ENCH_EXODII_BODY_1b_1" },
    armor = {
        {
            parts = {
                "torso_bionic_basic", "head_bionic_basic", "arm_bionic_basic_l", "arm_bionic_basic_r",
                "hand_bionic_basic_l", "hand_bionic_basic_r", "leg_bionic_basic_l", "leg_bionic_basic_r",
                "foot_bionic_basic_l", "foot_bionic_basic_r", "mouth_bionic_basic",
            },
            resistances = { cut = 5, bash = 5, stab = 5, bullet = 2 },
        },
    },
    cancels = { "BENDY1", "BENDY2", "BENDY3", "INTERSTICE_POSTURE", "INTERSTICE_POSTURE_2" },
}

ccb.content.define_mutation {
    id = "EXODII_BODY_2",
    flags = { "Exodii_Body" },
    name = ccb.content.text("Exodii cyborg framework - style 2a"),
    points = 0,
    visibility = 4,
    ugliness = 2,
    mixed_effect = true,
    description = ccb.content.text("Your brain and some of your organs are shielded in a shiny gold bipedal walker frame."),
    valid = false,
    purifiable = false,
    types = { "Cyberframe", "Cybernetic" },
    enchantments = { "INLINE_ENCH_EXODII_BODY_2_0" },
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    armor = {
        {
            parts = {
                "torso",
                "head",
                "arm_l",
                "arm_r",
                "hand_l",
                "hand_r",
                "leg_l",
                "leg_r",
                "foot_l",
                "foot_r",
                "mouth",
            },
            resistances = { cut = 15, bash = 15, stab = 15, bullet = 10, electric = 0 },
        },
    },
}

ccb.content.define_mutation {
    id = "BIONIC_ARM_BASIC_LEFT",
    name = ccb.content.text("Bionic Arm (left)"),
    description = ccb.content.text("Your left arm and hand have been replaced by advanced bionic prosthetics, controlled by an implanted neurobionic interface.  They more or less function like normal limbs, but they no longer bleed or feel discomfort, and are very modestly armored.  However, they cannot heal on their own and need power to operate."),
    points = 0,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_BIONIC_ARM_BASIC_LEFT_0" },
    armor = {
        {
            parts = { "robofac_arm_bionic_basic_l", "robofac_hand_bionic_basic_l" },
            resistances = { cut = 5, bash = 5, stab = 5, bullet = 2 },
        },
    },
}

ccb.content.define_mutation {
    id = "BIONIC_ARM_BASIC_RIGHT",
    name = ccb.content.text("Bionic Arm (right)"),
    description = ccb.content.text("Your right arm and hand have been replaced by advanced bionic prosthetics, controlled by an implanted neurobionic interface.  They more or less function like normal limbs, but they no longer bleed or feel discomfort, and are very modestly armored.  However, they cannot heal on their own and need power to operate."),
    points = 0,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_BIONIC_ARM_BASIC_RIGHT_0" },
    armor = {
        {
            parts = { "robofac_arm_bionic_basic_r", "robofac_hand_bionic_basic_r" },
            resistances = { cut = 5, bash = 5, stab = 5, bullet = 2 },
        },
    },
}

ccb.content.define_mutation {
    id = "BIONIC_ARM_BASIC_BOTH",
    name = ccb.content.text("Bionic Arms"),
    description = ccb.content.text("Both of your arms and hands have been replaced by advanced bionic prosthetics, controlled by an implanted neurobionic interface.  They more or less function like normal limbs, but they no longer bleed or feel discomfort, and are very modestly armored.  However, they cannot heal on their own and need power to operate."),
    points = 0,
    valid = false,
    purifiable = false,
    types = { "ARMS", "HANDS", "CLAWS" },
    enchantments = { "INLINE_ENCH_BIONIC_ARM_BASIC_BOTH_0" },
    armor = {
        {
            parts = {
                "robofac_arm_bionic_basic_l", "robofac_hand_bionic_basic_l",
                "robofac_arm_bionic_basic_r", "robofac_hand_bionic_basic_r",
            },
            resistances = { cut = 5, bash = 5, stab = 5, bullet = 2 },
        },
    },
    cancels = {
        "BENDY2", "BENDY3", "SLIME_HANDS", "WINGS_BIRD", "ARM_FEATHERS", "QUILLS", "BARBS", "WEBBED",
        "PAWS", "PAWS_LITTLE", "PAWS_LARGE", "CRUSTACEAN_CLAW", "WINGS_BAT", "ARM_TENTACLES",
        "CLAWS_TENTACLE", "INSECT_ARMS", "INSECT_ARMS_OK", "ARACHNID_ARMS", "ARACHNID_ARMS_OK", "NAILS",
        "TALONS", "CLAWS", "CLAWS_RAT", "CLAWS_ST", "CLAWS_RETRACT",
    },
}

ccb.content.define_mutation {
    id = "BIONIC_LEG_BASIC_LEFT",
    name = ccb.content.text("Bionic Leg (left)"),
    description = ccb.content.text("Your left leg and foot have been replaced by advanced bionic prosthetics, controlled by an implanted neurobionic interface.  They more or less function like normal limbs, but they no longer bleed or feel discomfort, and are very modestly armored.  However, they cannot heal on their own and need power to operate."),
    points = 0,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_BIONIC_LEG_BASIC_LEFT_0" },
    armor = {
        {
            parts = { "robofac_leg_bionic_basic_l", "robofac_foot_bionic_basic_l" },
            resistances = { cut = 5, bash = 5, stab = 5, bullet = 2 },
        },
    },
}

ccb.content.define_mutation {
    id = "BIONIC_LEG_BASIC_RIGHT",
    name = ccb.content.text("Bionic Leg (right)"),
    description = ccb.content.text("Your right leg and foot have been replaced by advanced bionic prosthetics, controlled by an implanted neurobionic interface.  They more or less function like normal limbs, but they no longer bleed or feel discomfort, and are very modestly armored.  However, they cannot heal on their own and need power to operate."),
    points = 0,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_BIONIC_LEG_BASIC_RIGHT_0" },
    armor = {
        {
            parts = { "robofac_leg_bionic_basic_r", "robofac_foot_bionic_basic_r" },
            resistances = { cut = 5, bash = 5, stab = 5, bullet = 2 },
        },
    },
}

ccb.content.define_mutation {
    id = "BIONIC_LEG_BASIC_BOTH",
    name = ccb.content.text("Bionic Legs"),
    description = ccb.content.text("Both of your legs and feet have been replaced by advanced bionic prosthetics, controlled by an implanted neurobionic interface.  They more or less function like normal limbs, but they no longer bleed or feel discomfort, and are very modestly armored.  However, they cannot heal on their own and need power to operate."),
    points = 0,
    valid = false,
    purifiable = false,
    flags = { "TOUGH_FEET" },
    types = { "LEGS", "FEET", "SOLES" },
    enchantments = { "INLINE_ENCH_BIONIC_LEG_BASIC_BOTH_0" },
    armor = {
        {
            parts = {
                "robofac_leg_bionic_basic_l", "robofac_foot_bionic_basic_l",
                "robofac_leg_bionic_basic_r", "robofac_foot_bionic_basic_r",
            },
            resistances = { cut = 5, bash = 5, stab = 5, bullet = 2 },
        },
    },
    cancels = {
        "BENDY2", "BENDY3", "LEG_TENTACLES", "LEG_TENT_BRACE", "GASTROPOD_FOOT", "GASTROPOD_BALANCE",
        "INSECT_RESERVOIR", "BIRD_LEGS", "LEGS_BAT", "CRAB_LEGS", "STRONG_LEGS", "ANIMAL_FEET",
        "HOOKED_TOES", "HOOVES", "RABBIT_FEET", "ROOTS1", "ROOTS2", "ROOTS3", "RAP_TALONS",
        "WEBBED_FEET", "PADDED_FEET", "TOUGH_FEET", "BADKNEES", "STRONGKNEES", "REALLYBADKNEES",
        "FLEET2", "RAP_TALONS", "LEGS_BAT", "SCUTTLE",
    },
}
