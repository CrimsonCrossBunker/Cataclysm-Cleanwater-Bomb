local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE" },
    line = ccb.content.text("As I've SAID before: I'm only authorized to trade vehicle parts and scraps.  Our patrol vehicles are not up for auction.  Now if you don't mind, I have work to do."),
    replies = {
        {
            text = ccb.content.text("Surely you can arrange for a patrol car to be 'lost'.  I can make it worth your while."),
            trial = { kind = "persuade", difficulty = 60 },
            success = {
                next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_PASS",
                actions = { actions.set_actor_value("interlocutor", "player_has_pursuaded", "yes") },
            },
            failure = {
                next_topic = "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_FAIL",
                actions = { actions.add_effect("interlocutor", "afs_tried_to_buy_car", { turns = 86400 }) },
            },
        },
        { text = ccb.content.text("Nevermind then."), next_topic = "TALK_DONE" },
    },
}
