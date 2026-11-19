local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY3",
    line = ccb.content.gendered_line("Mostly I just wanted to get some scotch out of you.  There really ain't much of a story.  I was in the marines, years ago.  After that, did security contract work.  I was out guarding some dump of a warehouse when the apocalypse rolled through town.  I was out on the edge of town, armed, and know when to not pick a fight, so I didn't get killed.  Wound up recruited by the Free Merchants early on, and then the Old Guard for a bit, but I was getting itchy feet when you came by with an offer.  Here I am.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why was a guy with your skillset guarding a warehouse?  Must've been some warehouse."),
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 8) }),
            next_topic = "BGSS_SCAVENGER_MERC_1_STORY4",
        },
        {
            text = ccb.content.text("What was working for the Free Merchants like?"),
            next_topic = "BGSS_SCAVENGER_MERC_1_FREE_MERCHANTS",
        },
        {
            text = ccb.content.text("What was working for the Old Guard like?"),
            next_topic = "BGSS_SCAVENGER_MERC_1_OLD_GUARD",
        },
        { text = ccb.content.text("Thanks for that."), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("Thanks for that.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}
