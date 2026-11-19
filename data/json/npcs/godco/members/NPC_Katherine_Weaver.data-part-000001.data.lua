local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Firstmeet",
    line = ccb.content.text("It's always a pleasure.  How may I help you?"),
    replies = {
        {
            text = ccb.content.text("I just had some questions."),
            next_topic = "TALK_GODCO_Katherine_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_2a",
    line = ccb.content.text("We have many things to pray for, I'm afraid."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_2",
    line = ccb.content.text("I understand.  I don't have the answers you are looking for, I'm afraid."),
    replies = { { text = ccb.content.text("I'll be on my way then."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Mood",
    line = ccb.content.text("Our prayers were heard.  We knew the day was coming, so we prepared.  Our community stockpiled months' worth of canned goods, well enough until the chaos ends.  With the food we have left, we could live peacefully, but we foolishly didn't take extra people into consideration.  With so much at risk, I don't think we can afford more people.  Though I'm not the one who makes the decisions here, and it's probably for the better."),
    replies = {
        {
            text = ccb.content.text("Can you can take in joinees once there's a vacancy?"),
            next_topic = "TALK_GODCO_Katherine_Joinees",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Job",
    line = ccb.content.text("I worked for the Church, organized charities and filed paperwork.  That's how I met the Founder.  I did so much for everyone, yet they never noticed…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Joinee_Opinion",
    line = ccb.content.text("You're right, I don't.  They should've come when they had the chance.  Now that our Ark has sailed, they want to jump aboard.  Such is the way of sinners, I suppose."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Joinees",
    line = ccb.content.text("If there's a vacancy.  Even then, there's the decision of which joinee to include.  Those people don't share or respect the same values as we do.  None of them are promising candidates."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Arturo",
    line = ccb.content.text("Jesus warned us about false prophets."),
}
