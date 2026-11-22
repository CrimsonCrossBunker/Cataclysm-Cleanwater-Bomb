local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_LUMBERMILL_FABRICATE",
    line = {
        joined = {
            {
            when = predicates.handler("w16b_p_dda_f3512244819a"),
            yes = ccb.content.text("&Your current order.  Total: $<npc_val:number_fabricate_price>.  Waiting time: <npc_val:number_fabricate_wait> days."),
            no = ccb.content.text("We offer various specialty cuts direct to our customers.  Here's a list of available materials.  Order waiting time depends on the amount of lumber ordered.  So, what would you like?"),
        },
            {
            when = predicates.handler("w16b_p_dda_b44d0ed910c9"),
            yes = ccb.content.text("\n<item_name:2x4>: <npc_val:number_fabricate_2x4> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_1f18058dc2f7"),
            yes = ccb.content.text("\n<item_name:plank_short>: <npc_val:number_fabricate_plank_short> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_8ce0fa17f798"),
            yes = ccb.content.text("\n<item_name:plank_long>: <npc_val:number_fabricate_plank_long> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_a98905572bea"),
            yes = ccb.content.text("\n<item_name:wooden_post>: <npc_val:number_fabricate_wooden_post> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_f843738f852c"),
            yes = ccb.content.text("\n<item_name:wooden_post_short>: <npc_val:number_fabricate_wooden_post_short> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_faf9ad0ea1e3"),
            yes = ccb.content.text("\n<item_name:wooden_post_long>: <npc_val:number_fabricate_wooden_post_long> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_beb9347a6c6c"),
            yes = ccb.content.text("\n<item_name:wood_panel>: <npc_val:number_fabricate_wood_panel> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_3383b84f4e86"),
            yes = ccb.content.text("\n<item_name:wood_sheet>: <npc_val:number_fabricate_wood_sheet> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_fbcbf08e9e22"),
            yes = ccb.content.text("\n<item_name:wood_beam>: <npc_val:number_fabricate_wood_beam> pcs."),
        },
            {
            when = predicates.handler("w16b_p_dda_6877a61d1f1b"),
            yes = ccb.content.text("\n<item_name:log>: <npc_val:number_fabricate_log> pcs."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("[<item_name:2x4>, $1 a piece, max 200]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_8073edf737e3") },
        },
        {
            text = ccb.content.text("[<item_name:plank_short>, $0.7 a piece, max 200]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_4c42faf7ba13") },
        },
        {
            text = ccb.content.text("[<item_name:plank_long>, $1.5 a piece, max 200]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_2a998e303525") },
        },
        {
            text = ccb.content.text("[<item_name:wooden_post>, $1 a piece, max 100]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_e2174ea841c3") },
        },
        {
            text = ccb.content.text("[<item_name:wooden_post_short>, $0.7 a piece, max 100]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_19c8bfcf25b9") },
        },
        {
            text = ccb.content.text("[<item_name:wooden_post_long>, $1.5 a piece, max 100]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_c10b2fabee74") },
        },
        {
            text = ccb.content.text("[<item_name:wood_panel>, $8 a piece, max 100]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_1dcc08912fd4") },
        },
        {
            text = ccb.content.text("[<item_name:wood_sheet>, $16 a piece, max 100]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_ab5661818100") },
        },
        {
            text = ccb.content.text("[<item_name:wood_beam>, $25 a piece, max 50]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_53561ab2ad95") },
        },
        {
            text = ccb.content.text("[<item_name:log>, $5 a piece, max 100]"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            actions = { actions.handler("w16b_a_dda_9ebac9e5e76a") },
        },
        {
            text = ccb.content.text("<color_light_red>[Reset.]</color>"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            when = predicates.handler("w16b_p_dda_f3512244819a"),
            actions = { actions.handler("w16b_a_dda_88871dfa336c") },
        },
        {
            text = ccb.content.text("<color_light_green>[$<npc_val:number_fabricate_price>] That's all.  I'm ready to pay.</color>"),
            next_topic = "TALK_NPC_LUMBERMILL_MERCHANT_INTRO",
            when = predicates.handler("w16b_p_dda_f3512244819a"),
            actions = { actions.handler("w16b_a_dda_2ea665c78060") },
        },
        {
            text = ccb.content.text("Actually, I don't want to place an order."),
            next_topic = "TALK_NPC_LUMBERMILL_MERCHANT_INTRO",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUMBERMILL_FABRICATE_FINISHED",
    line = {
        when = predicates.handler("w16b_p_dda_42ad73717088"),
        yes = ccb.content.text("Let me check…  <u_name>…  Yes, all your lumber are ready, you can pick it up."),
        no = ccb.content.text("Your order?  No, sorry, we're still working on it."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_42ad73717088"),
            actions = { actions.handler("w16b_a_dda_ee6ccdac8907") },
            switch = true,
        },
        {
            text = ccb.content.text("I see."),
            next_topic = "TALK_NPC_LUMBERMILL_MERCHANT_INTRO",
            switch = true,
        },
    },
}
