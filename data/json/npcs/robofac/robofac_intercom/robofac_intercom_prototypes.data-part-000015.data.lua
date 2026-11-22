local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED" },
    line = ccb.content.text("Brilliant!!  Just brilliant.  Thank you very much.  Please contact us again in three days.  Thank you!\"\n\nThe voice abruptly disconnects.  When the intercom comes back on, it's the original voice again.  \"Was there anything else?"),
    on_enter = {
        { once = "started_exodii_gun_research", actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "hwp_exodii") } },
    },
    replies = {
        {
            text = ccb.content.text("You seem very… excited about this."),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED_1",
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
