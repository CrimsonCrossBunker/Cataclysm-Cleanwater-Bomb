local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Heh, alright, the Feds.  Tell ya' what I got somethin' special for yah'.  Swing by heah and see me."),
        no = ccb.content.text("The Feds.  If they're payin', let's do it.  If they're all laid up in a cabin, I think your best bet may be explosives.  Heah.  Take this grenade.  Don't ask."),
    },
    replies = {
        {
            text = ccb.content.text("Sure, I'll swing by."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("[take the grenade] Thanks, Pat.  I'll put it to good use?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
            actions = { actions.set_actor_value("speaker", "robofac_pat_gave_grenade", "yes"), actions.handler("dlg_a_dda_4d9369728ac2") },
        },
    },
}
