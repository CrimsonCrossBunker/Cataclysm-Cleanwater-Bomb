local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_get_food_joinee",
    line = ccb.content.text("They can, but we're limited on the portions for now.  Hope you enjoy it, and come back tomorrow for another."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_d450420170b3"), actions.add_effect("interlocutor", "u_got_meal", { turns = 43200 }) } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_DONE",
        },
    },
}
