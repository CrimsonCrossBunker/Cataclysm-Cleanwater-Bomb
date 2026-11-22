local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_Help",
    line = ccb.content.text("*shrugs.  \"I don't have any skills.  I'm just a kid.  What am I going to do?\"  Before you can answer, he shakes his head.  \"I'm being pathetic, sorry.  You're right, I should see if there's something I can give back to the community, maybe make my place in it.  That's a good call.\"  He scratches his chin and looks out a gap in the shutters on the window.  \"Thanks.\""),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_9c8e651a478c") } },
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_Situation",
    line = {
        joined = {
            ccb.content.text("It sucks in here, there's no two ways about it"),
            {
            when = predicates.handler("dlg_p_dda_f4f8d93f10a9"),
            yes = ccb.content.text(".  Still, we're starting to find a bit of a place for ourselves.  I've been hanging out with Aleesha a bit, I didn't used to think we'd have a lot in common but there's more than you'd think.  My mom and dad are starting to relax a little too."),
            no = ccb.content.text(".  People don't talk to us because we wear turbans and we still have each other.  They think because we're still together, we didn't lose anything.  My dad believes it, too, and I think my mom's on the fence."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Your family all made it here?"),
            next_topic = "TALK_REFUGEE_Guneet_Family",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
