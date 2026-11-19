local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_alien_biology",
    category = "prof_weakpoint",
    name = ccb.content.text("Principles of Alien Biology"),
    description = ccb.content.text("Very basic familiarity with various types of alien creatures."),
    can_learn = true,
    time_to_learn = "6 h",
    requires = { "prof_intro_biology" },
    weakpoint_bonus = 2,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_gossamer_basic",
    category = "prof_tailoring",
    name = ccb.content.text("Principles of Gossamer Weaving"),
    description = ccb.content.text("It's particularly difficult to turn daydreams and moonlight into clothing, but you seem to have gotten the hang of it."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.1,
    time_to_learn = "12 h",
}

ccb.content.define_proficiency {
    id = "prof_gossamer",
    category = "prof_tailoring",
    name = ccb.content.text("Skilled Gossamer Weaving"),
    description = ccb.content.text("Even the Bright Lords would bid on your clothing if they found it at a Goblin Market."),
    can_learn = true,
    time_multiplier = 3,
    skill_penalty = 0.25,
    time_to_learn = "20 h",
}

ccb.content.define_proficiency {
    id = "prof_treesinging",
    category = "prof_survival",
    name = ccb.content.text("Skilled Treesinging"),
    description = ccb.content.text("The trees always hearken to your voice and wood practically molds itself like clay in your hands."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.25,
    time_to_learn = "16 h",
}

ccb.content.define_proficiency {
    id = "prof_treesinging_equipment",
    category = "prof_survival",
    name = ccb.content.text("Artisan Treesinging"),
    description = ccb.content.text("Not only can you create furniture and other large constructs using treesinging, you can mold treesung wood into weapons and armor as well."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.25,
    time_to_learn = "24 h",
}

ccb.content.define_proficiency {
    id = "prof_paraclesian_computer_understanding",
    category = "prof_misc_craft",
    name = ccb.content.text("Lore of the Thinking Machines"),
    description = ccb.content.text("The mortals have taught objects to think.  Now you too know how to read their thoughts."),
    can_learn = true,
    time_to_learn = "48 h",
    time_multiplier = 2,
    skill_penalty = 0.2,
}

ccb.content.define_proficiency {
    id = "prof_paraclesian_electronics_understanding",
    category = "prof_misc_craft",
    name = ccb.content.text("Lore of the Fulmenwrights"),
    description = ccb.content.text("The mortals have harnessed lightning and put it into boxes.  Now you also hold the reins."),
    can_learn = true,
    time_to_learn = "48 h",
    time_multiplier = 2,
    skill_penalty = 0.2,
}
