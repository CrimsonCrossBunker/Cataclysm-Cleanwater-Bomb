local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"We have forwarded the recording to Research and thank you for your continued cooperation.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}
