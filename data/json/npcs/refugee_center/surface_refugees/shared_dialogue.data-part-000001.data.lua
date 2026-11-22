local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Accept_Boris_Mission_1",
    line = {
        choices = {
            ccb.content.text("This is for Boris?  Yeah, Boris is has been through a lot, I'll do it for him."),
            ccb.content.text("It won't be pretty, but I'll see what I can do.  We'll all benefit from it after all."),
            ccb.content.text("I can try.  It's worth trying for Boris."),
            ccb.content.text("That's a big ask, for sure.  Okay, I'll see what I can do."),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_1771a2e9be11") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks anyway.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Well, thanks anyway."),
            next_topic = "TALK_DONE",
        },
    },
}
