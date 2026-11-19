local ccb = require("ccb")

-- I don't know if I'll make any advanced proficiencies for changeling recipes but I'd like to at least have some base level ones.
ccb.content.define_proficiency {
    id = "prof_aelfen_tailoring",
    category = "prof_tailoring",
    name = ccb.content.text("Aelfen Tailoring Techniques"),
    description = ccb.content.text("Working with materials from other dimensions is never easy.  But this definitely improves your ability to work on fabrics and furs from the lands under the hill."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 1.15,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_moonstearssmithing",
    category = "prof_smithing",
    name = ccb.content.text("Selenic Forging"),
    description = ccb.content.text("The art of turning the tears of the moon into weapons and armor, light and impossibly sharp."),
    can_learn = true,
    time_multiplier = 3,
    skill_penalty = 0.25,
    time_to_learn = "14 h",
    requires = { "prof_blacksmithing" },
}

ccb.content.define_proficiency_category {
    id = "prof_dreamsmithing",
    name = ccb.content.text("Dreamsmithing"),
    description = ccb.content.text("Proficiencies for using your magic abilities to cast items with thaumaturgical abilities."),
}

ccb.content.define_proficiency {
    id = "prof_dreamsmithing",
    category = "prof_dreamsmithing",
    name = ccb.content.text("Basics of Dreamsmithing"),
    description = ccb.content.text("You know how you use your mind to transform dreamdross into basic shapes."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0,
    time_to_learn = "2 h",
}

ccb.content.define_proficiency {
    id = "prof_dreamsmithing_weapon",
    category = "prof_dreamsmithing",
    name = ccb.content.text("Dreamsmithing of Weapons"),
    description = ccb.content.text("Your knowledge has grown, and you know how to shape dreamdross into a weapon of terrible power."),
    requires = { "prof_dreamsmithing" },
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0,
    time_to_learn = "4 h",
}

ccb.content.define_proficiency {
    id = "prof_dreamsmithing_armor",
    category = "prof_dreamsmithing",
    name = ccb.content.text("Dreamsmithing of Armor"),
    description = ccb.content.text("Your knowledge has grown, and you know how to shape dreamdross into an indestructible armor."),
    requires = { "prof_dreamsmithing" },
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0,
    time_to_learn = "4 h",
}

ccb.content.define_proficiency {
    id = "prof_dreamsmithing_peak",
    category = "prof_dreamsmithing",
    name = ccb.content.text("Dreamsmithing"),
    description = ccb.content.text("Your mind and feeling are the one.  Your items are impossible.  Your dreamdross could be everything."),
    requires = { "prof_dreamsmithing" },
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency_category {
    id = "prof_lucid_dreaming",
    name = ccb.content.text("Lucid Dreaming"),
    description = ccb.content.text("The ability to control your dreams during sleep."),
}

ccb.content.define_proficiency {
    id = "prof_lucid_dreaming",
    category = "prof_lucid_dreaming",
    name = ccb.content.text("Lucid Dreaming"),
    description = ccb.content.text("The ability to control your dreams during sleep."),
    can_learn = true,
    time_to_learn = "16 h",
    time_multiplier = 1,
    skill_penalty = 0.1,
}
