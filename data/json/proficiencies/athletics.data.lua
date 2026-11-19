local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_parkour",
    category = "prof_athletics",
    name = ccb.content.text("Parkour Expert"),
    description = ccb.content.text("You're skilled at clearing obstacles; terrain like railings or counters are as easy for you to move on as solid ground."),
    can_learn = true,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_athlete_basic",
    category = "prof_athletics",
    name = ccb.content.text("Athlete's Form"),
    description = ccb.content.text("You've spent some time developing your general fitness.  When operating muscle-powered vehicles, you know how to get more power out of each stroke."),
    can_learn = true,
    time_to_learn = "4 h",
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { athlete = { { attribute = "strength", value = 2 } } },
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_athlete_expert",
    category = "prof_athletics",
    name = ccb.content.text("Athlete's Form (Expert)"),
    description = ccb.content.text("With considerable practice, you've honed your athletic fitness and form.  You know how to get the most out of your effort, when manually powering a muscle-driven vehicle."),
    can_learn = true,
    time_to_learn = "8 h",
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    requires = { "prof_athlete_basic" },
    bonuses = { athlete = { { attribute = "strength", value = 2 } } },
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_athlete_master",
    category = "prof_athletics",
    name = ccb.content.text("Athlete's Form (Master)"),
    description = ccb.content.text("You've honed your athletics to at least a professional level.  When it comes to making vehicles move under your own power, your body is a well-oiled machine."),
    can_learn = true,
    time_to_learn = "16 h",
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    requires = { "prof_athlete_expert" },
    bonuses = { athlete = { { attribute = "strength", value = 2 } } },
    ignore_focus = true,
}
