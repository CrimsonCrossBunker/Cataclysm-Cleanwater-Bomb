local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Refuse_Boris_Mission_1",
    line = {
        choices = {
            ccb.content.text("Sorry, but you couldn't pay me enough to go back there."),
            ccb.content.gendered_line("No way, sorry.  I was in there when things went bad.  It'll be hard enough to go back after it's cleaned up, I can't bear to look at it right now.", { "interlocutor" }),
            ccb.content.text("I can't.  Too many memories back there.  Sorry."),
            ccb.content.text("I wish I could, but no.  I can't face the memories."),
            ccb.content.gendered_line("Sorry, no.  That's too much to ask from me.  I was back there when it went wrong.", { "interlocutor" }),
            ccb.content.text("You won't get much luck asking those of us who were back there I'm afraid.  Sorry."),
        },
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
