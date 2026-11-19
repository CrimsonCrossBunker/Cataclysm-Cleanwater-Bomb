local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GIVE_EQUIPMENT",
    line = ccb.content.text("Okay, here you go."),
    replies = {
        {
            text = ccb.content.text("Thank you!"),
            next_topic = "TALK_NONE",
            actions = { actions.add_effect("interlocutor", "asked_for_item", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("Thanks!  But can I have some more?"),
            next_topic = "TALK_SHARE_EQUIPMENT",
            actions = { actions.add_effect("interlocutor", "asked_for_item", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("Thanks, see you later!"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("interlocutor", "asked_for_item", { turns = 86400 }) },
        },
    },
}
