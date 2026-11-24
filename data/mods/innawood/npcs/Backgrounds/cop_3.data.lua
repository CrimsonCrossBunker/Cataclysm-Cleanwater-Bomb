local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_3_STORY1",
    line = ccb.content.text("Before <the_cataclysm>, I enforced the rules.  I got shot just a couple days before everything went down… I made a bad call taking a leak in the woods and a scumbag got me right in the gut.  It hurt bad.  I never thought getting shot would save my life, but I was off recuperating when the worst of it hit."),
    replies = {
        {
            text = ccb.content.text("What did you do when you found out about the Cataclysm?"),
            next_topic = "BGSS_COP_3_STORY2",
            when = predicates.handler("dlg_p_innawood_c0c4514d741e"),
            actions = { actions.add_effect("interlocutor", "BGSS_Cop_3_earlymeeting", { permanent = true }) },
        },
        {
            text = ccb.content.text("What did you do when you found out about the Cataclysm?"),
            next_topic = "BGSS_COP_3_STORY2",
            when = predicates.handler("dlg_p_innawood_e56eebad836d"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_3_STORY3",
    line = ccb.content.text("Honestly, probably better than it sounds.  I had a nice tent, a lot of good stuff.  I hadn't suffered any internal organ damage and I'd already had some good time to recover.  I think it kept me from doing anything too stupid, and believe me there was a high chance of that.  For a long time I had these Rambo visions of rushing in and saving everyone, but I was still too immobile.  By the time I had my strength back, it wasn't an option… it was too late.  The closest I got to saving any old friends was putting down the monsters wearing their faces."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
