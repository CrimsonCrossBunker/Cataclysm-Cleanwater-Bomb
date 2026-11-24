local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "augustmoon_shipping_chief",
    class = "NC_AUGUSTMOON_shipping_chief",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_AUGUSTMOON_SHIPPING_CHIEF",
    suffix = ccb.content.text("Portmaster"),
    faction = "UICA",
}

ccb.content.define_npc_class {
    id = "NC_AUGUSTMOON_shipping_chief",
    name = ccb.content.text("Portmaster"),
    job_description = ccb.content.text("I manage incoming and outgoing ships and shuttlecraft."),
    traits = {
        { group = "NPC_starting_traits" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { rng = { 5, 7 } },
    worn = "NC_UICA_PORT_CREW_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    shop_groups = { { id = "NC_AUGUSTMOON_shipping_stock", rigid = true } },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_AUGUSTMOON_LANDING",
    line = ccb.content.text("Excellent, the current price for a passage down is 1000 USD.  If there's any cargo you wish to transfer planetside please place it in the nearby container.  Additionally, I'm obliged to inform you that a return passage is considerably more expensive, having a current price of 12500 USD.  Do you wish to book passage?"),
    replies = {
        {
            text = ccb.content.text("I'm ready, book me in the next ship down."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_824101549704") },
        },
        {
            text = ccb.content.text("I need to settle a few things first"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_AUGUSTMOON_KIT",
    line = ccb.content.text("The kit is available as a one-time purchase for 3660 USD.  It includes a basic set of thermal clothing for survival, a backpack, basic cooking implements and supplies, a self-defense weapon and some basic medical supplies.  It is designed to help you survive the first few days planetside, but it is not a complete solution for long-term survival."),
    replies = {
        {
            text = ccb.content.text("I'll take it."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_b5399379ef32") },
        },
        {
            text = ccb.content.text("Let me think about it."),
            next_topic = "TALK_AUGUSTMOON_SHIPPING_CHIEF",
        },
    },
}
