local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Exodii",
    line = ccb.content.text("*lets out a low whistle.  \"No, not as such.  I've heard some rumors, I guess, but nothing credible.\"  She pauses, looking thoughtful.  \"I think, unless you can offer me some detailed answers about who and what they are and how they work, you'd better not tell me anything else.  I don't know if I could handle the stress.\"  With a gulp, she pulls listlessly at her earlobe.  \"If you do really know some juicy tidbits though, spill.\""),
    replies = {
        {
            text = ccb.content.text("Well, I know they're cyborgs, from some other dimension.  I think they're humans underneath the machines though.  Some of them kinda speak English."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodization_u_knows_exodiilore" } }),
            next_topic = "TALK_REFUGEE_JENNY_Exodii2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Exodii2",
    line = ccb.content.text("*puts her hands on her hips and glares at you.  \"I thought I made it clear I wasn't willing to accept enticing tidbits of information.  What the actual fuck?  Interdimensional cyborgs?  I don't want to believe you, but also, I already kinda thought there might be some multidimensional hijinks going on here, so I kinda do want to believe you.  They speak English though?  Are you sure this isn't some kind of scam?  Are you just fucking with me?  Honestly this would be a great way to fuck with me.\""),
    replies = {
        {
            text = ccb.content.text("[Show her your bionic interface.]"),
            when = predicates.has_trait("speaker", "CBM_Interface"),
            next_topic = "TALK_REFUGEE_JENNY_Exodii_Proof",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
