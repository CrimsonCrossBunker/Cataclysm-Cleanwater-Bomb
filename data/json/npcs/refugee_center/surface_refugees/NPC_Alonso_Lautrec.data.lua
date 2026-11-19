local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Refuse_Boris_Mission_1",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("I'm sorry.  I… saw things back there, when it all went sideways.  I can't go back, not for anything."),
        no = ccb.content.text("Alonso, alas, is sorry, but he cannot sully his hands with blood.  It is not that he does not wish to prove his strength, but he… he is not strong enough."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thanks anyway.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Well, thanks anyway."), next_topic = "TALK_DONE" },
    },
}
