local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Swing by heah and ask me about this again.  Got somethin' for ya'."),
        no = ccb.content.text("I saw that gun they gave ya' theah.  Cool shit.  I'd take their advice to heaht, though.  If you aren't up to snuff on workin' on electronics, I'd do a bit of reading.  That book they gave ya' is pretty advanced, so here, in case you need something to get stahted."),
    },
    replies = {
        {
            text = ccb.content.text("Sure, I'll swing by sometime."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("Thanks a lot."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
            actions = { actions.handler("dlg_a_dda_faece938f91c"), actions.set_actor_value("speaker", "robofac_pat_gave_electronics_books", "yes") },
        },
    },
}
