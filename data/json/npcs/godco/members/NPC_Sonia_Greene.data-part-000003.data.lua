local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Sonia_Play_For_U",
    line = ccb.content.text("Sure, I can play you a tune or two that I know.  It will cost you a little something, just one icon.  The artist doesn't want to starve, if you know what I mean."),
    replies = {
        {
            text = ccb.content.text("Alright, let's hear it."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "icon"),
            actions = { actions.transfer_items("icon"), actions.handler("dlg_a_dda_fa9ebfeb6877") },
            opinion = { trust = 1, value = 1 },
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
