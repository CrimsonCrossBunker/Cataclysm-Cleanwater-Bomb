local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_C1",
    line = ccb.content.text("Hey man.  Do you have any heroin?  I'm in a bit of a bind."),
    replies = {
        {
            text = ccb.content.text("Oh, uh, sorry."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Never, that heroin is for me and me alone."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "heroin"),
        },
        {
            text = ccb.content.text("I think you might need it even more than me.  Here you go."),
            next_topic = "TALK_CARAVAN_REFUGEE_C_LOVE",
            when = predicates.has_item("speaker", "heroin"),
            actions = { actions.transfer_items("heroin") },
            opinion = { trust = 2, value = 2 },
        },
    },
}
