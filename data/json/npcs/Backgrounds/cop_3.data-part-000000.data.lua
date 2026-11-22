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
