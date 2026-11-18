local content = require("ccb").content

local BRISK_EXERCISE = 6

-- At this level, anything will do that isn't like, a microwave, but I don't want to bloat out the list.
content.add(content.Recipe {
    id = "prac_melee_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("melee (beginner)"),
    description = content.text("Swing around a weapon-shaped object to try and get a feel for what fighting might be like.  It's difficult without any instruction to guide you, but hopefully this practice will help you to swing at your enemies without falling on your face or panicking too much."),
    skill = "melee",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = true,
}
    :tool_any({
            { id = "improvised_melee_weapons", charges = 1, requirement = true },
            { id = "basic_shivs", charges = 1, requirement = true },
            { id = "real_shivs", charges = 1, requirement = true },
            { id = "real_claws", charges = 1, requirement = true },
            { id = "basic_hooks", charges = 1, requirement = true },
            { id = "real_hooks", charges = 1, requirement = true },
            { id = "basic_knives", charges = 1, requirement = true },
            { id = "real_knives", charges = 1, requirement = true },
            { id = "basic_thrusting_swords", charges = 1, requirement = true },
            { id = "real_thrusting_swords", charges = 1, requirement = true },
            { id = "basic_short_swords", charges = 1, requirement = true },
            { id = "real_short_swords", charges = 1, requirement = true },
            { id = "basic_medium_swords", charges = 1, requirement = true },
            { id = "real_medium_swords", charges = 1, requirement = true },
            { id = "basic_long_swords", charges = 1, requirement = true },
            { id = "real_long_swords", charges = 1, requirement = true },
            { id = "basic_great_swords", charges = 1, requirement = true },
            { id = "real_great_swords", charges = 1, requirement = true },
            { id = "basic_axes", charges = 1, requirement = true },
            { id = "real_axes", charges = 1, requirement = true },
            { id = "real_great_axes", charges = 1, requirement = true },
            { id = "basic_batons", charges = 1, requirement = true },
            { id = "real_batons", charges = 1, requirement = true },
            { id = "basic_flails", charges = 1, requirement = true },
            { id = "real_flails", charges = 1, requirement = true },
            { id = "basic_great_hammers", charges = 1, requirement = true },
            { id = "real_great_hammers", charges = 1, requirement = true },
            { id = "basic_maces", charges = 1, requirement = true },
            { id = "real_maces", charges = 1, requirement = true },
            { id = "basic_quarterstaves", charges = 1, requirement = true },
            { id = "real_quarterstaves", charges = 1, requirement = true },
            { id = "basic_polearms", charges = 1, requirement = true },
            { id = "real_polearms", charges = 1, requirement = true },
            { id = "basic_spears", charges = 1, requirement = true },
            { id = "real_spears", charges = 1, requirement = true }
        })
    :learn_automatically("melee", 0)
)

