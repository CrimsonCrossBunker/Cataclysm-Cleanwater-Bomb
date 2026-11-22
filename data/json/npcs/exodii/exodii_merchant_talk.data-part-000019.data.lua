local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro5",
    line = ccb.content.text("Oh, rights.  Many lands be'd assert on thosun's.  A fusilly, she's a weapon, shoots a shot at high speeds usin' bang.  A mobbing, he's a grand box o' metal, pushed by burnin' and boomin' from wit'in, kennit?"),
    replies = {
        {
            text = ccb.content.text("[INT 7] Sounds like you mean a fusilly is a gun, and a mobbing is a car?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro6",
            when = predicates.minimum_attribute("speaker", "intelligence", 7),
            actions = { actions.set_actor_value("speaker", "dictionary_known_fussily", "yes"), actions.handler("dlg_a_dda_f3ca9f11fc01") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
