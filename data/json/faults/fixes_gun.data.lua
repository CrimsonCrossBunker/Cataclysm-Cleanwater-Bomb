local ccb = require("ccb")

ccb.content.define_fault_fix {
    id = "mend_gun_fouling_clean",
    name = ccb.content.text("Clean fouling"),
    success_message = ccb.content.text("You clean your %s."),
    duration = "50 m",
    removes = { "fault_gun_dirt" },
    adds = { "fault_gun_unlubricated" },
    skills = { mechanics = 1 },
    set_variables = { dirt = 0 },
    requirements = { { id = "gun_cleaning", count = 1 } },
    proficiency_time_factors = { prof_gun_cleaning = 0.5 },
}

ccb.content.define_fault_fix {
    id = "mend_gun_fouling_bp",
    name = ccb.content.text("Clean blackpowder fouling"),
    success_message = ccb.content.text("You clean your %s."),
    duration = "50 m",
    removes = { "fault_gun_blackpowder" },
    adds = { "fault_gun_unlubricated" },
    skills = { mechanics = 1 },
    set_variables = { dirt = 0, rust_timer = 0 },
    requirements = { { id = "gun_cleaning_bp", count = 1 } },
    proficiency_time_factors = { prof_gun_cleaning = 0.5 },
    flag_time_factors = { EASY_CLEAN = 0.5 },
}

ccb.content.define_fault_fix {
    id = "mend_gun_fouling_quick",
    name = ccb.content.text("Swab gun"),
    success_message = ccb.content.text("You quickly swab your %s to remove black powder residue and prevent further corrosion."),
    duration = "1 m",
    removes = { "fault_gun_blackpowder" },
    adds = { "fault_gun_blackpowder" },
    skills = { mechanics = 1 },
    set_variables = { rust_timer = 0 },
    multiply_variables = { dirt = 0.8 },
    requirements = { { id = "gun_cleaning_quick", count = 1 } },
    proficiency_time_factors = { prof_gun_cleaning = 0.5 },
    flag_time_factors = { EASY_CLEAN = 0.5 },
}

ccb.content.define_fault_fix {
    id = "mend_gun_fouling_clean_and_lube",
    name = ccb.content.text("Clean fouling and lubricate"),
    success_message = ccb.content.text("You clean and lubricate your %s."),
    duration = "60 m",
    removes = { "fault_gun_dirt", "fault_gun_unlubricated" },
    skills = { mechanics = 1 },
    set_variables = { dirt = 0 },
    requirements = { { id = "gun_cleaning", count = 1 }, { id = "gun_lubrication", count = 1 } },
    proficiency_time_factors = { prof_gun_cleaning = 0.5 },
}

ccb.content.define_fault_fix {
    id = "mend_gun_fouling_clean_and_lube_bp",
    name = ccb.content.text("Clean fouling and lubricate"),
    success_message = ccb.content.text("You clean and lubricate your %s."),
    duration = "60 m",
    removes = { "fault_gun_blackpowder", "fault_gun_unlubricated" },
    skills = { mechanics = 1 },
    set_variables = { dirt = 0, rust_timer = 0 },
    requirements = { { id = "gun_cleaning_bp", count = 1 }, { id = "gun_lubrication", count = 1 } },
    proficiency_time_factors = { prof_gun_cleaning = 0.5 },
    flag_time_factors = { EASY_CLEAN = 0.5 },
}

ccb.content.define_fault_fix {
    id = "mend_fault_fail_to_feed_manual_feed",
    name = ccb.content.text("Manual cycle"),
    success_message = ccb.content.text("You manually cycle your %s to put a round in the chamber."),
    duration = "10 s",
    set_variables = { u_know_round_in_chamber = true },
    removes = { "fault_fail_to_feed" },
}

ccb.content.define_fault_fix {
    id = "mend_fault_gun_chamber_spent_eject",
    name = ccb.content.text("Eject spent casing"),
    success_message = ccb.content.text("You eject the spent casing from the %s's chamber."),
    duration = "10 s",
    set_variables = { u_know_round_in_chamber = true },
    removes = { "fault_gun_chamber_spent" },
}

ccb.content.define_fault_fix {
    id = "mend_fault_stovepipe_eject",
    name = ccb.content.text("Eject spent casing"),
    success_message = ccb.content.text("You eject the spent casing stuck in the %s's slide."),
    duration = "10 s",
    set_variables = { u_know_round_in_chamber = true },
    removes = { "fault_stovepipe" },
}

ccb.content.define_fault_fix {
    id = "mend_fault_double_feed_clean",
    name = ccb.content.text("Clean double feed"),
    success_message = ccb.content.text("You eject the second round stuck in the %s's chamber."),
    duration = "10 s",
    set_variables = { u_know_round_in_chamber = true },
    removes = { "fault_double_feed" },
}

ccb.content.define_fault_fix {
    id = "mend_fault_gun_unlubricated",
    name = ccb.content.text("Lubricate"),
    duration = "10 m",
    removes = { "fault_gun_unlubricated" },
    skills = { mechanics = 1 },
    success_message = ccb.content.text("You lubricate the %s."),
    requirements = { { id = "gun_lubrication", count = 1 } },
    proficiency_time_factors = { prof_gun_cleaning = 0.5 },
}
