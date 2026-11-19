local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_You_Mutant",
    line = ccb.content.text("I'm talking about you and your filthy, unnatural appearance.  I don't like your kind, and neither does anyone else.  Go repent before the Lord for your many sins, if he'll even listen to you."),
    replies = { { text = ccb.content.text("Fuck you, I'm blowing this joint."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Angry",
    line = ccb.content.text("&Kostas becomes visibly angry now, glaring at you.  \"Feeling pushy today, are we?  If you want to hear it plain, we're not on good terms at the moment and I would appreciate it if you didn't bother me for a while.  Understand?\""),
    replies = { { text = ccb.content.text("Okay, see you later."), next_topic = "TALK_DONE" } },
}
