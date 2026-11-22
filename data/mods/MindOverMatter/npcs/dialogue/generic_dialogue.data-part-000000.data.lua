local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_STOLE_ITEM",
    replies = {
        {
            text = ccb.content.text("[Telepathy Check] What are you talking about?  This is mine."),
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
            switch = true,
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_a42101192724") },
            success = { next_topic = "TALK_TELEPATHY_ALLOW_KEEP_ITEM" },
            failure = { next_topic = "TALK_DISALLOW_KEEP_ITEM" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TELEPATHY_ALLOW_KEEP_ITEM",
    line = {
        choices = {
            ccb.content.text("Oh, I…I don't know what I was thinking.  I…sorry."),
            ccb.content.text("It is?  Oh, it…it is.  Right.  Right."),
            ccb.content.text("I…I thought that…never mind."),
            ccb.content.text("But you…no, I thought…I just…"),
            ccb.content.text("What?  But that's…we've had…how did you…"),
        },
    },
    replies = {
        {
            text = ccb.content.text("That's right."),
            next_topic = "TALK_DONE",
            actions = { "remove_stolen_status", actions.handler("dlg_a_mindovermatter_2cfa11e32d4b") },
        },
    },
}
