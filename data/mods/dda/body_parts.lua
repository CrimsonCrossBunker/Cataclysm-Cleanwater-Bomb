local ccb = require("ccb")
local content = ccb.content

do
    local part = content.BodyPart {
        id = "torso",
        name = ccb.content.text("torso"),
        plural_name = "",
        accusative = ccb.content.text("torso", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("torso"),
        plural_heading = ccb.content.text("torso"),
        encumbrance_text = ccb.content.text("Dodging and melee is hampered."),
        hp_bar_text = ccb.content.text("TORSO"),
        smash_message = ccb.content.text("You smash the %s with a powerful shoulder-check."),
        legacy_id = "TORSO",
        hit_size = 36,
        drench_capacity = 4000,
        limb = false,
        vital = true,
        winded_effect = "winded",
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 6,
        bionic_slots = 84,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.8,
        connected_to = "head",
        fire_warmth_c = 0.3,
    }
    part:sub_part("torso_upper")
    part:sub_part("torso_neck")
    part:sub_part("torso_lower")
    part:sub_part("torso_hanging_front")
    part:sub_part("torso_hanging_back")
    part:sub_part("torso_waist")
    part:limb_type("torso")
    part:limb_score("balance", 0.7)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 3,
        scale_increment = 2,
        duration = 120,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 1,
        scale_increment = 1.5,
        duration = 60,
        duration_scaling = 60,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 1,
        scale_increment = 1,
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
        id = "big_head",
        name = ccb.content.text("big head"),
        plural_name = "",
        accusative = ccb.content.text("head", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("big head"),
        plural_heading = ccb.content.text("big heads"),
        encumbrance_text = ccb.content.text("Dodging and blocking is hampered."),
        hp_bar_text = ccb.content.text("HEAD"),
        smash_message = ccb.content.text("You smash the %s with a firm headbutt."),
        hit_size = 4,
        hit_difficulty = 1.2,
        drench_capacity = 700,
        limb = false,
        vital = true,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 7,
        bionic_slots = 18,
        encumbrance_threshold = 10,
        fire_warmth_c = 0.3,
    }
    part:sub_part("head_forehead")
    part:sub_part("head_crown")
    part:sub_part("head_nape")
    part:sub_part("head_throat")
    part:sub_part("head_ear_r")
    part:sub_part("head_ear_l")
    part:flag("LIMB_UPPER")
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
        damage_type = "cut",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 30,
        max_duration = 960,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 1,
        scale_increment = 1.5,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1200,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 1,
        scale_increment = 1,
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
        id = "head",
        name = ccb.content.text("head"),
        plural_name = "",
        accusative = ccb.content.text("head", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("head"),
        plural_heading = ccb.content.text("head"),
        encumbrance_text = ccb.content.text("Dodging and blocking is hampered."),
        hp_bar_text = ccb.content.text("HEAD"),
        smash_message = ccb.content.text("You smash the %s with a firm headbutt."),
        legacy_id = "HEAD",
        hit_size = 4,
        hit_difficulty = 1.2,
        drench_capacity = 700,
        limb = false,
        vital = true,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 7,
        bionic_slots = 18,
        encumbrance_threshold = 10,
        fire_warmth_c = 0.3,
    }
    part:sub_part("head_forehead")
    part:sub_part("head_crown")
    part:sub_part("head_nape")
    part:sub_part("head_throat")
    part:sub_part("head_ear_r")
    part:sub_part("head_ear_l")
    part:flag("LIMB_UPPER")
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
        damage_type = "cut",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 30,
        max_duration = 960,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 1,
        scale_increment = 1.5,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1200,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 1,
        scale_increment = 1,
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

-- Shouldn't happen, but consistency is nice
do
    local part = content.BodyPart {
        id = "eyes",
        name = ccb.content.text("eyes"),
        plural_name = "",
        accusative = ccb.content.text("eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        legacy_id = "EYES",
        hit_size = 0.5,
        hit_difficulty = 1.15,
        drench_capacity = 100,
        limb = false,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
    }
    part:sub_part("eyes_left")
    part:sub_part("eyes_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
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
        id = "mouth",
        name = ccb.content.text("mouth"),
        plural_name = "",
        accusative = ccb.content.text("mouth", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("mouth"),
        plural_heading = ccb.content.text("mouth"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        legacy_id = "MOUTH",
        hit_size = 0.5,
        hit_difficulty = 1.15,
        drench_capacity = 100,
        limb = false,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 9,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 10,
        bmi_encumbrance_scalar = 0.75,
        main_part = "head",
    }
    part:sub_part("mouth_lips")
    part:sub_part("mouth_nose")
    part:sub_part("mouth_cheeks")
    part:sub_part("mouth_chin")
    part:flag("LIMB_UPPER")
    part:limb_type("mouth")
    part:limb_score("breathing", 1.0)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 1.0)
    part:limb_score("consume_solid", 1.0)
    content.add(part)
end

-- See comments in `body_part_struct::load` of bodypart.cpp about why xxx and xxx_multiple are not inside a single translation object.
do
    local part = content.BodyPart {
        id = "arm_l",
        name = ccb.content.text("left arm"),
        plural_name = ccb.content.text("arms"),
        accusative = ccb.content.text("left arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("arms", "bodypart_accusative"),
        heading = ccb.content.text("l. arm"),
        plural_heading = ccb.content.text("arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        legacy_id = "ARM_L",
        hit_size = 13,
        hit_difficulty = 0.95,
        drench_capacity = 1000,
        winded_effect = "winded_arm",
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 20,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_r",
        side = "left",
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_shoulder_l")
    part:sub_part("arm_upper_l")
    part:sub_part("arm_elbow_l")
    part:sub_part("arm_lower_l")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 30,
        max_duration = 1500,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 3,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 3,
        scale_increment = 1,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
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
        id = "arm_r",
        name = ccb.content.text("right arm"),
        plural_name = ccb.content.text("arms"),
        accusative = ccb.content.text("right arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("arms", "bodypart_accusative"),
        heading = ccb.content.text("r. arm"),
        plural_heading = ccb.content.text("arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("R ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        legacy_id = "ARM_R",
        hit_size = 13,
        hit_difficulty = 0.95,
        drench_capacity = 1000,
        winded_effect = "winded_arm",
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 20,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_l",
        side = "right",
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_shoulder_r")
    part:sub_part("arm_upper_r")
    part:sub_part("arm_elbow_r")
    part:sub_part("arm_lower_r")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 30,
        max_duration = 1500,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 3,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 3,
        scale_increment = 1,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
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
        id = "hand_l",
        name = ccb.content.text("left hand"),
        plural_name = ccb.content.text("hands"),
        accusative = ccb.content.text("left hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hands", "bodypart_accusative"),
        heading = ccb.content.text("l. hand"),
        plural_heading = ccb.content.text("hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your fist."),
        legacy_id = "HAND_L",
        hit_size = 1.5,
        hit_difficulty = 1.1,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_l",
        opposite = "hand_r",
        side = "left",
        fire_warmth_c = 3,
    }
    part:sub_part("hand_wrist_l")
    part:sub_part("hand_palm_l")
    part:sub_part("hand_back_l")
    part:sub_part("hand_fingers_l")
    part:technique("tech_base_punch")
    part:limb_type("hand")
    part:limb_score("grip", 0.5)
    part:limb_score("manip", 0.5, 1.0)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "hand_r",
        name = ccb.content.text("right hand"),
        plural_name = ccb.content.text("hands"),
        accusative = ccb.content.text("right hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hands", "bodypart_accusative"),
        heading = ccb.content.text("r. hand"),
        plural_heading = ccb.content.text("hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your fist."),
        legacy_id = "HAND_R",
        hit_size = 1.5,
        hit_difficulty = 1.1,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_r",
        opposite = "hand_l",
        side = "right",
        fire_warmth_c = 3,
    }
    part:sub_part("hand_wrist_r")
    part:sub_part("hand_palm_r")
    part:sub_part("hand_back_r")
    part:sub_part("hand_fingers_r")
    part:technique("tech_base_punch")
    part:limb_type("hand")
    part:limb_score("grip", 0.5)
    part:limb_score("manip", 0.5, 1.0)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "leg_l",
        name = ccb.content.text("left leg"),
        plural_name = ccb.content.text("legs"),
        accusative = ccb.content.text("left leg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("legs", "bodypart_accusative"),
        heading = ccb.content.text("l. leg"),
        plural_heading = ccb.content.text("legs"),
        encumbrance_text = ccb.content.text("Running and swimming are slowed."),
        hp_bar_text = ccb.content.text("L LEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        legacy_id = "LEG_L",
        hit_size = 13,
        hit_difficulty = 0.9,
        drench_capacity = 1100,
        winded_effect = "winded_leg",
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 30,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.7,
        connected_to = "torso",
        opposite = "leg_r",
        side = "left",
        fire_warmth_c = 0.3,
    }
    part:sub_part("leg_hip_l")
    part:sub_part("leg_upper_l")
    part:sub_part("leg_knee_l")
    part:sub_part("leg_lower_l")
    part:sub_part("leg_draped_l")
    part:flag("LIMB_LOWER")
    part:limb_type("leg")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("move_speed", 0.5)
    part:limb_score("swim", 0.15)
    part:limb_score("block", 1)
    part:limb_score("crawl", 0.2)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 5,
        scale_increment = 2.5,
        duration = 60,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 3,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 3,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
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
        id = "leg_r",
        name = ccb.content.text("right leg"),
        plural_name = ccb.content.text("legs"),
        accusative = ccb.content.text("right leg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("legs", "bodypart_accusative"),
        heading = ccb.content.text("r. leg"),
        plural_heading = ccb.content.text("legs"),
        encumbrance_text = ccb.content.text("Running and swimming are slowed."),
        hp_bar_text = ccb.content.text("R LEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        legacy_id = "LEG_R",
        hit_size = 13,
        hit_difficulty = 0.9,
        drench_capacity = 1100,
        winded_effect = "winded_leg",
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 30,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.7,
        connected_to = "torso",
        opposite = "leg_l",
        side = "right",
        fire_warmth_c = 0.3,
    }
    part:sub_part("leg_hip_r")
    part:sub_part("leg_upper_r")
    part:sub_part("leg_knee_r")
    part:sub_part("leg_lower_r")
    part:sub_part("leg_draped_r")
    part:flag("LIMB_LOWER")
    part:limb_type("leg")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("move_speed", 0.5)
    part:limb_score("swim", 0.15)
    part:limb_score("block", 1)
    part:limb_score("crawl", 0.2)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 5,
        scale_increment = 2.5,
        duration = 60,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 3,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 3,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
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
        id = "foot_l",
        name = ccb.content.text("left foot"),
        plural_name = ccb.content.text("feet"),
        accusative = ccb.content.text("left foot", "bodypart_accusative"),
        plural_accusative = ccb.content.text("feet", "bodypart_accusative"),
        heading = ccb.content.text("l. foot"),
        plural_heading = ccb.content.text("feet"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        legacy_id = "FOOT_L",
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 7,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_l",
        opposite = "foot_r",
        side = "left",
        fire_warmth_c = 0.6,
    }
    part:sub_part("foot_sole_l")
    part:sub_part("foot_arch_l")
    part:sub_part("foot_toes_l")
    part:sub_part("foot_ankle_l")
    part:sub_part("foot_heel_l")
    part:flag("LIMB_LOWER")
    part:technique("tech_base_kick")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "foot_r",
        name = ccb.content.text("right foot"),
        plural_name = ccb.content.text("feet"),
        accusative = ccb.content.text("right foot", "bodypart_accusative"),
        plural_accusative = ccb.content.text("feet", "bodypart_accusative"),
        heading = ccb.content.text("r. foot"),
        plural_heading = ccb.content.text("feet"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        legacy_id = "FOOT_R",
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 7,
        encumbrance_threshold = 5,
        technique_encumbrance_limit = 40,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_r",
        opposite = "foot_l",
        side = "right",
        fire_warmth_c = 0.6,
    }
    part:sub_part("foot_sole_r")
    part:sub_part("foot_arch_r")
    part:sub_part("foot_toes_r")
    part:sub_part("foot_ankle_r")
    part:sub_part("foot_heel_r")
    part:flag("LIMB_LOWER")
    part:technique("tech_base_kick")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "debug_tail",
        name = ccb.content.text("debug tail"),
        plural_name = ccb.content.text("debug tails"),
        accusative = ccb.content.text("debug tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("DBG Tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Your debug tail feels heavy"),
        hp_bar_text = ccb.content.text("DBG TAIL"),
        hit_size = 100,
        hit_difficulty = 0.8,
        base_health = 20,
        drench_capacity = 4,
        limb = false,
        heal_bonus = 15,
        mend_rate = 100,
        health_limit = 5,
        technique_encumbrance_limit = 10,
        bmi_encumbrance_threshold = 15,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        minimum_temperature_c = 1,
        maximum_temperature_c = 1,
    }
    part:sub_part("sub_limb_debug_tail")
    part:flag("ALWAYS_BLOCK")
    part:flag("NONSTANDARD_BLOCK")
    part:flag("MEND_LIMB")
    part:flag("WALL_CLING")
    part:technique("tec_dbg_sting")
    part:limb_type("tail")
    part:limb_score("manip", 0.5, 1.0)
    part:limb_score("balance", 1.0)
    part:limb_score("swim", 0.15)
    part:limb_score("lift", 2)
    part:limb_score("block", 5)
    part:limb_score("consume_solid", 10.0)
    part:armor("bash", 10)
    part:unarmed_damage("acid", 10)
    part:unarmed_damage("bullet", 5, 100)
    content.add(part)
end
