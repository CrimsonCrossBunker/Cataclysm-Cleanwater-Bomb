local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_helicopter_pilot",
    category = "prof_vehicles",
    name = ccb.content.text("Helicopter Piloting"),
    description = ccb.content.text("Before the Cataclysm, you were a helicopter pilot.  Now, you just hope you can fly again.  With enough study and practice, the controls of a rotorcraft can be mastered from scratch."),
    can_learn = true,
    time_to_learn = "12 h",
    time_multiplier = 2.0,
    skill_penalty = 0.25,
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_airship_pilot",
    category = "prof_vehicles",
    name = ccb.content.text("Airship Piloting"),
    description = ccb.content.text("You understand how to manage the buoyancy of a lighter-than-air craft and steer it with propellers.  Slower and more forgiving than a helicopter, but the principles still take study to master."),
    can_learn = true,
    time_to_learn = "10 h",
    time_multiplier = 2.0,
    skill_penalty = 0.25,
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_boat_pilot",
    category = "prof_vehicles",
    name = ccb.content.text("Boat Piloting"),
    description = ccb.content.text("You're familiar with the control and operation of marine vehicles, like boats."),
    can_learn = true,
    time_to_learn = "4 h",
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_driver",
    category = "prof_vehicles",
    name = ccb.content.text("Driving"),
    description = ccb.content.text("You're comfortable with the basic controls of cars, and land vehicles in general."),
    can_learn = true,
    time_to_learn = "4 h",
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    ignore_focus = true,
}
