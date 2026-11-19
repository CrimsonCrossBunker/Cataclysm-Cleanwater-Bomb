local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2",
    line = {
        when = predicates.available_missions("interlocutor", 0, 0),
        yes = {
            when = predicates.assigned_missions(0, 0),
            yes = ccb.content.text("We've done it!  We've solved the list!"),
            no = ccb.content.text("How's things with you?  My cardboard collection is getting quite impressive."),
        },
        no = ccb.content.text("Have I told you about cardboard, friend?  Do you have any?"),
    },
    replies = {
        {
            when = predicates.assigned_missions(1, 1),
            text = ccb.content.text("About that shopping list of yours…"),
            next_topic = "TALK_MISSION_INQUIRE",
        },
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_dinodave_cardboard_donor" } }), predicates.negate(predicates.available_missions("interlocutor", 0, 0)) }),
            text = ccb.content.text("Is there anything else I can do for you?"),
            next_topic = "TALK_MISSION_OFFER",
        },
        {
            when = predicates.all({ predicates.available_missions("interlocutor", 0, 0), predicates.assigned_missions(0, 0), predicates.negate(predicates.has_mission("MISSION_BEGGAR_2_PERMISSION")) }),
            text = ccb.content.text("What are you going to do with all that cardboard now?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_JOBSDONE",
            actions = { actions.set_actor_value("speaker", "general_recruit_dave_happy", "yes") },
        },
        {
            when = predicates.all({ predicates.has_mission("MISSION_BEGGAR_2_PERMISSION"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_Dave_Permission" } }) }),
            text = ccb.content.text("We've done it, Dave!  Smokes says you can build yourself a house up on the roof if you want.  You've got to keep it nice and clean, and help out the people down here by looking out for zombies, but you can still use the washrooms and things downstairs when you need to.  What do you say?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_PERMISSION",
        },
        { text = ccb.content.text("Cardboard?"), next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD" },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text("Are you seriously wearing a dinosaur costume?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINOSAUR",
        },
        {
            text = ccb.content.text("Do you need something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_GIVE_FOOD",
        },
        { text = ccb.content.text("Get away from me."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}
