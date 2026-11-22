local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE",
    line = ccb.content.text("Yes.  For the cost of three HGC we can begin R&D to incorporate your NRE recorder.  You'll need to provide the HEW and your NRE recorder.  R&D will take one working week."),
    replies = {
        {
            text = ccb.content.text("[3 HGC, HEW, NRE] See you in five days."),
            next_topic = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "RobofacCoin", 3), predicates.has_inventory("speaker", "xedra_mobile_weather_station", 1), predicates.has_inventory("speaker", "nre_recorder", 1) }),
            actions = { actions.handler("dlg_a_dda_51de27d579cc"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "hew_upgrade") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
