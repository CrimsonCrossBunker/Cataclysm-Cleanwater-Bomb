local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_NANO_ASK",
    line = ccb.content.text("Thank you.  This might be of use to us, but we will need at least a day to read the contents of the template.  Please speak with us again once we've had time to look it over."),
    on_enter = {
        { once = "gave_armor_template", actions = { actions.handler("dlg_a_dda_a1cb2e64d7fa"), actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_efd74ae5915b"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_gave_armor_disk", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_intercom_u_hub_prototypes", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Very well."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        {
            text = ccb.content.text("I'll see you then."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_1", "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_2", "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_3" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_started_robofac_hdd_trade" } }),
        yes = ccb.content.text("&The intercom's tray wordlessly slides open."),
        no = ccb.content.text("&The intercom erupts into static.  Then, it resolves into a voice.  It clears its throat, then speaks slowly and carefully.  \"Understood.  There is a tray embedded beneath the intercom.  Please place the drive into it.\"  On cue, a small portion of the wall beneath the intercom slides out along rails, revealing a large tray several inches deep.  \"You are welcome to leave afterwards.\""),
    },
    on_enter = {
        { once = "started_hdd_trade", actions = { actions.set_actor_value("speaker", "dialogue_intercom_u_started_robofac_hdd_trade", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("[Hand over the FEMA data.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_END",
            when = predicates.has_inventory("speaker", "fema_data", 1),
            actions = { actions.handler("dlg_a_dda_4ba535467f39"), actions.set_actor_value("speaker", "dialogue_intercom_completed_free_merchants_hub_delivery_1", "yes") },
        },
        {
            text = ccb.content.text("Hold on, who are you?  And what do you want with the data?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_2",
        },
        {
            text = ccb.content.text("What am I getting out of this?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_3",
        },
        {
            text = ccb.content.text("Sorry, forgot to grab the drive.  I'll return with it."),
            next_topic = "TALK_DONE",
        },
    },
}
