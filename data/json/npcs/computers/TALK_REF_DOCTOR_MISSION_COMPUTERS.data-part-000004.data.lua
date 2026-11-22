local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "mission_science_rep_3_computer_download",
    line = {
        when = predicates.has_item("speaker", "usb_drive_nano"),
        yes = ccb.content.text("The encryption codes are ready to download."),
        no = ccb.content.text("You don't have the right device to download the encryption codes."),
    },
    replies = {
        {
            text = ccb.content.text("Download Encryption Codes"),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "usb_drive_nano"),
            actions = { actions.handler("dlg_a_dda_43677bf6ed9b") },
        },
        {
            text = ccb.content.text("Power off."),
            next_topic = "TALK_DONE",
        },
    },
}
