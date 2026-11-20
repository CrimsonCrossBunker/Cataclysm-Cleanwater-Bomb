local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_dragger",
    copy_from = "mon_debug_grabber",
    mass = "100 kg",
    name = ccb.content.text_without_extraction("debug dragger"),
    description = ccb.content.text_without_extraction("This monster exists to drag you behind it briefly."),
    attacks = {
        {
            id = "grab_drag",
            cooldown = 0,
            move_cost = 0,
            grab_settings = { break_distance = 999, move_cost_multiplier = 0.001 },
        },
        {
            id = "drag_followup",
            move_cost = 0,
            cooldown = 0,
            grab_settings = { break_distance = 999 },
            when = "allow_jabberwock_bite_jabberwock_1",
        },
    },
}
