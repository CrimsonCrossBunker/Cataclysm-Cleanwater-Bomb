local ccb = require("ccb")

-- Experimental data: I actually went camping and just sat around twisting cordage until I felt like I had a good handle on it.
ccb.content.define_proficiency {
    id = "prof_fibers",
    category = "prof_survival",
    name = ccb.content.text("Fiber Twisting"),
    description = ccb.content.text("You've got a basic grasp of the theory of how to twist and arrange fibers into a more durable cord."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "4 h",
}

ccb.content.define_proficiency {
    id = "prof_fibers_rope",
    category = "prof_survival",
    name = ccb.content.text("Ropemaking"),
    description = ccb.content.text("Making twisted fibers into durable and useful rope."),
    can_learn = true,
    time_to_learn = "8 h",
    time_multiplier = 3,
    skill_penalty = 0.15,
    requires = { "prof_fibers" },
}

ccb.content.define_proficiency {
    id = "prof_tanning_basic",
    category = "prof_survival",
    name = ccb.content.text("Basic Tanning"),
    description = ccb.content.text("You're familiar with the theory behind turning raw hides into leather."),
    can_learn = true,
    time_to_learn = "4 h",
    time_multiplier = 1.5,
    skill_penalty = 0.5,
}

ccb.content.define_proficiency {
    id = "prof_tanning",
    category = "prof_survival",
    name = ccb.content.text("Skilled Tanning"),
    description = ccb.content.text("You have a lot of practice and experience with processing hides to leather, as well as related techniques like making boiled leather."),
    can_learn = true,
    time_to_learn = "8 h",
    time_multiplier = 2,
    skill_penalty = 0.2,
    requires = { "prof_tanning_basic" },
}

ccb.content.define_proficiency {
    id = "prof_bow_basic",
    category = "prof_archery",
    name = ccb.content.text("Archer's Form"),
    description = ccb.content.text("You have grasped some basic understanding on archery, and find handling bows easier."),
    can_learn = true,
    time_to_learn = "8 h",
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { archery = { { attribute = "strength", value = 2 } } },
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_bow_expert",
    category = "prof_archery",
    name = ccb.content.text("Archer's Form (Expert)"),
    description = ccb.content.text("After significant practice, you have become experienced in the movements used in drawing and firing a bow, and have strengthened those muscles considerably."),
    can_learn = true,
    time_to_learn = "16 h",
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    requires = { "prof_bow_basic" },
    bonuses = { archery = { { attribute = "strength", value = 2 } } },
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_bow_master",
    category = "prof_archery",
    name = ccb.content.text("Archer's Form (Master)"),
    description = ccb.content.text("You have drawn and fired a bow so many times, you probably have a bit of a twist in your spine from it.  You've developed at least a professional-level understanding of the pose and motion of effective archery."),
    can_learn = true,
    time_to_learn = "32 h",
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    requires = { "prof_bow_expert" },
    bonuses = { archery = { { attribute = "strength", value = 2 } } },
    ignore_focus = true,
}
