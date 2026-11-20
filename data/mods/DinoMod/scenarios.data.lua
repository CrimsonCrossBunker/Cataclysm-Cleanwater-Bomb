local ccb = require("ccb")

ccb.content.define_scenario {
    id = "dm_wilderness",
    copy_from = "wilderness",
    name = "Hunted by Dinosaurs",
    points = -2,
    description = "You find yourself among trees.  The screaming and moaning is fainter, but it sounds like something bigger and more dangerous is close by.",
    start_name = "Wilderness",
    surround_groups = { { group = "GROUP_DINOSAUR_MEGA_CARNIVORE", expected_points = 70 } },
}

ccb.content.define_scenario {
    id = "missed",
    copy_from = "missed",
    extend = { locations = { "sloc_dinoexhibit", "sloc_dinozoo_cafeteria" } },
}

ccb.content.define_scenario {
    id = "surrounded",
    copy_from = "surrounded",
    extend = { locations = { "sloc_dinoexhibit", "sloc_dinozoo_cafeteria" } },
}

ccb.content.define_scenario {
    id = "infected",
    copy_from = "infected",
    extend = { locations = { "sloc_dinoexhibit", "sloc_dinozoo_cafeteria" } },
}

ccb.content.define_scenario {
    id = "fungal_start",
    copy_from = "fungal_start",
    extend = { locations = { "sloc_dinoexhibit", "sloc_dinozoo_cafeteria" } },
}

ccb.content.define_scenario {
    id = "bad_day",
    copy_from = "bad_day",
    extend = { locations = { "sloc_dinoexhibit", "sloc_dinozoo_cafeteria" } },
}

ccb.content.define_scenario {
    id = "lab_chal",
    name = "Challenge - Lab Patient",
    points = -8,
    description = "The scientists stopped their experiments on you abruptly, leaving you behind while they evacuated before lockdown.  Find a way to escape or starve to death.",
    start_name = "Locked Lab",
    professions = { "unemployed", "mutant_patient", "mutant_volunteer" },
    locations = { "sloc_dinolab" },
    traits = {
        "ELFAEYES",
        "URSINE_EYE",
        "FANGS",
        "SPINES",
        "PLANTSKIN",
        "NAILS",
        "RADIOGENIC",
        "PADDED_FEET",
        "RAP_TALONS",
        "HOOVES",
        "CANINE_EARS",
        "BIOLUM1",
        "BIOLUM2",
        "FELINE_EARS",
        "TAIL_FLUFFY",
        "TAIL_LONG",
        "WEB_WALKER",
        "WHISKERS",
        "SLIT_NOSTRILS",
        "TROGLO",
        "WEBBED",
        "BEAK",
        "UNSTABLE",
        "RADIOACTIVE1",
        "SLIMY",
        "HERBIVORE",
        "CARNIVORE",
        "PONDEROUS1",
        "SUNLIGHT_DEPENDENT",
        "COLDBLOOD",
        "GROWL",
        "ARM_FEATHERS",
        "ARM_TENTACLES",
        "LEG_TENTACLES",
        "CHAOTIC",
        "ALCMET",
        "LIGHT_BONES",
        "CHITIN",
        "ELECTRORECEPTORS",
    },
    requirement = "achievement_reach_lab_finale",
    reveal_locale = false,
    initial_visibility = 0,
    flags = { "CHALLENGE", "CITY_START", "LONE_START" },
}

ccb.content.define_scenario {
    id = "lab_staff",
    name = "Challenge - Lab Staff",
    points = -8,
    description = "You were deemed an essential employee and required to stay behind during the lab's evacuation.  Find a way to escape or starve to death.",
    start_name = "Locked Lab",
    professions = { "labtech", "security", "medic" },
    locations = { "sloc_dinolab" },
    requirement = "achievement_reach_lab_finale",
    flags = { "CHALLENGE", "CITY_START", "LONE_START" },
}

ccb.content.define_scenario {
    id = "dm_predator_nest",
    name = "Woke up in a Dinosaur Nest",
    points = 0,
    description = "When you wake up, you find yourself in the swamp next to some large eggs.",
    start_name = "Predator Dinosaur Nest",
    locations = { "sloc_swamp" },
    map_extra = "mx_nest_tyrannosaurus",
    flags = { "LONE_START" },
}
