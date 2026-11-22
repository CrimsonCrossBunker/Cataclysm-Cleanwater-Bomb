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
