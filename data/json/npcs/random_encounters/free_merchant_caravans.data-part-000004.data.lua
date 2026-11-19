local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Home",
    line = ccb.content.text("Here, I'll mark it on your map.  Feel free to come by and trade, or if you're the type, we might have use for your services as a merc."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_REFUGEE_CENTER") } } },
    replies = {
        {
            text = ccb.content.text("Hey, thanks.  Well, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can you give me directions to any of these other survivor groups?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Others",
        },
        {
            text = ccb.content.text("Thanks for that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
