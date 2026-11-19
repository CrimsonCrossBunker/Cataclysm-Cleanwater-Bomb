local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_You_Mutant",
    line = ccb.content.text("Nearly everyone here went to a church that was a bit… out there, shall we say.  They hate what they call \"mutants\", how some creatures and people have physically changed inexplicably after everything went to shit.  I'm glad they didn't kill you on the spot, not many people are left out there."),
    replies = {
        {
            text = ccb.content.text("Well, thank's for telling me.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Corrie_2",
        },
        {
            text = ccb.content.text("Wow.  This place is fucking crazy, I'm outta here."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Angry",
    line = ccb.content.text("No, not really.  It's not like I've got any business with you anyways."),
    replies = {
        {
            text = ccb.content.text("What's the attitude for?"),
            next_topic = "TALK_GODCO_Corrie_Angry_Pressed",
        },
        { text = ccb.content.text("I'm outta here then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Angry_Pressed",
    line = ccb.content.text("You know freaking well what I'm upset about <name_b>.  Now go away."),
    replies = { { text = ccb.content.text("See you later <name_b>."), next_topic = "TALK_DONE" } },
}
