local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_HIRE",
    line = ccb.content.text("I'm currently waiting for a customer to return… I'll make you a deal though, 750 merch will cover my expenses if I get a small cut of the loot."),
    replies = {
        {
            text = ccb.content.text("What the heck is a merch?"),
            next_topic = "TALK_SCAVENGER_MERC_MERCH",
        },
        {
            text = ccb.content.text("I might be back."),
            next_topic = "TALK_SCAVENGER_MERC",
        },
        {
            text = ccb.content.text("[750 merch] You have a deal."),
            next_topic = "TALK_SCAVENGER_MERC_HIRE_SUCCESS",
            when = predicates.has_inventory("speaker", "FMCNote", 750),
            actions = { actions.handler("dlg_a_dda_fe6648a62eb4") },
        },
    },
}
