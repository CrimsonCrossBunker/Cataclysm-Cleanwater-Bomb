local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_HUNTER",
    line = ccb.content.text("Among other things, sure.  I have some extra I might be willing to trade, but I only trade with my friends and I don't have a lot of those left."),
    replies = {
        {
            text = ccb.content.text("[Offer Beer] I don't know about friends, but I have some drinks with me, want to have some?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "beer"),
        },
        {
            text = ccb.content.text("[Offer India Pale Ale] I don't know about friends, but I have some drinks with me, want to have some?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "india_pale_ale"),
        },
        {
            text = ccb.content.text("[Offer Cigarettes] I don't know about friends, but I have some cigarettes, want one with me?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "cig"),
        },
        {
            text = ccb.content.text("[Offer Joint] I don't know about friends, but I have something to smoke, want to have some with me?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "joint"),
        },
        {
            text = ccb.content.text("You seem cool and I'd like to talk more but I don't have anything fun.  I'll try and find something and come back so we can share."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[PRETTY] I think we're going to be great friends, don't you agree?"),
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
