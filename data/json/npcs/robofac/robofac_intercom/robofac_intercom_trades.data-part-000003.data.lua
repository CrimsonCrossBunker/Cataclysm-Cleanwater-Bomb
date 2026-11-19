local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Large",
    line = {
        when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_accepted_nre_recording" } }),
        yes = ccb.content.text("Fantastic.\"  The recording changes hands.  \"At this rate, we'll have some real results soon."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_accepted_nre_recording" } }),
            yes = ccb.content.text("Fantastic.\"  The recording changes hands.  \"At this rate, we'll have some real results soon."),
            no = ccb.content.text("Uh… please allow me a second to check this in.\"  The tray slides shut, and the intercom turns off.  Roughly a minute later, it turns back on.  \"Well, it looks like this is a real treasure trove of information.  In fact, you've made quite an impression on R&D, and probably just saved us a few weeks of research at the least.  They demanded you be given a pretty significant accomplishment bonus, so… well, there you go.\"  The tray slides open, revealing an impressive pile of coins.\n\n\"Given your performance and our constant need for new data, you are free to keep the recorder for further use.  We are willing to pay for any future data that you're able to record."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_nre_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_nre_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1", { success = true }),
            },
            once = "nre_trade",
        },
    },
}
