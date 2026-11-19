local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A_Job",
    line = ccb.content.text("I'm a caravan guard, working for the Free Merchants.  I'm an independent contractor though.  Seems like a good way to get safety in numbers and try to find a safe place to settle down."),
    replies = {
        {
            text = ccb.content.text("So you're working for these guys, but aren't one of them?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Merc",
        },
        {
            text = ccb.content.text("You looking for work?  I might be hiring."),
            next_topic = "TALK_CARAVAN_GUARD_A_Hire",
        },
        {
            text = ccb.content.text("The Free Merchants?  Do they have some kind of trade outpost or anything like that?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("It's a living, eh?  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A_Merc",
    line = ccb.content.text("Yeah, these guys snagged some kind of FEMA evacuation bunker during the early part of <the_cataclysm> and hoard the space.  They don't let anyone else join, but they need supplies, so they send out traders, and those traders need protection, so they send out guys like me."),
    replies = {
        {
            text = ccb.content.text("You looking for work?  I might be hiring."),
            next_topic = "TALK_CARAVAN_GUARD_A_Hire",
        },
        {
            text = ccb.content.text("How do I get there?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("It's a living, eh?  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A_Hire",
    line = ccb.content.text("I'm good for the moment, but you can usually find a merc or two waiting between jobs, back at the Free Merchant base."),
    replies = {
        {
            text = ccb.content.text("How do I get there?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for the tip!  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
