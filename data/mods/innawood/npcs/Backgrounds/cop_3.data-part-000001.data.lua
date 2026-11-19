local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_3_STORY2",
    line = ccb.content.text("At first I wanted to help.  The riots, the fighting, it was too much for me to just sit back and listen to the chaos.  Then a buddy of mine visited me.  He'd been hurt and he wasn't making much sense, but what he told me… well, you can imagine the kind of stuff he told me.  Everything the worst of the story tellers was making up, and more.  Instead of packing up to try to fight, I took his advice and packed up to leave.  I was out at the edge and the riots hadn't reached me yet, but from what I'd heard it was smarter to get out than to hold tight.  I slipped out that night and camped a few days in the woods, waiting for it to blow over.  It never did."),
    replies = {
        {
            text = ccb.content.text("What was it like, surviving out there with an injury?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "BGSS_Cop_3_earlymeeting")),
            next_topic = "BGSS_COP_3_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
