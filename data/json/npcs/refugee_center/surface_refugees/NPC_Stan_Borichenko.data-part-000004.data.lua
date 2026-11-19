local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_Situation",
    line = {
        joined = {
            ccb.content.text("Mostly my family and I have just been mourning.  This isn't the best place to do it.  "),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
                yes = ccb.content.text("Still, now that we've found ways to make this community a bit of our own, I feel like maybe there's a chance things will get better.  Sometimes, when he's working, Boris seems like himself again and I have some hope."),
                no = ccb.content.text("I hope we'll have something productive to do soon; Boris, in particular, has skills to contribute that might help him feel alive again."),
            },
        },
    },
    replies = {
        { text = ccb.content.text("Tell me about Boris."), next_topic = "TALK_REFUGEE_Stan_Boris" },
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
    id = "TALK_REFUGEE_Stan_Boris",
    line = {
        joined = {
            ccb.content.text("He's a strong man.  The things we've been through… that he's been through, before any of this.  If anyone can survive the loss we've seen, it's him.  But he pushes it all down, "),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
                yes = ccb.content.text("if he's left with it too long.  Having work has been helping him.  Cleaning up that back room might seem small, but it was a big deal for him."),
                no = ccb.content.text("and if he keeps it up, I don't know how much of him will be left.  He needs something to *do*.  We can't just sit here, trapped like rats in a cage forever."),
            },
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_3" } }),
                yes = ccb.content.text("  Even more, though, having a little memory of Ash has been more than we could ever have asked.  I thought it might hurt him, dwelling on those memories, but instead it's given both of us some strength back."),
                no = "",
            },
        },
    },
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
