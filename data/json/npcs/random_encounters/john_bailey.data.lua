local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_1a",
    line = ccb.content.text("*nods as you approach, then smiles and stretches casually.  \"Anything I can do for you, friend?\""),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text("What do you know about this place?"),
            next_topic = "TALK_RC_John_Bailey_RefCenter",
        },
        {
            text = ccb.content.text("You looking for any kind of work?"),
            next_topic = "TALK_RC_John_Bailey_Work",
        },
        {
            text = ccb.content.text("I'm looking for a very specific building in the wilderness.  Have you seen it?"),
            next_topic = "TALK_JOHN_BAILEY_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Not at the moment, thanks."),
            next_topic = "TALK_DONE",
        },
    },
}
