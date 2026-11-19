local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_askback",
    line = ccb.content.text("*nods.  \"Of course, what'd you want to ask?\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_no",
    line = ccb.content.text("Yeah, I think we need to talk about it, but I'm not ready yet.  Let me reclaim my life for a while."),
    replies = { { text = ccb.content.text("Sounds good, Barry."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_Skywalker",
    line = ccb.content.text("*laughs.  \"It was terrible timing, but I have to admit, you don't see many situations that perfect for that reference.  Sorry I didn't get it at the time.\""),
    replies = {
        {
            text = ccb.content.text("Can I ask you some questions?"),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_fresh1",
    line = ccb.content.text("It's still a bit fresh, but okay.  Yeah.  Let me sit down first.\"  Barry takes a seat, his hands shaking even at the prospect of discussing the tower and the things he saw.  \"What should we talk about?"),
    replies = {
        {
            text = ccb.content.text("What happened to you in there?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_fresh2",
        },
        {
            text = ccb.content.text("On second thought, I think you should recover more."),
            next_topic = "TALK_DONE",
        },
    },
}
