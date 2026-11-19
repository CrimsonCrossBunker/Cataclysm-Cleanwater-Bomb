local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "LIXA_personal_computer_main",
    line = ccb.content.text("&This is a personal computer, the frame around the screen decorated with whale stickers.  It has undergone a severe fault, and its file structure is completely scrambled."),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_1" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

-- NO_I18N
ccb.content.define_dialogue_topic {
    id = "LIXA_personal_success_1",
    line = ccb.content.text_without_extraction("&<LIXA_personal_snip_1>"),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_2" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

-- NO_I18N
ccb.content.define_dialogue_topic {
    id = "LIXA_personal_success_2",
    line = ccb.content.text_without_extraction("&<LIXA_personal_snip_2>"),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_3" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

-- NO_I18N
ccb.content.define_dialogue_topic {
    id = "LIXA_personal_success_3",
    line = ccb.content.text_without_extraction("&<LIXA_personal_snip_3>"),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_4" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

-- NO_I18N
ccb.content.define_dialogue_topic {
    id = "LIXA_personal_success_4",
    line = ccb.content.text_without_extraction("&<LIXA_personal_snip_4>"),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_1" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_personal_failure",
    line = ccb.content.text("&\"ERROR: file path corrupted.  Please contact your sysadmin.\"  The computer then freezes, and reboots."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}
