local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "THI_CONTROL_BAY_RAMP_STATUS" },
    line = {
        when = predicates.handler("dlg_p_aftershock_exoplanet_f2a4a85cdbb3"),
        yes = {
            choices = {
                ccb.content.text("BAY RAMP STATUS: GREEN"),
                ccb.content.text("The console shows a camera feed of the closing ramp."),
            },
        },
        no = ccb.content.text("**WARNING: OBSTRUCTION IN RAMP AREA.  MANUAL INTERVENTION REQUIRED.  ERROR.**"),
    },
}
