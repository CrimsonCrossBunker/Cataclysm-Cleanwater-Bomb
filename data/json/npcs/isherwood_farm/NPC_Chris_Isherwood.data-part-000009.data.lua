local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Done",
    line = ccb.content.text("*nods intently, looking at the assembled pile of equipment.  \"Like I said, I'll get this distributed to everyone who's coming.  It's starting to feel more real, but less impossible.  Thanks for doing this.\""),
    replies = {
        {
            text = ccb.content.text("Before you get on to that, I wanted to talk about something else."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        { text = ccb.content.text("I'll let you get on that."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Fail",
    line = ccb.content.gendered_line("*nods slowly.  \"I understand.  You tried.  We could maybe… no, nevermind.  Time is important here, we can't spend forever hoping to get everything in place if we want to get Uncle Barry back alive.  Let's do it without the gear.\"", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Sorry.  <done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("I'm sorry.  I'm going to go take care of a few more things."),
            next_topic = "TALK_DONE",
        },
    },
}
