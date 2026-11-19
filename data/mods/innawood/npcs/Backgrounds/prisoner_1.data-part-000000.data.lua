local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- This is a stand-in for 'npc_has_trait_flag': 'EXP_Bookkeeping' when that becomes available
-- This is a stand-in for 'npc_has_trait_flag': 'EXP_Medicine' when that becomes available
ccb.content.define_dialogue_topic {
    id = "BGSS_PRISONER_1_STORY1",
    line = ccb.content.text("I was locked up during <the_cataclysm>, but I escaped.  Hell of a story."),
    replies = {
        {
            text = ccb.content.text("So tell me this 'hell of a story'"),
            next_topic = "BGSS_PRISONER_1_STORY2",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Agriculture1"), predicates.has_trait("interlocutor", "Exp_Agriculture2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_GROWOP",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Biochemistry1"), predicates.has_trait("interlocutor", "Exp_Biochemistry2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_BIOWEAPON",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Bookkeeping1"), predicates.has_trait("interlocutor", "Exp_Bookkeeping2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_TAXEVASION",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Medicine1"), predicates.has_trait("interlocutor", "Exp_Medicine2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_ORGANS",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "Exp_Physics1"), predicates.has_trait("interlocutor", "Exp_Physics2") }), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_NUCLEAR",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.has_trait("interlocutor", "ADDICTIVE"), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_METH",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.has_trait("interlocutor", "PSYCHOTIC"), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_ASSAULT",
        },
        {
            text = ccb.content.text("What were you in for?"),
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Agriculture2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Biochemistry2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Bookkeeping2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Medicine2")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics1")), predicates.negate(predicates.has_trait("interlocutor", "Exp_Physics2")), predicates.negate(predicates.has_trait("interlocutor", "ADDICTIVE")), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOTIC")) }),
            next_topic = "BGSS_PRISONER_1_IN_FOR_OTHER",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
