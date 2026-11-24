local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "COMP_OBSIDIAN_RING_COMPUTER_BIOKINESIS" },
    line = ccb.content.text("Project OBSIDIAN RING.\n\nProject BURNT NOVEMBER.\n\nEnter login credentials."),
    replies = {
        {
            text = ccb.content.text("Try a random username and password"),
            next_topic = "COMP_OBSIDIAN_RING_COMPUTER_RANDOM_PASS",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_OBSIDIAN_RING_COMPUTER_CLAIRSENTIENT" },
    line = ccb.content.text("Project OBSIDIAN RING.\n\nProject NOBLE HORIZON.\n\nEnter login credentials."),
    replies = {
        {
            text = ccb.content.text("Try a random username and password"),
            next_topic = "COMP_OBSIDIAN_RING_COMPUTER_RANDOM_PASS",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_OBSIDIAN_RING_COMPUTER_TELEPATH" },
    line = ccb.content.text("Project OBSIDIAN RING.\n\nProject GRAY DAWN.\n\nEnter login credentials."),
    replies = {
        {
            text = ccb.content.text("Try a random username and password"),
            next_topic = "COMP_OBSIDIAN_RING_COMPUTER_RANDOM_PASS",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_OBSIDIAN_RING_COMPUTER_TELEPORTER" },
    line = ccb.content.text("Project OBSIDIAN RING.\n\nProject LOST RAIN.\n\nEnter login credentials."),
    replies = {
        {
            text = ccb.content.text("Try a random username and password"),
            next_topic = "COMP_OBSIDIAN_RING_COMPUTER_RANDOM_PASS",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_OBSIDIAN_RING_COMPUTER_VITAKINESIS" },
    line = ccb.content.text("Project OBSIDIAN RING.\n\nProject SMOKE USHER.\n\nEnter login credentials."),
    replies = {
        {
            text = ccb.content.text("Try a random username and password"),
            next_topic = "COMP_OBSIDIAN_RING_COMPUTER_RANDOM_PASS",
        },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "COMP_OBSIDIAN_RING_COMPUTER_RANDOM_PASS" },
    line = ccb.content.text("&You input the first combination of username and password that comes to mind, and of course it doesn't work.  Rather than trigger a lockout due to too many attempts, you decide to come back when you have some idea what to do."),
    replies = { { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" } },
}
