local ccb = require("ccb")
local content = ccb.content

do
    local part = content.BodyPart {
        id = "karma_arm_up_r",
        name = ccb.content.text("upper right karma arm"),
        plural_name = ccb.content.text("upper karma arms"),
        accusative = ccb.content.text("upper right karma arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("upper karma arms", "bodypart_accusative"),
        heading = ccb.content.text("up. r. karma arm"),
        plural_heading = ccb.content.text("up. karma arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("UP R K ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 100,
        heal_bonus = 5,
        mend_rate = 1000,
        smash_efficiency = 1.5,
        connected_to = "torso",
        opposite = "karma_arm_up_l",
        side = "right",
    }
    part:sub_part("karma_hand")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_HEAL")
    part:flag("HEAL_OVERRIDE")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.1)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "bleed_karma",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 5,
        duration_scaling = 5,
        max_duration = 120,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "karma_arm_up_l",
        name = ccb.content.text("upper left karma arm"),
        plural_name = ccb.content.text("upper karma arms"),
        accusative = ccb.content.text("upper left karma arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("upper karma arms", "bodypart_accusative"),
        heading = ccb.content.text("up. l. karma arm"),
        plural_heading = ccb.content.text("up. karma arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("UP L K ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 100,
        heal_bonus = 5,
        mend_rate = 1000,
        smash_efficiency = 1.5,
        connected_to = "torso",
        opposite = "karma_arm_up_r",
        side = "left",
    }
    part:sub_part("karma_hand")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_HEAL")
    part:flag("HEAL_OVERRIDE")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.1)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "bleed_karma",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 5,
        duration_scaling = 5,
        max_duration = 120,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "karma_arm_lw_r",
        name = ccb.content.text("lower right karma arm"),
        plural_name = ccb.content.text("lower karma arms"),
        accusative = ccb.content.text("lower right karma arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("lower karma arms", "bodypart_accusative"),
        heading = ccb.content.text("lw. r. karma arm"),
        plural_heading = ccb.content.text("lw. karma arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("LW r K ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 100,
        heal_bonus = 5,
        mend_rate = 1000,
        smash_efficiency = 1.5,
        connected_to = "torso",
        opposite = "karma_arm_lw_l",
        side = "right",
    }
    part:sub_part("karma_hand")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_HEAL")
    part:flag("HEAL_OVERRIDE")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.1)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "bleed_karma",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 5,
        duration_scaling = 5,
        max_duration = 120,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "karma_arm_lw_l",
        name = ccb.content.text("lower left karma arm"),
        plural_name = ccb.content.text("lower karma arms"),
        accusative = ccb.content.text("lower left karma arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("lower karma arms", "bodypart_accusative"),
        heading = ccb.content.text("lw. l. karma arm"),
        plural_heading = ccb.content.text("lw. karma arms"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("LW L K ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 100,
        heal_bonus = 5,
        mend_rate = 1000,
        smash_efficiency = 1.5,
        connected_to = "torso",
        opposite = "karma_arm_lw_r",
        side = "left",
    }
    part:sub_part("karma_hand")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_HEAL")
    part:flag("HEAL_OVERRIDE")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.1)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "bleed_karma",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 5,
        duration_scaling = 5,
        max_duration = 120,
    }
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "stalker_eyes",
        name = ccb.content.text("stalker's eyes"),
        plural_name = "",
        accusative = ccb.content.text("stalker's eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("s. eyes"),
        plural_heading = ccb.content.text("s. eyes"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        limb = false,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("stalker_eye")
    part:sub_part("stalker_eye")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:flag("BIONIC_LIMB")
    part:flag("CRAFT_IN_DARKNESS")
    part:limb_type("sensor")
    part:limb_score("vision", 2.0)
    part:limb_score("night_vis", 12)
    part:limb_score("reaction", 1.4)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "gracken_eyes",
        name = ccb.content.text("gracken's eyes"),
        plural_name = "",
        accusative = ccb.content.text("gracken's eyes", "bodypart_accusative"),
        plural_accusative = "",
        heading = ccb.content.text("s. eyes"),
        plural_heading = ccb.content.text("s. eyes"),
        encumbrance_text = ccb.content.text("Ranged combat is hampered."),
        hp_bar_text = "",
        smash_message = ccb.content.text("You use your flippin' face to smash the %s.  EXTREME."),
        hit_size = 0.5,
        hit_difficulty = 1.15,
        limb = false,
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("stalker_eye")
    part:sub_part("stalker_eye")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:limb_type("sensor")
    part:limb_score("vision", 1.0)
    part:limb_score("night_vis", 1.5)
    part:limb_score("reaction", 1)
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
        id = "devil_tail",
        name = ccb.content.text("devil's tail"),
        plural_name = ccb.content.text("devil's tails"),
        accusative = ccb.content.text("devil's tail", "bodypart_accusative"),
        plural_accusative = ccb.content.text("devil's tails", "bodypart_accusative"),
        heading = ccb.content.text("d. tail"),
        plural_heading = ccb.content.text("d. tails"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("D. TAIL"),
        smash_message = ccb.content.text("You smash %s with your tail!"),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 100,
        heal_bonus = 5,
        mend_rate = 1000,
        smash_efficiency = 1.5,
        connected_to = "torso",
        side = "right",
    }
    part:sub_part("devil_tail_tip")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_HEAL")
    part:flag("HEAL_OVERRIDE")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:technique("tec_devil_tail_puncture")
    part:technique("tec_devil_tail_wide")
    part:technique("tec_devil_tail_grab")
    part:limb_type("tail")
    part:limb_score("manip", 0.1, 0.2)
    part:limb_score("lift", 0.35)
    part:limb_score("balance", 0.7)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:unarmed_damage("cut", 14)
    part:unarmed_damage("bullet", 1)
    part:unarmed_damage("bash", 1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "assist_arm_r",
        name = ccb.content.text("right assistant's arm"),
        plural_name = ccb.content.text("right assistant's arms"),
        accusative = ccb.content.text("right assistant's arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("right assistant's arms", "bodypart_accusative"),
        heading = ccb.content.text("r. assist arm"),
        plural_heading = ccb.content.text("assist arms"),
        encumbrance_text = ccb.content.text("Crafting is hampered."),
        hp_bar_text = ccb.content.text("R A ARM"),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 25,
        connected_to = "torso",
        opposite = "assist_arm_l",
        side = "right",
    }
    part:sub_part("assist_hand")
    part:flag("IGNORE_TEMP")
    part:flag("BIONIC_LIMB")
    part:limb_type("arm")
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "assist_arm_l",
        name = ccb.content.text("left assistant's arm"),
        plural_name = ccb.content.text("left assistant's arms"),
        accusative = ccb.content.text("left assistant's arm", "bodypart_accusative"),
        plural_accusative = ccb.content.text("left assistant's arms", "bodypart_accusative"),
        heading = ccb.content.text("l. assist arm"),
        plural_heading = ccb.content.text("assist arms"),
        encumbrance_text = ccb.content.text("Crafting is hampered."),
        hp_bar_text = ccb.content.text("L A ARM"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_size = 13,
        hit_difficulty = 0.95,
        base_health = 100,
        heal_bonus = 5,
        mend_rate = 1000,
        smash_efficiency = 1.5,
        connected_to = "torso",
        opposite = "assist_arm_r",
        side = "left",
    }
    part:sub_part("assist_hand")
    part:flag("IGNORE_TEMP")
    part:flag("ALWAYS_HEAL")
    part:flag("HEAL_OVERRIDE")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:limb_type("arm")
    part:limb_score("grip", 0)
    part:limb_score("manip", 0)
    part:limb_score("lift", 0)
    part:limb_score("reaction", 0.1)
    part:limb_score("block", 1.0)
    part:limb_score("swim", 0.1)
    part:limb_score("crawl", 0.3)
    part:hit_effect {
        id = "bleed_karma",
        damage_threshold = 5,
        scale_increment = 2,
        duration = 5,
        duration_scaling = 5,
        max_duration = 120,
    }
    content.add(part)
end

-- I need to make this come from a bionic, and then have expansion traits that increase the number of slots available via bionic_slot_bonus
do
    local part = content.BodyPart {
        id = "data_shunt",
        name = ccb.content.text("data shunt interface"),
        plural_name = ccb.content.text("data shunt interfaces"),
        accusative = ccb.content.text("data shunt", "bodypart_accusative"),
        plural_accusative = ccb.content.text("data shunts", "bodypart_accusative"),
        heading = ccb.content.text("data shunt"),
        plural_heading = ccb.content.text("data shunt"),
        encumbrance_text = "",
        hp_bar_text = "",
        hit_difficulty = 0,
        base_health = 100,
        limb = false,
        bionic_slots = 3,
        main_part = "head",
        side = "left",
    }
    part:limb_type("other")
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "salamander_wing_r",
        name = ccb.content.text("right wing"),
        plural_name = ccb.content.text("right wings"),
        accusative = ccb.content.text("right wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("right wings", "bodypart_accusative"),
        heading = ccb.content.text("r. wing"),
        plural_heading = ccb.content.text("r. wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("R WING"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_difficulty = 0.01,
        base_health = 100,
        heal_bonus = 20,
        mend_rate = 1000,
        smash_efficiency = 0.1,
        connected_to = "torso",
        opposite = "salamander_wing_l",
        side = "right",
    }
    part:sub_part("salamander_wing_subpart_r")
    part:flag("IGNORE_TEMP")
    part:flag("WING_ARMS")
    part:flag("WINGS_2")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("HEAL_OVERRIDE")
    part:flag("ALWAYS_HEAL")
    part:flag("NON_FLESH_LIMB")
    part:technique("TECH_SALAMANDER_WING_BUFFET")
    part:limb_type("wing")
    part:unarmed_damage("heat", 10)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "salamander_wing_l",
        name = ccb.content.text("left wing"),
        plural_name = ccb.content.text("left wings"),
        accusative = ccb.content.text("left wing", "bodypart_accusative"),
        plural_accusative = ccb.content.text("left wings", "bodypart_accusative"),
        heading = ccb.content.text("l. wing"),
        plural_heading = ccb.content.text("l. wings"),
        encumbrance_text = ccb.content.text("Melee combat is hampered."),
        hp_bar_text = ccb.content.text("L WING"),
        smash_message = ccb.content.text("You elbow-smash the %s."),
        hit_difficulty = 0.01,
        base_health = 100,
        heal_bonus = 20,
        mend_rate = 1000,
        smash_efficiency = 0.1,
        connected_to = "torso",
        opposite = "salamander_wing_r",
        side = "left",
    }
    part:sub_part("salamander_wing_subpart_l")
    part:flag("IGNORE_TEMP")
    part:flag("WING_ARMS")
    part:flag("WINGS_2")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("HEAL_OVERRIDE")
    part:flag("ALWAYS_HEAL")
    part:flag("NON_FLESH_LIMB")
    part:technique("TECH_SALAMANDER_WING_BUFFET")
    part:limb_type("wing")
    part:unarmed_damage("heat", 10)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "fae_eyes_arvore",
        name = ccb.content.text("eyes"),
        plural_name = "",
        accusative = ccb.content.text("eyes", "bodypart_accusative"),
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
        encumbrance_limit = 60,
        main_part = "head",
    }
    part:sub_part("eyes_arvore_left")
    part:sub_part("eyes_arvore_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:conditional_flag("GLARE_RESIST")
    part:limb_type("sensor")
    part:limb_score("vision", 1.25)
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
        id = "fae_eyes_homullus",
        name = ccb.content.text("eyes"),
        plural_name = "",
        accusative = ccb.content.text("eyes", "bodypart_accusative"),
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
    part:sub_part("eyes_homullus_left")
    part:sub_part("eyes_homullus_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:conditional_flag("GLARE_RESIST")
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
        id = "fae_eyes_ierde",
        name = ccb.content.text("eyes"),
        plural_name = "",
        accusative = ccb.content.text("eyes", "bodypart_accusative"),
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
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_ierde_left")
    part:sub_part("eyes_ierde_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:conditional_flag("GLARE_RESIST")
    part:conditional_flag("SEESLEEP")
    part:limb_type("sensor")
    part:limb_score("vision", 1.0)
    part:limb_score("night_vis", 1.5)
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
        id = "fae_eyes_salamander",
        name = ccb.content.text("eyes"),
        plural_name = "",
        accusative = ccb.content.text("eyes", "bodypart_accusative"),
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
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_salamander_left")
    part:sub_part("eyes_salamander_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:conditional_flag("GLARE_RESIST")
    part:conditional_flag("THERMOMETER")
    part:limb_type("sensor")
    part:limb_score("vision", 1.25)
    part:limb_score("night_vis", 0.6)
    part:limb_score("reaction", 0.95)
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
        id = "fae_eyes_sylph",
        name = ccb.content.text("eyes"),
        plural_name = "",
        accusative = ccb.content.text("eyes", "bodypart_accusative"),
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
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_sylph_left")
    part:sub_part("eyes_sylph_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:conditional_flag("GLARE_RESIST")
    part:limb_type("sensor")
    part:limb_score("vision", 1.5)
    part:limb_score("night_vis", 1.0)
    part:limb_score("reaction", 1.1)
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
        id = "fae_eyes_undine",
        name = ccb.content.text("eyes"),
        plural_name = "",
        accusative = ccb.content.text("eyes", "bodypart_accusative"),
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
        encumbrance_limit = 60,
        main_part = "head",
        similar_body_part = "eyes",
    }
    part:sub_part("eyes_undine_left")
    part:sub_part("eyes_undine_right")
    part:flag("IGNORE_TEMP")
    part:flag("LIMB_UPPER")
    part:conditional_flag("GLARE_RESIST")
    part:conditional_flag("EYE_MEMBRANE")
    part:conditional_flag("SWIM_GOGGLES")
    part:conditional_flag("SEESLEEP")
    part:limb_type("sensor")
    part:limb_score("vision", 1.0)
    part:limb_score("night_vis", 1.3)
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
        id = "wing_gossamer_l",
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
        hit_difficulty = 1.1,
        base_health = 45,
        drench_capacity = 150,
        heal_bonus = 1,
        mend_rate = 5,
        drying_rate = 2,
        encumbrance_limit = 5,
        health_limit = 10,
        connected_to = "torso",
        opposite = "wing_gossamer_r",
        side = "left",
    }
    part:sub_part("wing_gossamer_basal_l")
    part:sub_part("wing_gossamer_forewing_l")
    part:sub_part("wing_gossamer_hindwing_l")
    part:flag("IGNORE_TEMP")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:flag("HEAL_OVERRIDE")
    part:flag("MEND_LIMB")
    part:flag("LIMB_UPPER")
    part:flag("WING_ARMS")
    part:limb_type("wing")
    part:limb_score("reaction", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "wing_gossamer_r",
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
        hit_difficulty = 1.1,
        base_health = 45,
        drench_capacity = 150,
        heal_bonus = 1,
        mend_rate = 5,
        drying_rate = 2,
        encumbrance_limit = 5,
        health_limit = 10,
        connected_to = "torso",
        opposite = "wing_gossamer_l",
        side = "right",
    }
    part:sub_part("wing_gossamer_basal_r")
    part:sub_part("wing_gossamer_forewing_r")
    part:sub_part("wing_gossamer_hindwing_r")
    part:flag("IGNORE_TEMP")
    part:flag("NO_LIMB_FIRST_AID")
    part:flag("NON_FLESH_LIMB")
    part:flag("HEAL_OVERRIDE")
    part:flag("MEND_LIMB")
    part:flag("LIMB_UPPER")
    part:flag("WING_ARMS")
    part:limb_type("wing")
    part:limb_score("reaction", 0.1)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "wing_strix_l",
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
        opposite = "wing_strix_r",
        side = "left",
        similar_body_part = "wing_l",
    }
    part:sub_part("wing_strix_shoulder_l")
    part:sub_part("wing_strix_upper_l")
    part:sub_part("wing_strix_joint_l")
    part:sub_part("wing_strix_lower_l")
    part:conditional_flag("WING_ARMS")
    part:conditional_flag("LIMB_UPPER")
    part:technique("tech_strix_wing_slap")
    part:limb_type("wing")
    part:limb_score("reaction", 0.1)
    part:unarmed_damage("bash", 0)
    content.add(part)
end

do
    local part = content.BodyPart {
        id = "wing_strix_r",
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
        opposite = "wing_strix_l",
        side = "right",
        similar_body_part = "wing_r",
    }
    part:sub_part("wing_strix_shoulder_r")
    part:sub_part("wing_strix_upper_r")
    part:sub_part("wing_strix_joint_r")
    part:sub_part("wing_strix_lower_r")
    part:conditional_flag("WING_ARMS")
    part:conditional_flag("LIMB_UPPER")
    part:technique("tech_strix_wing_slap")
    part:limb_type("wing")
    part:limb_score("reaction", 0.1)
    part:unarmed_damage("bash", 0)
    content.add(part)
end
