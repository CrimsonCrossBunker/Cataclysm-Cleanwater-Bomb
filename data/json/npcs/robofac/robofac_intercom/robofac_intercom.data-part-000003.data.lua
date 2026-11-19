local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_met_robofac_intercom" } }),
        yes = ccb.content.text("&The intercom is silent."),
        no = ccb.content.text("&The intercom crackles with static as it turns on.  The LED next to the button lights up a bright red, and the camera lens whirs as it focuses on you.  There is no immediate response."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_intercom_u_met_robofac_intercom", "yes"),
            },
            once = "met_intercom",
        },
    },
    replies = {
        {
            text = ccb.content.text("…Hello?"),
            when = predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
        },
        {
            text = ccb.content.text("Um, can anyone hear me?"),
            when = predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
        },
        {
            text = ccb.content.text("[Tap the camera lens.]  Look, I know someone's listening.  What is this place?"),
            when = predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_1",
        },
        {
            text = ccb.content.text("The merchant at the refugee center sent me.  You were looking for a hard drive from them?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_free_merchants_hub_delivery_1" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_started_robofac_hdd_trade" } })), predicates.has_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1"), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_1",
        },
        {
            text = ccb.content.text("About that hard drive…"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_free_merchants_hub_delivery_1" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_started_robofac_hdd_trade" } }), predicates.has_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1"), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_1",
        },
        {
            text = ccb.content.text("The traders mentioned you were looking for help."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_free_merchants_hub_delivery_1" } }), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            trial = { kind = "lie", difficulty = 1 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_2" },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_2" },
        },
        {
            text = ccb.content.text("…Hello?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_1",
        },
        {
            text = ccb.content.text("Um, can anyone hear me?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_1",
        },
        {
            text = ccb.content.text("[Tap the camera lens.]  Look, I know someone's listening.  What is this place?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_1",
        },
        { text = ccb.content.text("[Leave.]"), next_topic = "TALK_DONE" },
    },
}
