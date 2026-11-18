local ccb = require("ccb")
local content = ccb.content

do
    local part = content.BodyPart {
        id = "eyes_goblin",
        name = ccb.content.text("goblin eyes"),
        plural_name = "",
        accusative = ccb.content.text("goblin eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        drench_capacity = 100,
        limb = false,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_goblin_left")
    part:sub_part("eyes_goblin_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:flag("MYOPIC_IN_LIGHT")
    part:limb_type("sensor")
    part:limb_score("vision", 1.0)
    part:limb_score("night_vis", 8)
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
        id = "wing_ravenfolk_l",
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
        drench_capacity = 400,
        mend_rate = 0.75,
        hot_morale = 1.0,
        cold_morale = 0.2,
        squeamish_penalty = 20,
        encumbrance_limit = 5,
        health_limit = 15,
        connected_to = "torso",
        opposite = "wing_ravenfolk_r",
        side = "left",
        similar_body_part = "wing_l",
    }
    part:sub_part("wing_ravenfolk_shoulder_l")
    part:sub_part("wing_ravenfolk_upper_l")
    part:sub_part("wing_ravenfolk_joint_l")
    part:sub_part("wing_ravenfolk_lower_l")
    part:conditional_flag("WING_ARMS")
    part:conditional_flag("LIMB_UPPER")
    part:technique("tech_wing_slap")
    part:limb_type("wing")
    part:limb_score("reaction", 0.1)
    part:unarmed_damage("bash", 0)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "wing_ravenfolk_r",
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
        drench_capacity = 400,
        mend_rate = 0.75,
        hot_morale = 1.0,
        cold_morale = 0.2,
        squeamish_penalty = 20,
        encumbrance_limit = 5,
        health_limit = 15,
        connected_to = "torso",
        opposite = "wing_ravenfolk_l",
        side = "right",
        similar_body_part = "wing_r",
    }
    part:sub_part("wing_ravenfolk_shoulder_r")
    part:sub_part("wing_ravenfolk_upper_r")
    part:sub_part("wing_ravenfolk_joint_r")
    part:sub_part("wing_ravenfolk_lower_r")
    part:conditional_flag("WING_ARMS")
    part:conditional_flag("LIMB_UPPER")
    part:technique("tech_wing_slap")
    part:limb_type("wing")
    part:limb_score("reaction", 0.1)
    part:unarmed_damage("bash", 0)
    content.add(part)
end
