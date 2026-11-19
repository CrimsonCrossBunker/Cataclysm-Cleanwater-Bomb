local ccb = require("ccb")

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
