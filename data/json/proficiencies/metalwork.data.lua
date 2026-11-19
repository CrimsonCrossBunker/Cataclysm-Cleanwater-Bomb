local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_metalworking",
    category = "prof_smithing",
    name = ccb.content.text("Principles of Metalworking"),
    description = ccb.content.text("A basic understanding of the properties of metal as a material, and the concepts behind smithing, die casting, and other metalworking techniques."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "2 h",
}

ccb.content.define_proficiency {
    id = "prof_welding_basic",
    category = "prof_smithing",
    name = ccb.content.text("Principles of Welding"),
    description = ccb.content.text("A basic understanding of the different types of welding, welding tools and fuels, how to weld different materials, and more."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "6 h",
    requires = { "prof_metalworking" },
}

ccb.content.define_proficiency {
    id = "prof_welding",
    category = "prof_smithing",
    name = ccb.content.text("Skilled Welding"),
    description = ccb.content.text("You are an experienced welder."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
    requires = { "prof_welding_basic" },
}

ccb.content.define_proficiency {
    id = "prof_blacksmithing",
    category = "prof_smithing",
    name = ccb.content.text("Blacksmithing"),
    description = ccb.content.text("The craft of working metal into tools and other items of use."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
    requires = { "prof_metalworking" },
}

ccb.content.define_proficiency {
    id = "prof_redsmithing",
    category = "prof_smithing",
    name = ccb.content.text("Principles of Redsmithing"),
    description = ccb.content.text("A basic understanding of the techniques required to work with copper and bronze, soft metals require a somewhat different kind of skill set than blacksmithing."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "4 h",
    requires = { "prof_metalworking" },
}

ccb.content.define_proficiency {
    id = "prof_redsmithing_adv",
    category = "prof_smithing",
    name = ccb.content.text("Advanced Redsmithing"),
    description = ccb.content.text("You can now easily work with the more ductile copper-containing metals and could probably make a living in the Bronze Age."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "6 h",
    requires = { "prof_redsmithing" },
}

ccb.content.define_proficiency {
    id = "prof_fine_metalsmithing",
    category = "prof_smithing",
    name = ccb.content.text("Fine Metalsmithing"),
    description = ccb.content.text("How to make jewelry from precious metals like gold and silver."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.2,
    time_to_learn = "14 h",
}

ccb.content.define_proficiency {
    id = "prof_armorsmithing",
    category = "prof_smithing",
    name = ccb.content.text("Armorsmithing"),
    description = ccb.content.text("How to make articulated armor from pieces of metal."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.15,
    time_to_learn = "12 h",
    requires = { "prof_blacksmithing" },
}

ccb.content.define_proficiency {
    id = "prof_bladesmith",
    category = "prof_smithing",
    name = ccb.content.text("Bladesmithing"),
    description = ccb.content.text("How to fabricate sharp and reliable blades from scratch."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.15,
    time_to_learn = "12 h",
    requires = { "prof_blacksmithing" },
}

ccb.content.define_proficiency {
    id = "prof_toolsmithing",
    category = "prof_smithing",
    name = ccb.content.text("Manual Tooling"),
    description = ccb.content.text("How to make high-quality tools and parts by hand.  Includes techniques like threading, durable articulation points, and using appropriate metals for appropriate tasks.  Also applies to making blunt instruments that can withstand a severe beating without distortion."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.15,
    time_to_learn = "10 h",
    requires = { "prof_blacksmithing" },
}

ccb.content.define_proficiency {
    id = "prof_wiremaking",
    category = "prof_smithing",
    name = ccb.content.text("Wire Making"),
    description = ccb.content.text("How to turn raw ingots and metals into usable wire.  Includes both drawing and extruding."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.5,
    time_to_learn = "10 h",
    requires = { "prof_metalworking" },
}

ccb.content.define_proficiency {
    id = "prof_hardening",
    category = "prof_smithing",
    name = ccb.content.text("Quenching & Hardening"),
    description = ccb.content.text("Heating steel to critical temperature, and using a variety of techniques including differential hardening techniques like slack quenching, and case hardening techniques for armor, to achieve a hardening of the steel while minimizing the brittleness."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.5,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_tempering",
    category = "prof_smithing",
    name = ccb.content.text("Tempering"),
    description = ccb.content.text("Tempering involves thorough-hardening the steel then holding it at a constant temperature to increase metal durability."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 1,
    time_to_learn = "15 h",
}

ccb.content.define_proficiency {
    id = "prof_machining_basic",
    category = "prof_smithing",
    name = ccb.content.text("Principles of Machining"),
    description = ccb.content.text("A basic understanding of the operation of various metalworking machinery, such as lathes and mills."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "10 h",
}
