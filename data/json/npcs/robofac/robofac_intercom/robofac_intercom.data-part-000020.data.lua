local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_MERCENARY",
    line = ccb.content.text("Oh!  Good.  We had written that off as a non-starter.  Just drop it into the tray and we'll bring it in."),
    replies = {
        {
            text = ccb.content.text("[Hand over the FEMA data.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_MERCENARY_END",
            when = predicates.has_inventory("speaker", "fema_data", 1),
            actions = { actions.handler("dlg_a_dda_4ba535467f39"), actions.set_actor_value("speaker", "dialogue_intercom_completed_free_merchants_hub_delivery_1", "yes") },
        },
        {
            text = ccb.content.text("I don't have the drive with me right now; I'll give it to you when I have it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
