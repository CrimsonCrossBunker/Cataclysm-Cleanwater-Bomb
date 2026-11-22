local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_Situation",
    line = {
        when = predicates.handler("dlg_p_dda_f4f8d93f10a9"),
        yes = ccb.content.text("I reckon I've done my job here.  Goan' be time to ride out into the sunset soon, if'n you catch m'drift.\"  He tilts his hat melodramatically.  \"Folks're comin' around to this here new world we live in."),
        no = ccb.content.text("Folks don't like bein' kept from the blue sky for too long.  Cooped up like cattle in a barn… we need pastures to run free, if'n y'get my drift.  'Til we got 'em, it's gonna be tense in here."),
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
