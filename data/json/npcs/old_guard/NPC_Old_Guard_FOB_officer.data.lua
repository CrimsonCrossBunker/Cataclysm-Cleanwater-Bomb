local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_FOB_OFFICER",
    line = {
        choices = {
            ccb.content.text("I don't have any use for you right now.  You will be informed if I need you, soldier."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you tell me about yourself?"),
            next_topic = "TALK_OLD_GUARD_FOB_OFFICER_DISMISSED",
        },
        { text = ccb.content.text("Understood."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_FOB_OFFICER_DISMISSED",
    line = {
        choices = {
            ccb.content.text("If it wasn't clear, you are dismissed soldier."),
            ccb.content.text("I am clearly busy, soldier."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can I just ask you some questions?"),
            next_topic = "TALK_OLD_GUARD_FOB_OFFICER_DISMISSED_2",
        },
        { text = ccb.content.text("Understood."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_FOB_OFFICER_DISMISSED_2",
    line = {
        choices = {
            ccb.content.text("Go. Away."),
            ccb.content.text("If I have to tell you one more time so help me god…"),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
