local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_knapping",
    category = "prof_survival",
    name = ccb.content.text("Basic Knapping"),
    description = ccb.content.text("You know the basic principles of turning stones into more useful tools."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.8,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_knapping_speed",
    category = "prof_survival",
    name = ccb.content.text("Speed Knapping"),
    description = ccb.content.text("You've banged rocks together so much and for so long, you've become extremely fast at it."),
    can_learn = true,
    time_multiplier = 5,
    skill_penalty = 0.15,
    time_to_learn = "12 h",
    requires = { "prof_knapping" },
    ignore_focus = true,
}

ccb.content.define_proficiency {
    id = "prof_glassblowing",
    category = "prof_misc_craft",
    name = ccb.content.text("Glassblowing"),
    description = ccb.content.text("Working with glass and heat without poisoning or perforating yourself."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_plumbing",
    category = "prof_mechanic",
    name = ccb.content.text("Plumbing"),
    description = ccb.content.text("Working with pipes and pipe fittings to transport fluids without leakage."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_pottery",
    category = "prof_misc_craft",
    name = ccb.content.text("Pottery"),
    description = ccb.content.text("Basic pottery, from shaping to working with slip to fuse pieces."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_bowyery",
    category = "prof_archery",
    name = ccb.content.text("Bowyery"),
    description = ccb.content.text("The ability to make durable, effective bows."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.5,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_fletching",
    category = "prof_archery",
    name = ccb.content.text("Fletching"),
    description = ccb.content.text("The skill involved in making arrows that fly true."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_basketweaving",
    category = "prof_misc_craft",
    name = ccb.content.text("Basketweaving"),
    description = ccb.content.text("Forming coarse fibers into shapes."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.2,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_pottery_glazing",
    category = "prof_misc_craft",
    name = ccb.content.text("Pottery Glazing"),
    description = ccb.content.text("Adding glazes to pottery to make them waterproof."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.2,
    time_to_learn = "5 h",
}

ccb.content.define_proficiency {
    id = "prof_plasticworking",
    category = "prof_misc_craft",
    name = ccb.content.text("Plastic Working"),
    description = ccb.content.text("Working with plastic using your hands, including carving, molding, and gluing it.  You know how to identify thermoplastics that are suitable for mold casting, and how to identify the right plastic for the right job."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_carving",
    category = "prof_survival",
    name = ccb.content.text("Carving"),
    description = ccb.content.text("Shaping wood, bone, and similar materials with a cutting implement."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.2,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_gem_setting",
    category = "prof_misc_craft",
    name = ccb.content.text("Gem Setting"),
    description = ccb.content.text("How to add gemstones to jewelry."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.2,
    time_to_learn = "10 h",
    requires = { "prof_fine_metalsmithing", "prof_redsmithing" },
}

ccb.content.define_proficiency {
    id = "prof_handloading",
    category = "prof_gunmaking",
    name = ccb.content.text("Handloading"),
    description = ccb.content.text("You know how to accurately measure powder and projectile weights for reloading firearm cartridges."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_appliance_repair",
    category = "prof_mechanic",
    name = ccb.content.text("General Appliance Repair"),
    description = ccb.content.text("A base knowledge of how to put together and take apart common appliances, diagnose problems, and replace parts."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.1,
    time_to_learn = "8 h",
}
