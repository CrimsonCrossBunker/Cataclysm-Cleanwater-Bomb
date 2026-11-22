local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_JOIN",
    line = ccb.content.text("That's awful kind of you, but look at me.  I'm not traveling material, I've managed to stay fifty pounds overweight on a diet of pine nuts and wilted rhubarb, and I scream and shake uncontrollably at the sight of blood."),
    replies = {
        {
            text = ccb.content.text("Why stay out here then?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_WHYSTAY",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text("It'd be temporary.  I have a base set up.  There are only a few of us survivors left, we need to work together"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
            when = predicates.handler("dlg_p_dda_453225921210"),
        },
        {
            text = ccb.content.text("Okay, yeah, that's a bit of a problem.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_WHYSTAY",
    line = ccb.content.text("It may not be much, but we've got a little community.  We can't live like this forever, but we're safer than out there, and we look out for each other.  One way or another we'll shake things out to something better."),
    replies = {
        {
            text = ccb.content.text("You sound more optimistic than usual."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_WHYSTAY2",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text("It'd be temporary.  I have a base set up.  There are only a few of us survivors left, we need to work together"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
            when = predicates.handler("dlg_p_dda_453225921210"),
        },
        {
            text = ccb.content.text("So, about that doctorate of yours…"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_WHYSTAY2",
    line = ccb.content.text("Don't get me wrong, I hate this place and this situation, and especially the selfish racist fucks that landed me here… but these other losers that landed out here with me?  I like them.  We might be miserable, but we're miserable together."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text("It'd be temporary.  I have a base set up.  There are only a few of us survivors left, we need to work together"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
            when = predicates.handler("dlg_p_dda_453225921210"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
