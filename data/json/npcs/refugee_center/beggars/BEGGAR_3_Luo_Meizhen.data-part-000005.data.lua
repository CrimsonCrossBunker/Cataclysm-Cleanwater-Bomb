local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_INTRO",
    line = ccb.content.text("Oh, same old story at first.  I got evacuated on to the local concentration center, then picked up on a repurposed school bus and dragged out here.  Then the chick processing me to get in saw my face and Chinese name and conveniently 'lost' my paperwork.  I was sent out here to wait for further processing, while I watched busloads of people get processed and taken in.  By the time they 'found' it, the place was full up, wouldn't ya know it.  Now I'm stuck out here and they won't consider letting me in."),
    replies = {
        {
            text = ccb.content.text("You think you were treated like that because of your race?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RACISM",
        },
        {
            text = ccb.content.text("Does that mean you were part of that back room evacuation I heard about?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EVACUATION",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_told_about_FM_evacuation" } }),
        },
        {
            text = ccb.content.text("Why stay out here then?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_WHYSTAY",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
        },
        {
            text = ccb.content.text("I have a camp of my own, away from here.  No paperwork required.  Want to come?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
            when = predicates.handler("dlg_p_dda_453225921210"),
        },
        {
            text = ccb.content.text("We're cool.  Sorry for insulting you earlier."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_APOLOGY",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_apology_luo" } })), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_dont_insult_luo" } }), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            actions = { actions.set_actor_value("interlocutor", "general_conversation_apology_luo", "yes") },
        },
        {
            text = ccb.content.text("I found a sample of alien fungus for you."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_RECRUIT",
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } }), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
        },
        {
            text = ccb.content.text("Ok… see ya."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
