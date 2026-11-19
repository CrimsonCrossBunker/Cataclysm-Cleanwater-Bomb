local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_GO_IT_ALONE",
    line = ccb.content.text("*looks at you with obvious doubt.  \"You sure you know what you're getting into?  I can't stop you if you plan on going in solo, but it seems like a terrible idea.  Those things mean business.  I won't be able to go in and help you if you get trapped too.  It's probably better we pair up.\""),
    replies = {
        { text = ccb.content.text("Trust me.  See you in a bit."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("If you insist, yeah, we could team up."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_OWN_TEAM",
    line = ccb.content.text("Yeah, bringing your own people in is reasonable.  Still, the more the better.  It's my uncle in there, I'm more than willing to help out.  I know my way around, I won't get in your way."),
    replies = {
        {
            text = ccb.content.text("All right.  As long as you follow my lead, we could use another pair of hands."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
        },
        {
            text = ccb.content.text("It's all right.  We've got this, you get things ready for when we return with Barry."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
