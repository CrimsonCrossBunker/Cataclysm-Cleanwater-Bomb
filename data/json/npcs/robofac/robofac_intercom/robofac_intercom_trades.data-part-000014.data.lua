local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS",
    line = {
        when = predicates.handler("dlg_p_dda_2facb0b881bc"),
        yes = ccb.content.text("&You deposit the sheet in the tray and collect your payment.  \"Well, another report from that \"place\".  It's different, and we have growing confidence it is real, however distant.  Let us know if you have any other reports.\""),
        no = {
            when = predicates.handler("dlg_p_dda_bff2be0ec026"),
            yes = ccb.content.text("&You deposit the sheet in the tray and tell them all about that far-away world.  \"…  Well, that's certainly a report.  This is consistent with your previous reports, but the recording is suspiciously normal in many respects.  Perhaps a hallucination induced by interdimensional travel?  Perhaps everything you saw was here, in New England?  Not that we doubt your mental faculties, of course.  Anyway…  we look forward to future reports.\""),
            no = ccb.content.text("&You deposit the sheet in the tray and tell them all about that far-away world.  \"…  Well, that's certainly a report.  Based on these readings, I can tell you the place was certainly real, but it's not so different from here.  Perhaps a hallucination induced by the portal storms?  Perhaps everything you saw was here, in New England?  Not that we doubt your mental faculties, of course.  Anyway…  we look forward to future reports.\""),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }) } },
    },
}
