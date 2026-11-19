local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Work",
    line = ccb.content.text("Darryl should have something for you to do if you like gardening, Jane could use some medical supplies, too.  If you like to be bossed around, Helena probably has a few things that need doing.  I'd just ask around, really."),
    replies = {
        { text = ccb.content.text("Is there anything you need?"), next_topic = "TALK_MISSION_LIST" },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Angry",
    line = ccb.content.text("You know very well what I'm upset about.  Now do like I said earlier and get lost."),
    replies = { { text = ccb.content.text("Fine, whatever."), next_topic = "TALK_DONE" } },
}
