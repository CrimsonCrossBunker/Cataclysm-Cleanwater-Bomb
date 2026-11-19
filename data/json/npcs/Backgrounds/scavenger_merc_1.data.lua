local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_FREE_MERCHANTS",
    line = ccb.content.text("Fucking dull.  Caravan patrols were a bit more fun, for a while, but a guy can only eat so much road dust.  Guarding that pile of bricks full of sad-sack pussies who can't even justify surviving <the_cataclysm>?  Well, I dunno.  They're not a bad bunch but I'm fine not working for them now."),
    replies = {
        {
            text = ccb.content.text("Why was someone with your skillset guarding a warehouse?  Must've been some warehouse."),
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 8) }),
            next_topic = "BGSS_SCAVENGER_MERC_1_STORY4",
        },
        {
            text = ccb.content.text("What was working for the Old Guard like?"),
            next_topic = "BGSS_SCAVENGER_MERC_1_OLD_GUARD",
        },
        { text = ccb.content.text("Thanks for that."), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("Thanks for that.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_OLD_GUARD",
    line = ccb.content.gendered_line("Good work, and some fun stuff, but risky.  Without a few hands at my side that I trust, I wouldn't take more of their work.  If I had a solid team, though, I'd happily work for Uncle Sam again.", { "interlocutor" }),
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
        { text = ccb.content.text("Thanks for that."), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("Thanks for that.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}
