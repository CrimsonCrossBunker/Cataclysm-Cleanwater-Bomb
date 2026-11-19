local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = {
        "TALK_GODCO_Russell_Joinee", "TALK_GODCO_Russell_2", "TALK_GODCO_Russell_Trophy2",
        "TALK_GODCO_Russell_Mood", "TALK_GODCO_Russell_Mood1", "TALK_GODCO_Russell_Trophy3",
        "TALK_GODCO_Russell_Trade2",
    },
    replies = {
        {
            text = ccb.content.text("Let's talk about getting you those trophies."),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.has_effect("interlocutor", "hunt_godco_russell")),
        },
        {
            text = ccb.content.text("Why don't you hunt these trophies yourself?"),
            next_topic = "TALK_GODCO_Russell_Trophy3",
            when = predicates.negate(predicates.has_effect("interlocutor", "hunt_godco_russell")),
        },
        {
            text = ccb.content.text("Why didn't you hunt these trophies yourself?"),
            next_topic = "TALK_GODCO_Russell_Trophy3",
            when = predicates.has_effect("interlocutor", "hunt_godco_russell"),
        },
        {
            text = ccb.content.text("Do you really need these trophies?"),
            next_topic = "TALK_GODCO_Russell_Trophy2",
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Russell_Mood",
        },
        { text = ccb.content.text("Care to trade?"), next_topic = "TALK_GODCO_Russell_Trade" },
    },
}
