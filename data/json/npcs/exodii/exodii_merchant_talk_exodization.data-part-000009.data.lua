local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a_yes",
    line = ccb.content.text("&Rubik stares at Venn, and after a long silence, they offer each other a stiff bow.  Rubik places a hand upon your shoulder.  It's a familiar, warm gesture.  A stark juxtaposition to the chill of their metal hand.  You lay back upon the table, and you hear a mechanical whirr as the spider-like surgical robot starts to greedily tap away at your extremities.  You barely have a moment to consider your actions before it all goes black…"),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 43200 }), actions.add_effect("speaker", "sleep", { turns = 43200 }), actions.handler("w16b_a_dda_9ce35a2a90df"), actions.replace_mutation("speaker", "EXODII_CYBERFRAME_GENERIC"), actions.handler("w16b_a_dda_93293e0035eb") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b_yes",
    line = ccb.content.text("&Rubik stares at Venn, and after a long silence, they offer each other a stiff bow.  Rubik places a hand upon your shoulder.  It's a familiar, warm gesture.  A stark juxtaposition to the chill of their metal hand.  You lay back upon the table, and you hear a mechanical whirr as the spider-like surgical robot starts to greedily tap away at your extremities.  You barely have a moment to consider your actions before it all goes black…"),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 43200 }), actions.add_effect("speaker", "sleep", { turns = 43200 }), actions.handler("w16b_a_dda_9ce35a2a90df"), actions.replace_mutation("speaker", "EXODII_CYBERFRAME_GENERIC"), actions.handler("w16b_a_dda_644db66b5949") },
        },
    },
}
