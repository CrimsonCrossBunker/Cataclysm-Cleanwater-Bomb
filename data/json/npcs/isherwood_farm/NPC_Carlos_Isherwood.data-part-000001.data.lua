local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ISHERWOOD_CARLOS", "TALK_ISHERWOOD_CARLOS_ConvincedMarshal" },
    replies = {
        {
            text = ccb.content.text("Hi, looks like you are building a forge setup."),
            next_topic = "TALK_ISHERWOOD_CARLOS_TALK1",
            actions = {
                actions.set_actor_value("speaker", "u_met_Carlos_Isherwood", "yes"),
                actions.set_actor_value("speaker", "u_met_an_isherwood", "yes"),
            },
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
        {
            text = ccb.content.text("Hi, Jack and Claire suggested I come talk to you about a job."),
            next_topic = "TALK_CARLOS_FORGE1",
            actions = { actions.set_actor_value("speaker", "u_met_Carlos_Isherwood", "yes") },
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_about_jesse" } }) }),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS",
    line = {
        joined = {
            ccb.content.text("*is an older middle-aged man, well-muscled and darkly tanned, with worried lines around the corners of his eyes and mouth.  He looks up as you get close"),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text(", and then puts his hand on the butt of the rifle slung across his back.  \"I see that badge, I think you need to keep on walking, straight off this property.\""),
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text(", then smiles distantly.  \"Hello Sir, what brings you here?\""),
                    no = ccb.content.text(", then smiles distantly.  \"Hello Ma'am, what brings you here?\""),
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
            actions = { actions.set_first_topic("TALK_ISHERWOOD_CARLOS_SawMarshal") },
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
    },
}
