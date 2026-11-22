local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_SHOW_MILITARY_ID",
    line = ccb.content.text("Hey, where did you get it?  Nevermind, just give it to me.  Right now."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "mission_military_id_prisoner_leader_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Hey, no need to be hostile.  Here you go, I don't need it anyway."),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("id_military") },
        },
        {
            text = ccb.content.text("I went through incredible hardships to get it.  Please, can I keep this to myself?"),
            trial = { kind = "persuade", difficulty = 5, modifiers = { { score = "ALTRUISM", scale = 3 }, { score = "TRUST", scale = 1 } } },
            success = { next_topic = "TALK_PRISONER_LEADER_TRIAL_SUCCESS" },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("I killed tons of <zombies> while I was trying to get this thing.  Do you really think you and your handful of losers pose a threat to me?"),
            trial = { kind = "intimidate", difficulty = 30, modifiers = { { score = "BRAVERY", scale = -1 }, { score = "FEAR", scale = 3 } } },
            success = { next_topic = "TALK_PRISONER_LEADER_TRIAL_SUCCESS" },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("What, <no>!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}
