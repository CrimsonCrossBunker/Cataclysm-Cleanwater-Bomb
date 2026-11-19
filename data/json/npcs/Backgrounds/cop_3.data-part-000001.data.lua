local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_3_STORY2",
    line = ccb.content.gendered_line("At first I wanted to help.  The riots, fighting in the streets, it was too much for me to just sit in my house and hear about it on the news.  Then a buddy of mine called me from just off the front lines.  He'd been hurt and he wasn't making much sense, but what he told me… well, you can imagine the kind of stuff he told me.  Everything the worst of the internet was making up, and more.  Instead of packing up to try to volunteer back onto active duty, I took his advice and packed up to leave.  My house was on the edge of town and the riots hadn't reached it yet, but from what I'd heard it was smarter to get out than to hold tight.  I slipped out that night, took my quad out, and camped a few days in the woods, waiting for it to blow over.  It never did.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What was it like, surviving out there with an injury?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "BGSS_Cop_3_earlymeeting")),
            next_topic = "BGSS_COP_3_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
