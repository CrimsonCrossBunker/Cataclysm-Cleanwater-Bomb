local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ISHERWOOD_EDDIE", "TALK_ISHERWOOD_EDDIE_ConvincedMarshal" },
    replies = {
        {
            text = ccb.content.text("Nice dairy, must be tough keeping it running."),
            next_topic = "TALK_ISHERWOOD_EDDIE_TALK1",
            actions = {
                actions.set_actor_value("speaker", "u_met_Eddie_Isherwood", "yes"),
                actions.set_actor_value("speaker", "u_met_an_isherwood", "yes"),
            },
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Have anything to trade?"),
            next_topic = "TALK_ISHERWOOD_EDDIE",
            actions = { "start_trade" },
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("When will your cows produce again?"),
            next_topic = "TALK_ISHERWOOD_EDDIE_RESTOCK",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE",
    line = {
        joined = {
            ccb.content.text("*is a sun-worn, middle-aged man with crows feet and graying hair.  He looks up as you approach, "),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text("then sneers as he spots the Old Guard Marshal badge gleaming on your chest.  \"I already told your kind not to come around here.  You need to keep on walking, straight off this property.\""),
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text("then gives you a little greeting wave.  \"Hello Sir, what brings you here?\""),
                    no = ccb.content.text("then gives you a little greeting wave.  \"Hello Ma'am, what brings you here?\""),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I'm a Marshal, what are you going to do about it?"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_DONE",
            opinion = { trust = -20, value = -20 },
            actions = { actions.set_first_topic("TALK_ISHERWOOD_EDDIE_SawMarshal") },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Luke said you guys have some issues with the Old Guard.  What's up with that?"),
            next_topic = "TALK_ISHERWOOD_EDDIE_Marshal",
            when = predicates.all({ predicates.any_equal({ "known", { scope = "speaker", key = "isherwood_luke_marshal_questions" } }), predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
    },
}
