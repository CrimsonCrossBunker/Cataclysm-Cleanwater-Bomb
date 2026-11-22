local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_GROUND_QUARTERMASTER_BRIBE" },
    line = ccb.content.text("This isn't a store.  Go to the Spaceport if you want to buy supplies."),
    replies = {
        {
            text = ccb.content.text("I'm sure we can work something out.  [Bribe $3000]"),
            trial = { kind = "persuade", difficulty = 50 },
            success = { next_topic = "TALK_DONE", actions = { actions.set_actor_value("interlocutor", "player_can_trade", "yes"), actions.handler("w16b_a_aftershock_exoplanet_a8c0944b1770") } },
            failure = { next_topic = "TALK_UICA_GROUND_QUARTERMASTER_BRIBE_FAILURE", actions = { actions.add_effect("interlocutor", "afs_tried_to_bribe", { turns = 86400 }) } },
        },
        {
            text = ccb.content.text("Nevermind then."),
            next_topic = "TALK_DONE",
        },
    },
}
