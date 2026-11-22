local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_HIDE2",
    line = ccb.content.gendered_line("You're new here, who the hell put you up to this crap?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Get bent, traitor!"),
            trial = { kind = "intimidate", difficulty = 20, modifiers = { { score = "FEAR", scale = 3 } } },
            success = { next_topic = "TALK_EVAC_GUARD3_HOSTILE", actions = { actions.handler("dlg_a_dda_3e3cfcb1ca64") } },
            failure = { next_topic = "TALK_EVAC_GUARD3_INSULT" },
        },
        {
            text = ccb.content.text("Got something to hide?"),
            trial = { kind = "persuade", difficulty = 10, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_EVAC_GUARD3_DEAD", actions = { actions.handler("dlg_a_dda_08eb32f903c4") } },
            failure = { next_topic = "TALK_EVAC_GUARD3_INSULT" },
        },
        {
            text = ccb.content.text("Sorry, I didn't mean to offend you…"),
            next_topic = "TALK_EVAC_GUARD3_WASTE",
        },
    },
}
