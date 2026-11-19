local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN" },
    line = ccb.content.text("Right!  Sorry, this is the vehicle bay, and I run the place.  Mostly I just fix up the patrol vehicles.  But I am also in charge of maintaining our stock of vehicle parts.  As such: I've been authorized to trade with salvors in order to get what we need, and can offer you some of our excess stock or chits in exchange.  I'll give you a nice price, just: Don't tell my boss.  And one more thing, I've got something really special for sale, if you're interested."),
    replies = {
        {
            text = ccb.content.text("Can you show me your stock?"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes"), "start_trade" },
        },
        {
            text = ccb.content.text("What's this special offer?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
        {
            text = ccb.content.text("Thanks, I don't need anything right now."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION" },
    line = ccb.content.text("This is the vehicle bay, and I run the place.  Please don't touch anything unless you're buying.  I fix up the patrol vehicles and maintain our stock of spare parts.  As such: I've been authorized to trade with outsiders in order to get what we need, and can offer you some of our excess stock or chits in exchange."),
    replies = {
        {
            text = ccb.content.text("Can you show me your stock?"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes"), "start_trade" },
        },
        {
            text = ccb.content.text("Thanks, I don't need anything right now."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
    },
}
