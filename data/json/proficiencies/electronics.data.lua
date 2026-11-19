local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_elec_soldering",
    category = "prof_electronic",
    name = ccb.content.text("Electronics Soldering"),
    description = ccb.content.text("An understanding of the skills and tools needed to create durable, effective soldered electrical connections."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.5,
    time_to_learn = "5 h",
}

ccb.content.define_proficiency {
    id = "prof_elec_circuits",
    category = "prof_electronic",
    name = ccb.content.text("Electrical Circuits"),
    description = ccb.content.text("Practical experience building electrical circuits, and a grasp of the principles of electrical continuity, current, voltage, and resistance."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.4,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_elec_semiconductors",
    category = "prof_electronic",
    name = ccb.content.text("Semiconductors"),
    description = ccb.content.text("Basic working knowledge of using semiconductors such as diodes and transistors in electrical circuits, for switching or amplifying electrical signals."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.2,
    requires = { "prof_elec_circuits" },
    time_to_learn = "12 h",
}

ccb.content.define_proficiency {
    id = "prof_elec_integrated_circuits",
    category = "prof_electronic",
    name = ccb.content.text("Integrated Circuits"),
    description = ccb.content.text("Familiarity with the role of IC chips in circuit design, and ability to identify many common pre-Cataclysm ICs and understand how to use them in functional circuits."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.3,
    requires = { "prof_elec_semiconductors" },
    time_to_learn = "16 h",
}

ccb.content.define_proficiency {
    id = "prof_electromagnetics",
    category = "prof_electronic",
    name = ccb.content.text("Electromagnetics"),
    description = ccb.content.text("A practical working knowledge of electromagnetic fields and their creation and application."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.25,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_shock_weapons",
    category = "prof_electronic",
    name = ccb.content.text("Electroshock Weapons"),
    description = ccb.content.text("An understanding of how to use high voltage, low-current devices to cause debilitating muscle spasms.  Includes some theoretical knowledge of how to protect yourself from these."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.3,
    time_to_learn = "10 h",
}
