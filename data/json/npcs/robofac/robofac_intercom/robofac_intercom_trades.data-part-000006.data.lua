local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_ON_CREDIT_ACCEPT",
    line = {
        when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_pay_back_on_specimens" } }),
        yes = ccb.content.text("Well it might be more interesting than straight gear.  Tell us when it's available for inspection.  We expect you back in 20 days or less."),
        no = ccb.content.text("20 days then for payment."),
    },
    replies = {
        {
            text = ccb.content.text("Much obliged."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_93f3ca32d409"), actions.assign_mission("MISSION_HUB01_PAY_BACK_RIOT_GEAR"), actions.set_actor_value("interlocutor", "npc_dialogue_exodii_npc_bought_riot_gear", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_bought_riot_gear" }, { "yes" }) },
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_SELL_YRAX_TOYS", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIFACET", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIAKIS", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_GOLDEN_MONOLITH", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_DELTA", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT_LEG", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT", "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIFACET", "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIAKIS", "TALK_ROBOFAC_INTERCOM_SELL_BOT_GOLDEN_MONOLITH", "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_DELTA" },
    line = ccb.content.text("Beautiful; please put them into loading area.  We'll issue a reward depending on what you managed to scavenge."),
    replies = {
        {
            text = ccb.content.text("[Deliver a broken trifacet.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIFACET",
            when = predicates.has_inventory("speaker", "broken_yrax_trifacet", 1),
            actions = { actions.handler("dlg_a_dda_d134bbc1a0ec") },
        },
        {
            text = ccb.content.text("[Deliver a broken triakis drone.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIAKIS",
            when = predicates.all({ predicates.has_inventory("speaker", "broken_yrax_triakis", 1) }),
            actions = { actions.handler("dlg_a_dda_7de768356dce") },
        },
        {
            text = ccb.content.text("[Deliver a broken monolith.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_GOLDEN_MONOLITH",
            when = predicates.all({ predicates.has_inventory("speaker", "broken_golden_monolith", 1) }),
            actions = { actions.handler("dlg_a_dda_482889d0a465") },
        },
        {
            text = ccb.content.text("[Deliver a broken delta drone.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BROKEN_YRAX_DELTA",
            when = predicates.all({ predicates.has_inventory("speaker", "broken_yrax_delta", 1) }),
            actions = { actions.handler("dlg_a_dda_d81f3b78e058") },
        },
        {
            text = ccb.content.text("[Drag in broken quadraphract leg.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT_LEG",
            when = predicates.has_inventory("speaker", "broken_yrax_quadraphract_leg", 1),
            actions = { actions.handler("dlg_a_dda_5188f4918353") },
        },
        {
            text = ccb.content.text("[Drag in broken quadraphract.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT",
            when = predicates.has_inventory("speaker", "broken_yrax_quadraphract", 1),
            actions = { actions.handler("dlg_a_dda_1107ada30080") },
        },
        {
            text = ccb.content.text("[Deliver a deactivated trifacet.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIFACET",
            when = predicates.has_inventory("speaker", "bot_yrax_trifacet", 1),
            actions = { actions.handler("dlg_a_dda_9ba1a784cc90") },
        },
        {
            text = ccb.content.text("[Deliver a deactivated triakis.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIAKIS",
            when = predicates.has_inventory("speaker", "bot_yrax_triakis", 1),
            actions = { actions.handler("dlg_a_dda_6326394a9290") },
        },
        {
            text = ccb.content.text("[Deliver a deactivated monolith.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BOT_GOLDEN_MONOLITH",
            when = predicates.has_inventory("speaker", "bot_golden_monolith", 1),
            actions = { actions.handler("dlg_a_dda_f1359c393a58") },
        },
        {
            text = ccb.content.text("[Deliver a deactivated delta.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_DELTA",
            when = predicates.has_inventory("speaker", "bot_yrax_delta", 1),
            actions = { actions.handler("dlg_a_dda_91d78fc5eb37") },
        },
        {
            text = ccb.content.text("That would be all."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
