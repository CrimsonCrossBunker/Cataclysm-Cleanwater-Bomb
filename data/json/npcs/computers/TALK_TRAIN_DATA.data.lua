local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_TRAIN_DATA_MAIN",
    line = ccb.content.text("The computer awaits input…"),
    replies = {
        {
            text = ccb.content.text("Request Monorail"),
            next_topic = "COMP_TRAIN_DATA_MONRAIL_REQUEST",
        },
        {
            text = ccb.content.text("Download Train Data"),
            next_topic = "COMP_TRAIN_DATA_DOWNLOAD",
            when = predicates.has_mission("MISSION_SCIENCE_REP_5"),
        },
        { text = ccb.content.text("Power off."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_TRAIN_DATA_MONRAIL_REQUEST",
    line = ccb.content.text("UNABLE TO CONTACT MONORAIL LINE.  PLEASE SEE YOUR ADMINISTRATOR FOR ASSISTANCE."),
    replies = {
        { text = ccb.content.text("Go back."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Power off."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_TRAIN_DATA_DOWNLOAD",
    line = {
        when = predicates.has_item("speaker", "usb_drive_nano"),
        yes = ccb.content.text("The train data is ready to download."),
        no = ccb.content.text("You don't have the right device to download the train data."),
    },
    replies = {
        {
            text = ccb.content.text("Download Train Data"),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "usb_drive_nano"),
            actions = { actions.handler("dlg_a_dda_22362a6fdec4") },
        },
        {
            text = ccb.content.text("Go back."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Power off."),
            next_topic = "TALK_DONE",
        },
    },
}
