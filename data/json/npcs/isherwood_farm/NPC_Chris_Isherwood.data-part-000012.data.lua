local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall_Done",
    line = ccb.content.text("All right.  I think that's everything we need.  Let me get it out to the family and we'll have it all prepped by tomorrow."),
    replies = {
        {
            text = ccb.content.text("Before I go, let's talk about something else."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("I'll let you get on that, I've got my own preparations to take care of."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb",
    line = ccb.content.text("* looks thoughtful for a moment, then becomes a bit nervous.  \"Wait, won't that run the risk of injuring Barry, or possibly collapsing the tower?  I don't want him hurt during this, or anyone else if this bomb sends back a bunch of shrapnel.  What do you think about it?\""),
    replies = {
        {
            text = ccb.content.text("Don't worry, I know what I'm doing.  I've taken a look at these sorts of towers before, and I know that the structure itself is pretty solid.  If we tune it right, then the tower won't fall over."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb_Luke",
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
