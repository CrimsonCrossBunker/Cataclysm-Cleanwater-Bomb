local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- I didn't know you'd be such a hard bargain!  Tell ya what, when you come back, I'll let you in on some of these fancy knick-knacks.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_pay_skeptic",
    line = ccb.content.text("Rightly a trig barter, an I'm ken.  By ol' Rubik's word, on your saintly march home, for you'll have the pick of the bright and steelies roun' ol' Rubik's shop, choice o' your own finely.  What say?"),
    replies = {
        {
            text = ccb.content.text("I'll go check it out."),
            actions = { actions.assign_mission("EXODII_MISSION_CONTACT_HUB") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- That's quite the spirit!  For an exchange, I'll give you some of these shiny tools, whatever you want.  How's that sound?
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_pay_nice",
    line = ccb.content.text("Ah, 'tis a fine spark.  F'r a switch an' clock, ol' Rubik can share y'like o' these bright and steelies roun' the shop, choice o' your finely.  What say?"),
    replies = {
        {
            text = ccb.content.text("I'll go check it out.  Thanks, Rubik."),
            actions = { actions.assign_mission("EXODII_MISSION_CONTACT_HUB") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  I'll see you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
