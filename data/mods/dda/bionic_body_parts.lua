local ccb = require("ccb")
local content = ccb.content

-- See comments in `body_part_struct::load` of bodypart.cpp about why xxx and xxx_multiple are not inside a single translation object.
do
    local part = content.BodyPart {
        id = "robofac_arm_bionic_basic_l",
        name = ccb.content.text("left bionic arm"),
        plural_name = ccb.content.text("bionic arms"),
        accusative = ccb.content.text("left bionic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic arms", "bodypart_accusative"),
        heading = ccb.content.text("bionic l. arm"),
        plural_heading = ccb.content.text("bionic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("LB ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 150,
        drench_capacity = 1000,
        mend_rate = 0,
        ugliness_mandatory = 2,
        no_power_effect = "no_power_arm",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 5,
        power_efficiency = 1000,
        connected_to = "torso",
        opposite = "robofac_arm_bionic_basic_r",
        side = "left",
        similar_body_part = "arm_l",
        health_scaling = { strength = 0 },
    }
    part:sub_part("robofac_arm_bionic_basic_shoulder_l")
    part:sub_part("robofac_arm_bionic_basic_upper_l")
    part:sub_part("robofac_arm_bionic_basic_elbow_l")
    part:sub_part("robofac_arm_bionic_basic_lower_l")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "staggered_character",
        damage_type = "bash",
        damage_threshold = 5,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    part:hit_effect {
        id = "staggered_character",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "robofac_arm_bionic_basic_r",
        name = ccb.content.text("right bionic arm"),
        plural_name = ccb.content.text("bionic arms"),
        accusative = ccb.content.text("right bionic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic arms", "bodypart_accusative"),
        heading = ccb.content.text("bionic r. arm"),
        plural_heading = ccb.content.text("bionic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("RB ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 150,
        drench_capacity = 1000,
        mend_rate = 0,
        ugliness_mandatory = 2,
        no_power_effect = "no_power_arm",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 5,
        power_efficiency = 1000,
        connected_to = "torso",
        opposite = "robofac_arm_bionic_basic_l",
        side = "right",
        similar_body_part = "arm_r",
        health_scaling = { strength = 0 },
    }
    part:sub_part("robofac_arm_bionic_basic_shoulder_r")
    part:sub_part("robofac_arm_bionic_basic_upper_r")
    part:sub_part("robofac_arm_bionic_basic_elbow_r")
    part:sub_part("robofac_arm_bionic_basic_lower_r")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "staggered_character",
        damage_type = "bash",
        damage_threshold = 5,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    part:hit_effect {
        id = "staggered_character",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "robofac_hand_bionic_basic_l",
        name = ccb.content.text("left bionic hand"),
        plural_name = ccb.content.text("bionic hands"),
        accusative = ccb.content.text("left bionic hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic hands", "bodypart_accusative"),
        heading = ccb.content.text("bionic l. hand"),
        plural_heading = ccb.content.text("bionic hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 150,
        drench_capacity = 300,
        limb = false,
        mend_rate = 0,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        power_efficiency = 1000,
        main_part = "robofac_arm_bionic_basic_l",
        opposite = "robofac_hand_bionic_basic_r",
        side = "left",
        similar_body_part = "hand_l",
        health_scaling = { strength = 0 },
    }
    part:sub_part("robofac_hand_bionic_basic_wrist_l")
    part:sub_part("robofac_hand_bionic_basic_palm_l")
    part:sub_part("robofac_hand_bionic_basic_back_l")
    part:sub_part("robofac_hand_bionic_basic_fingers_l")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("hand")
    part:limb_score("grip", 1.0)
    part:limb_score("manip", 0.5, 1.0)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "robofac_hand_bionic_basic_r",
        name = ccb.content.text("right bionic hand"),
        plural_name = ccb.content.text("bionic hands"),
        accusative = ccb.content.text("right bionic hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic hands", "bodypart_accusative"),
        heading = ccb.content.text("bionic r. hand"),
        plural_heading = ccb.content.text("bionic hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 150,
        drench_capacity = 300,
        limb = false,
        mend_rate = 0,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        power_efficiency = 1000,
        main_part = "robofac_arm_bionic_basic_r",
        opposite = "robofac_hand_bionic_basic_l",
        side = "right",
        similar_body_part = "hand_r",
        health_scaling = { strength = 0 },
        fire_warmth_c = 3,
    }
    part:sub_part("robofac_hand_bionic_basic_wrist_r")
    part:sub_part("robofac_hand_bionic_basic_palm_r")
    part:sub_part("robofac_hand_bionic_basic_back_r")
    part:sub_part("robofac_hand_bionic_basic_fingers_r")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("hand")
    part:limb_score("grip", 1.0)
    part:limb_score("manip", 0.5, 1.0)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "robofac_leg_bionic_basic_l",
        name = ccb.content.text("left bionic leg"),
        plural_name = ccb.content.text("bionic legs"),
        accusative = ccb.content.text("left bionic leg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic legs", "bodypart_accusative"),
        heading = ccb.content.text("bionic l. leg"),
        plural_heading = ccb.content.text("bionic legs"),
        encumbrance_text = ccb.content.text("Running and swimming are slowed."),
        hp_bar_text = ccb.content.text("LB LEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        hit_size = 13,
        hit_difficulty = 0.9,
        base_health = 150,
        drench_capacity = 1100,
        mend_rate = 0,
        ugliness_mandatory = 3,
        no_power_effect = "no_power_leg",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 6,
        power_efficiency = 1000,
        connected_to = "torso",
        opposite = "robofac_leg_bionic_basic_r",
        side = "left",
        similar_body_part = "leg_l",
        health_scaling = { strength = 0 },
    }
    part:sub_part("robofac_leg_bionic_basic_hip_l")
    part:sub_part("robofac_leg_bionic_basic_upper_l")
    part:sub_part("robofac_leg_bionic_basic_knee_l")
    part:sub_part("robofac_leg_bionic_basic_lower_l")
    part:sub_part("robofac_leg_bionic_basic_draped_l")
    part:flag("LIMB_LOWER")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("leg")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("move_speed", 0.5)
    part:limb_score("swim", 0.15)
    part:limb_score("block", 1)
    part:limb_score("crawl", 0.2)
    part:hit_effect {
        id = "bouldering",
        damage_threshold = 5,
        scale_increment = 3,
        chance = 20,
        chance_scaling = 2,
        duration = 3,
        max_duration = 15,
    }
    part:hit_effect {
        id = "downed",
        damage_type = "bash",
        damage_threshold = 10,
        scale_increment = 10,
        chance = 5,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 10,
        chance = 15,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "robofac_leg_bionic_basic_r",
        name = ccb.content.text("right bionic leg"),
        plural_name = ccb.content.text("bionic legs"),
        accusative = ccb.content.text("right bionic leg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic legs", "bodypart_accusative"),
        heading = ccb.content.text("bionic r. leg"),
        plural_heading = ccb.content.text("bionic legs"),
        encumbrance_text = ccb.content.text("Running and swimming are slowed."),
        hp_bar_text = ccb.content.text("RB LEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        hit_size = 13,
        hit_difficulty = 0.9,
        base_health = 150,
        drench_capacity = 1100,
        mend_rate = 0,
        ugliness_mandatory = 3,
        no_power_effect = "no_power_leg",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 6,
        power_efficiency = 1000,
        connected_to = "torso",
        opposite = "robofac_leg_bionic_basic_l",
        side = "right",
        similar_body_part = "leg_r",
        health_scaling = { strength = 0 },
    }
    part:sub_part("robofac_leg_bionic_basic_hip_r")
    part:sub_part("robofac_leg_bionic_basic_upper_r")
    part:sub_part("robofac_leg_bionic_basic_knee_r")
    part:sub_part("robofac_leg_bionic_basic_lower_r")
    part:sub_part("robofac_leg_bionic_basic_draped_r")
    part:flag("LIMB_LOWER")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("leg")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("move_speed", 0.5)
    part:limb_score("swim", 0.15)
    part:limb_score("block", 1)
    part:limb_score("crawl", 0.2)
    part:hit_effect {
        id = "bouldering",
        damage_threshold = 5,
        scale_increment = 3,
        chance = 20,
        chance_scaling = 2,
        duration = 3,
        max_duration = 15,
    }
    part:hit_effect {
        id = "downed",
        damage_type = "bash",
        damage_threshold = 10,
        scale_increment = 10,
        chance = 5,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 10,
        chance = 15,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "robofac_foot_bionic_basic_l",
        name = ccb.content.text("left bionic foot"),
        plural_name = ccb.content.text("bionic feet"),
        accusative = ccb.content.text("left bionic foot", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic feet", "bodypart_accusative"),
        heading = ccb.content.text("bionic l. foot"),
        plural_heading = ccb.content.text("bionic feet"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        base_health = 150,
        drench_capacity = 300,
        limb = false,
        mend_rate = 0,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 5,
        power_efficiency = 1000,
        main_part = "robofac_leg_bionic_basic_l",
        opposite = "robofac_foot_bionic_basic_r",
        side = "left",
        similar_body_part = "foot_l",
        health_scaling = { strength = 0 },
    }
    part:sub_part("robofac_foot_bionic_basic_sole_l")
    part:sub_part("robofac_foot_bionic_basic_arch_l")
    part:sub_part("robofac_foot_bionic_basic_toes_l")
    part:sub_part("robofac_foot_bionic_basic_ankle_l")
    part:sub_part("robofac_foot_bionic_basic_heel_l")
    part:flag("LIMB_LOWER")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.6)
    part:limb_score("swim", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "robofac_foot_bionic_basic_r",
        name = ccb.content.text("right bionic foot"),
        plural_name = ccb.content.text("bionic feet"),
        accusative = ccb.content.text("right bionic foot", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic feet", "bodypart_accusative"),
        heading = ccb.content.text("bionic r. foot"),
        plural_heading = ccb.content.text("bionic feet"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        base_health = 150,
        drench_capacity = 300,
        limb = false,
        mend_rate = 0,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 5,
        power_efficiency = 1000,
        main_part = "robofac_leg_bionic_basic_r",
        opposite = "robofac_foot_bionic_basic_l",
        side = "right",
        similar_body_part = "foot_r",
        health_scaling = { strength = 0 },
    }
    part:sub_part("robofac_foot_bionic_basic_sole_r")
    part:sub_part("robofac_foot_bionic_basic_arch_r")
    part:sub_part("robofac_foot_bionic_basic_toes_r")
    part:sub_part("robofac_foot_bionic_basic_ankle_r")
    part:sub_part("robofac_foot_bionic_basic_heel_r")
    part:flag("LIMB_LOWER")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.6)
    part:limb_score("swim", 0.1)
    content.add(part)
end

-- See comments in `body_part_struct::load` of bodypart.cpp about why xxx and xxx_multiple are not inside a single translation object.
do
    local part = content.BodyPart {
        id = "arm_bionic_basic_l",
        name = ccb.content.text("left bionic arm"),
        plural_name = ccb.content.text("bionic arms"),
        accusative = ccb.content.text("left bionic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic arms", "bodypart_accusative"),
        heading = ccb.content.text("bionic l. arm"),
        plural_heading = ccb.content.text("bionic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("LB ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 150,
        drench_capacity = 1000,
        mend_rate = 0,
        ugliness_mandatory = 2,
        no_power_effect = "no_power_arm",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 5,
        power_efficiency = 1000,
        connected_to = "torso",
        opposite = "arm_bionic_basic_r",
        side = "left",
        similar_body_part = "arm_l",
        health_scaling = { strength = 0 },
    }
    part:sub_part("arm_bionic_basic_shoulder_l")
    part:sub_part("arm_bionic_basic_upper_l")
    part:sub_part("arm_bionic_basic_elbow_l")
    part:sub_part("arm_bionic_basic_lower_l")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.75)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.5)
    part:hit_effect {
        id = "staggered_character",
        damage_type = "bash",
        damage_threshold = 5,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    part:hit_effect {
        id = "staggered_character",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "arm_bionic_basic_r",
        name = ccb.content.text("right bionic arm"),
        plural_name = ccb.content.text("bionic arms"),
        accusative = ccb.content.text("right bionic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic arms", "bodypart_accusative"),
        heading = ccb.content.text("bionic r. arm"),
        plural_heading = ccb.content.text("bionic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("RB ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 150,
        drench_capacity = 1000,
        mend_rate = 0,
        ugliness_mandatory = 2,
        no_power_effect = "no_power_arm",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 5,
        power_efficiency = 1000,
        connected_to = "torso",
        opposite = "arm_bionic_basic_l",
        side = "right",
        similar_body_part = "arm_r",
        health_scaling = { strength = 0 },
    }
    part:sub_part("arm_bionic_basic_shoulder_r")
    part:sub_part("arm_bionic_basic_upper_r")
    part:sub_part("arm_bionic_basic_elbow_r")
    part:sub_part("arm_bionic_basic_lower_r")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.75)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.5)
    part:hit_effect {
        id = "staggered_character",
        damage_type = "bash",
        damage_threshold = 5,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    part:hit_effect {
        id = "staggered_character",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "hand_bionic_basic_l",
        name = ccb.content.text("left bionic hand"),
        plural_name = ccb.content.text("bionic hands"),
        accusative = ccb.content.text("left bionic hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic hands", "bodypart_accusative"),
        heading = ccb.content.text("bionic l. hand"),
        plural_heading = ccb.content.text("bionic hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 150,
        drench_capacity = 300,
        limb = false,
        mend_rate = 0,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        power_efficiency = 1000,
        main_part = "arm_bionic_basic_l",
        opposite = "hand_bionic_basic_r",
        side = "left",
        similar_body_part = "hand_l",
        health_scaling = { strength = 0 },
    }
    part:sub_part("hand_bionic_basic_wrist_l")
    part:sub_part("hand_bionic_basic_palm_l")
    part:sub_part("hand_bionic_basic_back_l")
    part:sub_part("hand_bionic_basic_fingers_l")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("hand")
    part:limb_score("grip", 1.0)
    part:limb_score("manip", 0.5, 1.0)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "hand_bionic_basic_r",
        name = ccb.content.text("right bionic hand"),
        plural_name = ccb.content.text("bionic hands"),
        accusative = ccb.content.text("right bionic hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic hands", "bodypart_accusative"),
        heading = ccb.content.text("bionic r. hand"),
        plural_heading = ccb.content.text("bionic hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 150,
        drench_capacity = 300,
        limb = false,
        mend_rate = 0,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        power_efficiency = 1000,
        main_part = "arm_bionic_basic_r",
        opposite = "hand_bionic_basic_l",
        side = "right",
        similar_body_part = "hand_r",
        health_scaling = { strength = 0 },
        fire_warmth_c = 3,
    }
    part:sub_part("hand_bionic_basic_wrist_r")
    part:sub_part("hand_bionic_basic_palm_r")
    part:sub_part("hand_bionic_basic_back_r")
    part:sub_part("hand_bionic_basic_fingers_r")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("hand")
    part:limb_score("grip", 1.0)
    part:limb_score("manip", 0.5, 1.0)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "leg_bionic_basic_l",
        name = ccb.content.text("left bionic leg"),
        plural_name = ccb.content.text("bionic legs"),
        accusative = ccb.content.text("left bionic leg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic legs", "bodypart_accusative"),
        heading = ccb.content.text("bionic l. leg"),
        plural_heading = ccb.content.text("bionic legs"),
        encumbrance_text = ccb.content.text("Running and swimming are slowed."),
        hp_bar_text = ccb.content.text("LB LEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        hit_size = 13,
        hit_difficulty = 0.9,
        base_health = 150,
        drench_capacity = 1100,
        mend_rate = 0,
        ugliness_mandatory = 3,
        no_power_effect = "no_power_leg",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 6,
        power_efficiency = 1000,
        connected_to = "torso",
        opposite = "leg_bionic_basic_r",
        side = "left",
        similar_body_part = "leg_l",
        health_scaling = { strength = 0 },
    }
    part:sub_part("leg_bionic_basic_hip_l")
    part:sub_part("leg_bionic_basic_upper_l")
    part:sub_part("leg_bionic_basic_knee_l")
    part:sub_part("leg_bionic_basic_lower_l")
    part:sub_part("leg_bionic_basic_draped_l")
    part:flag("LIMB_LOWER")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("leg")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("move_speed", 0.6)
    part:limb_score("swim", 0.15)
    part:limb_score("block", 1)
    part:limb_score("crawl", 0.5)
    part:hit_effect {
        id = "bouldering",
        damage_threshold = 5,
        scale_increment = 3,
        chance = 20,
        chance_scaling = 2,
        duration = 3,
        max_duration = 15,
    }
    part:hit_effect {
        id = "downed",
        damage_type = "bash",
        damage_threshold = 10,
        scale_increment = 10,
        chance = 5,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 10,
        chance = 15,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "leg_bionic_basic_r",
        name = ccb.content.text("right bionic leg"),
        plural_name = ccb.content.text("bionic legs"),
        accusative = ccb.content.text("right bionic leg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic legs", "bodypart_accusative"),
        heading = ccb.content.text("bionic r. leg"),
        plural_heading = ccb.content.text("bionic legs"),
        encumbrance_text = ccb.content.text("Running and swimming are slowed."),
        hp_bar_text = ccb.content.text("RB LEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        hit_size = 13,
        hit_difficulty = 0.9,
        base_health = 150,
        drench_capacity = 1100,
        mend_rate = 0,
        ugliness_mandatory = 3,
        no_power_effect = "no_power_leg",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 6,
        power_efficiency = 1000,
        connected_to = "torso",
        opposite = "leg_bionic_basic_l",
        side = "right",
        similar_body_part = "leg_r",
        health_scaling = { strength = 0 },
    }
    part:sub_part("leg_bionic_basic_hip_r")
    part:sub_part("leg_bionic_basic_upper_r")
    part:sub_part("leg_bionic_basic_knee_r")
    part:sub_part("leg_bionic_basic_lower_r")
    part:sub_part("leg_bionic_basic_draped_r")
    part:flag("LIMB_LOWER")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("leg")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("move_speed", 0.6)
    part:limb_score("swim", 0.15)
    part:limb_score("block", 1)
    part:limb_score("crawl", 0.5)
    part:hit_effect {
        id = "bouldering",
        damage_threshold = 5,
        scale_increment = 3,
        chance = 20,
        chance_scaling = 2,
        duration = 3,
        max_duration = 15,
    }
    part:hit_effect {
        id = "downed",
        damage_type = "bash",
        damage_threshold = 10,
        scale_increment = 10,
        chance = 5,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 10,
        chance = 15,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "foot_bionic_basic_l",
        name = ccb.content.text("left bionic foot"),
        plural_name = ccb.content.text("bionic feet"),
        accusative = ccb.content.text("left bionic foot", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic feet", "bodypart_accusative"),
        heading = ccb.content.text("bionic l. foot"),
        plural_heading = ccb.content.text("bionic feet"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        base_health = 150,
        drench_capacity = 300,
        limb = false,
        mend_rate = 0,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 5,
        power_efficiency = 1000,
        main_part = "leg_bionic_basic_l",
        opposite = "foot_bionic_basic_r",
        side = "left",
        similar_body_part = "foot_l",
        health_scaling = { strength = 0 },
    }
    part:sub_part("foot_bionic_basic_sole_l")
    part:sub_part("foot_bionic_basic_arch_l")
    part:sub_part("foot_bionic_basic_toes_l")
    part:sub_part("foot_bionic_basic_ankle_l")
    part:sub_part("foot_bionic_basic_heel_l")
    part:flag("LIMB_LOWER")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.6)
    part:limb_score("swim", 0.2)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "foot_bionic_basic_r",
        name = ccb.content.text("right bionic foot"),
        plural_name = ccb.content.text("bionic feet"),
        accusative = ccb.content.text("right bionic foot", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bionic feet", "bodypart_accusative"),
        heading = ccb.content.text("bionic r. foot"),
        plural_heading = ccb.content.text("bionic feet"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        base_health = 150,
        drench_capacity = 300,
        limb = false,
        mend_rate = 0,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 5,
        power_efficiency = 1000,
        main_part = "leg_bionic_basic_r",
        opposite = "foot_bionic_basic_l",
        side = "right",
        similar_body_part = "foot_r",
        health_scaling = { strength = 0 },
    }
    part:sub_part("foot_bionic_basic_sole_r")
    part:sub_part("foot_bionic_basic_arch_r")
    part:sub_part("foot_bionic_basic_toes_r")
    part:sub_part("foot_bionic_basic_ankle_r")
    part:sub_part("foot_bionic_basic_heel_r")
    part:flag("LIMB_LOWER")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.6)
    part:limb_score("swim", 0.2)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "torso_bionic_basic",
        name = ccb.content.text("bionic torso"),
        plural_name = "",
        accusative = ccb.content.text("bionic torso", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("bionic torso"),
        plural_heading = ccb.content.text("bionic torsos"),
        encumbrance_text = ccb.content.text("Dodging and melee is hampered."),
        hp_bar_text = ccb.content.text("TORSO"),
        smash_message = ccb.content.text("You smash the %s with a powerful shoulder-check."),
        hit_size = 36,
        base_health = 150,
        drench_capacity = 1300,
        limb = false,
        vital = true,
        mend_rate = 0,
        winded_effect = "winded",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 6,
        connected_to = "head_bionic_basic",
        similar_body_part = "torso",
        health_scaling = { strength = 0 },
    }
    part:sub_part("torso_bionic_basic_upper")
    part:sub_part("torso_bionic_basic_neck")
    part:sub_part("torso_bionic_basic_lower")
    part:sub_part("torso_bionic_basic_hanging_front")
    part:sub_part("torso_bionic_basic_hanging_back")
    part:sub_part("torso_bionic_basic_waist")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("PARTIAL_BIONIC_LIMB")
    part:limb_type("torso")
    part:limb_score("balance", 0.7)
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 20,
        scale_increment = 20,
        duration = 60,
        duration_scaling = 60,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 20,
        scale_increment = 20,
        duration = 60,
        duration_scaling = 60,
    }
    part:hit_effect {
        id = "winded",
        damage_type = "bash",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 10,
        chance_scaling = 2,
        max_duration = 15,
    }
    part:hit_effect {
        id = "staggered_character",
        damage_type = "bash",
        damage_threshold = 5,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    part:hit_effect {
        id = "staggered_character",
        damage_threshold = 15,
        scale_increment = 5,
        chance = 20,
        chance_scaling = 10,
        duration = 5,
        duration_scaling = 2,
        max_duration = 15,
    }
    part:hit_effect {
        id = "downed",
        damage_type = "bash",
        damage_threshold = 15,
        scale_increment = 10,
        chance = 5,
        chance_scaling = 20,
        duration = 2,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 10,
        chance = 5,
        chance_scaling = 20,
        duration = 2,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "head_bionic_basic",
        name = ccb.content.text("bionic head"),
        plural_name = "",
        accusative = ccb.content.text("bionic head", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("bionic head"),
        plural_heading = ccb.content.text("bionic heads"),
        encumbrance_text = ccb.content.text("Dodging and blocking are hampered."),
        hp_bar_text = ccb.content.text("HEAD"),
        smash_message = ccb.content.text("You smash the %s with a firm headbutt."),
        hit_size = 4,
        hit_difficulty = 1.2,
        base_health = 150,
        drench_capacity = 200,
        limb = false,
        vital = true,
        mend_rate = 0,
        smash_efficiency = 0.25,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 10,
        similar_body_part = "head",
        health_scaling = { strength = 0 },
    }
    part:sub_part("head_bionic_basic_forehead")
    part:sub_part("head_bionic_basic_crown")
    part:sub_part("head_bionic_basic_nape")
    part:sub_part("head_bionic_basic_throat")
    part:sub_part("head_bionic_basic_ear_r")
    part:sub_part("head_bionic_basic_ear_l")
    part:flag("LIMB_UPPER")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("PARTIAL_BIONIC_LIMB")
    part:technique("tech_base_headbutt")
    part:limb_type("head")
    part:limb_score("reaction", 0.3)
    part:weight_encumbrance(1, 1)
    part:weight_encumbrance(300000, 4)
    part:weight_encumbrance(800000, 8)
    part:weight_encumbrance(1300000, 20)
    part:weight_encumbrance(1600000, 30)
    part:weight_encumbrance(2200000, 50)
    part:weight_encumbrance(5600000, 80)
    part:weight_encumbrance(10000000, 160)
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 20,
        scale_increment = 20,
        duration = 60,
        duration_scaling = 60,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 20,
        scale_increment = 20,
        duration = 60,
        duration_scaling = 60,
    }
    part:hit_effect {
        id = "stunned",
        damage_type = "bash",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 10,
        chance_scaling = 10,
        duration = 1,
        duration_scaling = 0.5,
        max_duration = 4,
    }
    part:hit_effect {
        id = "stunned",
        damage_threshold = 30,
        scale_increment = 10,
        chance = 10,
        chance_scaling = 10,
        duration = 1,
        duration_scaling = 0.5,
        max_duration = 4,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "eyes_bionic_basic",
        name = ccb.content.text("bionic eyes"),
        plural_name = "",
        accusative = ccb.content.text("bionic eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("bionic eyes"),
        plural_heading = ccb.content.text("bionic eyes"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        base_health = 150,
        drench_capacity = 30,
        limb = false,
        mend_rate = 0,
        environmental_protection = 16,
        no_power_effect = "no_power_eyes",
        smash_efficiency = 0.25,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_limit = 60,
        power_efficiency = 100,
        main_part = "head_bionic_basic",
        similar_body_part = "eyes",
        health_scaling = { strength = 0 },
    }
    part:sub_part("eyes_bionic_basic_left")
    part:sub_part("eyes_bionic_basic_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("sensor")
    part:limb_score("vision", 1.0)
    part:limb_score("night_vis", 1.0)
    part:limb_score("reaction", 0.7)
    part:hit_effect {
        id = "blind",
        damage_threshold = 3,
        scale_increment = 3,
        chance = 50,
        chance_scaling = 5,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "mouth_bionic_basic",
        name = ccb.content.text("bionic mouth"),
        plural_name = "",
        accusative = ccb.content.text("bionic mouth", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("bionic mouth"),
        plural_heading = ccb.content.text("bionic mouth"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        base_health = 150,
        drench_capacity = 30,
        limb = false,
        mend_rate = 0,
        smash_efficiency = 0.25,
        pain_multiplier = 0.0,
        feels_discomfort = false,
        main_part = "head_bionic_basic",
        similar_body_part = "mouth",
        health_scaling = { strength = 0 },
    }
    part:sub_part("mouth_bionic_basic_lips")
    part:sub_part("mouth_bionic_basic_nose")
    part:sub_part("mouth_bionic_basic_cheeks")
    part:sub_part("mouth_bionic_basic_chin")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:limb_type("mouth")
    part:limb_score("breathing", 1.0)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 1.0)
    part:limb_score("consume_solid", 1.0)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "bionic_treads_leg",
        name = ccb.content.text("bionic treads"),
        plural_name = "",
        accusative = ccb.content.text("bionic treads", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("bionic treads"),
        plural_heading = ccb.content.text("bionic treads"),
        encumbrance_text = ccb.content.text("Servomotors are operating at abnormal load, reducing movement speed."),
        hp_bar_text = ccb.content.text("TREADS"),
        smash_message = ccb.content.text("You ram the %s with your bionic treads."),
        hit_size = 36,
        hit_difficulty = 1.2,
        base_health = 150,
        drench_capacity = 700,
        limb = false,
        mend_rate = 0,
        ugliness_mandatory = 10,
        no_power_effect = "no_power_tank_treads",
        pain_multiplier = 0.0,
        feels_discomfort = false,
        encumbrance_threshold = 20,
        power_efficiency = 1500,
        connected_to = "torso",
        health_scaling = { strength = 0 },
    }
    part:sub_part("bionic_treads_body")
    part:sub_part("bionic_treads_treads")
    part:flag("LIMB_LOWER")
    part:flag("BIONIC_LIMB")
    part:flag("IGNORE_TEMP")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NONSTANDARD_BLOCK")
    part:limb_type("leg", 0.8)
    part:limb_type("foot", 0.5)
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("move_speed", 1.2)
    part:limb_score("swim", 0.01)
    part:limb_score("block", 0)
    part:limb_score("crawl", 0.01)
    part:limb_score("footing", 2.0)
    part:hit_effect {
        id = "bouldering",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 1,
        chance_scaling = 1,
        duration = 3,
        max_duration = 15,
    }
    content.add(part)
end
