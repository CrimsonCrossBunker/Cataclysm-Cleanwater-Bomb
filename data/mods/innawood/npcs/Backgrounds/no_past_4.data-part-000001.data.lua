local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "CWH_NO_PAST_4_IDEAS1",
    line = ccb.content.text("You're asking me what I think caused all this?  Everyone was talking about it. Some kind of new weapon.  It's no different from that big disease a few years back, but this time they got the formula right.  Maybe too right.  Doesn't matter anyway, I hear it got out on them and wiped them out too.  Serves em right."),
    replies = {
        {
            text = ccb.content.text("Can you tell me more about what actually went down, though?"),
            next_topic = "CWH_NO_PAST_4_IDEAS2",
        },
        {
            when = predicates.any({ predicates.minimum_attribute("speaker", "perception", 7), predicates.minimum_attribute("speaker", "intelligence", 8) }),
            text = ccb.content.text("How does that explain all the other crazy stuff?"),
            next_topic = "CWH_NO_PAST_4_SKEPTIC",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_NO_PAST_4_IDEAS2",
    line = ccb.content.text("Well, you know.  First there were the riots from the drugs in the water.  Except I think we can all see now it was actually a virus again.  The leaders did their damndest to put it down but it got out of hand.  Then the virus mutated and started bringing the dead back to life like in some kinda scary story, and shit got really real.  They let the big things loose, or they set them on us, I dunno.  Huge unspeakable monsters… still makes me shudder to think of them.  They obviously weren't built for combat though, so they went down fast."),
    replies = {
        {
            when = predicates.any({ predicates.minimum_attribute("speaker", "perception", 7), predicates.minimum_attribute("speaker", "intelligence", 8) }),
            text = ccb.content.text("How does that explain all the other crazy stuff?"),
            next_topic = "CWH_NO_PAST_4_SKEPTIC",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
