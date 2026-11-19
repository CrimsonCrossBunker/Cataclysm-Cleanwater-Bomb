local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Story",
    line = ccb.content.text("We're with a larger group of survivors, working out of one of the old FEMA bunkers.  Folks have taken to calling us Free Merchants, although that sounds kinda on the nose to me.  We know about a few survivor groups and we make regular trips around, sharing supplies back and forth and bringing them home.  We're on the way back now."),
    replies = {
        {
            text = ccb.content.text("That's interesting.  Well, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can you give me directions to any of these other survivor groups?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Others",
        },
        {
            text = ccb.content.text("Where is 'home'?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Home",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for chatting.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Others",
    line = ccb.content.gendered_line("No offense, but my clients definitely would not like me giving strangers directions to their hideouts.  You'll have to find them on their own terms.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("I can understand that.  Well, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Where is 'home'?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Home",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for chatting.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
