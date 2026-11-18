local ccb = require("ccb")
local content = ccb.content

do
    local part = content.BodyPart {
        id = "debug_torso",
        name = ccb.content.text("debug torso"),
        plural_name = "",
        accusative = ccb.content.text("debug torso", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("debug torso"),
        plural_heading = ccb.content.text("debug torso"),
        encumbrance_text = ccb.content.text("Weee macarena."),
        hp_bar_text = ccb.content.text("DBG TORSO"),
        smash_message = ccb.content.text("You smash the %s with a powerful shoulder-check."),
        hit_size = 36,
        drench_capacity = 4000,
        limb = false,
        vital = true,
        encumbrance_threshold = 6,
        connected_to = "head",
        health_scaling = { strength = 0 },
    }
    part:sub_part("torso_upper")
    part:sub_part("torso_neck")
    part:sub_part("torso_lower")
    part:sub_part("torso_hanging_front")
    part:sub_part("torso_hanging_back")
    part:sub_part("torso_waist")
    part:limb_type("torso")
    part:limb_score("balance", 0.7)
    content.add(part)
end

-- Slightly larger, but still boring eyes
do
    local part = content.BodyPart {
        id = "eyes_bulging",
        name = ccb.content.text("bulging eyes"),
        plural_name = "",
        accusative = ccb.content.text("bulging eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("Blg Eyes"),
        plural_heading = ccb.content.text("Blg Eyes"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.9,
        hit_difficulty = 1.25,
        drench_capacity = 100,
        limb = false,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_bulging_l")
    part:sub_part("eyes_bulging_r")
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
    content.replace(part)
end

-- Even larger.  Vision score lower, removed hardcoded per bonus.  Slightly less likely to blind on hit + cut armor.
do
    local part = content.BodyPart {
        id = "eyes_insect_1",
        name = ccb.content.text("compound eyes"),
        plural_name = "",
        accusative = ccb.content.text("compound eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("Compound Eyes"),
        plural_heading = ccb.content.text("Compound Eyes"),
        encumbrance_text = ccb.content.text("Your vision is impaired!"),
        hp_bar_text = ccb.content.text("CMP EYES"),
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 1.2,
        hit_difficulty = 1.25,
        drench_capacity = 100,
        limb = false,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_compound_l")
    part:sub_part("eyes_compound_r")
    part:flag("IGNORE_TEMP")
    part:flag("SEESLEEP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 0.65)
    part:limb_score("night_vis", 0.8)
    part:limb_score("reaction", 0.8)
    part:armor("cut", 3)
    part:hit_effect {
        id = "blind",
        damage_threshold = 3,
        scale_increment = 3,
        chance = 25,
        chance_scaling = 5,
        duration = 1,
        duration_scaling = 0.5,
        max_duration = 12,
    }
    content.add(part)
end

-- Differentiated to allow eyewear on them without too high coverage, and to suppress multiple portion errors
-- Most of the fine/night vision, lower proportion of the reaction score (peripheral vision)
do
    local part = content.BodyPart {
        id = "eyes_dragonfly",
        name = ccb.content.text("dragonfly eyes (front)"),
        plural_name = "",
        accusative = ccb.content.text("dragonfly eyes (front)", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("dragonfly eyes (front)"),
        plural_heading = ccb.content.text("dragonfly eyes (front)"),
        encumbrance_text = ccb.content.text("Your vision is impaired!"),
        hp_bar_text = ccb.content.text("CMP EYES"),
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 1.2,
        hit_difficulty = 1.25,
        drench_capacity = 100,
        limb = false,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head_dragonfly",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_dragonfly_mono_l")
    part:sub_part("eyes_dragonfly_mono_r")
    part:flag("IGNORE_TEMP")
    part:flag("SEESLEEP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 0.4)
    part:limb_score("night_vis", 0.5)
    part:limb_score("reaction", 0.7)
    part:armor("cut", 3)
    part:hit_effect {
        id = "blind",
        damage_threshold = 3,
        scale_increment = 3,
        chance = 25,
        chance_scaling = 5,
        duration = 1,
        duration_scaling = 0.5,
        max_duration = 12,
    }
    content.add(part)
end

-- Head replacement.  TOgether with the eye replacement superhuman reaction score, raised but still suboptimal vision score (getting used to it), a large target.
do
    local part = content.BodyPart {
        id = "head_dragonfly",
        name = ccb.content.text("dragonfly head"),
        plural_name = "",
        accusative = ccb.content.text("dragonfly eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("dragonfly head"),
        plural_heading = ccb.content.text("dragonfly head"),
        encumbrance_text = ccb.content.text("Your vision is impaired!"),
        hp_bar_text = ccb.content.text("DRGFL HEAD"),
        smash_message = ccb.content.text("You smash the %s with a firm headbutt."),
        hit_size = 7,
        hit_difficulty = 1.2,
        drench_capacity = 700,
        limb = false,
        vital = true,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 7,
        bionic_slots = 18,
        encumbrance_limit = 75,
        similar_body_part = "head",
        fire_warmth_c = 0.3,
    }
    part:sub_part("head_dragonfly_forehead")
    part:sub_part("head_dragonfly_crown")
    part:sub_part("head_dragonfly_nape")
    part:sub_part("head_dragonfly_throat")
    part:sub_part("head_dragonfly_ear_r")
    part:sub_part("head_dragonfly_ear_l")
    part:flag("SEESLEEP")
    part:flag("LIMB_UPPER")
    part:technique("tech_base_headbutt")
    part:limb_type("sensor")
    part:limb_type("head")
    part:limb_score("vision", 0.5)
    part:limb_score("night_vis", 0.5)
    part:limb_score("reaction", 1.1)
    part:armor("cut", 3)
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
    part:hit_effect {
        id = "blind",
        damage_threshold = 3,
        scale_increment = 3,
        chance = 25,
        chance_scaling = 5,
        duration = 1,
        duration_scaling = 0.5,
        max_duration = 12,
    }
    content.replace(part)
end

-- Slightly more fragile, clumsier, better swimmer but annoying when wet.
do
    local part = content.BodyPart {
        id = "arm_feathers_l",
        name = ccb.content.text("feathered arm"),
        plural_name = ccb.content.text("feathered arms"),
        accusative = ccb.content.text("feathered left arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("feathered arms", "bodypart_accusative"),
        heading = ccb.content.text("feathered left arm"),
        plural_heading = ccb.content.text("feathered arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 15,
        hit_difficulty = 0.95,
        drench_capacity = 1800,
        drench_increment = 1,
        drying_rate = 0.5,
        wet_morale = -20,
        ugliness = -2,
        ugliness_mandatory = 1,
        environmental_protection = 2,
        winded_effect = "winded_arm",
        smash_efficiency = 0.4,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 10,
        bionic_slots = 20,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_feathers_r",
        side = "left",
        health_scaling = { strength = 2 },
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_feathers_shoulder_l")
    part:sub_part("arm_feathers_upper_l")
    part:sub_part("arm_feathers_elbow_l")
    part:sub_part("arm_feathers_lower_l")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.12)
    part:limb_score("block", 0.8)
    part:limb_score("swim", 0.2)
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
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "arm_feathers_r",
        name = ccb.content.text("feathered arm"),
        plural_name = ccb.content.text("feathered arms"),
        accusative = ccb.content.text("feathered left arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("feathered arms", "bodypart_accusative"),
        heading = ccb.content.text("feathered right arm"),
        plural_heading = ccb.content.text("feathered arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 15,
        hit_difficulty = 0.95,
        drench_capacity = 1800,
        drench_increment = 1,
        drying_rate = 0.5,
        wet_morale = -20,
        ugliness = -2,
        ugliness_mandatory = 1,
        environmental_protection = 2,
        winded_effect = "winded_arm",
        smash_efficiency = 0.4,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 10,
        bionic_slots = 20,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_feathers_l",
        side = "right",
        health_scaling = { strength = 2 },
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_feathers_shoulder_r")
    part:sub_part("arm_feathers_upper_r")
    part:sub_part("arm_feathers_elbow_r")
    part:sub_part("arm_feathers_lower_r")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.18)
    part:limb_score("block", 0.8)
    part:limb_score("swim", 0.2)
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
    content.replace(part)
end

-- Shoulder is similar enough to substitute, the rest is too divergent for armor substitution.  Slightly better balance, terrible manipulation, better swim.  Temperature gets taken care of via feathers, unless you're a naked chicken.  No fat deposits.  Copy-from for onhit effects.
do
    local part = content.BodyPart {
        id = "arm_wing_bird_l",
        name = ccb.content.text("left wing"),
        plural_name = ccb.content.text("left wings"),
        accusative = ccb.content.text("left wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("left wings", "bodypart_accusative"),
        heading = ccb.content.text("l. wing"),
        plural_heading = ccb.content.text("wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered, and you won't be able to use your wings to glide."),
        hp_bar_text = ccb.content.text("L WING"),
        smash_message = ccb.content.text("You buffet the %s with your wing."),
        hit_size = 20,
        hit_difficulty = 1.2,
        base_health = 45,
        mend_rate = 1.2,
        drench_increment = 1,
        drying_rate = 0.5,
        wet_morale = -20,
        ugliness = -2,
        ugliness_mandatory = 1,
        environmental_protection = 2,
        winded_effect = "winded_arm",
        smash_efficiency = 0.4,
        hot_morale = 1.0,
        cold_morale = 0.2,
        squeamish_penalty = 20,
        bionic_slots = 20,
        encumbrance_threshold = 5,
        encumbrance_limit = 10,
        health_limit = 15,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_wing_bird_r",
        side = "left",
        health_scaling = { strength = 2 },
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_wing_bird_shoulder_l")
    part:sub_part("arm_wing_bird_upper_l")
    part:sub_part("arm_wing_bird_elbow_l")
    part:sub_part("arm_wing_bird_lower_l")
    part:sub_part("arm_wing_bird_fingers_l")
    part:conditional_flag("WING_ARMS")
    part:technique("tech_wing_slap")
    part:limb_type("arm", 0.8)
    part:limb_type("hand", 0.3)
    part:limb_score("grip", 0.3)
    part:limb_score("manip", 0.2, 0.3)
    part:limb_score("lift", 0.3)
    part:limb_score("balance", 0.2)
    part:limb_score("block", 0.5)
    part:limb_score("swim", 0.3)
    part:limb_score("crawl", 0.2)
    part:unarmed_damage("bash", -2)
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
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "arm_wing_bird_r",
        name = ccb.content.text("right wing"),
        plural_name = ccb.content.text("right wings"),
        accusative = ccb.content.text("right wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("right wings", "bodypart_accusative"),
        heading = ccb.content.text("r. wing"),
        plural_heading = ccb.content.text("wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered, and you won't be able to use your wings to glide."),
        hp_bar_text = ccb.content.text("R WING"),
        smash_message = ccb.content.text("You buffet the %s with your wing."),
        hit_size = 20,
        hit_difficulty = 1.2,
        base_health = 45,
        mend_rate = 1.2,
        drench_increment = 1,
        drying_rate = 0.5,
        wet_morale = -20,
        ugliness = -2,
        ugliness_mandatory = 1,
        environmental_protection = 2,
        winded_effect = "winded_arm",
        smash_efficiency = 0.4,
        hot_morale = 1.0,
        cold_morale = 0.2,
        squeamish_penalty = 20,
        bionic_slots = 20,
        encumbrance_threshold = 5,
        encumbrance_limit = 10,
        health_limit = 15,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_wing_bird_l",
        side = "right",
        health_scaling = { strength = 2 },
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_wing_bird_shoulder_r")
    part:sub_part("arm_wing_bird_upper_r")
    part:sub_part("arm_wing_bird_elbow_r")
    part:sub_part("arm_wing_bird_lower_r")
    part:sub_part("arm_wing_bird_fingers_r")
    part:conditional_flag("WING_ARMS")
    part:technique("tech_wing_slap")
    part:limb_type("arm", 0.8)
    part:limb_type("hand", 0.3)
    part:limb_score("grip", 0.3)
    part:limb_score("manip", 0.38)
    part:limb_score("lift", 0.42)
    part:limb_score("balance", 0.2)
    part:limb_score("block", 0.8)
    part:limb_score("swim", 0.25)
    part:limb_score("crawl", 0.3)
    part:unarmed_damage("bash", -2)
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
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "gastropod_foot",
        name = ccb.content.text("gastropod foot"),
        plural_name = "",
        accusative = ccb.content.text("gastropod foot", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("gastropod foot"),
        plural_heading = ccb.content.text("gastropod feet"),
        encumbrance_text = ccb.content.text("Running and swimming are slowed."),
        hp_bar_text = ccb.content.text("G. FOOT"),
        hit_size = 30,
        hit_difficulty = 1.2,
        base_health = 120,
        drench_capacity = 700,
        limb = false,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 5,
        bionic_slots = 58,
        encumbrance_threshold = 20,
        connected_to = "torso",
        fire_warmth_c = 0.3,
    }
    part:sub_part("leg_hip_l")
    part:sub_part("leg_upper_l")
    part:sub_part("leg_knee_l")
    part:sub_part("leg_lower_l")
    part:sub_part("leg_draped_l")
    part:flag("LIMB_LOWER")
    part:limb_type("leg", 0.8)
    part:limb_type("foot", 0.5)
    part:limb_type("tail", 0.2)
    part:limb_score("move_speed", 0.3)
    part:limb_score("crawl", 0.6)
    part:limb_score("footing", 0.8)
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
        id = "bouldering",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 10,
        chance_scaling = 3,
        duration = 3,
        max_duration = 15,
    }
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "arm_stub_l",
        name = ccb.content.text("left arm stub"),
        plural_name = ccb.content.text("arm stubs"),
        accusative = ccb.content.text("left arm stub", "bodypart_accusative"),
        plural_accusative = ccb.content.text("arm stubs", "bodypart_accusative"),
        heading = ccb.content.text("l. arm stub"),
        plural_heading = ccb.content.text("arm stubs"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L ARM STUB"),
        hit_difficulty = 0.3,
        base_health = 0,
        bmi_encumbrance_threshold = 0,
        connected_to = "torso",
        opposite = "arm_stub_r",
        side = "left",
    }
    part:sub_part("arm_shoulder_l")
    part:limb_type("arm")
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("balance", 0)
    part:limb_score("block", 0)
    part:limb_score("swim", 0)
    part:limb_score("crawl", 0)
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
        id = "bouldering",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 10,
        chance_scaling = 3,
        duration = 3,
        max_duration = 15,
    }
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "arm_stub_r",
        name = ccb.content.text("right arm stub"),
        plural_name = ccb.content.text("arm stubs"),
        accusative = ccb.content.text("right arm stub", "bodypart_accusative"),
        plural_accusative = ccb.content.text("arm stubs", "bodypart_accusative"),
        heading = ccb.content.text("r. arm stub"),
        plural_heading = ccb.content.text("arm stubs"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("R ARM STUB"),
        hit_difficulty = 0.3,
        base_health = 0,
        bmi_encumbrance_threshold = 0,
        connected_to = "torso",
        opposite = "arm_stub_l",
        side = "right",
    }
    part:sub_part("arm_shoulder_r")
    part:limb_type("arm")
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("balance", 0)
    part:limb_score("block", 0)
    part:limb_score("swim", 0)
    part:limb_score("crawl", 0)
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
        id = "bouldering",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 10,
        chance_scaling = 3,
        duration = 3,
        max_duration = 15,
    }
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "leg_stub_r",
        name = ccb.content.text("right leg stub"),
        plural_name = "",
        accusative = ccb.content.text("r. leg stub", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("right leg stub"),
        plural_heading = ccb.content.text("right leg stubs"),
        encumbrance_text = ccb.content.text("You've lost your right leg."),
        hp_bar_text = ccb.content.text("R. STUB"),
        hit_difficulty = 0.3,
        base_health = 0,
        limb = false,
        connected_to = "torso",
        opposite = "leg_stub_l",
        side = "right",
    }
    part:sub_part("leg_hip_r")
    part:flag("LIMB_UPPER")
    part:limb_type("leg", 0.1)
    part:limb_type("foot", 0)
    part:limb_score("move_speed", 0.1)
    part:limb_score("crawl", 0.5)
    part:limb_score("footing", 0.5)
    part:weight_encumbrance(1, 0)
    part:weight_encumbrance(300000, 0)
    part:weight_encumbrance(800000, 0)
    part:weight_encumbrance(1300000, 0)
    part:weight_encumbrance(1600000, 0)
    part:weight_encumbrance(2200000, 0)
    part:weight_encumbrance(5600000, 0)
    part:weight_encumbrance(10000000, 0)
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
        id = "bouldering",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 10,
        chance_scaling = 3,
        duration = 3,
        max_duration = 15,
    }
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "leg_stub_l",
        name = ccb.content.text("left leg stub"),
        plural_name = "",
        accusative = ccb.content.text("l. leg stub", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("left leg stub"),
        plural_heading = ccb.content.text("left leg stubs"),
        encumbrance_text = ccb.content.text("You've lost your left leg."),
        hp_bar_text = ccb.content.text("L. STUB"),
        hit_difficulty = 0.3,
        base_health = 0,
        limb = false,
        connected_to = "torso",
        opposite = "leg_stub_r",
        side = "left",
    }
    part:sub_part("leg_hip_l")
    part:flag("LIMB_UPPER")
    part:limb_type("leg", 0.1)
    part:limb_type("foot", 0)
    part:limb_score("move_speed", 0.1)
    part:limb_score("crawl", 0.5)
    part:limb_score("footing", 0.5)
    part:weight_encumbrance(1, 0)
    part:weight_encumbrance(300000, 0)
    part:weight_encumbrance(800000, 0)
    part:weight_encumbrance(1300000, 0)
    part:weight_encumbrance(1600000, 0)
    part:weight_encumbrance(2200000, 0)
    part:weight_encumbrance(5600000, 0)
    part:weight_encumbrance(10000000, 0)
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
        id = "bouldering",
        damage_threshold = 10,
        scale_increment = 5,
        chance = 10,
        chance_scaling = 3,
        duration = 3,
        max_duration = 15,
    }
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "leg_prosthetic_r",
        name = ccb.content.text("right prosthetic leg"),
        plural_name = "",
        accusative = ccb.content.text("r. leg prosthetic", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("right leg prosthetic"),
        plural_heading = ccb.content.text("right leg prosthetics"),
        encumbrance_text = ccb.content.text("You're using a prosthetic right leg."),
        hp_bar_text = ccb.content.text("R. PROS"),
        hit_size = 13,
        hit_difficulty = 0.9,
        base_health = 84,
        limb = false,
        mend_rate = 0,
        encumbrance_threshold = 15,
        connected_to = "torso",
        opposite = "leg_prosthetic_l",
        side = "right",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("leg_hip_r")
    part:sub_part("leg_upper_r")
    part:sub_part("leg_knee_r")
    part:sub_part("leg_lower_r")
    part:sub_part("leg_draped_r")
    part:flag("LIMB_LOWER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("leg", 0.5)
    part:limb_type("foot", 0.5)
    part:limb_score("move_speed", 0.8)
    part:limb_score("crawl", 0.5)
    part:limb_score("footing", 0.6)
    part:weight_encumbrance(1, 1)
    part:weight_encumbrance(300000, 6)
    part:weight_encumbrance(800000, 12)
    part:weight_encumbrance(1300000, 30)
    part:weight_encumbrance(1600000, 45)
    part:weight_encumbrance(2200000, 75)
    part:weight_encumbrance(5600000, 120)
    part:weight_encumbrance(10000000, 240)
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
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "leg_prosthetic_l",
        name = ccb.content.text("left prosthetic leg"),
        plural_name = "",
        accusative = ccb.content.text("l. leg prosthetic", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("left leg prosthetic"),
        plural_heading = ccb.content.text("left leg prosthetics"),
        encumbrance_text = ccb.content.text("You're using a prosthetic left leg."),
        hp_bar_text = ccb.content.text("L. PROS"),
        hit_size = 13,
        hit_difficulty = 0.9,
        base_health = 84,
        mend_rate = 0,
        encumbrance_threshold = 15,
        connected_to = "torso",
        opposite = "leg_prosthetic_r",
        side = "left",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("leg_hip_l")
    part:sub_part("leg_upper_l")
    part:sub_part("leg_knee_l")
    part:sub_part("leg_lower_l")
    part:sub_part("leg_draped_l")
    part:flag("LIMB_LOWER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("leg", 0.5)
    part:limb_type("foot", 0.5)
    part:limb_score("move_speed", 0.8)
    part:limb_score("crawl", 0.5)
    part:limb_score("footing", 0.6)
    part:weight_encumbrance(1, 1)
    part:weight_encumbrance(300000, 6)
    part:weight_encumbrance(800000, 12)
    part:weight_encumbrance(1300000, 30)
    part:weight_encumbrance(1600000, 45)
    part:weight_encumbrance(2200000, 75)
    part:weight_encumbrance(5600000, 120)
    part:weight_encumbrance(10000000, 240)
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
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "leg_peg_r",
        name = ccb.content.text("right peg leg"),
        plural_name = "",
        accusative = ccb.content.text("r. peg leg", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("right peg leg"),
        plural_heading = ccb.content.text("right peg legs"),
        encumbrance_text = ccb.content.text("You're using a prosthetic right leg."),
        hp_bar_text = ccb.content.text("R. PEG"),
        hit_size = 13,
        hit_difficulty = 0.9,
        base_health = 84,
        limb = false,
        mend_rate = 0,
        encumbrance_threshold = 10,
        connected_to = "torso",
        opposite = "leg_peg_l",
        side = "right",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("leg_hip_r")
    part:sub_part("leg_upper_r")
    part:sub_part("leg_knee_r")
    part:sub_part("leg_lower_r")
    part:sub_part("leg_draped_r")
    part:flag("LIMB_LOWER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("leg", 0.3)
    part:limb_type("foot", 0.3)
    part:limb_score("move_speed", 0.6)
    part:limb_score("crawl", 0.3)
    part:limb_score("footing", 0.4)
    part:weight_encumbrance(1, 2)
    part:weight_encumbrance(300000, 8)
    part:weight_encumbrance(800000, 16)
    part:weight_encumbrance(1300000, 40)
    part:weight_encumbrance(1600000, 60)
    part:weight_encumbrance(2200000, 100)
    part:weight_encumbrance(5600000, 160)
    part:weight_encumbrance(10000000, 320)
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
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "leg_peg_l",
        name = ccb.content.text("left peg leg"),
        plural_name = "",
        accusative = ccb.content.text("l. peg leg", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("left peg leg"),
        plural_heading = ccb.content.text("left peg legs"),
        encumbrance_text = ccb.content.text("You're using a prosthetic left leg."),
        hp_bar_text = ccb.content.text("L. PEG"),
        hit_size = 13,
        hit_difficulty = 0.9,
        base_health = 84,
        limb = false,
        mend_rate = 0,
        encumbrance_threshold = 10,
        connected_to = "torso",
        opposite = "leg_peg_r",
        side = "left",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("leg_hip_l")
    part:sub_part("leg_upper_l")
    part:sub_part("leg_knee_l")
    part:sub_part("leg_lower_l")
    part:sub_part("leg_draped_l")
    part:flag("LIMB_LOWER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("leg", 0.3)
    part:limb_type("foot", 0.3)
    part:limb_score("move_speed", 0.6)
    part:limb_score("crawl", 0.3)
    part:limb_score("footing", 0.4)
    part:weight_encumbrance(1, 2)
    part:weight_encumbrance(300000, 8)
    part:weight_encumbrance(800000, 16)
    part:weight_encumbrance(1300000, 40)
    part:weight_encumbrance(1600000, 60)
    part:weight_encumbrance(2200000, 100)
    part:weight_encumbrance(5600000, 160)
    part:weight_encumbrance(10000000, 320)
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
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "foot_prosthetic_l",
        name = ccb.content.text("left prosthetic foot"),
        plural_name = ccb.content.text("feet"),
        accusative = ccb.content.text("left prosthetic foot", "bodypart_accusative"),
        plural_accusative = ccb.content.text("prosthetic feet", "bodypart_accusative"),
        heading = ccb.content.text("l. pros foot"),
        plural_heading = ccb.content.text("feet"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        base_health = 84,
        limb = false,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 0,
        main_part = "leg_prosthetic_l",
        opposite = "foot_prosthetic_r",
        side = "left",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("foot_sole_l")
    part:sub_part("foot_arch_l")
    part:sub_part("foot_toes_l")
    part:sub_part("foot_ankle_l")
    part:sub_part("foot_heel_l")
    part:flag("LIMB_LOWER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("foot")
    part:limb_score("manip", 0)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.1)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "foot_prosthetic_r",
        name = ccb.content.text("right prosthetic foot"),
        plural_name = ccb.content.text("feet"),
        accusative = ccb.content.text("right prosthetic foot", "bodypart_accusative"),
        plural_accusative = ccb.content.text("prosthetic feet", "bodypart_accusative"),
        heading = ccb.content.text("r. pros foot"),
        plural_heading = ccb.content.text("feet"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        base_health = 84,
        limb = false,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 0,
        main_part = "leg_prosthetic_r",
        opposite = "foot_prosthetic_l",
        side = "right",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("foot_sole_r")
    part:sub_part("foot_arch_r")
    part:sub_part("foot_toes_r")
    part:sub_part("foot_ankle_r")
    part:sub_part("foot_heel_r")
    part:flag("LIMB_LOWER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("foot")
    part:limb_score("manip", 0)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.1)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "arm_prosthetic_r",
        name = ccb.content.text("prosthetic right arm"),
        plural_name = ccb.content.text("prosthetic arms"),
        accusative = ccb.content.text("right prosthetic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("prosthetic arms", "bodypart_accusative"),
        heading = ccb.content.text("r. prosthetic arm"),
        plural_heading = ccb.content.text("prosthetic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("R PROS ARM"),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 84,
        encumbrance_threshold = 15,
        bmi_encumbrance_threshold = 0,
        connected_to = "torso",
        opposite = "arm_prosthetic_l",
        side = "right",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("arm_shoulder_r")
    part:sub_part("arm_upper_r")
    part:sub_part("arm_elbow_r")
    part:sub_part("arm_lower_r")
    part:flag("LIMB_UPPER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("arm")
    part:limb_score("manip", 0)
    part:limb_score("lift", 0.3)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 0.8)
    part:limb_score("swim", 0.05)
    part:limb_score("crawl", 0.1)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "arm_prosthetic_l",
        name = ccb.content.text("prosthetic left arm"),
        plural_name = ccb.content.text("prosthetic arms"),
        accusative = ccb.content.text("left prosthetic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("prosthetic arms", "bodypart_accusative"),
        heading = ccb.content.text("l. prosthetic arm"),
        plural_heading = ccb.content.text("prosthetic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L PROS ARM"),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 84,
        encumbrance_threshold = 15,
        bmi_encumbrance_threshold = 0,
        connected_to = "torso",
        opposite = "arm_prosthetic_r",
        side = "left",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("arm_shoulder_l")
    part:sub_part("arm_upper_l")
    part:sub_part("arm_elbow_l")
    part:sub_part("arm_lower_l")
    part:flag("LIMB_UPPER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("arm")
    part:limb_score("manip", 0)
    part:limb_score("lift", 0.3)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 0.8)
    part:limb_score("swim", 0.05)
    part:limb_score("crawl", 0.1)
    content.replace(part)
end

-- This is really to represent prosthetics that might not have a practical use, or be used for something besides a regular arm.
do
    local part = content.BodyPart {
        id = "arm_prosthetic_cosmetic_r",
        name = ccb.content.text("cosmetic prosthetic right arm"),
        plural_name = ccb.content.text("cosmetic prosthetic arms"),
        accusative = ccb.content.text("right cosmetic prosthetic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("cosmetic prosthetic arms", "bodypart_accusative"),
        heading = ccb.content.text("r. prosthetic arm"),
        plural_heading = ccb.content.text("cosmetic prosthetic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("R PROS ARM"),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 84,
        encumbrance_threshold = 15,
        bmi_encumbrance_threshold = 0,
        connected_to = "torso",
        opposite = "arm_prosthetic_cosmetic_l",
        side = "right",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("arm_shoulder_r")
    part:sub_part("arm_upper_r")
    part:sub_part("arm_elbow_r")
    part:sub_part("arm_lower_r")
    part:flag("LIMB_UPPER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("arm")
    part:limb_score("manip", 0)
    part:limb_score("lift", 0.1)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 0.8)
    part:limb_score("swim", 0)
    part:limb_score("crawl", 0.05)
    content.replace(part)
end

-- This is really to represent prosthetics that might not have a practical use, or be used for something besides a regular arm.
do
    local part = content.BodyPart {
        id = "arm_prosthetic_cosmetic_l",
        name = ccb.content.text("cosmetic prosthetic left arm"),
        plural_name = ccb.content.text("cosmetic prosthetic arms"),
        accusative = ccb.content.text("left cosmetic prosthetic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("cosmetic prosthetic arms", "bodypart_accusative"),
        heading = ccb.content.text("l. prosthetic arm"),
        plural_heading = ccb.content.text("cosmetic prosthetic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L PROS ARM"),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 84,
        encumbrance_threshold = 15,
        bmi_encumbrance_threshold = 0,
        connected_to = "torso",
        opposite = "arm_prosthetic_cosmetic_r",
        side = "left",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("arm_shoulder_l")
    part:sub_part("arm_upper_l")
    part:sub_part("arm_elbow_l")
    part:sub_part("arm_lower_l")
    part:flag("LIMB_UPPER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("arm")
    part:limb_score("manip", 0)
    part:limb_score("lift", 0.1)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 0.8)
    part:limb_score("swim", 0)
    part:limb_score("crawl", 0.05)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "arm_neuroprosthetic_r",
        name = ccb.content.text("neuroprosthetic right arm"),
        plural_name = ccb.content.text("neuroprosthetic arms"),
        accusative = ccb.content.text("right neuroprosthetic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("neuroprosthetic arms", "bodypart_accusative"),
        heading = ccb.content.text("r. neuroprosthetic arm"),
        plural_heading = ccb.content.text("neuroprosthetic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("R N.PROS ARM"),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 84,
        encumbrance_threshold = 15,
        bmi_encumbrance_threshold = 0,
        connected_to = "torso",
        opposite = "arm_neuroprosthetic_l",
        side = "right",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("arm_shoulder_r")
    part:sub_part("arm_upper_r")
    part:sub_part("arm_elbow_r")
    part:sub_part("arm_lower_r")
    part:flag("LIMB_UPPER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("arm")
    part:limb_score("manip", 0.15)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 0.9)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.25)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "arm_neuroprosthetic_l",
        name = ccb.content.text("neuroprosthetic left arm"),
        plural_name = ccb.content.text("neuroprosthetic arms"),
        accusative = ccb.content.text("left neuroprosthetic arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("neuroprosthetic arms", "bodypart_accusative"),
        heading = ccb.content.text("l. neuroprosthetic arm"),
        plural_heading = ccb.content.text("neuroprosthetic arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L N.PROS ARM"),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 84,
        encumbrance_threshold = 15,
        bmi_encumbrance_threshold = 0,
        connected_to = "torso",
        opposite = "arm_neuroprosthetic_r",
        side = "left",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("arm_shoulder_l")
    part:sub_part("arm_upper_l")
    part:sub_part("arm_elbow_l")
    part:sub_part("arm_lower_l")
    part:flag("LIMB_UPPER")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("arm")
    part:limb_score("manip", 0.15)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.15)
    part:limb_score("block", 0.9)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.25)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "hand_prosthetic_r",
        name = ccb.content.text("prosthetic right hand"),
        plural_name = ccb.content.text("prosthetic hands"),
        accusative = ccb.content.text("prosthetic right hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("prosthetic hands", "bodypart_accusative"),
        heading = ccb.content.text("r. prosthetic hand"),
        plural_heading = ccb.content.text("prosthetic hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your prosthetic fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 84,
        limb = false,
        bmi_encumbrance_threshold = 0,
        main_part = "arm_prosthetic_r",
        opposite = "hand_prosthetic_l",
        side = "right",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("hand_wrist_r")
    part:sub_part("hand_palm_r")
    part:sub_part("hand_back_r")
    part:sub_part("hand_fingers_r")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("hand")
    part:limb_score("grip", 0.2)
    part:limb_score("manip", 0)
    part:limb_score("swim", 0.07)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "hand_prosthetic_l",
        name = ccb.content.text("prosthetic left hand"),
        plural_name = ccb.content.text("prosthetic hands"),
        accusative = ccb.content.text("prosthetic left hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("prosthetic hands", "bodypart_accusative"),
        heading = ccb.content.text("l. prosthetic hand"),
        plural_heading = ccb.content.text("prosthetic hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your prosthetic fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 84,
        limb = false,
        bmi_encumbrance_threshold = 0,
        main_part = "arm_prosthetic_l",
        opposite = "hand_prosthetic_r",
        side = "left",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("hand_wrist_l")
    part:sub_part("hand_palm_l")
    part:sub_part("hand_back_l")
    part:sub_part("hand_fingers_l")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("hand")
    part:limb_score("grip", 0.2)
    part:limb_score("manip", 0)
    part:limb_score("swim", 0.07)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "hand_neuroprosthetic_r",
        name = ccb.content.text("neuroprosthetic right hand"),
        plural_name = ccb.content.text("prosthetic hands"),
        accusative = ccb.content.text("neuroprosthetic right hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("neuroprosthetic hands", "bodypart_accusative"),
        heading = ccb.content.text("r. neuroprosthetic hand"),
        plural_heading = ccb.content.text("neuroprosthetic hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your neuroprosthetic fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 84,
        limb = false,
        bmi_encumbrance_threshold = 0,
        main_part = "arm_prosthetic_r",
        opposite = "hand_neuroprosthetic_l",
        side = "right",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("hand_wrist_r")
    part:sub_part("hand_palm_r")
    part:sub_part("hand_back_r")
    part:sub_part("hand_fingers_r")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("hand")
    part:limb_score("grip", 0.5)
    part:limb_score("manip", 0.7)
    part:limb_score("swim", 0.12)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "hand_neuroprosthetic_l",
        name = ccb.content.text("neuroprosthetic left hand"),
        plural_name = ccb.content.text("prosthetic hands"),
        accusative = ccb.content.text("neuroprosthetic left hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("neuroprosthetic hands", "bodypart_accusative"),
        heading = ccb.content.text("l. neuroprosthetic hand"),
        plural_heading = ccb.content.text("neuroprosthetic hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your neuroprosthetic fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 84,
        limb = false,
        bmi_encumbrance_threshold = 0,
        main_part = "arm_prosthetic_l",
        opposite = "hand_neuroprosthetic_r",
        side = "left",
        health_scaling = { strength = 0, dexterity = 0, intelligence = 0, perception = 0 },
    }
    part:sub_part("hand_wrist_l")
    part:sub_part("hand_palm_l")
    part:sub_part("hand_back_l")
    part:sub_part("hand_fingers_l")
    part:flag("HEAL_OVERRIDE")
    part:limb_type("hand")
    part:limb_score("grip", 0.5)
    part:limb_score("manip", 0.7)
    part:limb_score("swim", 0.12)
    content.replace(part)
end

do
    local part = content.BodyPart {
        id = "leg_bionic_treads",
        name = ccb.content.text("tank treads"),
        plural_name = "",
        accusative = ccb.content.text("bionic treads", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("tank treads"),
        plural_heading = ccb.content.text("tank treads"),
        encumbrance_text = ccb.content.text("Servomotors are operating at abnormal load."),
        hp_bar_text = ccb.content.text("TREADS"),
        smash_message = ccb.content.text("You ram the %s with the shell of your tank treads."),
        hit_size = 36,
        hit_difficulty = 1.2,
        base_health = 250,
        drench_capacity = 700,
        limb = false,
        mend_rate = 0,
        ugliness_mandatory = 10,
        no_power_effect = "no_power_tank_treads",
        hot_morale = 2,
        cold_morale = 2,
        feels_discomfort = false,
        bionic_slots = 58,
        encumbrance_threshold = 20,
        power_efficiency = 500,
        connected_to = "torso",
        health_scaling = { strength = 0 },
        fire_warmth_c = 0.3,
    }
    part:sub_part("bionic_treads_body")
    part:sub_part("bionic_treads_treads")
    part:flag("LIMB_LOWER")
    part:flag("BIONIC_LIMB")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("IGNORE_TEMP")
    part:limb_type("leg", 0.8)
    part:limb_type("foot", 0.5)
    part:limb_score("move_speed", 1.5)
    part:limb_score("crawl", 1.0)
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