content.add(content.Recipe {
    id = "prac_melee_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("melee (intermediate)"),
    description = content.text("Practice the basics of combat with the guidance of a manual or prior knowledge.  Even without a sparring partner you can practice your footwork, form, and flow drills to help avoid overswinging and stumbling."),
    skill = "melee",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_any({
            { id = "improvised_melee_weapons", charges = 1, requirement = true },
            { id = "basic_shivs", charges = 1, requirement = true },
            { id = "real_shivs", charges = 1, requirement = true },
            { id = "real_claws", charges = 1, requirement = true },
            { id = "basic_hooks", charges = 1, requirement = true },
            { id = "real_hooks", charges = 1, requirement = true },
            { id = "basic_knives", charges = 1, requirement = true },
            { id = "real_knives", charges = 1, requirement = true },
            { id = "basic_thrusting_swords", charges = 1, requirement = true },
            { id = "real_thrusting_swords", charges = 1, requirement = true },
            { id = "basic_short_swords", charges = 1, requirement = true },
            { id = "real_short_swords", charges = 1, requirement = true },
            { id = "basic_medium_swords", charges = 1, requirement = true },
            { id = "real_medium_swords", charges = 1, requirement = true },
            { id = "basic_long_swords", charges = 1, requirement = true },
            { id = "real_long_swords", charges = 1, requirement = true },
            { id = "basic_great_swords", charges = 1, requirement = true },
            { id = "real_great_swords", charges = 1, requirement = true },
            { id = "basic_axes", charges = 1, requirement = true },
            { id = "real_axes", charges = 1, requirement = true },
            { id = "real_great_axes", charges = 1, requirement = true },
            { id = "basic_batons", charges = 1, requirement = true },
            { id = "real_batons", charges = 1, requirement = true },
            { id = "basic_flails", charges = 1, requirement = true },
            { id = "real_flails", charges = 1, requirement = true },
            { id = "basic_great_hammers", charges = 1, requirement = true },
            { id = "real_great_hammers", charges = 1, requirement = true },
            { id = "basic_maces", charges = 1, requirement = true },
            { id = "real_maces", charges = 1, requirement = true },
            { id = "basic_quarterstaves", charges = 1, requirement = true },
            { id = "real_quarterstaves", charges = 1, requirement = true },
            { id = "basic_polearms", charges = 1, requirement = true },
            { id = "real_polearms", charges = 1, requirement = true },
            { id = "basic_spears", charges = 1, requirement = true },
            { id = "real_spears", charges = 1, requirement = true }
        })
    :learn_automatically("melee", 3)
    :book("mag_melee", 1)
    :book("manual_melee", 1)
)

-- Can use any weapon that cuts.
content.add(content.Recipe {
    id = "prac_cutting_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("cutting (beginner)"),
    description = content.text("Practice some of the basics of combat with cutting weapons, such as how to keep your edge lined up and how to not chop your own leg off."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_shivs", charges = 1, requirement = true },
            { id = "real_shivs", charges = 1, requirement = true },
            { id = "real_claws", charges = 1, requirement = true },
            { id = "basic_hooks", charges = 1, requirement = true },
            { id = "real_hooks", charges = 1, requirement = true },
            { id = "basic_knives", charges = 1, requirement = true },
            { id = "real_knives", charges = 1, requirement = true },
            { id = "basic_short_swords", charges = 1, requirement = true },
            { id = "real_short_swords", charges = 1, requirement = true },
            { id = "basic_medium_swords", charges = 1, requirement = true },
            { id = "real_medium_swords", charges = 1, requirement = true },
            { id = "basic_long_swords", charges = 1, requirement = true },
            { id = "real_long_swords", charges = 1, requirement = true },
            { id = "basic_great_swords", charges = 1, requirement = true },
            { id = "real_great_swords", charges = 1, requirement = true },
            { id = "basic_axes", charges = 1, requirement = true },
            { id = "real_axes", charges = 1, requirement = true },
            { id = "real_great_axes", charges = 1, requirement = true },
            { id = "basic_polearms", charges = 1, requirement = true },
            { id = "real_polearms", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :book("mag_cutting", 0)
    :book("manual_cutting", 0)
)

-- Only real and powerful cutting weapons.
-- A bunch of duct tape and scrap to repair the dummy with each training session.
content.add(content.Recipe {
    id = "prac_cutting_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("cutting (intermediate)"),
    description = content.text("Practice your edge alignment and cutting form by slashing soaked rolled-up paper on a stand.  It's not quite tatami mats but you don't have the luxury of historical accuracy."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_any({
            { id = "real_shivs", charges = 1, requirement = true },
            { id = "real_claws", charges = 1, requirement = true },
            { id = "real_hooks", charges = 1, requirement = true },
            { id = "real_knives", charges = 1, requirement = true },
            { id = "real_short_swords", charges = 1, requirement = true },
            { id = "real_medium_swords", charges = 1, requirement = true },
            { id = "real_long_swords", charges = 1, requirement = true },
            { id = "real_great_swords", charges = 1, requirement = true },
            { id = "real_axes", charges = 1, requirement = true },
            { id = "real_great_axes", charges = 1, requirement = true },
            { id = "real_polearms", charges = 1, requirement = true }
        })
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("duct_tape", 10)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("paper", 10)
    :quality("HAMMER", 2, 1)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :book("mag_cutting", 2)
    :book("manual_cutting", 2)
)

-- Only training weapons or light and easy to use weapons, a war hammer is a good weapon but you should not
-- start your training with one.
content.add(content.Recipe {
    id = "prac_bashing_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("bashing (beginner)"),
    description = content.text("Practice the basics of fighting with bludgeons, both purpose-made and impromptu.  Learn how to apply your leverage, maximize kinetic energy, and to swing for the fences without tearing your shoulder out of its socket."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_batons", charges = 1, requirement = true },
            { id = "real_batons", charges = 1, requirement = true },
            { id = "basic_flails", charges = 1, requirement = true },
            { id = "real_flails", charges = 1, requirement = true },
            { id = "basic_great_hammers", charges = 1, requirement = true },
            { id = "real_great_hammers", charges = 1, requirement = true },
            { id = "basic_maces", charges = 1, requirement = true },
            { id = "real_maces", charges = 1, requirement = true },
            { id = "basic_quarterstaves", charges = 1, requirement = true },
            { id = "real_quarterstaves", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 2)
    :book("mag_bashing", 0)
    :book("manual_bashing", 0)
)

-- Only large, top-heavy bashing weapons or axes.
-- A bunch of duct tape and scrap to repair the dummy with each training session.
content.add(content.Recipe {
    id = "prac_bashing_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("bashing (intermediate)"),
    description = content.text("Practice the handling of very top-heavy and weighty bludgeons.  Learn how to swing fast, accurately, with force, and without throwing yourself for a loop.  You'll need a reinforced training dummy to not break it into splinters with such heavy weaponry, though."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_any({
            { id = "real_batons", charges = 1, requirement = true },
            { id = "real_flails", charges = 1, requirement = true },
            { id = "real_great_hammers", charges = 1, requirement = true },
            { id = "real_maces", charges = 1, requirement = true },
            { id = "real_quarterstaves", charges = 1, requirement = true }
        })
    :tool("pseudo_training_dummy_heavy", 1)
    :component("duct_tape", 50)
    :component("scrap", 20)
    :quality("HAMMER", 2, 1)
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 4)
    :book("mag_bashing", 2)
    :book("manual_bashing", 2)
)

content.add(content.Recipe {
    id = "prac_dancing",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("dancing"),
    description = content.text("Practice some dancing moves with your imaginary partner."),
    skill = "dodge",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :learn_automatically("dodge", 2)
    :book("mag_dodge", 0)
    :book("manual_dodge", 0)
)

content.add(content.Recipe {
    id = "prac_dodge_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("dodge (beginner)"),
    description = content.text("Practice your dodging with some side hops, backsteps, and maybe a somersault or two to learn why you shouldn't somersault in a fight.  Without someone attacking you to actually dodge all you can practice is footwork, but hopefully it'll help prevent you tripping over your shoelaces in a panic."),
    skill = "dodge",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = true,
}
    :learn_automatically("dodge", 0)
)

content.add(content.Recipe {
    id = "prac_unarmed_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("unarmed (beginner)"),
    description = content.text("Do a bit of shadowboxing as practice just in case you're left without a weapon versus the undead.  There's not much you can learn without someone to correct your mistakes, though."),
    skill = "unarmed",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = true,
}
    :learn_automatically("unarmed", 0)
    :proficiency("prof_unarmed_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_unarmed_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("unarmed (intermediate)"),
    description = content.text("Learn how to throw a punch with the help of a punching bag or training dummy."),
    skill = "unarmed",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 },
            { id = "pseudo_punching_bag", count = 1 }
        })
    :learn_automatically("unarmed", 3)
    :book("mag_unarmed", 1)
    :book("manual_brawl", 1)
    :proficiency("prof_unarmed_familiar", { required = true })
    :proficiency("prof_unarmed_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_long_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("long swords (beginner)"),
    description = content.text("Drill the fundamentals of using a longsword."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_long_swords", charges = 1, requirement = true },
            { id = "real_long_swords", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :book("mag_cutting", 1)
    :book("manual_swords", 0)
    :proficiency("prof_long_swords_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

-- Standard Blade Training Cost
content.add(content.Recipe {
    id = "prac_cutting_int_long_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("long swords (intermediate)"),
    description = content.text("Hone your skills with a longsword against a dummy."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_long_swords", 1, true)
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("duct_tape", 10)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("paper", 10)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :book("mag_cutting", 3)
    :book("manual_swords", 2)
    :proficiency("prof_long_swords_familiar", { required = true })
    :proficiency("prof_long_swords_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_great_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("great swords (beginner)"),
    description = content.text("Practice swinging your great sword against an imaginary opponent."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_great_swords", charges = 1, requirement = true },
            { id = "real_great_swords", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :book("mag_cutting", 1)
    :book("manual_swords", 0)
    :proficiency("prof_great_swords_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

-- Standard Blade Training Cost
content.add(content.Recipe {
    id = "prac_cutting_int_great_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("great swords (intermediate)"),
    description = content.text("Practice using your sword's momentum to your advantage against a dummy."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_great_swords", 1, true)
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("duct_tape", 10)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("paper", 10)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :book("mag_cutting", 3)
    :book("manual_swords", 2)
    :proficiency("prof_great_swords_familiar", { required = true })
    :proficiency("prof_great_swords_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_bionic_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("bionic swords (beginner)"),
    description = content.text("Get a feel for the weight, balance, and length of your bionic sword."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool("bio_blade_weapon", 1)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :proficiency("prof_bionic_swords_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

-- Standard Blade Training Cost
content.add(content.Recipe {
    id = "prac_cutting_int_bionic_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("bionic swords (intermediate)"),
    description = content.text("Practice fighting with your bionic sword against a dummy."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool("bio_blade_weapon", 1)
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("duct_tape", 10)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("paper", 10)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :proficiency("prof_bionic_swords_familiar", { required = true })
    :proficiency("prof_bionic_swords_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_great_axe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("great axes (beginner)"),
    description = content.text("Drill keeping the proper form while swinging a heavy axe."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_charges("real_great_axes", 1, true)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :proficiency("prof_great_axes_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_int_great_axe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("great axes (intermediate)"),
    description = content.text("Engage in advanced exercises and drills using a heavy axe."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_great_axes", 1, true)
    :tool("pseudo_training_dummy_heavy", 1)
    :component("duct_tape", 50)
    :component("scrap", 20)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :proficiency("prof_great_axes_familiar", { required = true })
    :proficiency("prof_great_axes_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_hand_axe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("hand axes (beginner)"),
    description = content.text("Practice your chopping motions against an imaginary assailant."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_charges("handaxes_axes", 1, true)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :proficiency("prof_hand_axes_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_int_hand_axe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("hand axes (intermediate)"),
    description = content.text("Practice advanced methods of using a hand axe in combat, such as pommel strikes and backswings."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("handaxes_axes", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :proficiency("prof_hand_axes_familiar", { required = true })
    :proficiency("prof_hand_axes_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_beg_great_hammer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("great hammers (beginner)"),
    description = content.text("Work on handling the weight of your great hammer while swinging it."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_great_hammers", charges = 1, requirement = true },
            { id = "real_great_hammers", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 2)
    :proficiency("prof_great_hammers_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_int_great_hammer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("great hammers (intermediate)"),
    description = content.text("Practice your strikes with a great hammer, crushing the dummy without throwing yourself off balance."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_great_hammers", 1, true)
    :tool("pseudo_training_dummy_heavy", 1)
    :component("duct_tape", 50)
    :component("scrap", 20)
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 4)
    :proficiency("prof_great_hammers_familiar", { required = true })
    :proficiency("prof_great_hammers_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_beg_flail",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("flails (beginner)"),
    description = content.text("Practice swinging a flail around and drill your endurance by keeping your flail in motion for long periods of time."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_flails", charges = 1, requirement = true },
            { id = "real_flails", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 2)
    :proficiency("prof_flails_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_int_flail",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("flails (intermediate)"),
    description = content.text("Refine your understanding of the fine art of crushing skulls with a flail and a dummy."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_flails", charges = 1, requirement = true },
            { id = "real_flails", charges = 1, requirement = true }
        })
    :tool("pseudo_training_dummy_heavy", 1)
    :component("duct_tape", 50)
    :component("scrap", 20)
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 4)
    :proficiency("prof_flails_familiar", { required = true })
    :proficiency("prof_flails_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_beg_mace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("maces (beginner)"),
    description = content.text("Work at swinging a mace around and making it land where you want."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_maces", charges = 1, requirement = true },
            { id = "real_maces", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 2)
    :proficiency("prof_maces_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_int_mace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("maces (intermediate)"),
    description = content.text("Practice advanced skull splitting techniques."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_maces", 1, true)
    :tool("pseudo_training_dummy_heavy", 1)
    :component("duct_tape", 50)
    :component("scrap", 20)
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 4)
    :proficiency("prof_maces_familiar", { required = true })
    :proficiency("prof_maces_pro", { time_multiplier = 2, skill_penalty = 0 })
)

-- Long stick works as a spear here, no tip is needed to practice form.
content.add(content.Recipe {
    id = "prac_stabbing_beg_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("spears (beginner)"),
    description = content.text("Practice the basics of spears, the most popular melee weapon throughout history.  Learn the footwork, how to thrust with power, where to place your hands, and the right way to hold the damn thing.  Dominant hand back, non-dominant forward!"),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_spears", charges = 1, requirement = true },
            { id = "real_spears", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 2)
    :book("manual_stabbing", 0)
    :proficiency("prof_spears_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_stabbing_int_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("spears (intermediate)"),
    description = content.text("Practice advanced spear moves and accurate thrusts against a training dummy.  It's not glamorous, but spears were the workhorses of armed combat for millennia with good reason."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_spears", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 4)
    :book("manual_stabbing", 2)
    :proficiency("prof_spears_familiar", { required = true })
    :proficiency("prof_spears_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_stabbing_beg_thrust",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("long thrusting swords (beginner)"),
    description = content.text("Practice switching between different ways of gripping your sword."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_thrusting_swords", charges = 1, requirement = true },
            { id = "real_thrusting_swords", charges = 1, requirement = true },
            { id = "zweihander", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 2)
    :proficiency("prof_thrusting_swords_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_stabbing_int_thrust",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("long thrusting swords (intermediate)"),
    description = content.text("Drill yourself in using your sword as a thrusting weapon against a dummy."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_any({
            { id = "real_thrusting_swords", charges = 1, requirement = true },
            { id = "zweihander", count = 1 }
        })
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 4)
    :proficiency("prof_thrusting_swords_familiar", { required = true })
    :proficiency("prof_thrusting_swords_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_beg_rifle",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("rifle CQC (beginner)"),
    description = content.text("Practice striking with your long gun."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :quality("RIFLE", 1, 1)
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 2)
    :proficiency("prof_auto_rifles_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_int_rifle",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("rifle CQC (intermediate)"),
    description = content.text("Practice your muzzle thump and buttstroke against a dummy."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :quality("RIFLE", 1, 1)
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 4)
    :proficiency("prof_auto_rifles_familiar", { required = true })
    :proficiency("prof_auto_rifles_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_beg_pistol",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("pistol CQC (beginner)"),
    description = content.text("Practice safely swinging your pistol around like a club."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :quality("PISTOL", 1, 1)
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 2)
    :proficiency("prof_auto_pistols_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_int_pistol",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("pistol CQC (intermediate)"),
    description = content.text("Pistol whip a dummy repeatedly until you've got it down."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :quality("PISTOL", 1, 1)
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 4)
    :proficiency("prof_auto_pistols_familiar", { required = true })
    :proficiency("prof_auto_pistols_pro", { time_multiplier = 2, skill_penalty = 0 })
)

-- Too many damn knives.  Someone else can flesh out the list if they want, but this should be enough that
-- you'll almost always have at least one of these before you get others.
content.add(content.Recipe {
    id = "prac_stabbing_beg_knife",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("knives (beginner)"),
    description = content.text("Practice the brutal art of shanking the shit out of something until it dies.  Learn the form, where and how to stab to avoid your knife glancing off bone, and whether you should actually hold the knife in reverse grip.  (It depends.)"),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_knives", charges = 1, requirement = true },
            { id = "real_knives", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 2)
    :book("manual_cutting", 1)
    :book("manual_knives", 0)
    :proficiency("prof_knives_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_stabbing_int_knife",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("knives (intermediate)"),
    description = content.text("Get in touch with your inner commando and practice some advanced knife-fighting techniques on a training dummy."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_knives", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 4)
    :book("manual_cutting", 3)
    :book("manual_knives", 2)
    :proficiency("prof_knives_familiar", { required = true })
    :proficiency("prof_knives_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_stabbing_beg_shiv",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("shivs (beginner)"),
    description = content.text("You wouldn't think it, but there is more to stabbing someone with something small and pointy.  Practice shanking an imaginary enemy where it hurts most."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_shivs", charges = 1, requirement = true },
            { id = "real_shivs", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 2)
    :book("manual_knives", 1)
    :book("manual_melee", 1)
    :proficiency("prof_shivs_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_stabbing_int_shiv",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("shivs (intermediate)"),
    description = content.text("Practice shanking the ever living hell out of a dummy to hone your accuracy and grip while you gut someone."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_shivs", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 4)
    :book("manual_knives", 3)
    :book("manual_melee", 3)
    :proficiency("prof_shivs_familiar", { required = true })
    :proficiency("prof_shivs_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_beg_baton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("batons (beginner)"),
    description = content.text("Practice the basics of using a baton or small club in combat."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_batons", charges = 1, requirement = true },
            { id = "real_batons", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 2)
    :book("mag_bashing", 1)
    :book("manual_bashing", 0)
    :proficiency("prof_batons_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_int_baton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("batons (intermediate)"),
    description = content.text("Train your backswing, overhead strike, and up strike against a dummy."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_batons", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 4)
    :book("mag_bashing", 3)
    :book("manual_bashing", 2)
    :proficiency("prof_batons_familiar", { required = true })
    :proficiency("prof_batons_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_med_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("medium swords (beginner)"),
    description = content.text("Footwork is key, practice dancing around an imaginary opponent with your sword."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_medium_swords", charges = 1, requirement = true },
            { id = "real_medium_swords", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :book("mag_cutting", 1)
    :book("manual_swords", 0)
    :proficiency("prof_medium_swords_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

-- Standard Blade Training Cost
content.add(content.Recipe {
    id = "prac_cutting_int_med_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("medium swords (intermediate)"),
    description = content.text("Perform solo drills to practice advanced techniques, such as feints and moulinet cuts."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_medium_swords", 1, true)
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("duct_tape", 10)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("paper", 10)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :book("mag_cutting", 3)
    :book("manual_swords", 2)
    :proficiency("prof_medium_swords_familiar", { required = true })
    :proficiency("prof_medium_swords_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_short_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("short swords (beginner)"),
    description = content.text("Practice putting your weight behind your strike, cutting through an imaginary enemy."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_short_swords", charges = 1, requirement = true },
            { id = "real_short_swords", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :book("mag_cutting", 1)
    :book("manual_swords", 0)
    :proficiency("prof_short_swords_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

-- Standard Blade Training Cost
content.add(content.Recipe {
    id = "prac_cutting_int_short_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("short swords (intermediate)"),
    description = content.text("Practice drills in delivering quick and precise strikes against a dummy."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_short_swords", 1, true)
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("duct_tape", 10)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("paper", 10)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :book("mag_cutting", 3)
    :book("manual_swords", 2)
    :proficiency("prof_short_swords_familiar", { required = true })
    :proficiency("prof_short_swords_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_beg_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("quarterstaves (beginner)"),
    description = content.text("Practice swinging your staff, getting used to the balance and weight."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_quarterstaves", charges = 1, requirement = true },
            { id = "real_quarterstaves", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 2)
    :book("mag_bashing", 1)
    :book("manual_bashing", 0)
    :proficiency("prof_quarterstaves_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_bashing_int_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("quarterstaves (intermediate)"),
    description = content.text("Practice using your staff against a dummy, familiarizing yourself with its length."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_quarterstaves", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 4)
    :book("mag_bashing", 3)
    :book("manual_bashing", 2)
    :proficiency("prof_quarterstaves_familiar", { required = true })
    :proficiency("prof_quarterstaves_pro", { time_multiplier = 2, skill_penalty = 0 })
)

-- Basically anything that works with the fencing MA should work here, but the list is truncated for my
-- sanity.
content.add(content.Recipe {
    id = "prac_stabbing_beg_fencing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("fencing (beginner)"),
    description = content.text("Practice the basics of the noble art of fencing.  Learn how to angle your body, aim your lunges, and parry pretend swords.  Not that the undead are using swords.  Hopefully."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_thrusting_swords", charges = 1, requirement = true },
            { id = "real_thrusting_swords", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 2)
    :book("mag_stabbing", 1)
    :proficiency("prof_fencing_weapons_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_stabbing_int_fencing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("fencing (intermediate)"),
    description = content.text("Further develop your footwork and timing by fighting against a dummy.  En garde!"),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_thrusting_swords", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 4)
    :book("mag_stabbing", 3)
    :book("manual_fencing", 2)
    :proficiency("prof_fencing_weapons_familiar", { required = true })
    :proficiency("prof_fencing_weapons_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_claw",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("claw weapons (beginner)"),
    description = content.text("Practice the basics of fighting with a clawed weapon by shadowboxing while using them."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_charges("real_claws", 1, true)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :proficiency("prof_claws_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_int_claw",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("claw weapons (intermediate)"),
    description = content.text("Practice your strikes against a dummy, focusing on speed, accuracy, and power."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_claws", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :proficiency("prof_claws_familiar", { required = true })
    :proficiency("prof_claws_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_hooking",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("hooking weapons (beginner)"),
    description = content.text("Practice tripping an imaginary enemy with the hook of your weapon in between swings."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_hooks", charges = 1, requirement = true },
            { id = "real_hooks", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :proficiency("prof_hooking_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_int_hooking",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("hooking weapons (intermediate)"),
    description = content.text("Train by hooking a dummy and knocking it to the ground while practicing your footwork."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_hooks", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :proficiency("prof_hooking_familiar", { required = true })
    :proficiency("prof_hooking_pro", { time_multiplier = 2, skill_penalty = 0 })
)

-- Top-heavy reach weapons could all be used to train polearms
content.add(content.Recipe {
    id = "prac_stabbing_beg_polearm",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("polearms (beginner)"),
    description = content.text("Practice slicing and stabbing with your polearm against an imaginary opponent."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "basic_polearms", charges = 1, requirement = true },
            { id = "real_polearms", charges = 1, requirement = true }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 2)
    :book("mag_stabbing", 1)
    :book("manual_stabbing", 0)
    :proficiency("prof_polearms_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_stabbing_int_polearm",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("polearms (intermediate)"),
    description = content.text("Perform solo exercises against a dummy to train your distance management and endurance with a polearm."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("real_polearms", 1, true)
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 4)
    :book("mag_stabbing", 3)
    :book("manual_stabbing", 2)
    :proficiency("prof_polearms_familiar", { required = true })
    :proficiency("prof_polearms_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_beg_bionics",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("bionic weapons (beginner)"),
    description = content.text("Perform basic fighting drills to learn to fight with your new bionic weapons."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "bio_blade_weapon", count = 1 },
            { id = "bio_claws_weapon", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :proficiency("prof_bionics_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_cutting_int_bionics",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("bionic weapons (intermediate)"),
    description = content.text("Drill advanced methods of using your bionic weapons, with the help of a dummy."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_any({
            { id = "bio_blade_weapon", count = 1 },
            { id = "bio_claws_weapon", count = 1 }
        })
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :proficiency("prof_bionics_familiar", { required = true })
    :proficiency("prof_bionics_pro", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_whipping_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("whips (beginner)"),
    description = content.text("Practice the basics of fighting with whips by swinging one around.  Familiarize yourself with the length and accuracy of your unwieldy choice of weapon."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_charges("whips", 1, true)
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 2)
    :proficiency("prof_whips_familiar", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_whipping_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("whips (intermediate)"),
    description = content.text("Improve your accuracy with a whip by attempting to extinguish a candle without damaging the wax."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("whips", 1, true)
    :tool_charges("candle", 10)
    :tool_any({
            { id = "lighter", charges = 1 },
            { id = "ref_lighter", charges = 1 },
            { id = "survival_match", charges = 1 },
            { id = "match", charges = 1 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 4)
    :proficiency("prof_whips_familiar", { required = true })
    :proficiency("prof_whips_pro", { time_multiplier = 2, skill_penalty = 0 })
)
