local ccb = require("ccb")

-- while specifically made for tailoring, I think this could also apply to things like making robot legs.  For tailoring this is mostly a speed boost skill.
ccb.content.define_proficiency {
    id = "prof_articulation",
    category = "prof_tailoring",
    name = ccb.content.text("Joint Articulation"),
    description = ccb.content.text("Making flexible items out of hard materials is tricky.  You've done enough of it to understand how to make smoothly articulated joints out of rigid or semi-rigid materials."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.15,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_closures",
    category = "prof_tailoring",
    name = ccb.content.text("Garment Closures"),
    description = ccb.content.text("You are familiar with the adjustments and tricks needed to make properly functional buttons, zippers, and other closures on garments."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "6 h",
}

-- The 'closures' part of the name is historical.
ccb.content.define_proficiency {
    id = "prof_closures_waterproofing",
    category = "prof_tailoring",
    name = ccb.content.text("Fabric Waterproofing"),
    description = ccb.content.text("You know how to make garments and fabric containers sealed against water."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_elastics",
    category = "prof_tailoring",
    name = ccb.content.text("Stretch Fabric"),
    description = ccb.content.text("Making elastic bands is easy enough, but making a whole garment from stretchy cloth takes a bit of finesse.  You're good at it."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_cobbling",
    category = "prof_tailoring",
    name = ccb.content.text("Cobbling"),
    description = ccb.content.text("Like a magical elf, you've learned how to construct footwear by hand."),
    can_learn = true,
    time_to_learn = "10 h",
    time_multiplier = 2,
    skill_penalty = 0.25,
    requires = { "prof_closures", "prof_leatherworking_basic" },
}

-- In the future, having this proficiency could give a boost to learning rope making and vice versa
ccb.content.define_proficiency {
    id = "prof_spinning",
    category = "prof_tailoring",
    name = ccb.content.text("Spinning"),
    description = ccb.content.text("The art of spinning fiber into thread."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.4,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_weaving",
    category = "prof_tailoring",
    name = ccb.content.text("Weaving"),
    description = ccb.content.text("You've learned how to use a loom to produce sheets of fabric from thread."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.4,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_millinery",
    category = "prof_tailoring",
    name = ccb.content.text("Millinery"),
    description = ccb.content.text("Like a solitary mouse, you've learned how to construct hats by hand."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
    requires = { "prof_leatherworking_basic" },
}

ccb.content.define_proficiency {
    id = "prof_knitting",
    category = "prof_tailoring",
    name = ccb.content.text("Skilled Knitting"),
    description = ccb.content.text("Knitting, one of the oldest ways of making loops in fiber until it is fabric."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_knitting_speed",
    category = "prof_tailoring",
    name = ccb.content.text("Speed Knitting"),
    description = ccb.content.text("You have knitted and knitted and knitted some more, and have the consistent string tension to show for it.  When you get going, the clicking of your needles is like a metronome."),
    can_learn = true,
    time_multiplier = 5,
    skill_penalty = 0,
    time_to_learn = "20 h",
    requires = { "prof_knitting" },
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_leatherworking_basic",
    category = "prof_tailoring",
    name = ccb.content.text("Principles of Leatherworking"),
    description = ccb.content.text("You've got a basic familiarity with how to work with leather, furs, hides, and similar materials."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "4 h",
}

ccb.content.define_proficiency {
    id = "prof_leatherworking",
    category = "prof_tailoring",
    name = ccb.content.text("Skilled Leatherworking"),
    description = ccb.content.text("Working with leather requires a specific set of skills and tools… a set you are familiar with."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
    requires = { "prof_leatherworking_basic" },
}

ccb.content.define_proficiency {
    id = "prof_furriery",
    category = "prof_tailoring",
    name = ccb.content.text("Furriery"),
    description = ccb.content.text("Working with fur and faux fur is a skill all its own."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "8 h",
    requires = { "prof_leatherworking_basic" },
}

-- Given that nobody has ever written a guide for this, it should be particularly tough to master.
ccb.content.define_proficiency {
    id = "prof_chitinworking",
    category = "prof_tailoring",
    name = ccb.content.text("Chitinworking"),
    description = ccb.content.text("It seems unlikely that anyone prior to the Cataclysm knew how to work with the shells of giant bugs as well as you do now."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.3,
    time_to_learn = "16 h",
    requires = { "prof_leatherworking_basic" },
}

ccb.content.define_proficiency {
    id = "prof_chain_armour",
    category = "prof_tailoring",
    name = ccb.content.text("Chain Garments"),
    description = ccb.content.text("Turning sheets of chain links into effective, wearable clothing that doesn't bind up."),
    can_learn = true,
    time_multiplier = 3,
    skill_penalty = 0.15,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_polymerworking",
    category = "prof_tailoring",
    name = ccb.content.text("Advanced Polymer Sewing"),
    description = ccb.content.text("You know the tricks for working with Kevlar, Nomex, and other advanced polymer cloth."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_quilting",
    category = "prof_tailoring",
    name = ccb.content.text("Fabric Quilting"),
    description = ccb.content.text("You know how to sew stacks of sheets together efficiently to create sturdier armor.  It's also a nice way to sew something pretty!"),
    can_learn = true,
    time_multiplier = 1.35,
    skill_penalty = 0.15,
    time_to_learn = "6 h",
}
