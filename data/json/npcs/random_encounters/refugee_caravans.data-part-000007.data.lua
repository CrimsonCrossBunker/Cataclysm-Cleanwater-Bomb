local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B2",
    line = ccb.content.text("Nice.  Good to see you again.  What do you want from me?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Job",
        },
        {
            text = ccb.content.text("You should come with me instead."),
            false_text = ccb.content.text("You should definitely come with me instead."),
            text_when = predicates.handler("dlg_p_dda_5a268b8b89b9"),
            trial = { kind = "skill_check", difficulty = 3, skill = "speech" },
            success = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_Yes" },
            failure = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_No" },
        },
        {
            text = ccb.content.text("Nothing, just saying hi."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Job",
    line = ccb.content.gendered_line("I'm a refugee, but don't get the wrong idea.  I've got big dreams of settling down after this and starting a big family.  I just need to find the right place and the right person.  Last couple of places didn't work out so well.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("So you're not attached right now?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Attached",
        },
        {
            text = ccb.content.text("You should come with me instead."),
            false_text = ccb.content.text("You should definitely come with me instead."),
            text_when = predicates.handler("dlg_p_dda_5a268b8b89b9"),
            trial = { kind = "skill_check", difficulty = 3, skill = "speech" },
            success = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_Yes" },
            failure = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_No" },
        },
        {
            text = ccb.content.text("Why, where were you before?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Not interested.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Attached",
    line = ccb.content.text("No, I'm not really with them.  We just got stuck together in the same messed up evacuation place.  This one guy was really nice, but they wouldn't let us stay.  They got there first so they told us we needed to find our own place, but if we got anything they wanted they'd trade some of the stuff they have.  I tried to talk them into helping but they were so cold to me."),
    replies = {
        {
            text = ccb.content.text("You should come with me instead."),
            false_text = ccb.content.text("You should definitely come with me instead."),
            text_when = predicates.handler("dlg_p_dda_5a268b8b89b9"),
            trial = { kind = "skill_check", difficulty = 3, skill = "speech" },
            success = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_Yes" },
            failure = { next_topic = "TALK_CARAVAN_REFUGEE_B1_Join_No" },
        },
        {
            text = ccb.content.text("How do I get there?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Yeah, I guess it's hard all over.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
