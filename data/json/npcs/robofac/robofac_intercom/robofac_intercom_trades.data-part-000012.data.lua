local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB_DIMENSION",
    line = {
        when = predicates.handler("dlg_p_dda_2facb0b881bc"),
        yes = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Ah, interesting.  So this is where you entered this other place?  This decreases the chances that what you experienced was a hallucination.  These conditions are clearly Earth-like, but the recordings performed unexpected loops in its subroutines.  The topographical scan shows what appear to be deliberate patterns in the placement of whatever structures you may have encountered.  We suspect that this may be a location where spacetime is slipping in various directions.  We will forward this to Research.\""),
        no = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Astounding!  These conditions are clearly Earth-like, but the recordings performed unexpected loops in its subroutines.  The topographical scan shows what appear to be deliberate patterns in the placement of whatever structures you may have encountered.  We suspect that this may be a location where spacetime is slipping in various directions.  We will forward this to Research and alert you if we need more scans.\""),
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }) } },
    },
}
