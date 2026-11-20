local ccb = require("ccb")

ccb.content.define_fault_fix {
    id = "mend_handle_duct_tape",
    name = ccb.content.text("Duct-tape the handle."),
    success_message = ccb.content.text("You duct-tape the handle of your %s."),
    duration = "10 m",
    removes = { "fault_handle_chipping", "fault_handle_cracked" },
    mod_damage = -1000,
    mod_degradation = 10,
    requirements = { { components = { { { "duct_tape", 10 } } } } },
}

ccb.content.define_fault_fix {
    id = "mend_handle_glue",
    name = ccb.content.text("Glue the handle cracks."),
    success_message = ccb.content.text("You thoroughly glue the handle of your %s."),
    duration = "5 m",
    removes = { "fault_handle_cracked" },
    mod_damage = -1000,
    mod_degradation = -20,
    requirements = { { id = "glue_any", count = 5 } },
}

ccb.content.define_fault_fix {
    id = "mend_handle_replace",
    name = ccb.content.text("Replace a handle."),
    success_message = ccb.content.text("You securely install a new handle on your %s."),
    duration = "60 m",
    removes = { "fault_handle_chipping", "fault_handle_cracked", "fault_handle_broken", "fault_handle_off" },
    mod_damage = -1000,
    mod_degradation = -100,
    requirements = {
        {
            qualities = { { id = "CUT", level = 2 } },
            components = { { { "stick", 1 }, { "2x4", 1 }, { "stick_long", 1 } } },
        },
    },
}

ccb.content.define_fault_fix {
    id = "mend_handle_long_duct_tape",
    name = ccb.content.text("Duct-tape the handle."),
    success_message = ccb.content.text("You duct-tape the handle of your %s."),
    duration = "10 m",
    removes = { "fault_handle_long_chipping", "fault_handle_long_cracked" },
    mod_damage = -1000,
    mod_degradation = 10,
    requirements = { { components = { { { "duct_tape", 25 } } } } },
}

ccb.content.define_fault_fix {
    id = "mend_handle_long_glue",
    name = ccb.content.text("Glue the handle cracks."),
    success_message = ccb.content.text("You thoroughly glue the handle of your %s."),
    duration = "5 m",
    removes = { "fault_handle_long_cracked" },
    mod_damage = -1000,
    mod_degradation = -20,
    requirements = { { id = "glue_any", count = 15 } },
}

ccb.content.define_fault_fix {
    id = "mend_handle_long_replace",
    name = ccb.content.text("Replace a handle."),
    success_message = ccb.content.text("You securely install a new handle on your %s."),
    duration = "60 m",
    removes = {
        "fault_handle_long_chipping",
        "fault_handle_long_cracked",
        "fault_handle_long_broken_half",
        "fault_handle_long_broken",
        "fault_handle_long_off",
    },
    mod_damage = -1000,
    mod_degradation = -100,
    requirements = {
        { qualities = { { id = "CUT", level = 2 } }, components = { { { "2x4", 1 }, { "stick_long", 1 } } } },
    },
}

-- I chose to make this take an hour because the metal needs to cool slowly to prevent brittleness
ccb.content.define_fault_fix {
    id = "mend_steel_pipe_bent_heat_application",
    name = ccb.content.text("Straighten using heat"),
    success_message = ccb.content.text("You successfully straighten your %s."),
    duration = "60 m",
    removes = { "fault_steel_pipe_bent", "fault_steel_pipe_bent_heavy" },
    mod_damage = -1000,
    mod_degradation = -50,
    requirements = { { id = "forging_standard", count = 1 }, { qualities = { { id = "VISE", level = 1 } } } },
}

-- takes much less time, but can only remove minor bends
ccb.content.define_fault_fix {
    id = "mend_steel_pipe_bent_hand_straightening",
    name = ccb.content.text("Straighten by hand"),
    success_message = ccb.content.text("You successfully straighten your %s."),
    duration = "5 m",
    removes = { "fault_steel_pipe_bent" },
    mod_damage = -1000,
    mod_degradation = -25,
    requirements = { { qualities = { { id = "VISE", level = 1 } } } },
}
