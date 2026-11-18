local ccb = require("ccb")
local content = ccb.content

-- Head replacement.  Together with the eye replacement superhuman reaction score, raised but still suboptimal vision score (getting used to it), a large target.
-- Squeamish is because your head is mostly eye.  Yuck!!
-- encumbrance per weight increased 10% over human head
do
    local part = content.BodyPart {
        id = "head_dragonfly",
        name = ccb.content.text("dragonfly head"),
        plural_name = "",
        accusative = ccb.content.text("dragonfly head", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("d. head"),
        plural_heading = ccb.content.text("d. head"),
        encumbrance_text = ccb.content.text("Your vision is impaired!"),
        hp_bar_text = ccb.content.text("DRGFL HEAD"),
        hit_size = 7,
        hit_difficulty = 1.6,
        base_health = 50,
        drench_capacity = 700,
        limb = false,
        vital = true,
        ugliness = 10,
        ugliness_mandatory = 6,
        squeamish_penalty = 30,
        bionic_slots = 12,
        encumbrance_limit = 75,
    }
    part:sub_part("head_dragonfly_forehead")
    part:sub_part("head_dragonfly_crown")
    part:sub_part("head_dragonfly_nape")
    part:sub_part("head_dragonfly_throat")
    part:sub_part("head_dragonfly_ear_r")
    part:sub_part("head_dragonfly_ear_l")
    part:flag("SEESLEEP")
    part:flag("LIMB_UPPER")
    part:limb_type("head")
    part:limb_score("reaction", 0.9)
    part:limb_score("balance", 0.4)
    part:armor("cut", 3)
    part:weight_encumbrance(1, 1)
    part:weight_encumbrance(330000, 4)
    part:weight_encumbrance(880000, 9)
    part:weight_encumbrance(1400000, 22)
    part:weight_encumbrance(1750000, 33)
    part:weight_encumbrance(2400000, 55)
    part:weight_encumbrance(6100000, 88)
    part:weight_encumbrance(11000000, 176)
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "head_slime",
        name = ccb.content.text("pseudopod"),
        plural_name = "",
        accusative = ccb.content.text("pseudopod", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = ccb.content.text("Dodging and blocking are hampered."),
        hp_bar_text = ccb.content.text("HEAD"),
        smash_message = ccb.content.text("You smash the %s with a firm headbutt."),
        hit_size = 4,
        hit_difficulty = 1.2,
        drench_capacity = 3000,
        limb = false,
        smash_efficiency = 0.25,
        hot_morale = 2.0,
        cold_morale = 2.0,
        feels_discomfort = false,
        encumbrance_threshold = 10,
        similar_body_part = "head",
    }
    part:sub_part("head_slime_forehead")
    part:sub_part("head_slime_crown")
    part:sub_part("head_slime_nape")
    part:sub_part("head_slime_throat")
    part:sub_part("head_slime_ear_r")
    part:sub_part("head_slime_ear_l")
    part:flag("LIMB_UPPER")
    part:technique("tech_base_headbutt")
    part:limb_type("head")
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "eyes_bulging",
        name = ccb.content.text("bulging eyes"),
        plural_name = "",
        accusative = ccb.content.text("bulging eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "eyes_fey",
        name = ccb.content.text("iridescent eyes"),
        plural_name = "",
        accusative = ccb.content.text("iridescent eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
        encumbrance_text = ccb.content.text("Your vision is impaired!"),
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
    part:sub_part("eyes_fey_left")
    part:sub_part("eyes_fey_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 1.1)
    part:limb_score("night_vis", 2.5)
    part:limb_score("reaction", 0.75)
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
        id = "eyes_fey_full",
        name = ccb.content.text("iridescent eyes"),
        plural_name = "",
        accusative = ccb.content.text("iridescent eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
        encumbrance_text = ccb.content.text("Your vision is impaired!"),
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
    part:sub_part("eyes_fey_full_left")
    part:sub_part("eyes_fey_full_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 1.4)
    part:limb_score("night_vis", 4.5)
    part:limb_score("reaction", 0.85)
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
        id = "eyes_feline",
        name = ccb.content.text("feline eyes"),
        plural_name = "",
        accusative = ccb.content.text("feline eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
        encumbrance_text = ccb.content.text("Your vision is impaired!"),
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
    part:sub_part("eyes_feline_left")
    part:sub_part("eyes_feline_right")
    part:flag("IGNORE_TEMP")
    part:flag("HIGH_GLARE")
    part:flag("HYPEROPIC")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 0.8)
    part:limb_score("night_vis", 3.0)
    part:limb_score("reaction", 1.25)
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
        id = "eyes_snail",
        name = ccb.content.text("eyestalks"),
        plural_name = "",
        accusative = ccb.content.text("eyestalks", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyestalks"),
        plural_heading = ccb.content.text("eyestalks"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 1.5,
        hit_difficulty = 1.5,
        drench_capacity = 100,
        limb = false,
        ugliness = 3,
        ugliness_mandatory = 2,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_snail_left")
    part:sub_part("eyes_snail_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 1.1)
    part:limb_score("night_vis", 1.0)
    part:limb_score("reaction", 0.8)
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
        id = "eyes_snail_good",
        name = ccb.content.text("eyestalks"),
        plural_name = "",
        accusative = ccb.content.text("eyestalks", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyestalks"),
        plural_heading = ccb.content.text("eyestalks"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 1.5,
        hit_difficulty = 1.5,
        drench_capacity = 100,
        limb = false,
        ugliness = 3,
        ugliness_mandatory = 2,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_snail_good_left")
    part:sub_part("eyes_snail_good_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 1.25)
    part:limb_score("night_vis", 1.0)
    part:limb_score("reaction", 1.0)
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

-- Reduced hit size and difficulty to represent moving them out of the way of attacks
do
    local part = content.BodyPart {
        id = "eyes_crab",
        name = ccb.content.text("eyestalks"),
        plural_name = "",
        accusative = ccb.content.text("eyestalks", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyestalks"),
        plural_heading = ccb.content.text("eyestalks"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_difficulty = 1.15,
        drench_capacity = 100,
        limb = false,
        ugliness = 3,
        ugliness_mandatory = 2,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_crab_left")
    part:sub_part("eyes_crab_right")
    part:flag("EYE_MEMBRANE")
    part:limb_type("sensor")
    part:limb_score("vision", 1.2)
    part:limb_score("night_vis", 1.0)
    part:limb_score("reaction", 0.8)
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
        id = "eyes_frog",
        name = ccb.content.text("eyes"),
        plural_name = "",
        accusative = ccb.content.text("eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
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
    part:sub_part("eyes_frog_left")
    part:sub_part("eyes_frog_right")
    part:flag("IGNORE_TEMP")
    part:flag("EYE_MEMBRANE")
    part:flag("SEESLEEP")
    part:flag("MYOPIC_IN_LIGHT")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 1.0)
    part:limb_score("night_vis", 1.1)
    part:limb_score("reaction", 1.0)
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

-- Same size as bulging, plus high glare and eye membrane
do
    local part = content.BodyPart {
        id = "eyes_ceph",
        name = ccb.content.text("cephalopod eyes"),
        plural_name = "",
        accusative = ccb.content.text("cephalopod eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.9,
        hit_difficulty = 1.25,
        drench_capacity = 100,
        limb = false,
        wet_morale = 5,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_ceph_left")
    part:sub_part("eyes_ceph_right")
    part:flag("IGNORE_TEMP")
    part:flag("HIGH_GLARE")
    part:flag("LIMB_UPPER")
    part:flag("EYE_MEMBRANE")
    part:limb_type("sensor")
    part:limb_score("vision", 0.7)
    part:limb_score("night_vis", 5.0)
    part:limb_score("reaction", 0.8)
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
        id = "eyes_ursine",
        name = ccb.content.text("ursine eyes"),
        plural_name = "",
        accusative = ccb.content.text("ursine eyes", "bodypart_accusative"),
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
    part:sub_part("eyes_ursine_left")
    part:sub_part("eyes_ursine_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:flag("MYOPIC_IN_LIGHT")
    part:limb_type("sensor")
    part:limb_score("vision", 1.0)
    part:limb_score("night_vis", 2.75)
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
        id = "eyes_avian",
        name = ccb.content.text("avian eyes"),
        plural_name = "",
        accusative = ccb.content.text("avian eyes", "bodypart_accusative"),
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
    part:sub_part("eyes_avian_left")
    part:sub_part("eyes_avian_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 2.5)
    part:limb_score("night_vis", 1.0)
    part:limb_score("reaction", 1.0)
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
        id = "eyes_compound",
        name = ccb.content.text("compound eyes"),
        plural_name = "",
        accusative = ccb.content.text("compound eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes"),
        plural_heading = ccb.content.text("eyes"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 7,
        hit_difficulty = 1.15,
        drench_capacity = 5,
        limb = false,
        drying_rate = 0.4,
        ugliness = 8,
        smash_efficiency = 0.25,
        squeamish_penalty = 8,
        bionic_slots = 4,
        encumbrance_limit = 60,
        main_part = "head",
    }
    part:sub_part("eyes_compound_left")
    part:sub_part("eyes_compound_right")
    part:flag("IGNORE_TEMP")
    part:flag("SEESLEEP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 0.65)
    part:limb_score("night_vis", 0.8)
    part:limb_score("reaction", 1.0)
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
        id = "eyes_slime",
        name = ccb.content.text("eyes?"),
        plural_name = "",
        accusative = ccb.content.text("eyes?", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("eyes?"),
        plural_heading = ccb.content.text("eyes?"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        drench_capacity = 500,
        limb = false,
        smash_efficiency = 0.25,
        feels_discomfort = false,
        encumbrance_limit = 1000,
        main_part = "head_slime",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_slime_left")
    part:sub_part("eyes_slime_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    content.add(part)
end

-- Used as a default for similar_bodypart to work for armor.
do
    local part = content.BodyPart {
        id = "muzzle",
        name = ccb.content.text("default muzzle"),
        plural_name = ccb.content.text("default muzzle"),
        accusative = ccb.content.text("default muzzle", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("default muzzle"),
        plural_heading = ccb.content.text("muzzles"),
        encumbrance_text = ccb.content.text("Your default muzzle feels heavy"),
        hp_bar_text = ccb.content.text("DFLT MUZZLE"),
        hit_difficulty = 0.8,
        base_health = 20,
        drench_capacity = 4,
        limb = false,
        connected_to = "head",
    }
    part:sub_part("muzzle_lips")
    part:sub_part("muzzle_nose")
    part:sub_part("muzzle_cheeks")
    part:sub_part("muzzle_chin")
    part:limb_type("mouth")
    part:limb_score("balance", 0.0)
    content.add(part)
end

-- We'll assume that if you've mutated far enough to have a bear mouth, biting is a primary attack for you
do
    local part = content.BodyPart {
        id = "muzzle_bear",
        name = ccb.content.text("muzzle", "bodypart_name"),
        plural_name = "",
        accusative = ccb.content.text("muzzle", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("muzzle", "bodypart_heading"),
        plural_heading = ccb.content.text("muzzles"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.65,
        hit_difficulty = 1.15,
        base_health = 75,
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
        similar_body_part = "muzzle",
    }
    part:sub_part("muzzle_bear_lips")
    part:sub_part("muzzle_bear_nose")
    part:sub_part("muzzle_bear_cheeks")
    part:sub_part("muzzle_bear_chin")
    part:flag("LIMB_UPPER")
    part:technique("TECH_BEAR_BITE")
    part:limb_type("mouth")
    part:limb_score("breathing", 0.9)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 1.0)
    part:limb_score("consume_solid", 1.5)
    part:unarmed_damage("bash", 3)
    part:unarmed_damage("stab", 13)
    content.add(part)
end

-- We'll assume that if you've mutated far enough to have a lupine mouth, biting is a primary attack for you
do
    local part = content.BodyPart {
        id = "muzzle_lupine",
        name = ccb.content.text("muzzle", "bodypart_name"),
        plural_name = "",
        accusative = ccb.content.text("muzzle", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("muzzle", "bodypart_heading"),
        plural_heading = ccb.content.text("muzzles"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.6,
        hit_difficulty = 1.15,
        base_health = 65,
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
        similar_body_part = "muzzle",
    }
    part:sub_part("muzzle_lupine_lips")
    part:sub_part("muzzle_lupine_nose")
    part:sub_part("muzzle_lupine_cheeks")
    part:sub_part("muzzle_lupine_chin")
    part:flag("LIMB_UPPER")
    part:technique("TECH_LUPINE_BITE")
    part:limb_type("mouth")
    part:limb_score("breathing", 1.0)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 1.1)
    part:limb_score("consume_solid", 1.2)
    part:unarmed_damage("bash", 3)
    part:unarmed_damage("stab", 8)
    content.add(part)
end

-- We'll assume that if you've mutated far enough to have a reptilian mouth, biting is a primary attack for you
do
    local part = content.BodyPart {
        id = "muzzle_long",
        name = ccb.content.text("muzzle", "bodypart_name"),
        plural_name = "",
        accusative = ccb.content.text("muzzle", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("muzzle", "bodypart_heading"),
        plural_heading = ccb.content.text("muzzles"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.65,
        hit_difficulty = 1.15,
        base_health = 75,
        drench_capacity = 100,
        limb = false,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 9,
        bionic_slots = 3,
        bmi_encumbrance_threshold = 10,
        bmi_encumbrance_scalar = 0.75,
        main_part = "head",
        similar_body_part = "muzzle",
    }
    part:sub_part("muzzle_long_lips")
    part:sub_part("muzzle_long_nostrils")
    part:sub_part("muzzle_long_cheeks")
    part:sub_part("muzzle_long_chin")
    part:flag("LIMB_UPPER")
    part:technique("TECH_REPTILE_BITE")
    part:limb_type("mouth")
    part:limb_score("breathing", 0.8)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 1.3)
    part:limb_score("consume_solid", 2.0)
    part:unarmed_damage("bash", 3)
    part:unarmed_damage("stab", 16)
    content.add(part)
end

-- We'll assume that if you've mutated far enough to have a reptilian mouth, biting is a primary attack for you
do
    local part = content.BodyPart {
        id = "muzzle_rodent",
        name = ccb.content.text("muzzle", "bodypart_name"),
        plural_name = "",
        accusative = ccb.content.text("muzzle", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("muzzle", "bodypart_heading"),
        plural_heading = ccb.content.text("muzzles"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.65,
        hit_difficulty = 1.15,
        base_health = 75,
        drench_capacity = 100,
        limb = false,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 9,
        bionic_slots = 3,
        bmi_encumbrance_threshold = 10,
        bmi_encumbrance_scalar = 0.75,
        main_part = "head",
        similar_body_part = "muzzle",
    }
    part:sub_part("muzzle_rodent_lips")
    part:sub_part("muzzle_rodent_nose")
    part:sub_part("muzzle_rodent_cheeks")
    part:sub_part("muzzle_rodent_chin")
    part:flag("LIMB_UPPER")
    part:technique("TECH_RODENT_BITE")
    part:limb_type("mouth")
    part:limb_score("breathing", 0.95)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 1.1)
    part:limb_score("consume_solid", 1.25)
    part:unarmed_damage("bash", 3)
    part:unarmed_damage("stab", 10)
    content.add(part)
end

-- Biting is not a primary attack for rabbits but they'll do it if they have to
do
    local part = content.BodyPart {
        id = "muzzle_rabbit",
        name = ccb.content.text("muzzle", "bodypart_name"),
        plural_name = "",
        accusative = ccb.content.text("muzzle", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("muzzle", "bodypart_heading"),
        plural_heading = ccb.content.text("muzzles"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
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
        similar_body_part = "mouth",
    }
    part:sub_part("muzzle_rabbit_lips")
    part:sub_part("muzzle_rabbit_nose")
    part:sub_part("muzzle_rabbit_cheeks")
    part:sub_part("muzzle_rabbit_chin")
    part:flag("LIMB_UPPER")
    part:technique("TECH_RABBIT_BITE")
    part:technique("TECH_RABBIT_BITE_GRABBED")
    part:limb_type("mouth")
    part:limb_score("breathing", 1.0)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 1.0)
    part:limb_score("consume_solid", 1.0)
    part:unarmed_damage("bash", 2)
    part:unarmed_damage("stab", 8)
    content.add(part)
end

-- Used as a default for similar_bodypart to work for armor.
do
    local part = content.BodyPart {
        id = "beak",
        name = ccb.content.text("default beak"),
        plural_name = ccb.content.text("default beak"),
        accusative = ccb.content.text("default beak", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("default beak"),
        plural_heading = ccb.content.text("beaks"),
        encumbrance_text = ccb.content.text("Your default beak feels heavy"),
        hp_bar_text = ccb.content.text("DFLT BEAK"),
        hit_difficulty = 0.8,
        base_health = 20,
        drench_capacity = 4,
        limb = false,
        connected_to = "head",
    }
    part:sub_part("beak_nares")
    part:sub_part("beak_top")
    part:sub_part("beak_tip")
    part:sub_part("beak_bottom")
    part:limb_type("mouth")
    part:limb_score("balance", 0.0)
    content.add(part)
end

-- Pecking is not a primary attack for birds but they'll do it if they have to
do
    local part = content.BodyPart {
        id = "beak_bird",
        name = ccb.content.text("beak"),
        plural_name = "",
        accusative = ccb.content.text("beak", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("beak"),
        plural_heading = ccb.content.text("beaks"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
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
        similar_body_part = "beak",
    }
    part:sub_part("beak_bird_nares")
    part:sub_part("beak_bird_top")
    part:sub_part("beak_bird_tip")
    part:sub_part("beak_bird_bottom")
    part:flag("LIMB_UPPER")
    part:technique("TECH_BIRD_PECK")
    part:technique("TECH_BIRD_PECK_IF_WINGS")
    part:technique("TECH_BIRD_PECK_GRABBED")
    part:limb_type("mouth")
    part:limb_score("breathing", 1.0)
    part:limb_score("manip", 0.03, 0.15)
    part:limb_score("consume_liquid", 1.0)
    part:limb_score("consume_solid", 1.0)
    part:unarmed_damage("stab", 8)
    content.add(part)
end

-- Pecking is not a primary attack for birds but they'll do it if they have to
do
    local part = content.BodyPart {
        id = "beak_woodpecker",
        name = ccb.content.text("beak"),
        plural_name = "",
        accusative = ccb.content.text("beak", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("beak"),
        plural_heading = ccb.content.text("beaks"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
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
        similar_body_part = "beak",
    }
    part:sub_part("beak_woodpecker_nares")
    part:sub_part("beak_woodpecker_top")
    part:sub_part("beak_woodpecker_tip")
    part:sub_part("beak_woodpecker_bottom")
    part:flag("LIMB_UPPER")
    part:technique("TECH_BIRD_WOODPECKER_PECK")
    part:technique("TECH_BIRD_WOODPECKER_PECK_IF_WINGS")
    part:technique("TECH_BIRD_WOODPECKER_PECK_GRABBED")
    part:limb_type("mouth")
    part:limb_score("breathing", 1.0)
    part:limb_score("manip", 0.03, 0.15)
    part:limb_score("consume_liquid", 1.0)
    part:limb_score("consume_solid", 1.0)
    part:unarmed_damage("stab", 12)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "beak_hummingbird",
        name = ccb.content.text("beak"),
        plural_name = "",
        accusative = ccb.content.text("beak", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("beak"),
        plural_heading = ccb.content.text("beaks"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
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
        similar_body_part = "beak",
    }
    part:sub_part("beak_hummingbird_nares")
    part:sub_part("beak_hummingbird_top")
    part:sub_part("beak_hummingbird_tip")
    part:sub_part("beak_hummingbird_bottom")
    part:flag("LIMB_UPPER")
    part:limb_type("mouth")
    part:limb_score("breathing", 1.0)
    part:limb_score("manip", 0.03, 0.15)
    part:limb_score("consume_liquid", 3.0)
    part:limb_score("consume_solid", 0.66)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "gastropod_tongue",
        name = ccb.content.text("mouth"),
        plural_name = "",
        accusative = ccb.content.text("mouth", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("mouth"),
        plural_heading = ccb.content.text("mouth"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        drench_capacity = 700,
        limb = false,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 6,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 10,
        bmi_encumbrance_scalar = 0.75,
        main_part = "head",
        similar_body_part = "mouth",
    }
    part:sub_part("gastropod_tongue_lips")
    part:sub_part("gastropod_tongue_nose")
    part:sub_part("gastropod_tongue_cheeks")
    part:sub_part("gastropod_tongue_chin")
    part:flag("LIMB_UPPER")
    part:technique("TECH_GASTROPOD_TONGUE")
    part:limb_type("mouth")
    part:limb_score("breathing", 0.9)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 0.9)
    part:limb_score("consume_solid", 0.9)
    part:unarmed_damage("stab", 15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "insect_proboscis",
        name = ccb.content.text("proboscis"),
        plural_name = "",
        accusative = ccb.content.text("proboscis", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("proboscis"),
        plural_heading = ccb.content.text("proboscises"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        drench_capacity = 900,
        limb = false,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 3,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 10,
        bmi_encumbrance_scalar = 0.75,
        main_part = "head",
    }
    part:sub_part("insect_proboscis_base")
    part:sub_part("insect_proboscis_labium")
    part:sub_part("insect_proboscis_cheeks")
    part:sub_part("insect_proboscis_bottom")
    part:flag("LIMB_UPPER")
    part:limb_type("mouth")
    part:limb_score("breathing", 0.7)
    part:limb_score("manip", 0.05, 0.2)
    part:limb_score("consume_liquid", 3.0)
    part:limb_score("consume_solid", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "mouth_slime",
        name = ccb.content.text("mouth?"),
        plural_name = "",
        accusative = ccb.content.text("mouth?", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("mouth?"),
        plural_heading = ccb.content.text("mouth?"),
        encumbrance_text = "",
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        drench_capacity = 500,
        limb = false,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 10,
        bmi_encumbrance_scalar = 0.75,
        main_part = "head_slime",
        similar_body_part = "mouth",
    }
    part:sub_part("mouth_slime_lips")
    part:sub_part("mouth_slime_nose")
    part:sub_part("mouth_slime_cheeks")
    part:sub_part("mouth_slime_chin")
    part:flag("LIMB_UPPER")
    part:limb_type("mouth")
    content.add(part)
end

-- The core contains all your limb scores
do
    local part = content.BodyPart {
        id = "torso_slime",
        name = ccb.content.text("core"),
        plural_name = "",
        accusative = ccb.content.text("core", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("core"),
        plural_heading = ccb.content.text("core"),
        encumbrance_text = ccb.content.text("Dodging and melee is hampered."),
        hp_bar_text = ccb.content.text("CORE"),
        smash_message = ccb.content.text("You smash the %s with a powerful slime-check."),
        hit_size = 36,
        drench_capacity = 8000,
        limb = false,
        vital = true,
        winded_effect = "winded",
        hot_morale = 2,
        cold_morale = 2,
        feels_discomfort = false,
        encumbrance_threshold = 150,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.8,
        connected_to = "head_slime",
        similar_body_part = "torso",
        fire_warmth_c = 0.3,
    }
    part:sub_part("torso_slime_upper")
    part:sub_part("torso_slime_neck")
    part:sub_part("torso_slime_lower")
    part:sub_part("torso_slime_hanging_front")
    part:sub_part("torso_slime_hanging_back")
    part:sub_part("torso_slime_waist")
    part:limb_type("torso")
    part:limb_type("sensor")
    part:limb_type("mouth")
    part:limb_score("vision", 1.0)
    part:limb_score("night_vis", 1.0)
    part:limb_score("reaction", 1.0)
    part:limb_score("balance", 1.0)
    part:limb_score("breathing", 1.0)
    part:limb_score("manip", 1.65, 2.4)
    part:limb_score("grip", 1.0)
    part:limb_score("consume_liquid", 1.0)
    part:limb_score("consume_solid", 1.0)
    part:limb_score("lift", 1.0)
    part:limb_score("block", 4.0)
    part:limb_score("swim", 1.0)
    part:limb_score("crawl", 1.0)
    part:limb_score("move_speed", 1.0)
    part:limb_score("footing", 1.0)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 3,
        scale_increment = 2,
        duration = 60,
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "crustacean_pincer_r",
        name = ccb.content.text("crustacean pincer"),
        plural_name = ccb.content.text("crustacean pincers"),
        accusative = ccb.content.text("crustacean pincer", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pincers", "bodypart_accusative"),
        heading = ccb.content.text("pincer"),
        plural_heading = ccb.content.text("pincers"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your pincer."),
        hit_size = 3,
        hit_difficulty = 1.4,
        base_health = 90,
        drench_capacity = 300,
        limb = false,
        environmental_protection = 3,
        smash_efficiency = 2,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_r",
        side = "right",
        fire_warmth_c = 3,
    }
    part:sub_part("crustacean_pincer_wrist_r")
    part:sub_part("crustacean_pincer_claws_r")
    part:flag("NONSTANDARD_BLOCK")
    part:technique("TECH_CRAB_PUNCH")
    part:technique("BRUTAL")
    part:technique("WBLOCK_2")
    part:limb_type("hand")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0.1, 0.5)
    part:limb_score("swim", 0)
    part:quality("BUTCHER", -4, 0.5)
    part:quality("PRY", 1, 0.5)
    part:quality("HAMMER", 1, 0.5)
    part:unarmed_damage("bash", 12)
    part:unarmed_damage("cut", 3)
    content.add(part)
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
        ugliness = 2,
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
        similar_body_part = "arm_l",
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
    content.add(part)
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
        ugliness = 2,
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
        similar_body_part = "arm_r",
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
    content.add(part)
end

-- Shoulder is similar enough to substitute, the rest is too divergent for armor substitution.  Slightly better balance, terrible manipulation, better swim.  Temperature gets taken care of via feathers, unless you're a naked chicken.  No fat deposits.  Copy-from for onhit effects.
-- Similar to itself to prevent copy-from problems
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
        drench_capacity = 400,
        mend_rate = 1.2,
        drench_increment = 1,
        drying_rate = 0.5,
        wet_morale = -20,
        ugliness = 2,
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
        health_limit = 35,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_wing_bird_r",
        side = "left",
        similar_body_part = "arm_wing_bird_l",
        health_scaling = { strength = 2 },
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_wing_bird_shoulder_l")
    part:sub_part("arm_wing_bird_upper_l")
    part:sub_part("arm_wing_bird_elbow_l")
    part:sub_part("arm_wing_bird_lower_l")
    part:sub_part("arm_wing_bird_fingers_l")
    part:conditional_flag("WING_ARMS")
    part:conditional_flag("WINGS_2")
    part:technique("TECH_WING_SLAP")
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
    content.add(part)
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
        drench_capacity = 400,
        mend_rate = 1.2,
        drench_increment = 1,
        drying_rate = 0.5,
        wet_morale = -20,
        ugliness = 2,
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
        health_limit = 35,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_wing_bird_l",
        side = "right",
        similar_body_part = "arm_wing_bird_r",
        health_scaling = { strength = 2 },
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_wing_bird_shoulder_r")
    part:sub_part("arm_wing_bird_upper_r")
    part:sub_part("arm_wing_bird_elbow_r")
    part:sub_part("arm_wing_bird_lower_r")
    part:sub_part("arm_wing_bird_fingers_r")
    part:conditional_flag("WING_ARMS")
    part:conditional_flag("WINGS_2")
    part:technique("TECH_WING_SLAP")
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
    content.add(part)
end

-- Slightly larger and clumsier, same strength
do
    local part = content.BodyPart {
        id = "arm_leathery_l",
        name = ccb.content.text("leathery arm"),
        plural_name = ccb.content.text("leathery arms"),
        accusative = ccb.content.text("leathery arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("leathery arms", "bodypart_accusative"),
        heading = ccb.content.text("l. arm"),
        plural_heading = ccb.content.text("arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 16,
        hit_difficulty = 0.9,
        drench_capacity = 15,
        ugliness = 2,
        winded_effect = "winded_arm",
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 20,
        encumbrance_threshold = 2,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_leathery_r",
        side = "left",
        similar_body_part = "arm_l",
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_leathery_shoulder_l")
    part:sub_part("arm_leathery_upper_l")
    part:sub_part("arm_leathery_elbow_l")
    part:sub_part("arm_leathery_lower_l")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.1)
    part:limb_score("block", 0.7)
    part:limb_score("swim", 0.1)
    part:armor("cut", 2)
    part:armor("stab", 2)
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
        id = "arm_leathery_r",
        name = ccb.content.text("leathery arm"),
        plural_name = ccb.content.text("leathery arms"),
        accusative = ccb.content.text("leathery arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("leathery arms", "bodypart_accusative"),
        heading = ccb.content.text("r. arm"),
        plural_heading = ccb.content.text("arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 16,
        hit_difficulty = 0.9,
        drench_capacity = 15,
        ugliness = 2,
        winded_effect = "winded_arm",
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 20,
        encumbrance_threshold = 2,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_leathery_l",
        side = "right",
        similar_body_part = "arm_r",
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_leathery_shoulder_r")
    part:sub_part("arm_leathery_upper_r")
    part:sub_part("arm_leathery_elbow_r")
    part:sub_part("arm_leathery_lower_r")
    part:limb_type("arm")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.5)
    part:limb_score("balance", 0.1)
    part:limb_score("block", 0.7)
    part:limb_score("swim", 0.1)
    part:armor("cut", 2)
    part:armor("stab", 2)
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

-- Same size as bird wings, slightly more dextrous, no armor and temp malus.
do
    local part = content.BodyPart {
        id = "arm_wing_bat_l",
        name = ccb.content.text("left wing"),
        plural_name = ccb.content.text("bat wings"),
        accusative = ccb.content.text("left wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bat wings", "bodypart_accusative"),
        heading = ccb.content.text("l. wing"),
        plural_heading = ccb.content.text("wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered, and you won't be able to use your wings to glide."),
        hp_bar_text = ccb.content.text("L WING"),
        smash_message = ccb.content.text("You smash the %s."),
        hit_size = 20,
        hit_difficulty = 1.2,
        base_health = 45,
        drench_capacity = 15,
        mend_rate = 1.2,
        drench_increment = 1,
        drying_rate = 0.5,
        wet_morale = -20,
        ugliness = 3,
        ugliness_mandatory = 2,
        environmental_protection = 2,
        winded_effect = "winded_arm",
        smash_efficiency = 0.3,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 20,
        encumbrance_threshold = 5,
        encumbrance_limit = 10,
        health_limit = 35,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_wing_bat_r",
        side = "left",
        similar_body_part = "arm_wing_bird_l",
        health_scaling = { strength = 2 },
        fire_warmth_c = 1.6,
        minimum_temperature_c = -0.6,
        maximum_temperature_c = -0.2,
    }
    part:sub_part("arm_wing_bat_shoulder_l")
    part:sub_part("arm_wing_bat_upper_l")
    part:sub_part("arm_wing_bat_elbow_l")
    part:sub_part("arm_wing_bat_lower_l")
    part:sub_part("arm_wing_bat_fingers_l")
    part:conditional_flag("WING_ARMS")
    part:conditional_flag("WINGS_2")
    part:technique("TECH_WING_SLAP")
    part:limb_type("arm", 0.8)
    part:limb_type("hand", 0.3)
    part:limb_score("manip", 0.2, 0.4)
    part:limb_score("grip", 0.2)
    part:limb_score("lift", 0.3)
    part:limb_score("balance", 0.1)
    part:limb_score("block", 0.4)
    part:limb_score("swim", 0.3)
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "arm_wing_bat_r",
        name = ccb.content.text("right wing"),
        plural_name = ccb.content.text("bat wings"),
        accusative = ccb.content.text("right wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("bat wings", "bodypart_accusative"),
        heading = ccb.content.text("r. wing"),
        plural_heading = ccb.content.text("wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered, and you won't be able to use your wings to glide."),
        hp_bar_text = ccb.content.text("L WING"),
        smash_message = ccb.content.text("You smash the %s."),
        hit_size = 20,
        hit_difficulty = 1.2,
        base_health = 45,
        drench_capacity = 15,
        mend_rate = 1.2,
        drench_increment = 1,
        drying_rate = 0.5,
        wet_morale = -20,
        ugliness = 3,
        ugliness_mandatory = 2,
        environmental_protection = 2,
        winded_effect = "winded_arm",
        smash_efficiency = 0.3,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 20,
        encumbrance_threshold = 5,
        encumbrance_limit = 10,
        health_limit = 35,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso",
        opposite = "arm_wing_bat_l",
        side = "right",
        similar_body_part = "arm_wing_bird_l",
        health_scaling = { strength = 2 },
        fire_warmth_c = 1.6,
        minimum_temperature_c = -0.6,
        maximum_temperature_c = -0.2,
    }
    part:sub_part("arm_wing_bat_shoulder_r")
    part:sub_part("arm_wing_bat_upper_r")
    part:sub_part("arm_wing_bat_elbow_r")
    part:sub_part("arm_wing_bat_lower_r")
    part:sub_part("arm_wing_bat_fingers_r")
    part:conditional_flag("WING_ARMS")
    part:conditional_flag("WINGS_2")
    part:technique("TECH_WING_SLAP")
    part:limb_type("arm", 0.8)
    part:limb_type("hand", 0.3)
    part:limb_score("manip", 0.2, 0.4)
    part:limb_score("grip", 0.2)
    part:limb_score("lift", 0.3)
    part:limb_score("balance", 0.1)
    part:limb_score("block", 0.4)
    part:limb_score("swim", 0.3)
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
    content.add(part)
end

-- No control over it, so just gets in the way - negative manipulation/balance/swim score
do
    local part = content.BodyPart {
        id = "arm_insect_l",
        name = ccb.content.text("lower left arm"),
        plural_name = ccb.content.text("insect arms"),
        accusative = ccb.content.text("lower left arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("insect arms", "bodypart_accusative"),
        heading = ccb.content.text("l. insect arm"),
        plural_heading = ccb.content.text("insect arms"),
        encumbrance_text = ccb.content.text("They might finally hold still."),
        hp_bar_text = ccb.content.text("L I ARM"),
        hit_size = 9,
        hit_difficulty = 0.85,
        base_health = 20,
        drench_capacity = 12,
        mend_rate = 0.7,
        drench_increment = 1,
        drying_rate = 2,
        ugliness = 3,
        hot_morale = 0.1,
        cold_morale = 0.1,
        squeamish_penalty = 1,
        encumbrance_limit = 40,
        connected_to = "torso",
        opposite = "arm_insect_r",
        side = "left",
        health_scaling = { strength = 1 },
        fire_warmth_c = 0.6,
    }
    part:sub_part("arm_insect_upper_l")
    part:sub_part("arm_insect_elbow_l")
    part:sub_part("arm_insect_lower_l")
    part:flag("NONSTANDARD_BLOCK")
    part:limb_type("arm")
    part:limb_score("balance", -0.1)
    part:limb_score("manip", -0.1, 3)
    part:limb_score("swim", -0.2)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "arm_insect_r",
        name = ccb.content.text("lower right arm"),
        plural_name = ccb.content.text("insect arms"),
        accusative = ccb.content.text("lower right arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("insect arms", "bodypart_accusative"),
        heading = ccb.content.text("r. insect arm"),
        plural_heading = ccb.content.text("insect arms"),
        encumbrance_text = ccb.content.text("They might finally hold still."),
        hp_bar_text = ccb.content.text("R I ARM"),
        hit_size = 9,
        hit_difficulty = 0.85,
        base_health = 20,
        drench_capacity = 12,
        mend_rate = 0.7,
        drench_increment = 1,
        drying_rate = 2,
        ugliness = 3,
        hot_morale = 0.1,
        cold_morale = 0.1,
        squeamish_penalty = 1,
        encumbrance_limit = 40,
        connected_to = "torso",
        opposite = "arm_insect_l",
        side = "right",
        health_scaling = { strength = 1 },
        fire_warmth_c = 0.6,
    }
    part:sub_part("arm_insect_upper_r")
    part:sub_part("arm_insect_elbow_r")
    part:sub_part("arm_insect_lower_r")
    part:flag("NONSTANDARD_BLOCK")
    part:limb_type("arm")
    part:limb_score("balance", -0.1)
    part:limb_score("manip", -0.1, 3)
    part:limb_score("swim", -0.2)
    content.add(part)
end

-- No balance malus, 20% manipulation and 10% grip/lift/crawl/swim bonus.
do
    local part = content.BodyPart {
        id = "arm_insect_good_l",
        name = ccb.content.text("lower left arm"),
        plural_name = ccb.content.text("insect arms"),
        accusative = ccb.content.text("lower left arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("insect arms", "bodypart_accusative"),
        heading = ccb.content.text("l. insect arm"),
        plural_heading = ccb.content.text("insect arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L I ARM"),
        hit_size = 9,
        hit_difficulty = 0.85,
        base_health = 20,
        drench_capacity = 12,
        mend_rate = 0.7,
        drench_increment = 1,
        drying_rate = 2,
        ugliness = 3,
        hot_morale = 0.1,
        cold_morale = 0.1,
        squeamish_penalty = 1,
        encumbrance_threshold = 3,
        encumbrance_limit = 40,
        connected_to = "torso",
        opposite = "arm_insect_good_r",
        side = "left",
        health_scaling = { strength = 1 },
        fire_warmth_c = 0.6,
    }
    part:sub_part("arm_insect_good_upper_l")
    part:sub_part("arm_insect_good_elbow_l")
    part:sub_part("arm_insect_good_lower_l")
    part:flag("NONSTANDARD_BLOCK")
    part:limb_type("arm")
    part:limb_score("balance", 0)
    part:limb_score("manip", 0.1, 2)
    part:limb_score("lift", 0.1)
    part:limb_score("block", 0.5)
    part:limb_score("crawl", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "arm_insect_good_r",
        name = ccb.content.text("lower right arm"),
        plural_name = ccb.content.text("insect arms"),
        accusative = ccb.content.text("lower right arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("insect arms", "bodypart_accusative"),
        heading = ccb.content.text("r. insect arm"),
        plural_heading = ccb.content.text("insect arms"),
        encumbrance_text = ccb.content.text("They might finally hold still."),
        hp_bar_text = ccb.content.text("R I ARM"),
        hit_size = 9,
        hit_difficulty = 0.85,
        base_health = 20,
        drench_capacity = 12,
        mend_rate = 0.7,
        drench_increment = 1,
        drying_rate = 2,
        ugliness = 3,
        hot_morale = 0.1,
        cold_morale = 0.1,
        squeamish_penalty = 1,
        encumbrance_limit = 40,
        connected_to = "torso",
        opposite = "arm_insect_good_l",
        side = "right",
        health_scaling = { strength = 1 },
        fire_warmth_c = 0.6,
    }
    part:sub_part("arm_insect_good_upper_r")
    part:sub_part("arm_insect_good_elbow_r")
    part:sub_part("arm_insect_good_lower_r")
    part:flag("NONSTANDARD_BLOCK")
    part:limb_type("arm")
    part:limb_score("balance", 0)
    part:limb_score("manip", 0.1, 2)
    part:limb_score("lift", 0.1)
    part:limb_score("block", 0.5)
    part:limb_score("crawl", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "insect_hand_l",
        name = ccb.content.text("left tarsus"),
        plural_name = ccb.content.text("insect tarsuses"),
        accusative = ccb.content.text("insect tarsus", "bodypart_accusative"),
        plural_accusative = ccb.content.text("tarsuses", "bodypart_accusative"),
        heading = ccb.content.text("tarsus"),
        plural_heading = ccb.content.text("tarsuses"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your tarsus."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 90,
        drench_capacity = 300,
        limb = false,
        environmental_protection = 3,
        smash_efficiency = 2,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_insect_good_l",
        opposite = "insect_hand_r",
        side = "left",
        fire_warmth_c = 3,
    }
    part:sub_part("insect_tarsomere_l")
    part:sub_part("insect_segment_l")
    part:sub_part("insect_terminus_l")
    part:technique("TECH_CRAB_PUNCH")
    part:technique("BRUTAL")
    part:technique("WBLOCK_2")
    part:limb_type("hand")
    part:limb_score("grip", 0.05)
    part:limb_score("manip", 0.05, 0.25)
    part:limb_score("swim", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "insect_hand_r",
        name = ccb.content.text("right tarsus"),
        plural_name = ccb.content.text("insect tarsuses"),
        accusative = ccb.content.text("insect tarsus", "bodypart_accusative"),
        plural_accusative = ccb.content.text("tarsuses", "bodypart_accusative"),
        heading = ccb.content.text("tarsus"),
        plural_heading = ccb.content.text("tarsuses"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your tarsus."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        base_health = 90,
        drench_capacity = 300,
        limb = false,
        environmental_protection = 3,
        smash_efficiency = 2,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_insect_good_r",
        opposite = "insect_hand_l",
        side = "left",
        fire_warmth_c = 3,
    }
    part:sub_part("insect_tarsomere_r")
    part:sub_part("insect_segment_r")
    part:sub_part("insect_terminus_r")
    part:technique("TECH_CRAB_PUNCH")
    part:technique("BRUTAL")
    part:technique("WBLOCK_2")
    part:limb_type("hand")
    part:limb_score("grip", 0.05)
    part:limb_score("manip", 0.05, 0.25)
    part:limb_score("swim", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "arm_slime_l",
        name = ccb.content.text("pseudopod"),
        plural_name = ccb.content.text("pseudopods"),
        accusative = ccb.content.text("pseudopod", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pseudopods", "bodypart_accusative"),
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = "",
        hp_bar_text = ccb.content.text("PSPOD"),
        smash_message = ccb.content.text("You slime-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        drench_capacity = 1000,
        winded_effect = "winded_arm",
        hot_morale = 0.5,
        cold_morale = 0.5,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso_slime",
        opposite = "arm_slime_r",
        side = "left",
        similar_body_part = "arm_l",
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_slime_shoulder_l")
    part:sub_part("arm_slime_upper_l")
    part:sub_part("arm_slime_elbow_l")
    part:sub_part("arm_slime_lower_l")
    part:limb_type("arm")
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "arm_slime_r",
        name = ccb.content.text("pseudopod"),
        plural_name = ccb.content.text("pseudopods"),
        accusative = ccb.content.text("pseudopod", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pseudopods", "bodypart_accusative"),
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = "",
        hp_bar_text = ccb.content.text("PSPOD"),
        smash_message = ccb.content.text("You slime-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        drench_capacity = 1000,
        winded_effect = "winded_arm",
        hot_morale = 0.5,
        cold_morale = 0.5,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.6,
        connected_to = "torso_slime",
        opposite = "arm_slime_l",
        side = "right",
        similar_body_part = "arm_r",
        fire_warmth_c = 1.2,
    }
    part:sub_part("arm_slime_shoulder_r")
    part:sub_part("arm_slime_upper_r")
    part:sub_part("arm_slime_elbow_r")
    part:sub_part("arm_slime_lower_r")
    part:limb_type("arm")
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "hand_slime_complete_l",
        name = ccb.content.text("pseudopod tip"),
        plural_name = ccb.content.text("pseudopod tips"),
        accusative = ccb.content.text("pseudopod", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pseudopods", "bodypart_accusative"),
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = "",
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your pseudopod."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        drench_capacity = 1500,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_slime_l",
        opposite = "hand_slime_complete_r",
        side = "left",
        similar_body_part = "hand_l",
        fire_warmth_c = 0.01,
    }
    part:sub_part("hand_slime_complete_wrist_l")
    part:sub_part("hand_slime_complete_palm_l")
    part:sub_part("hand_slime_complete_back_l")
    part:sub_part("hand_slime_complete_fingers_l")
    part:technique("TECH_SLIME_COMPLETE_PUNCH")
    part:limb_type("hand")
    part:unarmed_damage("bash", -2)
    part:unarmed_damage("acid", 4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "hand_slime_complete_r",
        name = ccb.content.text("pseudopod tip"),
        plural_name = ccb.content.text("pseudopod tips"),
        accusative = ccb.content.text("pseudopod", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pseudopods", "bodypart_accusative"),
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = "",
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your pseudopod."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        drench_capacity = 1500,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_slime_r",
        opposite = "hand_slime_complete_l",
        side = "right",
        similar_body_part = "hand_r",
        fire_warmth_c = 0.01,
    }
    part:sub_part("hand_slime_complete_wrist_r")
    part:sub_part("hand_slime_complete_palm_r")
    part:sub_part("hand_slime_complete_back_r")
    part:sub_part("hand_slime_complete_fingers_r")
    part:technique("TECH_SLIME_COMPLETE_PUNCH")
    part:limb_type("hand")
    part:unarmed_damage("bash", -2)
    part:unarmed_damage("acid", 4)
    content.add(part)
end

-- Used as a default for similar_bodypart to work for armor.
do
    local part = content.BodyPart {
        id = "paw_default_l",
        name = ccb.content.text("default paw"),
        plural_name = ccb.content.text("default left paws"),
        accusative = ccb.content.text("default paw", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("default paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Your default paw feels heavy"),
        hp_bar_text = ccb.content.text("TST PAW"),
        hit_difficulty = 0.8,
        base_health = 20,
        drench_capacity = 4,
        limb = false,
        connected_to = "arm_l",
        opposite = "paw_default_r",
        side = "left",
    }
    part:sub_part("paw_default_wrist_l")
    part:sub_part("paw_default_palm_l")
    part:sub_part("paw_default_back_l")
    part:sub_part("paw_default_fingers_l")
    part:limb_type("hand")
    part:limb_score("balance", 0.0)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_default_r",
        name = ccb.content.text("default paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("left paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("r. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = ccb.content.text("TST PAW"),
        hit_difficulty = 0.8,
        base_health = 20,
        drench_capacity = 4,
        limb = false,
        main_part = "arm_r",
        opposite = "paw_default_l",
        side = "right",
    }
    part:sub_part("paw_default_wrist_r")
    part:sub_part("paw_default_palm_r")
    part:sub_part("paw_default_back_r")
    part:sub_part("paw_default_fingers_r")
    part:limb_type("hand")
    part:limb_score("balance", 0.0)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_broad_l",
        name = ccb.content.text("left paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("left paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("l. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your paw."),
        hit_size = 1.8,
        hit_difficulty = 1.25,
        base_health = 75,
        drench_capacity = 400,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 6,
        bmi_encumbrance_threshold = 18,
        bmi_encumbrance_scalar = 0.2,
        main_part = "arm_l",
        opposite = "paw_broad_r",
        side = "left",
        similar_body_part = "paw_default_l",
        fire_warmth_c = 3,
    }
    part:sub_part("paw_broad_wrist_l")
    part:sub_part("paw_broad_palm_l")
    part:sub_part("paw_broad_back_l")
    part:sub_part("paw_broad_fingers_l")
    part:flag("HANDS_CANNOT_USE_FIREARMS")
    part:technique("TECH_BROAD_PAW_PUNCH")
    part:technique("TECH_BROAD_PAW_PUNCH_WITH_CLAWS")
    part:technique("TECH_BROAD_PAW_CLAW")
    part:technique("TECH_BROAD_PAW_SMASH_KNOCKBACK")
    part:limb_type("hand")
    part:limb_score("grip", 0.27)
    part:limb_score("manip", 0.27, 0.54)
    part:limb_score("swim", 0.25)
    part:unarmed_damage("bash", 4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_broad_r",
        name = ccb.content.text("right paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("right paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("r. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your paw."),
        hit_size = 1.8,
        hit_difficulty = 1.25,
        base_health = 75,
        drench_capacity = 400,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 6,
        bmi_encumbrance_threshold = 18,
        bmi_encumbrance_scalar = 0.2,
        main_part = "arm_r",
        opposite = "paw_broad_l",
        side = "right",
        similar_body_part = "paw_default_r",
        fire_warmth_c = 3,
    }
    part:sub_part("paw_broad_wrist_r")
    part:sub_part("paw_broad_palm_r")
    part:sub_part("paw_broad_back_r")
    part:sub_part("paw_broad_fingers_r")
    part:flag("HANDS_CANNOT_USE_FIREARMS")
    part:technique("TECH_BROAD_PAW_PUNCH")
    part:technique("TECH_BROAD_PAW_PUNCH_WITH_CLAWS")
    part:technique("TECH_BROAD_PAW_CLAW")
    part:technique("TECH_BROAD_PAW_SMASH_KNOCKBACK")
    part:limb_type("hand")
    part:limb_score("grip", 0.27)
    part:limb_score("manip", 0.27, 0.54)
    part:limb_score("swim", 0.25)
    part:unarmed_damage("bash", 4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_l",
        name = ccb.content.text("left paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("left paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("l. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your paw."),
        hit_size = 1.5,
        hit_difficulty = 1.15,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 19,
        bmi_encumbrance_scalar = 0.17,
        main_part = "arm_l",
        opposite = "paw_r",
        side = "left",
        similar_body_part = "paw_default_l",
        fire_warmth_c = 3,
    }
    part:sub_part("paw_wrist_l")
    part:sub_part("paw_palm_l")
    part:sub_part("paw_back_l")
    part:sub_part("paw_fingers_l")
    part:flag("HANDS_CANNOT_USE_FIREARMS")
    part:technique("TECH_PAW_PUNCH")
    part:technique("TECH_PAW_PUNCH_WITH_CLAWS")
    part:technique("TECH_PAW_CLAW")
    part:limb_type("hand")
    part:limb_score("grip", 0.38)
    part:limb_score("manip", 0.38, 0.72)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_r",
        name = ccb.content.text("right paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("right paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("r. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your paw."),
        hit_size = 1.5,
        hit_difficulty = 1.15,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 5,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 19,
        bmi_encumbrance_scalar = 0.17,
        main_part = "arm_r",
        opposite = "paw_l",
        side = "right",
        similar_body_part = "paw_default_r",
        fire_warmth_c = 3,
    }
    part:sub_part("paw_wrist_r")
    part:sub_part("paw_palm_r")
    part:sub_part("paw_back_r")
    part:sub_part("paw_fingers_r")
    part:flag("HANDS_CANNOT_USE_FIREARMS")
    part:technique("TECH_PAW_PUNCH")
    part:technique("TECH_PAW_PUNCH_WITH_CLAWS")
    part:technique("TECH_PAW_CLAW")
    part:limb_type("hand")
    part:limb_score("grip", 0.38)
    part:limb_score("manip", 0.38, 0.72)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_rat_l",
        name = ccb.content.text("left paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("left paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("l. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your paw."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 1,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_l",
        opposite = "paw_rat_r",
        side = "left",
        similar_body_part = "paw_default_l",
        fire_warmth_c = 3,
    }
    part:sub_part("paw_rat_wrist_l")
    part:sub_part("paw_rat_palm_l")
    part:sub_part("paw_rat_back_l")
    part:sub_part("paw_rat_fingers_l")
    part:technique("TECH_PAW_PUNCH")
    part:technique("TECH_PAW_PUNCH_WITH_CLAWS")
    part:technique("TECH_PAW_CLAW")
    part:limb_type("hand")
    part:limb_score("grip", 0.5)
    part:limb_score("manip", 0.47, 0.95)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_rat_r",
        name = ccb.content.text("right paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("right paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("r. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your paw."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 1,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_r",
        opposite = "paw_rat_l",
        side = "right",
        similar_body_part = "paw_default_r",
        fire_warmth_c = 3,
    }
    part:sub_part("paw_rat_wrist_r")
    part:sub_part("paw_rat_palm_r")
    part:sub_part("paw_rat_back_r")
    part:sub_part("paw_rat_fingers_r")
    part:technique("TECH_PAW_PUNCH")
    part:technique("TECH_PAW_PUNCH_WITH_CLAWS")
    part:technique("TECH_PAW_CLAW")
    part:limb_type("hand")
    part:limb_score("grip", 0.5)
    part:limb_score("manip", 0.47, 0.95)
    part:limb_score("swim", 0.15)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_little_l",
        name = ccb.content.text("left paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("left paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("l. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your paw."),
        hit_size = 1.4,
        hit_difficulty = 1.05,
        base_health = 55,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 4,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_l",
        opposite = "paw_little_r",
        side = "left",
        similar_body_part = "paw_default_l",
        fire_warmth_c = 3,
    }
    part:sub_part("paw_little_wrist_l")
    part:sub_part("paw_little_palm_l")
    part:sub_part("paw_little_back_l")
    part:sub_part("paw_little_fingers_l")
    part:technique("TECH_LITTLE_PAW_PUNCH")
    part:limb_type("hand")
    part:limb_score("grip", 0.45)
    part:limb_score("manip", 0.45, 0.9)
    part:limb_score("swim", 0.15)
    part:unarmed_damage("bash", -1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "paw_little_r",
        name = ccb.content.text("right paw"),
        plural_name = ccb.content.text("paws"),
        accusative = ccb.content.text("right paw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("paws", "bodypart_accusative"),
        heading = ccb.content.text("r. paw"),
        plural_heading = ccb.content.text("paws"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your paw."),
        hit_size = 1.4,
        hit_difficulty = 1.05,
        base_health = 55,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 4,
        bionic_slots = 4,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_r",
        opposite = "paw_little_l",
        side = "right",
        similar_body_part = "paw_default_r",
        fire_warmth_c = 3,
    }
    part:sub_part("paw_little_wrist_r")
    part:sub_part("paw_little_palm_r")
    part:sub_part("paw_little_back_r")
    part:sub_part("paw_little_fingers_r")
    part:technique("TECH_LITTLE_PAW_PUNCH")
    part:limb_type("hand")
    part:limb_score("grip", 0.45)
    part:limb_score("manip", 0.45, 0.9)
    part:limb_score("swim", 0.15)
    part:unarmed_damage("bash", -1)
    content.add(part)
end

-- Slightly higher grip, slightly lowered manip
do
    local part = content.BodyPart {
        id = "hand_slime_l",
        name = ccb.content.text("left hand"),
        plural_name = ccb.content.text("hands"),
        accusative = ccb.content.text("left hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hands", "bodypart_accusative"),
        heading = ccb.content.text("l. hand"),
        plural_heading = ccb.content.text("hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        drench_capacity = 1500,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_l",
        opposite = "hand_slime_r",
        side = "left",
        similar_body_part = "hand_slime_l",
        fire_warmth_c = 3,
    }
    part:sub_part("hand_slime_wrist_l")
    part:sub_part("hand_slime_palm_l")
    part:sub_part("hand_slime_back_l")
    part:sub_part("hand_slime_fingers_l")
    part:technique("TECH_SLIME_PUNCH")
    part:limb_type("hand")
    part:limb_score("grip", 0.55)
    part:limb_score("manip", 0.45, 0.9)
    part:limb_score("swim", 0.15)
    part:unarmed_damage("bash", -2)
    part:unarmed_damage("acid", 4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "hand_slime_r",
        name = ccb.content.text("right hand"),
        plural_name = ccb.content.text("hands"),
        accusative = ccb.content.text("right hand", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hands", "bodypart_accusative"),
        heading = ccb.content.text("r. hand"),
        plural_heading = ccb.content.text("hands"),
        encumbrance_text = ccb.content.text("Manual tasks are slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You smash the %s with your fist."),
        hit_size = 1.5,
        hit_difficulty = 1.1,
        drench_capacity = 1500,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "arm_r",
        opposite = "hand_slime_l",
        side = "right",
        similar_body_part = "hand_slime_r",
        fire_warmth_c = 3,
    }
    part:sub_part("hand_slime_wrist_r")
    part:sub_part("hand_slime_palm_r")
    part:sub_part("hand_slime_back_r")
    part:sub_part("hand_slime_fingers_r")
    part:technique("TECH_SLIME_PUNCH")
    part:limb_type("hand")
    part:limb_score("grip", 0.55)
    part:limb_score("manip", 0.45, 0.9)
    part:limb_score("swim", 0.15)
    part:unarmed_damage("bash", -2)
    part:unarmed_damage("acid", 4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "vine_limb_upper_r",
        name = ccb.content.text("upper right vine"),
        plural_name = ccb.content.text("upper vines"),
        accusative = ccb.content.text("upper right vine", "bodypart_accusative"),
        plural_accusative = ccb.content.text("upper vines", "bodypart_accusative"),
        heading = ccb.content.text("up. r. vine"),
        plural_heading = ccb.content.text("up. vines"),
        encumbrance_text = ccb.content.text("Blocking is hampered."),
        hp_bar_text = ccb.content.text("UP R VINE"),
        smash_message = ccb.content.text("You hit the %s with a vine."),
        hit_size = 9,
        hit_difficulty = 0.75,
        base_health = 50,
        heal_bonus = 1,
        mend_rate = 5,
        environmental_protection = 15,
        smash_efficiency = 1.5,
        feels_discomfort = false,
        health_limit = 10,
        connected_to = "torso",
        opposite = "vine_limb_upper_l",
        side = "right",
    }
    part:sub_part("vine_sublimb_ur")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_BLOCK")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:flag("HEAL_OVERRIDE")
    part:flag("MEND_LIMB")
    part:flag("LIMB_UPPER")
    part:flag("NONSTANDARD_BLOCK")
    part:technique("VINE_LIMB_WHIP")
    part:technique("VINE_LIMB_TRIP")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.05)
    part:limb_score("block", 0.25)
    part:limb_score("crawl", 0.05)
    part:unarmed_damage("bash", 4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "vine_limb_upper_l",
        name = ccb.content.text("upper left vine"),
        plural_name = ccb.content.text("upper vines"),
        accusative = ccb.content.text("upper left vine", "bodypart_accusative"),
        plural_accusative = ccb.content.text("upper vines", "bodypart_accusative"),
        heading = ccb.content.text("up. l. vine"),
        plural_heading = ccb.content.text("up. vines"),
        encumbrance_text = ccb.content.text("Blocking is hampered."),
        hp_bar_text = ccb.content.text("UP L VINE"),
        smash_message = ccb.content.text("You hit the %s with a vine."),
        hit_size = 9,
        hit_difficulty = 0.75,
        base_health = 50,
        heal_bonus = 1,
        mend_rate = 5,
        environmental_protection = 15,
        smash_efficiency = 1.5,
        feels_discomfort = false,
        health_limit = 10,
        connected_to = "torso",
        opposite = "vine_limb_upper_r",
        side = "left",
    }
    part:sub_part("vine_sublimb_ul")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_BLOCK")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:flag("HEAL_OVERRIDE")
    part:flag("MEND_LIMB")
    part:flag("LIMB_UPPER")
    part:flag("NONSTANDARD_BLOCK")
    part:technique("VINE_LIMB_WHIP")
    part:technique("VINE_LIMB_TRIP")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.05)
    part:limb_score("block", 0.25)
    part:limb_score("crawl", 0.05)
    part:unarmed_damage("bash", 4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "vine_limb_lower_r",
        name = ccb.content.text("lower right vine"),
        plural_name = ccb.content.text("lower vines"),
        accusative = ccb.content.text("lower right vine", "bodypart_accusative"),
        plural_accusative = ccb.content.text("lower vines", "bodypart_accusative"),
        heading = ccb.content.text("lw. r. vine"),
        plural_heading = ccb.content.text("lw. vines"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("LW R VINE"),
        smash_message = ccb.content.text("You hit the %s with a vine."),
        hit_size = 9,
        hit_difficulty = 0.75,
        base_health = 50,
        heal_bonus = 1,
        mend_rate = 5,
        environmental_protection = 15,
        smash_efficiency = 1.5,
        feels_discomfort = false,
        health_limit = 10,
        connected_to = "torso",
        opposite = "vine_limb_lower_l",
        side = "right",
    }
    part:sub_part("vine_sublimb_lr")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_BLOCK")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:flag("HEAL_OVERRIDE")
    part:flag("MEND_LIMB")
    part:flag("LIMB_LOWER")
    part:flag("NONSTANDARD_BLOCK")
    part:technique("VINE_LIMB_WHIP")
    part:technique("VINE_LIMB_TRIP")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.05)
    part:limb_score("block", 0.25)
    part:limb_score("crawl", 0.05)
    part:unarmed_damage("bash", 4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "vine_limb_lower_l",
        name = ccb.content.text("lower left vine"),
        plural_name = ccb.content.text("lower vines"),
        accusative = ccb.content.text("lower left vine", "bodypart_accusative"),
        plural_accusative = ccb.content.text("lower vines", "bodypart_accusative"),
        heading = ccb.content.text("lw. l. vine"),
        plural_heading = ccb.content.text("lw. vines"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("LW L VINE"),
        smash_message = ccb.content.text("You hit the %s with a vine."),
        hit_size = 9,
        hit_difficulty = 0.75,
        base_health = 50,
        heal_bonus = 1,
        mend_rate = 5,
        environmental_protection = 15,
        smash_efficiency = 1.5,
        feels_discomfort = false,
        health_limit = 10,
        connected_to = "torso",
        opposite = "vine_limb_lower_r",
        side = "left",
    }
    part:sub_part("vine_sublimb_ll")
    part:flag("ALWAYS_BLOCK")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:flag("HEAL_OVERRIDE")
    part:flag("MEND_LIMB")
    part:flag("LIMB_LOWER")
    part:flag("NONSTANDARD_BLOCK")
    part:technique("VINE_LIMB_WHIP")
    part:technique("VINE_LIMB_TRIP")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.05)
    part:limb_score("block", 0.25)
    part:limb_score("crawl", 0.05)
    part:unarmed_damage("bash", 4)
    content.add(part)
end

-- These exist for wings that are independent, like butterfly or insect wings, or ravenfolk or black dragon wings in Magiclysm, to use as a similar_bodypart for gear coverage
do
    local part = content.BodyPart {
        id = "wing_l",
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
        opposite = "wing_r",
        side = "left",
    }
    part:sub_part("wing_shoulder_l")
    part:sub_part("wing_upper_l")
    part:sub_part("wing_joint_l")
    part:sub_part("wing_lower_l")
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
        id = "wing_r",
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
        opposite = "wing_l",
        side = "right",
    }
    part:sub_part("wing_shoulder_r")
    part:sub_part("wing_upper_r")
    part:sub_part("wing_joint_r")
    part:sub_part("wing_lower_r")
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
        id = "wing_butterfly_l",
        name = ccb.content.text("left wing"),
        plural_name = ccb.content.text("left wings"),
        accusative = ccb.content.text("left wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("left wings", "bodypart_accusative"),
        heading = ccb.content.text("l. wing"),
        plural_heading = ccb.content.text("wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L WING"),
        smash_message = ccb.content.text("You buffet the %s with your wing."),
        hit_size = 20,
        hit_difficulty = 1.2,
        base_health = 30,
        drench_capacity = 150,
        mend_rate = 0.5,
        drying_rate = 2,
        hot_morale = 1.0,
        cold_morale = 0.2,
        squeamish_penalty = 20,
        encumbrance_limit = 5,
        health_limit = 5,
        connected_to = "torso",
        opposite = "wing_butterfly_r",
        side = "left",
        similar_body_part = "wing_l",
    }
    part:sub_part("wing_butterfly_basal_l")
    part:sub_part("wing_butterfly_forewing_l")
    part:sub_part("wing_butterfly_hindwing_l")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("LIMB_UPPER")
    part:limb_type("wing")
    part:limb_score("reaction", -0.07)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "wing_butterfly_r",
        name = ccb.content.text("right wing"),
        plural_name = ccb.content.text("right wings"),
        accusative = ccb.content.text("right wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("right wings", "bodypart_accusative"),
        heading = ccb.content.text("r. wing"),
        plural_heading = ccb.content.text("wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("R WING"),
        smash_message = ccb.content.text("You buffet the %s with your wing."),
        hit_size = 20,
        hit_difficulty = 1.2,
        base_health = 30,
        drench_capacity = 150,
        mend_rate = 0.5,
        drying_rate = 2,
        hot_morale = 1.0,
        cold_morale = 0.2,
        squeamish_penalty = 20,
        encumbrance_limit = 5,
        health_limit = 5,
        connected_to = "torso",
        opposite = "wing_butterfly_l",
        side = "right",
        similar_body_part = "wing_r",
    }
    part:sub_part("wing_butterfly_basal_r")
    part:sub_part("wing_butterfly_forewing_r")
    part:sub_part("wing_butterfly_hindwing_r")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("LIMB_UPPER")
    part:limb_type("wing")
    part:limb_score("reaction", -0.07)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "wing_insect_l",
        name = ccb.content.text("left wing"),
        plural_name = ccb.content.text("left wings"),
        accusative = ccb.content.text("left wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("left wings", "bodypart_accusative"),
        heading = ccb.content.text("l. wing"),
        plural_heading = ccb.content.text("wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L WING"),
        smash_message = ccb.content.text("You buffet the %s with your wing."),
        hit_size = 15,
        hit_difficulty = 0.9,
        base_health = 30,
        drench_capacity = 150,
        mend_rate = 0.4,
        drying_rate = 2,
        hot_morale = 1.0,
        cold_morale = 0.2,
        squeamish_penalty = 10,
        encumbrance_limit = 5,
        health_limit = 10,
        connected_to = "torso",
        opposite = "wing_insect_r",
        side = "left",
        similar_body_part = "wing_l",
    }
    part:sub_part("wing_insect_costal_margin_l")
    part:sub_part("wing_insect_posterior_margin_l")
    part:sub_part("wing_insect_apex_l")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("LIMB_UPPER")
    part:conditional_flag("WINGS_2")
    part:limb_type("wing")
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "wing_insect_r",
        name = ccb.content.text("right wing"),
        plural_name = ccb.content.text("right wings"),
        accusative = ccb.content.text("right wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("right wings", "bodypart_accusative"),
        heading = ccb.content.text("r. wing"),
        plural_heading = ccb.content.text("wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("R WING"),
        smash_message = ccb.content.text("You buffet the %s with your wing."),
        hit_size = 15,
        hit_difficulty = 0.9,
        base_health = 30,
        drench_capacity = 150,
        mend_rate = 0.4,
        drying_rate = 2,
        hot_morale = 1.0,
        cold_morale = 0.2,
        squeamish_penalty = 10,
        encumbrance_limit = 5,
        health_limit = 10,
        connected_to = "torso",
        opposite = "wing_insect_l",
        side = "right",
        similar_body_part = "wing_r",
    }
    part:sub_part("wing_insect_costal_margin_r")
    part:sub_part("wing_insect_posterior_margin_r")
    part:sub_part("wing_insect_apex_r")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("LIMB_UPPER")
    part:conditional_flag("WINGS_2")
    part:limb_type("wing")
    content.add(part)
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
        hp_bar_text = ccb.content.text("G FOOT"),
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
    part:sub_part("leg_hip_gastropod_l")
    part:sub_part("leg_hip_gastropod_r")
    part:sub_part("leg_upper_gastropod")
    part:sub_part("leg_lower_gastropod")
    part:flag("LIMB_LOWER")
    part:limb_type("leg", 0.8)
    part:limb_type("foot", 0.5)
    part:limb_type("tail", 0.2)
    part:limb_score("move_speed", 0.3)
    part:limb_score("crawl", 0.6)
    part:limb_score("footing", 1.5)
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "leg_slime_l",
        name = ccb.content.text("pseudopod"),
        plural_name = ccb.content.text("pseudopods"),
        accusative = ccb.content.text("pseudopod", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pseudopods", "bodypart_accusative"),
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = "",
        hp_bar_text = ccb.content.text("PSPOD"),
        smash_message = ccb.content.text("You bring your pseudopod down on the %s, smashing it."),
        hit_size = 13,
        hit_difficulty = 0.9,
        drench_capacity = 5500,
        limb = false,
        winded_effect = "winded_leg",
        hot_morale = 0.5,
        cold_morale = 0.5,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.7,
        connected_to = "torso_slime",
        opposite = "leg_slime_r",
        side = "left",
        similar_body_part = "leg_l",
        fire_warmth_c = 0.3,
    }
    part:sub_part("leg_slime_hip_l")
    part:sub_part("leg_slime_upper_l")
    part:sub_part("leg_slime_knee_l")
    part:sub_part("leg_slime_lower_l")
    part:sub_part("leg_slime_draped_l")
    part:flag("LIMB_LOWER")
    part:limb_type("leg")
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "leg_slime_r",
        name = ccb.content.text("pseudopod"),
        plural_name = ccb.content.text("pseudopods"),
        accusative = ccb.content.text("pseudopod", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pseudopods", "bodypart_accusative"),
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = "",
        hp_bar_text = ccb.content.text("PSPOD"),
        smash_message = ccb.content.text("You bring your pseudopod down on the %s, smashing it."),
        hit_size = 13,
        hit_difficulty = 0.9,
        drench_capacity = 5500,
        limb = false,
        winded_effect = "winded_leg",
        hot_morale = 0.5,
        cold_morale = 0.5,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 9,
        bmi_encumbrance_scalar = 0.7,
        connected_to = "torso_slime",
        opposite = "leg_slime_l",
        side = "right",
        similar_body_part = "leg_r",
        fire_warmth_c = 0.3,
    }
    part:sub_part("leg_slime_hip_r")
    part:sub_part("leg_slime_upper_r")
    part:sub_part("leg_slime_knee_r")
    part:sub_part("leg_slime_lower_r")
    part:sub_part("leg_slime_draped_r")
    part:flag("LIMB_LOWER")
    part:limb_type("leg")
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "foot_slime_l",
        name = ccb.content.text("pseudopod tip"),
        plural_name = ccb.content.text("pseudopod tips"),
        accusative = ccb.content.text("pseudopod tip", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pseudopod tips", "bodypart_accusative"),
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = "",
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 1500,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_slime_l",
        opposite = "foot_slime_r",
        side = "left",
        similar_body_part = "foot_l",
        fire_warmth_c = 0.6,
    }
    part:sub_part("foot_slime_sole_l")
    part:sub_part("foot_slime_arch_l")
    part:sub_part("foot_slime_toes_l")
    part:sub_part("foot_slime_ankle_l")
    part:sub_part("foot_slime_heel_l")
    part:flag("LIMB_LOWER")
    part:technique("TECH_SLIME_KICK")
    part:limb_type("foot")
    part:unarmed_damage("bash", -2)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "foot_slime_r",
        name = ccb.content.text("pseudopod tip"),
        plural_name = ccb.content.text("pseudopod tips"),
        accusative = ccb.content.text("pseudopod tip", "bodypart_accusative"),
        plural_accusative = ccb.content.text("pseudopod tips", "bodypart_accusative"),
        heading = ccb.content.text("pseudopod"),
        plural_heading = ccb.content.text("pseudopods"),
        encumbrance_text = "",
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 1500,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        feels_discomfort = false,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_slime_r",
        opposite = "foot_slime_l",
        side = "right",
        similar_body_part = "foot_r",
        fire_warmth_c = 0.6,
    }
    part:sub_part("foot_slime_sole_r")
    part:sub_part("foot_slime_arch_r")
    part:sub_part("foot_slime_toes_r")
    part:sub_part("foot_slime_ankle_r")
    part:sub_part("foot_slime_heel_r")
    part:flag("LIMB_LOWER")
    part:technique("TECH_SLIME_KICK")
    part:limb_type("foot")
    part:unarmed_damage("bash", -2)
    content.add(part)
end

-- Slower speed but better footing, slight balance buff, much lower crawl, no swimming.  No innate armor (armor comes from the shell).  Numbers scale based on having four legs.
do
    local part = content.BodyPart {
        id = "leg_crab_front_l",
        name = ccb.content.text("left foreleg"),
        plural_name = ccb.content.text("forelegs"),
        accusative = ccb.content.text("left foreleg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("forelegs", "bodypart_accusative"),
        heading = ccb.content.text("l. foreleg"),
        plural_heading = ccb.content.text("forelegs"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = ccb.content.text("L FLEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        hit_size = 9,
        hit_difficulty = 0.7,
        base_health = 45,
        drench_capacity = 1100,
        winded_effect = "winded_crab_leg",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 6,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "leg_crab_front_r",
        side = "left",
        fire_warmth_c = 0.15,
    }
    part:sub_part("leg_crab_basis_fl")
    part:sub_part("leg_crab_merus_fl")
    part:sub_part("leg_crab_carpus_fl")
    part:sub_part("leg_crab_manus_fl")
    part:sub_part("leg_crab_dactyl_fl")
    part:flag("LIMB_LOWER")
    part:limb_type("leg")
    part:limb_score("manip", 0.07, 0.14)
    part:limb_score("move_speed", 0.2)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.35)
    part:limb_score("block", 0.5)
    part:limb_score("crawl", 0.05)
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
        damage_threshold = 15,
        scale_increment = 15,
        chance = 5,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 15,
        chance = 15,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "leg_crab_front_r",
        name = ccb.content.text("right foreleg"),
        plural_name = ccb.content.text("forelegs"),
        accusative = ccb.content.text("right foreleg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("forelegs", "bodypart_accusative"),
        heading = ccb.content.text("r. foreleg"),
        plural_heading = ccb.content.text("forelegs"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = ccb.content.text("R FLEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        hit_size = 9,
        hit_difficulty = 0.7,
        base_health = 45,
        drench_capacity = 1100,
        winded_effect = "winded_crab_leg",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 6,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "leg_crab_front_l",
        side = "right",
        fire_warmth_c = 0.15,
    }
    part:sub_part("leg_crab_basis_fr")
    part:sub_part("leg_crab_merus_fr")
    part:sub_part("leg_crab_carpus_fr")
    part:sub_part("leg_crab_manus_fr")
    part:sub_part("leg_crab_dactyl_fr")
    part:flag("LIMB_LOWER")
    part:limb_type("leg")
    part:limb_score("manip", 0.07, 0.14)
    part:limb_score("move_speed", 0.2)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.35)
    part:limb_score("block", 0.5)
    part:limb_score("crawl", 0.05)
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
        damage_threshold = 15,
        scale_increment = 15,
        chance = 5,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 15,
        chance = 15,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "leg_crab_rear_l",
        name = ccb.content.text("left hindleg"),
        plural_name = ccb.content.text("forelegs"),
        accusative = ccb.content.text("left hindleg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hindlegs", "bodypart_accusative"),
        heading = ccb.content.text("l. hindleg"),
        plural_heading = ccb.content.text("hindlegs"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = ccb.content.text("L HLEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        hit_size = 9,
        hit_difficulty = 0.7,
        base_health = 45,
        drench_capacity = 1100,
        winded_effect = "winded_crab_leg",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 6,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "leg_crab_rear_r",
        side = "left",
        fire_warmth_c = 0.15,
    }
    part:sub_part("leg_crab_basis_rl")
    part:sub_part("leg_crab_merus_rl")
    part:sub_part("leg_crab_carpus_rl")
    part:sub_part("leg_crab_manus_rl")
    part:sub_part("leg_crab_dactyl_rl")
    part:flag("LIMB_LOWER")
    part:limb_type("leg")
    part:limb_score("manip", 0.07, 0.14)
    part:limb_score("move_speed", 0.2)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.35)
    part:limb_score("block", 0.5)
    part:limb_score("crawl", 0.05)
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
        damage_threshold = 15,
        scale_increment = 15,
        chance = 5,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 15,
        chance = 15,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "leg_crab_rear_r",
        name = ccb.content.text("right hindleg"),
        plural_name = ccb.content.text("forelegs"),
        accusative = ccb.content.text("right hindleg", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hindlegs", "bodypart_accusative"),
        heading = ccb.content.text("r. hindleg"),
        plural_heading = ccb.content.text("hindlegs"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = ccb.content.text("R HLEG"),
        smash_message = ccb.content.text("You bring your knee down on the %s, smashing it."),
        hit_size = 9,
        hit_difficulty = 0.7,
        base_health = 45,
        drench_capacity = 1100,
        winded_effect = "winded_crab_leg",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 6,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        main_part = "leg_crab_rear_l",
        opposite = "leg_crab_rear_l",
        side = "right",
        fire_warmth_c = 0.15,
    }
    part:sub_part("leg_crab_basis_rr")
    part:sub_part("leg_crab_merus_rr")
    part:sub_part("leg_crab_carpus_rr")
    part:sub_part("leg_crab_manus_rr")
    part:sub_part("leg_crab_dactyl_rr")
    part:flag("LIMB_LOWER")
    part:limb_type("leg")
    part:limb_score("manip", 0.07, 0.14)
    part:limb_score("move_speed", 0.2)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.35)
    part:limb_score("block", 0.5)
    part:limb_score("crawl", 0.05)
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
        damage_threshold = 15,
        scale_increment = 15,
        chance = 5,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 25,
        scale_increment = 15,
        chance = 15,
        chance_scaling = 15,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

-- Exists for armor coverage definitions.  Encompasses three tentacles, hence the 100% plurals
do
    local part = content.BodyPart {
        id = "tentacle_default_l",
        name = ccb.content.text("left tentacles"),
        plural_name = ccb.content.text("left tentacles"),
        accusative = ccb.content.text("left tentacles", "bodypart_accusative"),
        plural_accusative = ccb.content.text("left tentacles", "bodypart_accusative"),
        heading = ccb.content.text("l. tents"),
        plural_heading = ccb.content.text("l. tents"),
        encumbrance_text = ccb.content.text("Slithering is slowed."),
        hp_bar_text = ccb.content.text("L TENTS"),
        hit_size = 7,
        hit_difficulty = 0.6,
        base_health = 20,
        drench_capacity = 1000,
        limb = false,
        encumbrance_threshold = 6,
        connected_to = "torso",
        opposite = "tentacle_default_r",
        side = "left",
    }
    part:sub_part("tentacle_default_base_l")
    part:sub_part("tentacle_default_middle_l")
    part:sub_part("tentacle_default_tip_l")
    part:limb_type("leg")
    content.add(part)
end

-- Exists for armor coverage definitions.  Encompasses three tentacles, hence the 100% plurals
do
    local part = content.BodyPart {
        id = "tentacle_default_r",
        name = ccb.content.text("right tentacles"),
        plural_name = ccb.content.text("right tentacles"),
        accusative = ccb.content.text("right tentacles", "bodypart_accusative"),
        plural_accusative = ccb.content.text("right tentacles", "bodypart_accusative"),
        heading = ccb.content.text("r. tents"),
        plural_heading = ccb.content.text("r. tents"),
        encumbrance_text = ccb.content.text("Slithering is slowed."),
        hp_bar_text = ccb.content.text("R TENTS"),
        hit_size = 7,
        hit_difficulty = 0.6,
        base_health = 20,
        drench_capacity = 1000,
        limb = false,
        encumbrance_threshold = 6,
        connected_to = "torso",
        opposite = "tentacle_default_l",
        side = "right",
    }
    part:sub_part("tentacle_default_base_r")
    part:sub_part("tentacle_default_middle_r")
    part:sub_part("tentacle_default_tip_r")
    part:limb_type("leg")
    content.add(part)
end

-- Slower speed but much better footing, slight balance buff, lower crawl, good swimming.  Numbers scale based on having six tentacles.
do
    local part = content.BodyPart {
        id = "tentacle_lower_front_l",
        name = ccb.content.text("left front tentacle"),
        plural_name = ccb.content.text("front tentacles"),
        accusative = ccb.content.text("left front tentacle", "bodypart_accusative"),
        plural_accusative = ccb.content.text("front tentacles", "bodypart_accusative"),
        heading = ccb.content.text("l. f. tent"),
        plural_heading = ccb.content.text("f. tent"),
        encumbrance_text = ccb.content.text("Slithering is slowed."),
        hp_bar_text = ccb.content.text("L FTENT"),
        smash_message = ccb.content.text("You whip the %s with your tentacle, smashing it."),
        hit_size = 7,
        hit_difficulty = 0.6,
        base_health = 40,
        drench_capacity = 1400,
        winded_effect = "winded_tentacle",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 5,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "tentacle_lower_front_r",
        side = "left",
        similar_body_part = "tentacle_default_l",
        fire_warmth_c = 0.2,
    }
    part:sub_part("tentacle_lower_front_base_l")
    part:sub_part("tentacle_lower_front_middle_l")
    part:sub_part("tentacle_lower_front_tip_l")
    part:flag("LIMB_LOWER")
    part:flag("MEND_LIMB")
    part:flag("TOUGH_FEET")
    part:limb_type("leg")
    part:limb_type("foot", 0.2)
    part:limb_score("manip", 0.05, 0.1)
    part:limb_score("move_speed", 0.125)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.17)
    part:limb_score("block", 0.35)
    part:limb_score("crawl", 0.08)
    part:limb_score("swim", 0.2)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 4,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 2,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 2,
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
        damage_threshold = 20,
        scale_increment = 20,
        chance = 5,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 35,
        scale_increment = 20,
        chance = 15,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tentacle_lower_middle_l",
        name = ccb.content.text("left middle tentacle"),
        plural_name = ccb.content.text("middle tentacles"),
        accusative = ccb.content.text("left middle tentacle", "bodypart_accusative"),
        plural_accusative = ccb.content.text("middle tentacles", "bodypart_accusative"),
        heading = ccb.content.text("l. m. tent"),
        plural_heading = ccb.content.text("m. tent"),
        encumbrance_text = ccb.content.text("Slithering is slowed."),
        hp_bar_text = ccb.content.text("L MTENT"),
        smash_message = ccb.content.text("You whip the %s with your tentacle, smashing it."),
        hit_size = 7,
        hit_difficulty = 0.6,
        base_health = 40,
        drench_capacity = 1400,
        winded_effect = "winded_tentacle",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 5,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "tentacle_lower_middle_r",
        side = "left",
        similar_body_part = "tentacle_default_l",
        fire_warmth_c = 0.2,
    }
    part:sub_part("tentacle_lower_middle_base_l")
    part:sub_part("tentacle_lower_middle_middle_l")
    part:sub_part("tentacle_lower_middle_tip_l")
    part:flag("LIMB_LOWER")
    part:flag("MEND_LIMB")
    part:flag("TOUGH_FEET")
    part:limb_type("leg")
    part:limb_type("foot", 0.2)
    part:limb_score("manip", 0.05, 0.1)
    part:limb_score("move_speed", 0.125)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.17)
    part:limb_score("block", 0.35)
    part:limb_score("crawl", 0.08)
    part:limb_score("swim", 0.2)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 4,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 2,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 2,
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
        damage_threshold = 20,
        scale_increment = 20,
        chance = 5,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 35,
        scale_increment = 20,
        chance = 15,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tentacle_lower_rear_l",
        name = ccb.content.text("left rear tentacle"),
        plural_name = ccb.content.text("rear tentacles"),
        accusative = ccb.content.text("left rear tentacle", "bodypart_accusative"),
        plural_accusative = ccb.content.text("rear tentacles", "bodypart_accusative"),
        heading = ccb.content.text("l. r. tent"),
        plural_heading = ccb.content.text("r. tent"),
        encumbrance_text = ccb.content.text("Slithering is slowed."),
        hp_bar_text = ccb.content.text("L RTENT"),
        smash_message = ccb.content.text("You whip the %s with your tentacle, smashing it."),
        hit_size = 7,
        hit_difficulty = 0.6,
        base_health = 40,
        drench_capacity = 1400,
        winded_effect = "winded_tentacle",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 5,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "tentacle_lower_rear_r",
        side = "left",
        similar_body_part = "tentacle_default_l",
        fire_warmth_c = 0.2,
    }
    part:sub_part("tentacle_lower_rear_base_l")
    part:sub_part("tentacle_lower_rear_middle_l")
    part:sub_part("tentacle_lower_rear_tip_l")
    part:flag("LIMB_LOWER")
    part:flag("MEND_LIMB")
    part:flag("TOUGH_FEET")
    part:limb_type("leg")
    part:limb_type("foot", 0.2)
    part:limb_score("manip", 0.05, 0.1)
    part:limb_score("move_speed", 0.125)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.17)
    part:limb_score("block", 0.35)
    part:limb_score("crawl", 0.08)
    part:limb_score("swim", 0.2)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 4,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 2,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 2,
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
        damage_threshold = 20,
        scale_increment = 20,
        chance = 5,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 35,
        scale_increment = 20,
        chance = 15,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tentacle_lower_front_r",
        name = ccb.content.text("right front tentacle"),
        plural_name = ccb.content.text("front tentacles"),
        accusative = ccb.content.text("right front tentacle", "bodypart_accusative"),
        plural_accusative = ccb.content.text("front tentacles", "bodypart_accusative"),
        heading = ccb.content.text("r. f. tent"),
        plural_heading = ccb.content.text("f. tent"),
        encumbrance_text = ccb.content.text("Slithering is slowed."),
        hp_bar_text = ccb.content.text("R FTENT"),
        smash_message = ccb.content.text("You whip the %s with your tentacle, smashing it."),
        hit_size = 7,
        hit_difficulty = 0.6,
        base_health = 40,
        drench_capacity = 1400,
        winded_effect = "winded_tentacle",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 5,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "tentacle_lower_front_l",
        side = "right",
        similar_body_part = "tentacle_default_r",
        fire_warmth_c = 0.2,
    }
    part:sub_part("tentacle_lower_front_base_r")
    part:sub_part("tentacle_lower_front_middle_r")
    part:sub_part("tentacle_lower_front_tip_r")
    part:flag("LIMB_LOWER")
    part:flag("MEND_LIMB")
    part:flag("TOUGH_FEET")
    part:limb_type("leg")
    part:limb_type("foot", 0.2)
    part:limb_score("manip", 0.05, 0.1)
    part:limb_score("move_speed", 0.125)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.17)
    part:limb_score("block", 0.35)
    part:limb_score("crawl", 0.08)
    part:limb_score("swim", 0.2)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 4,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 2,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 2,
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
        damage_threshold = 20,
        scale_increment = 20,
        chance = 5,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 35,
        scale_increment = 20,
        chance = 15,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tentacle_lower_middle_r",
        name = ccb.content.text("right middle tentacle"),
        plural_name = ccb.content.text("middle tentacles"),
        accusative = ccb.content.text("right middle tentacle", "bodypart_accusative"),
        plural_accusative = ccb.content.text("middle tentacles", "bodypart_accusative"),
        heading = ccb.content.text("r. m. tent"),
        plural_heading = ccb.content.text("m. tent"),
        encumbrance_text = ccb.content.text("Slithering is slowed."),
        hp_bar_text = ccb.content.text("R MTENT"),
        smash_message = ccb.content.text("You whip the %s with your tentacle, smashing it."),
        hit_size = 7,
        hit_difficulty = 0.6,
        base_health = 40,
        drench_capacity = 1400,
        winded_effect = "winded_tentacle",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 5,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "tentacle_lower_middle_l",
        side = "right",
        similar_body_part = "tentacle_default_r",
        fire_warmth_c = 0.2,
    }
    part:sub_part("tentacle_lower_middle_base_r")
    part:sub_part("tentacle_lower_middle_middle_r")
    part:sub_part("tentacle_lower_middle_tip_r")
    part:flag("LIMB_LOWER")
    part:flag("MEND_LIMB")
    part:flag("TOUGH_FEET")
    part:limb_type("leg")
    part:limb_type("foot", 0.2)
    part:limb_score("manip", 0.05, 0.1)
    part:limb_score("move_speed", 0.125)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.17)
    part:limb_score("block", 0.35)
    part:limb_score("crawl", 0.08)
    part:limb_score("swim", 0.2)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 4,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 2,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 2,
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
        damage_threshold = 20,
        scale_increment = 20,
        chance = 5,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 35,
        scale_increment = 20,
        chance = 15,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tentacle_lower_rear_r",
        name = ccb.content.text("right rear tentacle"),
        plural_name = ccb.content.text("rear tentacles"),
        accusative = ccb.content.text("right rear tentacle", "bodypart_accusative"),
        plural_accusative = ccb.content.text("rear tentacles", "bodypart_accusative"),
        heading = ccb.content.text("r. r. tent"),
        plural_heading = ccb.content.text("r. tent"),
        encumbrance_text = ccb.content.text("Slithering is slowed."),
        hp_bar_text = ccb.content.text("R RTENT"),
        smash_message = ccb.content.text("You whip the %s with your tentacle, smashing it."),
        hit_size = 7,
        hit_difficulty = 0.6,
        base_health = 40,
        drench_capacity = 1400,
        winded_effect = "winded_tentacle",
        hot_morale = 0.25,
        cold_morale = 0.25,
        squeamish_penalty = 3,
        bionic_slots = 5,
        encumbrance_threshold = 6,
        bmi_encumbrance_threshold = 7,
        bmi_encumbrance_scalar = 0.5,
        connected_to = "torso",
        opposite = "tentacle_lower_rear_l",
        side = "right",
        similar_body_part = "tentacle_default_r",
        fire_warmth_c = 0.2,
    }
    part:sub_part("tentacle_lower_rear_base_r")
    part:sub_part("tentacle_lower_rear_middle_r")
    part:sub_part("tentacle_lower_rear_tip_r")
    part:flag("LIMB_LOWER")
    part:flag("MEND_LIMB")
    part:flag("TOUGH_FEET")
    part:limb_type("leg")
    part:limb_type("foot", 0.2)
    part:limb_score("manip", 0.05, 0.1)
    part:limb_score("move_speed", 0.125)
    part:limb_score("balance", 0.05)
    part:limb_score("footing", 0.17)
    part:limb_score("block", 0.35)
    part:limb_score("crawl", 0.08)
    part:limb_score("swim", 0.2)
    part:hit_effect {
        id = "bleed",
        damage_type = "cut",
        damage_threshold = 4,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 45,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "stab",
        damage_threshold = 2,
        scale_increment = 2,
        duration = 60,
        duration_scaling = 60,
        max_duration = 1800,
    }
    part:hit_effect {
        id = "bleed",
        damage_type = "bullet",
        damage_threshold = 2,
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
        damage_threshold = 20,
        scale_increment = 20,
        chance = 5,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    part:hit_effect {
        id = "downed",
        damage_threshold = 35,
        scale_increment = 20,
        chance = 15,
        chance_scaling = 20,
        duration = 1,
        duration_scaling = 0.5,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "hoof_l",
        name = ccb.content.text("left hoof"),
        plural_name = ccb.content.text("hooves"),
        accusative = ccb.content.text("left hoof", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hooves", "bodypart_accusative"),
        heading = ccb.content.text("l. hoof"),
        plural_heading = ccb.content.text("hooves"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You slam your hooves into the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 2,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_r",
        opposite = "hoof_r",
        side = "left",
        fire_warmth_c = 0.6,
        minimum_temperature_c = 0.4,
        maximum_temperature_c = 0.9,
    }
    part:sub_part("hoof_sole_l")
    part:sub_part("hoof_wall_l")
    part:sub_part("hoof_fetlock_l")
    part:flag("LIMB_LOWER")
    part:technique("HOOVES_KICK")
    part:technique("HOOVES_KICK_AGAINST_LARGE")
    part:technique("HOOVES_KICK_NATURAL")
    part:technique("HOOVES_KICK_NATURAL_AGAINST_LARGE")
    part:technique("HOOVES_KICK_CRIT")
    part:limb_type("foot")
    part:limb_score("manip", 0.0, 0.1)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.05)
    part:armor("bash", 5)
    part:armor("cut", 3)
    part:armor("stab", 2)
    part:armor("acid", 4)
    part:unarmed_damage("bash", 8)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "hoof_r",
        name = ccb.content.text("right hoof"),
        plural_name = ccb.content.text("hooves"),
        accusative = ccb.content.text("right hoof", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hooves", "bodypart_accusative"),
        heading = ccb.content.text("r. hoof"),
        plural_heading = ccb.content.text("hooves"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You slam your hooves into the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 2,
        encumbrance_threshold = 5,
        technique_encumbrance_limit = 40,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_r",
        opposite = "hoof_l",
        side = "right",
        fire_warmth_c = 0.6,
        minimum_temperature_c = 0.4,
        maximum_temperature_c = 0.9,
    }
    part:sub_part("hoof_sole_r")
    part:sub_part("hoof_wall_r")
    part:sub_part("hoof_fetlock_r")
    part:flag("LIMB_LOWER")
    part:technique("HOOVES_KICK")
    part:technique("HOOVES_KICK_AGAINST_LARGE")
    part:technique("HOOVES_KICK_NATURAL")
    part:technique("HOOVES_KICK_NATURAL_AGAINST_LARGE")
    part:technique("HOOVES_KICK_CRIT")
    part:limb_type("foot")
    part:limb_score("manip", 0.0, 0.1)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.05)
    part:armor("bash", 5)
    part:armor("cut", 3)
    part:armor("stab", 2)
    part:armor("acid", 4)
    part:unarmed_damage("bash", 8)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "avian_talon_l",
        name = ccb.content.text("left talon"),
        plural_name = ccb.content.text("talons"),
        accusative = ccb.content.text("left talon", "bodypart_accusative"),
        plural_accusative = ccb.content.text("talons", "bodypart_accusative"),
        heading = ccb.content.text("l. talon"),
        plural_heading = ccb.content.text("talons"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 1,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_l",
        opposite = "avian_talon_r",
        side = "left",
        fire_warmth_c = 0.6,
        minimum_temperature_c = 0.2,
        maximum_temperature_c = 0.5,
    }
    part:sub_part("avian_talon_bottom_l")
    part:sub_part("avian_talon_top_l")
    part:sub_part("avian_talon_talons_l")
    part:sub_part("avian_talon_ankle_l")
    part:sub_part("avian_talon_rear_l")
    part:flag("LIMB_LOWER")
    part:technique("TECH_AVIAN_KICK")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.6)
    part:limb_score("swim", 0.0)
    part:unarmed_damage("cut", 6)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "avian_talon_r",
        name = ccb.content.text("right talon"),
        plural_name = ccb.content.text("talons"),
        accusative = ccb.content.text("right talon", "bodypart_accusative"),
        plural_accusative = ccb.content.text("talons", "bodypart_accusative"),
        heading = ccb.content.text("r. talon"),
        plural_heading = ccb.content.text("talons"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 1,
        encumbrance_threshold = 5,
        technique_encumbrance_limit = 40,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_l",
        opposite = "avian_talon_l",
        side = "right",
        fire_warmth_c = 0.6,
        minimum_temperature_c = 0.2,
        maximum_temperature_c = 0.5,
    }
    part:sub_part("avian_talon_bottom_r")
    part:sub_part("avian_talon_top_r")
    part:sub_part("avian_talon_talons_r")
    part:sub_part("avian_talon_ankle_r")
    part:sub_part("avian_talon_rear_r")
    part:flag("LIMB_LOWER")
    part:technique("TECH_AVIAN_KICK")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.6)
    part:limb_score("swim", 0.0)
    part:unarmed_damage("cut", 6)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "animal_paw_l",
        name = ccb.content.text("left hindpaw"),
        plural_name = ccb.content.text("hindpaws"),
        accusative = ccb.content.text("left hindpaw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hindpaws", "bodypart_accusative"),
        heading = ccb.content.text("l. hindpaw"),
        plural_heading = ccb.content.text("hindpaws"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 1,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_l",
        opposite = "animal_paw_r",
        side = "left",
        fire_warmth_c = 0.6,
    }
    part:sub_part("digitigrade_foot_sole_l")
    part:sub_part("digitigrade_foot_arch_l")
    part:sub_part("digitigrade_foot_toes_l")
    part:sub_part("digitigrade_foot_ankle_l")
    part:sub_part("digitigrade_foot_heel_l")
    part:flag("LIMB_LOWER")
    part:technique("TECH_ANIMAL_FOOT_KICK")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "animal_paw_r",
        name = ccb.content.text("right hindpaw"),
        plural_name = ccb.content.text("hindpaws"),
        accusative = ccb.content.text("right hindpaw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hindpaws", "bodypart_accusative"),
        heading = ccb.content.text("r. hindpaw"),
        plural_heading = ccb.content.text("hindpaws"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 1,
        encumbrance_threshold = 5,
        technique_encumbrance_limit = 40,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_l",
        opposite = "animal_paw_l",
        side = "right",
        fire_warmth_c = 0.6,
    }
    part:sub_part("digitigrade_foot_sole_r")
    part:sub_part("digitigrade_foot_arch_r")
    part:sub_part("digitigrade_foot_toes_r")
    part:sub_part("digitigrade_foot_ankle_r")
    part:sub_part("digitigrade_foot_heel_r")
    part:flag("LIMB_LOWER")
    part:technique("TECH_ANIMAL_FOOT_KICK")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "animal_paw_rabbit_l",
        name = ccb.content.text("left hindpaw"),
        plural_name = ccb.content.text("hindpaws"),
        accusative = ccb.content.text("left hindpaw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hindpaws", "bodypart_accusative"),
        heading = ccb.content.text("l. hindpaw"),
        plural_heading = ccb.content.text("hindpaws"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 1,
        encumbrance_threshold = 5,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_l",
        side = "left",
        similar_body_part = "animal_paw_l",
        fire_warmth_c = 0.6,
    }
    part:sub_part("digitigrade_foot_sole_l")
    part:sub_part("digitigrade_foot_arch_l")
    part:sub_part("digitigrade_foot_toes_l")
    part:sub_part("digitigrade_foot_ankle_l")
    part:sub_part("digitigrade_foot_heel_l")
    part:flag("LIMB_LOWER")
    part:technique("TECH_ANIMAL_FOOT_KICK")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.1)
    part:unarmed_damage("bash", 3)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "animal_paw_rabbit_r",
        name = ccb.content.text("right hindpaw"),
        plural_name = ccb.content.text("hindpaws"),
        accusative = ccb.content.text("right hindpaw", "bodypart_accusative"),
        plural_accusative = ccb.content.text("hindpaws", "bodypart_accusative"),
        heading = ccb.content.text("r. hindpaw"),
        plural_heading = ccb.content.text("hindpaws"),
        encumbrance_text = ccb.content.text("Running is slowed."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You kick down the %s, smashing it."),
        hit_size = 2,
        hit_difficulty = 0.8,
        drench_capacity = 300,
        limb = false,
        hot_morale = 0.5,
        cold_morale = 0.5,
        squeamish_penalty = 3,
        bionic_slots = 1,
        encumbrance_threshold = 5,
        technique_encumbrance_limit = 40,
        bmi_encumbrance_threshold = 20,
        bmi_encumbrance_scalar = 0.15,
        main_part = "leg_l",
        side = "right",
        similar_body_part = "animal_paw_r",
        fire_warmth_c = 0.6,
    }
    part:sub_part("digitigrade_foot_sole_r")
    part:sub_part("digitigrade_foot_arch_r")
    part:sub_part("digitigrade_foot_toes_r")
    part:sub_part("digitigrade_foot_ankle_r")
    part:sub_part("digitigrade_foot_heel_r")
    part:flag("LIMB_LOWER")
    part:technique("TECH_ANIMAL_FOOT_KICK")
    part:limb_type("foot")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("footing", 0.5)
    part:limb_score("swim", 0.1)
    part:unarmed_damage("bash", 3)
    content.add(part)
end

-- Used as a default for similar_bodypart to work for armor.
do
    local part = content.BodyPart {
        id = "tail",
        name = ccb.content.text("default tail"),
        plural_name = ccb.content.text("default tails"),
        accusative = ccb.content.text("default tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("default tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Your testing tail feels heavy"),
        hp_bar_text = ccb.content.text("TST TAIL"),
        hit_difficulty = 0.8,
        base_health = 20,
        drench_capacity = 4,
        limb = false,
        connected_to = "torso",
    }
    part:sub_part("tail_default_base")
    part:sub_part("tail_default_center")
    part:sub_part("tail_default_tip")
    part:limb_type("tail")
    part:limb_score("balance", 0.0)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tail_long",
        name = ccb.content.text("long tail"),
        plural_name = "",
        accusative = ccb.content.text("long tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("long tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("L TAIL"),
        smash_message = ccb.content.text("You thwap %s with your tail."),
        hit_size = 6,
        hit_difficulty = 0.4,
        base_health = 25,
        drench_capacity = 700,
        wet_morale = -15,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 6,
        encumbrance_limit = 25,
        health_limit = 5,
        main_part = "torso",
        similar_body_part = "tail",
        fire_warmth_c = 0.3,
    }
    part:sub_part("tail_long_base")
    part:sub_part("tail_long_center")
    part:sub_part("tail_long_tip")
    part:limb_type("tail")
    part:limb_score("balance", 0.05)
    part:limb_score("reaction", 0.1)
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tail_fluffy",
        name = ccb.content.text("fluffy tail"),
        plural_name = "",
        accusative = ccb.content.text("fluffy tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("fluffy tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("F TAIL"),
        smash_message = ccb.content.text("You thwap %s with your tail."),
        hit_size = 6,
        hit_difficulty = 0.4,
        base_health = 25,
        drench_capacity = 700,
        wet_morale = -2,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 9,
        encumbrance_limit = 25,
        health_limit = 5,
        main_part = "torso",
        similar_body_part = "tail",
        fire_warmth_c = 0.5,
    }
    part:sub_part("tail_fluffy_base")
    part:sub_part("tail_fluffy_center")
    part:sub_part("tail_fluffy_tip")
    part:limb_type("tail")
    part:limb_score("balance", 0.08)
    part:limb_score("reaction", 0.15)
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tail_scorpion",
        name = ccb.content.text("scorpion tail"),
        plural_name = "",
        accusative = ccb.content.text("scorpion tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("scorpion tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("S TAIL"),
        smash_message = ccb.content.text("You smash %s with your tail."),
        hit_size = 6,
        hit_difficulty = 0.4,
        base_health = 25,
        drench_capacity = 700,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        encumbrance_limit = 25,
        health_limit = 10,
        technique_encumbrance_limit = 5,
        main_part = "torso",
        similar_body_part = "tail",
        fire_warmth_c = 0.2,
    }
    part:sub_part("tail_scorpion_base")
    part:sub_part("tail_scorpion_center")
    part:sub_part("tail_scorpion_stinger")
    part:technique("TAIL_SCORPION_STING")
    part:technique("TAIL_SCORPION_STING_NATURAL")
    part:technique("TAIL_SCORPION_STING_CRIT")
    part:limb_type("tail")
    part:armor("bash", 4)
    part:armor("cut", 3)
    part:armor("stab", 2)
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tail_thick",
        name = ccb.content.text("thick tail"),
        plural_name = "",
        accusative = ccb.content.text("thick tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("thick tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("Th TAIL"),
        smash_message = ccb.content.text("You thwap %s with your tail."),
        hit_size = 8,
        hit_difficulty = 0.5,
        base_health = 35,
        drench_capacity = 700,
        smash_efficiency = 0.45,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 3,
        encumbrance_limit = 25,
        health_limit = 10,
        technique_encumbrance_limit = 5,
        main_part = "torso",
        similar_body_part = "tail",
        fire_warmth_c = 0.3,
    }
    part:sub_part("tail_thick_base")
    part:sub_part("tail_thick_center")
    part:sub_part("tail_thick_tip")
    part:technique("TAIL_THICK_BASH")
    part:technique("TAIL_THICK_BASH_NATURAL")
    part:technique("TAIL_THICK_BASH_CRIT_VS_STUMBLE")
    part:limb_type("tail")
    part:limb_score("balance", 0.05)
    part:limb_score("reaction", 0.05)
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tail_club",
        name = ccb.content.text("club tail"),
        plural_name = "",
        accusative = ccb.content.text("club tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("club tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("Cl TAIL"),
        smash_message = ccb.content.text("You smash %s with your tail."),
        hit_size = 8,
        hit_difficulty = 0.5,
        base_health = 40,
        drench_capacity = 700,
        smash_efficiency = 0.45,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 3,
        encumbrance_limit = 25,
        health_limit = 10,
        technique_encumbrance_limit = 5,
        main_part = "torso",
        similar_body_part = "tail",
        fire_warmth_c = 0.3,
    }
    part:sub_part("tail_club_base")
    part:sub_part("tail_club_center")
    part:sub_part("tail_club_club")
    part:technique("TAIL_CLUB_BASH")
    part:technique("TAIL_CLUB_BASH_VS_LARGE")
    part:technique("TAIL_CLUB_BASH_NATURAL")
    part:technique("TAIL_CLUB_BASH_NATURAL_VS_LARGE")
    part:technique("TAIL_CLUB_BASH_CRIT")
    part:limb_type("tail")
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tail_bovine",
        name = ccb.content.text("cattle tail"),
        plural_name = "",
        accusative = ccb.content.text("cattle tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("cattle tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("C TAIL"),
        smash_message = ccb.content.text("You thwap %s with your tail."),
        hit_size = 3,
        hit_difficulty = 0.1,
        base_health = 15,
        drench_capacity = 300,
        wet_morale = -15,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 6,
        encumbrance_limit = 15,
        health_limit = 2,
        main_part = "torso",
        similar_body_part = "tail",
        fire_warmth_c = 0.3,
    }
    part:sub_part("tail_bovine_base")
    part:sub_part("tail_bovine_center")
    part:sub_part("tail_bovine_tip")
    part:limb_type("tail")
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tail_raptor",
        name = ccb.content.text("raptor tail"),
        plural_name = "",
        accusative = ccb.content.text("raptor tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("raptor tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("Rp TAIL"),
        smash_message = ccb.content.text("You thwap %s with your tail."),
        hit_size = 6,
        hit_difficulty = 0.4,
        base_health = 25,
        drench_capacity = 700,
        wet_morale = -2,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 9,
        encumbrance_limit = 25,
        health_limit = 5,
        main_part = "torso",
        similar_body_part = "tail",
        fire_warmth_c = 0.5,
    }
    part:sub_part("tail_raptor_base")
    part:sub_part("tail_raptor_center")
    part:sub_part("tail_raptor_tip")
    part:limb_type("tail")
    part:limb_score("balance", 0.08)
    part:limb_score("reaction", 0.15)
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
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "tail_finned",
        name = ccb.content.text("finned tail"),
        plural_name = "",
        accusative = ccb.content.text("finned tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("finned tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("Fi TAIL"),
        smash_message = ccb.content.text("You thwap %s with your tail."),
        hit_size = 7,
        hit_difficulty = 0.5,
        base_health = 30,
        drench_capacity = 7000,
        wet_morale = 6,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        squeamish_penalty = 11,
        encumbrance_limit = 25,
        health_limit = 10,
        main_part = "torso",
        similar_body_part = "tail",
        fire_warmth_c = 0.5,
    }
    part:sub_part("tail_finned_base")
    part:sub_part("tail_finned_center")
    part:sub_part("tail_finned_tip")
    part:limb_type("tail")
    part:limb_score("swim", 2)
    part:limb_score("reaction", 0.05)
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
    content.add(part)
end

-- This is a separate part so that the various furs don't provide armor coverage
do
    local part = content.BodyPart {
        id = "tail_rat",
        name = ccb.content.text("rat tail"),
        plural_name = "",
        accusative = ccb.content.text("rat tail", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("rat tail"),
        plural_heading = ccb.content.text("tails"),
        encumbrance_text = ccb.content.text("Balance is hampered."),
        hp_bar_text = ccb.content.text("R TAIL"),
        smash_message = ccb.content.text("You thwap %s with your tail."),
        hit_size = 6,
        hit_difficulty = 0.4,
        base_health = 25,
        drench_capacity = 700,
        smash_efficiency = 0.25,
        hot_morale = 2,
        cold_morale = 2,
        encumbrance_limit = 25,
        health_limit = 5,
        main_part = "torso",
        similar_body_part = "tail_rat",
        fire_warmth_c = 0.3,
    }
    part:sub_part("tail_rat_base")
    part:sub_part("tail_rat_center")
    part:sub_part("tail_rat_tip")
    part:limb_type("tail")
    part:limb_score("balance", 0.05)
    part:limb_score("reaction", 0.15)
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
    content.add(part)
end
