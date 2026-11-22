local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "mission_science_rep_2_computer_download",
    line = {
        when = predicates.has_item("speaker", "usb_drive_nano"),
        yes = ccb.content.text("The lab data is ready to download."),
        no = ccb.content.text("You don't have the right device to download the lab data."),
    },
    replies = {
        {
            text = ccb.content.text("Download Lab Data"),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "usb_drive_nano"),
            actions = { actions.handler("dlg_a_dda_da0c407d533c") },
        },
        {
            text = ccb.content.text("Power off."),
            next_topic = "TALK_DONE",
        },
    },
}
