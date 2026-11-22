local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_MISSION_3_Predone",
    line = ccb.content.text("Oh, well.  In that case, I would be interested in hearing what you know about them.  I can relay it to command.  Let's see what I have to trade… how about some antibiotics from our stores?  You can never have too many of them out there."),
    replies = {
        {
            text = ccb.content.text("Yeah, I've met them.  They seem open to trade and things.  Not hostile, at least not to me."),
            next_topic = "TALK_OLD_GUARD_REP_EXODII_2",
            actions = { actions.handler("dlg_a_dda_0b1562fc78f3"), "mission_success", "clear_mission" },
        },
        {
            text = ccb.content.text("I'll have to think about it.  <done_conversation_section>"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_Refuse_Boris_Mission_1",
    line = ccb.content.text("I'm sorry, but I can't leave my post here, and I just don't have the human resources even for a project like that."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Well, thanks anyway."), next_topic = "TALK_OLD_GUARD_REP" } },
}
