local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_FAIL",
    line = ccb.content.gendered_line("And stuff sure.  How can I help you stranger?  They say I'm the nice one.  See this smile?  Nice smile right?", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("[Offer Beer] I am extremely into your smile yes.  I have some drinks with me, want to have some?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "beer"),
        },
        {
            text = ccb.content.text("[Offer India Pale Ale] I am extremely into your smile yes.  I have some drinks with me, want to have some?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "india_pale_ale"),
        },
        {
            text = ccb.content.text("[Offer Cigarettes] I am extremely into your smile yes.  I have some cigarettes, want one with me?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "cig"),
        },
        {
            text = ccb.content.text("[Offer Joint] I am extremely into your smile yes.  I have something to smoke, want to have some with me?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "joint"),
        },
        {
            text = ccb.content.text("You seem cool but I don't have anything fun.  I'll try and find something and come back so we can share."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[PRETTY] That smile is very nice.  It makes me smile too."),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_trait("speaker", "PRETTY"),
        },
        {
            text = ccb.content.text("[GLORIOUS] Worship my beauty."),
            next_topic = "TALK_GLOOSCAP_WORSHIP",
            when = predicates.has_trait("speaker", "BEAUTIFUL3"),
        },
        {
            text = ccb.content.text("[TERRIFYING] Fear me!  I am disgusting!"),
            next_topic = "TALK_GLOOSCAP_FEAR",
            when = predicates.all({ predicates.has_trait("speaker", "TERRIFYING") }),
        },
        {
            text = ccb.content.text("[TERRIFYING] Destroy me!"),
            native_actions = { "insult_combat" },
            when = predicates.has_trait("speaker", "TERRIFYING"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[INT 14] Do you have a twin named Malsumis?"),
            next_topic = "TALK_GLOOSCAP_MYTH_SUCCESS",
            when = predicates.minimum_attribute("speaker", "intelligence", 14),
        },
    },
}
