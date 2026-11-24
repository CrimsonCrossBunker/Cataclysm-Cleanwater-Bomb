local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "mission_science_rep_2_computer_main",
    line = {
        when = predicates.has_mission("MISSION_SCIENCE_REP_2"),
        yes = ccb.content.text("The computer awaits your input"),
        no = ccb.content.text("You don't see anything useful available on this computer."),
    },
    replies = {
        {
            text = ccb.content.text("Access Lab Data"),
            next_topic = "mission_science_rep_2_computer_download",
            when = predicates.has_mission("MISSION_SCIENCE_REP_2"),
        },
        { text = ccb.content.text("Power off."), next_topic = "TALK_DONE" },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "mission_science_rep_3_computer_main",
    line = {
        when = predicates.has_mission("MISSION_SCIENCE_REP_3"),
        yes = ccb.content.text("The computer awaits your input"),
        no = ccb.content.text("You don't see anything useful available on this computer."),
    },
    replies = {
        {
            text = ccb.content.text("Access Encryption Codes"),
            next_topic = "mission_science_rep_3_computer_download",
            when = predicates.has_mission("MISSION_SCIENCE_REP_3"),
        },
        { text = ccb.content.text("Power off."), next_topic = "TALK_DONE" },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "mission_science_rep_4_computer_main",
    line = {
        when = predicates.has_mission("MISSION_SCIENCE_REP_4"),
        yes = ccb.content.text("The computer awaits your input"),
        no = ccb.content.text("You don't see anything useful available on this computer."),
    },
    replies = {
        {
            text = ccb.content.text("Access Archived Data"),
            next_topic = "mission_science_rep_4_computer_download",
            when = predicates.has_mission("MISSION_SCIENCE_REP_4"),
        },
        { text = ccb.content.text("Power off."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "mission_science_rep_4_computer_download",
    line = {
        when = predicates.has_item("speaker", "usb_drive_nano"),
        yes = ccb.content.text("The archived data is ready to download."),
        no = ccb.content.text("You don't have the right device to download the archived data."),
    },
    replies = {
        {
            text = ccb.content.text("Download Archived Data"),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "usb_drive_nano"),
            actions = { actions.handler("dlg_a_dda_381a2ebd1766") },
        },
        {
            text = ccb.content.text("Power off."),
            next_topic = "TALK_DONE",
        },
    },
}
