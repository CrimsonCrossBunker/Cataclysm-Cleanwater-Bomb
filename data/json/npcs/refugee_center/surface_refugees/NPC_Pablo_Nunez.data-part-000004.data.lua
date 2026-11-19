local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2_survivors",
    line = ccb.content.text("From the bus?  A few of us made it in the end; the Singh family were on that bus with us.  We were some of the last refugees to arrive.\"  He gestures to three people gathered together a short distance away.  \"They put us into a room for processing, where a bunch of the wounded were being handled as best as they could manage.  They were short staffed though, and they missed one.  We all thought he was just having a nap, but he wasn't,\" Pablo wipes his face with his hand and pauses for a moment.  \"When he got back up as a zombie, there was a huge panic.  Gunshots in a small, crowded room, and trampling… it was really ugly.  We were close to the door and managed to get out right away, but then a couple panicking people closed the place off and left innocent people in there for what seemed like ages, calling it an 'outbreak'.  By the time leveler heads prevailed, there weren't many people left in there to recover."),
    replies = {
        {
            text = ccb.content.text("I've been back to the quarantined area, cleared it out.  It was ugly back there."),
            next_topic = "TALK_REFUGEE_Pablo_Background2_cleared",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } }),
        },
    },
}
