local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_3_STORY1",
    line = ccb.content.gendered_line("Before <the_cataclysm>, I was a cop.  I got shot just a couple days before everything went down… I made a bad call in a drug bust and a scumbag got me right in the gut, it was barely stopped by my vest.  I took some pretty bad internal bruising.  I never thought getting shot would save my life, but I was off duty recuperating when the worst of it hit.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What did you do when you found out about the Cataclysm?"),
            next_topic = "BGSS_COP_3_STORY2",
            when = predicates.handler("dlg_p_dda_726627078ec1"),
            actions = { actions.add_effect("interlocutor", "BGSS_Cop_3_earlymeeting", { permanent = true }) },
        },
        {
            text = ccb.content.text("What did you do when you found out about the Cataclysm?"),
            next_topic = "BGSS_COP_3_STORY2",
            when = predicates.handler("dlg_p_dda_3b14879c9833"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_3_STORY3",
    line = ccb.content.gendered_line("Honestly, probably better than it sounds.  I had a good bug-out bag, a nice tent, a lot of good stuff.  I hadn't suffered any internal organ damage, my stomach muscles were just really badly bruised, and I'd already had some good time to recover.  I think it kept me from doing anything too stupid, and believe me there was a high chance of that.  For a long time I had these Rambo visions of rushing into town and saving everyone, but I was still too immobile.  By the time I had my strength back, it wasn't an option… we were well into the rushing into town for supplies phase.  The closest I got to saving any old friends was putting down the monsters wearing their faces.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
