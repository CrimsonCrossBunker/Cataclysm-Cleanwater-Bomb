local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_EXODII_1",
    line = ccb.content.gendered_line("If you want to know what our next steps are, I'm not at liberty to tell you.  Truth be told, I don't even know myself.  They don't share that sort of information with me.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Actually, I've met them.  They seem open to trade and things.  Thought you might want to know."),
            next_topic = "TALK_OLD_GUARD_REP_EXODII_2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
    },
}
