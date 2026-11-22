local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions



ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE_FINISH",
    line = ccb.content.text("&<mypronoun> quickly removes the offending piece of meat from your hand and places two golden coins on the table, apparently unshaken by the prospect of meeting someone who casually visits bars while carrying cuts of human flesh.  \"Now if you please, I have a meal to get rid of.\" <mypronoun> says, between poorly masked bouts of nausea."),
    on_enter = {
        { actions = { actions.transfer_items("human_sample"), actions.handler("dlg_a_dda_3cea5fb343d4") } },
    },
    replies = {
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
            actions = { "end_conversation" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE_BUY",
    line = ccb.content.gendered_line("&The mercenary gives you a quick appraisal.  \"Five coins for three, special price just for you.  Pay in advance, and I'll arrange a drop in the subway rails here for you to pick within two days.  Deal or not?\"", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("[5 HGC] Its a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 5),
            actions = { actions.transfer_items("RobofacCoin", 5), actions.handler("w16b_a_dda_44ca1332f016") },
        },
        {
            text = ccb.content.text("Sure, just let me find the cash."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_inventory("speaker", "RobofacCoin", 5)),
        },
        {
            text = ccb.content.text("No deal."),
            next_topic = "TALK_DONE",
        },
    },
}
