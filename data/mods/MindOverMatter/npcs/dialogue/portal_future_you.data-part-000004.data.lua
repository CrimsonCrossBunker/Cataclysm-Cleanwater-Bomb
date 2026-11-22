local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PORTAL_STORM_I_NEED_TO_DO",
    replies = {
        {
            text = ccb.content.text("[Gateway 8+] Thanks, but here I can leave without your help.  Be seeing you.  (End your story)"),
            next_topic = "TALK_PORTAL_STORM_TELEPORT_OUT",
            when = predicates.handler("dlg_p_mindovermatter_4e39a8ddadc9"),
            actions = { actions.handler("dlg_a_mindovermatter_9387dea2b6c1") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PORTAL_STORM_TELEPORT_OUT",
    line = ccb.content.text("&Normally you need to have been to your destination to teleport to it, but here in the heart of the chaos you can sense other worlds.  Other times.  An endless torrent of possibility, flowing continuously around and over and through you.  None of it lasts long enough for you to get a good glimpse, but almost anywhere has to be better than here.  With a simple act of will, you reach out and grasp one chance as it floats by, open a doorway, and leave your dying world behind.\n\nAnd what happens to you afterwards, well, that's another story."),
    replies = {
        {
            text = ccb.content.text("That's what life's about: making the right choice at the right time."),
            next_topic = "TALK_DONE",
            actions = { "u_die" },
        },
    },
}
