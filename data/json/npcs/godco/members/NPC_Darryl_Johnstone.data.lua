local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_BarterSuccess",
    line = ccb.content.gendered_line("Well, you got me there.  I sure ain't one to block a fellow farmer's right to reclaim this God-given earth.", { "speaker" }),
    replies = { { text = ccb.content.text("Thank you.  See you around, Darryl."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_BarterFail",
    line = ccb.content.text("It really isn't difficult to earn your money here.  Hard labor, like the rest of us."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Wife",
    line = ccb.content.text("I've got a wife, Gemma.  She's a grand lady, should be around here somewhere.  She used to teach biology, and we both love gardenin'; that's how we met, ya see.  She 'aint been herself lately, I'm startin' to worry."),
    replies = {
        {
            text = ccb.content.text("What about your parents?"),
            next_topic = "TALK_GODCO_Darryl_Mom&Dad",
        },
        {
            text = ccb.content.text("I'll check on her.  I hope everything works out for you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Mom&Dad",
    line = ccb.content.text("Oh, they passed a long time ago.  Wish they could've seen Gemma and I marry…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'm sorry for your loss."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_You_Mutant",
    line = ccb.content.text("I've heard of unnatural monsters such as yourself causing chaos after the fall of civilization, and how men have transformed into horrors and gone mad with sin.  This is the judgment of God upon you heathens for your wicked ways, and I want nothing to do with it."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Angry",
    line = ccb.content.text("No, I fucking well don't, not with you at least.  I ain't interested in whatever you've got to say."),
    replies = { { text = ccb.content.text("See you later then."), next_topic = "TALK_DONE" } },
}
