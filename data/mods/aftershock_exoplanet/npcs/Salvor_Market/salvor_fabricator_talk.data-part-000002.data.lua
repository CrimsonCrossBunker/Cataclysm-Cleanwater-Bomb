local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_3" },
    line = ccb.content.text("Right then, this here's my shop, and round the back there's my workroom.  I've enough tech here to whip up whatever you need, 'cept for that real fancy glittertech shit.  I sell the sorts of tools folk like you need to do your work.  Stuff that'll get you into places you ain't supposed to be and break apart anything interesting you find.  I'll buy any scraps you get out there and I'll shoot you straight on the prices.  So if you find anything interesting you bring it here first ya hear?"),
    replies = {
        {
            text = ccb.content.text("Good to know.  Can I take a look at your stock?"),
            next_topic = "TALK_DONE",
            actions = { "start_trade", actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
        {
            text = ccb.content.text("Good to know.  I don't need anything right now though."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
    },
}
