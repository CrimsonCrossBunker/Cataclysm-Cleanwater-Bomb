local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "THI_CONTROL_CONTROL_READY" },
    line = ccb.content.text("&************************************************\n\nINTEGRITY CHK : ███████████████ 100% (COMPLETE)\nNAV TRANSFER :  ███████████████ 100% (COMPLETE)\n\n************************************************\n*  Operation Successful                         *\n************************************************"),
    replies = { { text = ccb.content.text("Pilot the ship."), next_topic = "TALK_DONE" } },
}
