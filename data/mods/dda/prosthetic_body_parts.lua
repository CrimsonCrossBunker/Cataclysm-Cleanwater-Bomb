local ccb = require("ccb")
local content = ccb.content

-- Prosthetics moved to WIP Limb Stuff, but missing ids cause load-time errors
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
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
    content.add(part)
end
