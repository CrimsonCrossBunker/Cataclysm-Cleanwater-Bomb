local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_AUGUSTMOON_SHIPPING_CHIEF",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_augustmoon_shipping_chief_first_meet" } }),
        yes = {
            choices = {
                ccb.content.text("Interested in booking passage planetside?"),
            },
        },
        no = ccb.content.text("Let me be first to welcome you to Salus IV orbit.  I'm the portmaster representative for this section of the station, and I can help you with booking passage planetside for you and any cargo.\"  They glance briefly to a desk console before continuing with a well trained smile.  \"Oh it seems system flagged you as a new arrival, are you familiar with local planetary conditions?  If not, I can provide you with a starting kit that will help you survive the first few days planetside."),
    },
    on_enter = {
        { once = "longshoreman_meet", actions = { actions.set_actor_value("speaker", "dialogue_augustmoon_shipping_chief_first_meet", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("That's why I'm here"),
            false_text = ccb.content.text("Alright, let see about passage planetside."),
            text_when = predicates.handler("dlg_p_aftershock_exoplanet_38b9f0150908"),
            next_topic = "TALK_AUGUSTMOON_LANDING",
        },
        {
            text = ccb.content.text("I want to contract a drone shuttle."),
            next_topic = "TALK_AUGUSTMOON_SHIPPING_CHIEF",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'm interested in that starting kit."),
            next_topic = "TALK_AUGUSTMOON_KIT",
            when = predicates.handler("dlg_p_aftershock_exoplanet_ea5c55dbd47a"),
        },
        {
            text = ccb.content.text("Not right now."),
            next_topic = "TALK_DONE",
        },
    },
}
