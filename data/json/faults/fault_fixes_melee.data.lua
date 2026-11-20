local ccb = require("ccb")

ccb.content.define_fault_fix {
    id = "mend_blade_grind",
    name = ccb.content.text("Grind the edge."),
    success_message = ccb.content.text("You grind and polish the edge of %s till it's nice and sharp."),
    duration = "40 m",
    removes = {
        "fault_blade_rolled_edge",
        "fault_blade_chipped",
        "fault_blade_broken_tip",
        "fault_blade_bent_tip",
    },
    mod_damage = -1000,
    mod_degradation = 5,
    requirements = { { qualities = { { id = "GRIND", level = 1 } } } },
}

ccb.content.define_fault_fix {
    id = "mend_spearhead_grind",
    name = ccb.content.text("Grind the spearhead."),
    success_message = ccb.content.text("You grind and polish the head of %s till it's nice and sharp."),
    duration = "30 m",
    removes = { "fault_spearhead_fracture", "fault_spearhead_warped", "fault_spearhead_chipping" },
    mod_damage = -1000,
    mod_degradation = 5,
    requirements = { { qualities = { { id = "GRIND", level = 1 } } } },
}

ccb.content.define_fault_fix {
    id = "mend_spearhead_straighten",
    name = ccb.content.text("Straighten the spear socket."),
    success_message = ccb.content.text("You spend some time straightening the socket of a %s until it is straight and can be used again."),
    duration = "20 m",
    removes = { "fault_spearhead_bent_socket" },
    mod_damage = -1000,
    mod_degradation = 5,
}

ccb.content.define_fault_fix {
    id = "mend_staff_duct_tape",
    name = ccb.content.text("Duct-tape everything."),
    success_message = ccb.content.text("You duct-tape your %s."),
    duration = "10 m",
    removes = { "fault_staff_short_chipping", "fault_staff_short_cracked" },
    mod_damage = -1000,
    mod_degradation = 10,
    requirements = { { components = { { { "duct_tape", 20 } } } } },
}

ccb.content.define_fault_fix {
    id = "mend_staff_glue",
    name = ccb.content.text("Glue the cracks."),
    success_message = ccb.content.text("You thoroughly glue your %s."),
    duration = "5 m",
    removes = { "fault_staff_short_cracked" },
    mod_damage = -1000,
    mod_degradation = -20,
    requirements = { { id = "glue_any", count = 10 } },
}

ccb.content.define_fault_fix {
    id = "mend_staff_short_replace",
    name = ccb.content.text("Replace a handle."),
    success_message = ccb.content.text("You securely install a new handle on your %s."),
    duration = "60 m",
    removes = { "fault_staff_short_chipping", "fault_staff_short_cracked", "fault_staff_short_broken" },
    mod_damage = -1000,
    mod_degradation = -100,
    requirements = {
        { qualities = { { id = "CUT", level = 2 } }, components = { { { "2x4", 1 }, { "stick_long", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    id = "mend_staff_long_duct_tape",
    name = ccb.content.text("Duct-tape everything."),
    success_message = ccb.content.text("You duct-tape your %s."),
    duration = "10 m",
    removes = { "fault_staff_long_chipping", "fault_staff_long_cracked" },
    mod_damage = -1000,
    mod_degradation = 10,
    requirements = { { components = { { { "duct_tape", 40 } } } } },
}

ccb.content.define_fault_fix {
    id = "mend_staff_long_glue",
    name = ccb.content.text("Glue the cracks."),
    success_message = ccb.content.text("You thoroughly glue the entire %s."),
    duration = "5 m",
    removes = { "fault_staff_long_cracked" },
    mod_damage = -1000,
    mod_degradation = -20,
    requirements = { { id = "glue_any", count = 25 } },
}

ccb.content.define_fault_fix {
    id = "mend_staff_long_replace",
    name = ccb.content.text("Replace a handle."),
    success_message = ccb.content.text("You securely install a new handle on your %s."),
    duration = "60 m",
    removes = {
        "fault_staff_long_chipping",
        "fault_staff_long_cracked",
        "fault_staff_long_broken_half",
        "fault_staff_long_broken",
    },
    mod_damage = -1000,
    mod_degradation = -100,
    requirements = {
        { qualities = { { id = "CUT", level = 2 } }, components = { { { "2x4", 1 }, { "stick_long", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    id = "mend_steel_staff_bent_heat_application",
    name = ccb.content.text("Straighten using heat"),
    success_message = ccb.content.text("You successfully straighten your %s."),
    duration = "90 m",
    removes = { "fault_steel_pipe_staff_bent", "fault_steel_pipe_staff_bent_heavy" },
    mod_damage = -1000,
    mod_degradation = -50,
    requirements = { { id = "forging_standard", count = 1 }, { qualities = { { id = "VISE", level = 1 } } } },
}

ccb.content.define_fault_fix {
    id = "mend_steel_staff_bent_hand_straightening",
    name = ccb.content.text("Straighten by hand"),
    success_message = ccb.content.text("You successfully straighten your %s."),
    duration = "5 m",
    removes = { "fault_steel_pipe_staff_bent" },
    mod_damage = -1000,
    mod_degradation = -25,
    requirements = { { qualities = { { id = "VISE", level = 1 } } } },
}

ccb.content.define_fault_fix {
    id = "mend_pipe_shaft_replace",
    name = ccb.content.text("Replace"),
    success_message = ccb.content.text("You successfully replace the pipe shaft of your %s."),
    duration = "50 m",
    removes = { "fault_pipe_shaft_broken" },
    mod_damage = -1000,
    mod_degradation = -100,
    requirements = { { components = { { { "pipe", 1 } }, { { "pipe_fittings", 1 } } } } },
}
