local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_PERSON_2" },
    replies = {
        {
            text = ccb.content.text("[Telepath] *Read the strange person's mind*"),
            next_topic = "TALK_PORTAL_TRAVELER_telepathy",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_TRAVELER_telepathy" },
    line = ccb.content.text("«Jasz vata aralas mat!  On de farah shatan!  Mazeh jast ond!»"),
    replies = { { text = ccb.content.text("Well, that didn't help either."), next_topic = "TALK_DONE" } },
}
