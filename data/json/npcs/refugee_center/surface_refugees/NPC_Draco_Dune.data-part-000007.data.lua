local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_hasnt_found_weed",
    line = ccb.content.text("Well, let me know when you have.  I'm not going anywhere."),
    replies = {
        { text = ccb.content.text("Sure."), next_topic = "TALK_REFUGEE_Draco_10_approve" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        { text = ccb.content.text("I'm not your drug dealer, buddy."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_sold",
    line = ccb.content.gendered_line("Sold!  Thanks for helping me out, friend.", { "speaker" }),
    replies = {
        { text = ccb.content.text("No problem, Draco."), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("You're welcome.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}
