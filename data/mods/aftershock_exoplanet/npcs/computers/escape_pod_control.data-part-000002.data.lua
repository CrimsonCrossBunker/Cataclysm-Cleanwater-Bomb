local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "ESPOD_CONTROL_READY" },
    line = ccb.content.text("&************************************************\n\nINTEGRITY CHK : ███████████████ 100% (COMPLETE)\nNAV TRANSFER :  ███████████████ 100% (COMPLETE)\nFUELING :       ███████████████ 100% (COMPLETE)\n\n************************************************\n*  Operation Successful                         *\n************************************************"),
    replies = {
        {
            text = ccb.content.text("Continue."),
            next_topic = "ESPOD_CONTROL_CONTINUE",
            actions = { actions.handler("dlg_a_aftershock_exoplanet_946f9b1b3869") },
        },
    },
}
