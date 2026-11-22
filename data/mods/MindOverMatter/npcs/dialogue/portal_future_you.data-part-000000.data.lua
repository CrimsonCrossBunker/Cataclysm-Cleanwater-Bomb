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
