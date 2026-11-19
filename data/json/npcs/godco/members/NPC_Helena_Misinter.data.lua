local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Angry",
    line = ccb.content.text("You've been nothing but a leech and a stain on us, we don't want you here anymore nor your \"services\" you might provide.  Now get out."),
    replies = { { text = ccb.content.text("Fine then."), next_topic = "TALK_DONE" } },
}
