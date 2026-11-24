local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_WHAT_ARE_YOU", "TALK_PORTAL_STORM_DO_FOR_ME", "TALK_PORTAL_STORM_WHAT_DO_YOU_GET" },
    replies = {
        {
            text = ccb.content.text("[Premonition] *Check for anything amiss*"),
            next_topic = "TALK_PORTAL_STORM_DANGER_SENSE_FAIL",
            when = predicates.handler("dlg_p_mindovermatter_fb988aab4d33"),
        },
        {
            text = ccb.content.text("[Premonition 8+] *Check for anything amiss*"),
            next_topic = "TALK_PORTAL_STORM_DANGER_SENSE_SUCCEED",
            when = predicates.handler("dlg_p_mindovermatter_e102dd3a1faa"),
        },
        {
            text = ccb.content.text("[Sense Hostility] *Determine if the voice is a threat*"),
            next_topic = "TALK_PORTAL_STORM_DANGER_sense_hostility",
            when = predicates.handler("dlg_p_mindovermatter_2aa005690cdb"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_WHAT_ARE_YOU", "TALK_PORTAL_STORM_DO_FOR_ME", "TALK_PORTAL_STORM_WHAT_DO_YOU_GET" },
    replies = {
        {
            text = ccb.content.text("[Telepath] *Read the voice's mind(?)*"),
            next_topic = "TALK_PORTAL_STORM_telepathy",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_telepathy" },
    line = ccb.content.text("&You reach out to the voice's location(?) and try to touch its thoughts.  In an instant, your mind is filled by a babble of your *own* thoughts, at exactly the moment you think them, which then repeat again as you realize what is happening and your thoughts about the experience are reflected back at you and your brain is filled with an agonizing cacophony until you break the connection."),
    replies = {
        {
            text = ccb.content.text("Well, that was a mistake."),
            next_topic = "TALK_PORTAL_STORM_CONVERSATION",
            actions = { actions.handler("dlg_a_mindovermatter_13dcaba35575") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_DANGER_SENSE_FAIL" },
    line = ccb.content.text("&You extend your senses, alert for danger, and are immediately almost blinded.  In the heart of the portal storm, there's danger everywhere.  In the air and ground, in the things half-glimpsed that vanish when you look at them, and in yourself, just waiting for the right conditions to be unleashed.  If there's anything sinister in the voice's offer, you cannot tell."),
    replies = {
        {
            text = ccb.content.text("*Close your inner eye*"),
            next_topic = "TALK_PORTAL_STORM_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_DANGER_SENSE_SUCCEED" },
    line = ccb.content.text("&You extend your senses, alert for danger.  Shutting out the ever-present danger of the post-Cataclysmic world and the portal storm, you focus on your immediate surroundings.  There is danger there, but not directly.  Whatever the outcome of its offer, it is not meant as a trap."),
    replies = {
        {
            text = ccb.content.text("*Close your inner eye*"),
            next_topic = "TALK_PORTAL_STORM_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_DANGER_sense_hostility" },
    line = ccb.content.text("&You focus on the voice, trying to determine its intentions, and are surprised.  The voice, at least, does not mean you any harm.\n\nAs you withdraw your senses, however, you can't help but realize that in these circumstances, that doesn't necessarily mean you won't come to any harm."),
    replies = {
        {
            text = ccb.content.text("*Close your inner eye*"),
            next_topic = "TALK_PORTAL_STORM_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_WHAT_DO_YOU_GET" },
    replies = {
        {
            text = ccb.content.text("[Clarity 3+] *Is the voice lying?*"),
            next_topic = "TALK_PORTAL_STORM_CLARITY",
            when = predicates.handler("dlg_p_mindovermatter_4d44b6e93be9"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PORTAL_STORM_CLARITY",
    line = ccb.content.text("&You open your inner eye and in its light you see the truth.  This *is* you.  Was you.  Might be you.  You know it like you know yourself.  Whatever game it's playing, its intentions are not malicious.  They are your own."),
    replies = {
        {
            text = ccb.content.text("What do I need to do?"),
            next_topic = "TALK_PORTAL_STORM_I_NEED_TO_DO",
        },
        { text = ccb.content.text("Leave me alone."), next_topic = "TALK_PORTAL_STORM_IGNORE" },
    },
}

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
