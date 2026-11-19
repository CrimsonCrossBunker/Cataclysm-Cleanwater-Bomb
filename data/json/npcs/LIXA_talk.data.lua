local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_flux_limiters",
    line = ccb.content.text("Safe exodimensional flux threshold exceeded!  Current flux compression:  ERROR STACK OVERFLOW m/s"),
    replies = {
        { text = ccb.content.text("ERROR: Power Draw"), next_topic = "LIXA_experiment_power_draw" },
        {
            text = ccb.content.text("SYSTEM SHUTDOWN"),
            next_topic = "LIXA_experiment_system_shutdown",
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_power_draw",
    line = ccb.content.text("Power draw experiencing instability.  Current power input:  negative ERROR STACK OVERFLOW kJ/s."),
    replies = {
        {
            text = ccb.content.text("ERROR: Flux Limiters"),
            next_topic = "LIXA_experiment_flux_limiters",
        },
        {
            text = ccb.content.text("SYSTEM SHUTDOWN"),
            next_topic = "LIXA_experiment_system_shutdown",
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_system_shutdown",
    line = ccb.content.text("Emergency shutdown halted:  ERROR unsafe power discharge, ERROR active compressors"),
    replies = {
        {
            text = ccb.content.text("ERROR: Flux Limiters"),
            next_topic = "LIXA_experiment_flux_limiters",
        },
        { text = ccb.content.text("ERROR: Power Draw"), next_topic = "LIXA_experiment_power_draw" },
        {
            text = ccb.content.text("SYSTEM SHUTDOWN"),
            next_topic = "LIXA_experiment_system_shutdown",
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}
