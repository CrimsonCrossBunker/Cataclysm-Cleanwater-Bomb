local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_BREAKTHROUGH",
    line = {
        when = predicates.handler("dlg_p_dda_b386bedc4d2b"),
        yes = ccb.content.text("The Platform is complete.  As a reminder, the HWP will not function as a weapon without a conversion kit installed.  Transferring the requested items now.\"\n\nThe tray shakes as several heavy objects are dropped into it, and it slides open.  Inside: the Hybrid Weapons Platform.  On its own, it doesn't look like much; it resembles the body of a service rifle without a stock or barrel, colored in sleek black with blue highlights around the magazine well.  Small yellow arrows and inscriptions are present at certain points, highlighting the fasteners used to assemble the thing in earnest.  Accompanying the Platform itself is a series of four bundles of parts for it, each held together using velcro strips and tagged by caliber.  A drawstring nylon bag, embroidered with the Hub's logo and filled with proprietary tools, completes the whole package.\n\nAll in all, not a bad deal.\n\n\"Should you require magazines of any given caliber, we are willing to provide them through standard requisitions.  We hope you find its performance to be satisfactory."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_b386bedc4d2b"),
            actions = { actions.set_actor_value("speaker", "dialogue_hub_rnd_u_has_researched_gun", "yes"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_gun"), actions.handler("dlg_a_dda_390efe4feee0") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_RIFLE_REQUEST", "TALK_ROBOFAC_INTERCOM_RIFLE_ADAPTERS", "TALK_ROBOFAC_INTERCOM_RIFLE_TIMEGATE", "TALK_ROBOFAC_INTERCOM_RIFLE_BENEFITS" },
    line = ccb.content.text("I'll spare you the marketing pitch.  The Hybrid Weapons Platform - or more commonly the HWP - is a weapons platform capable of supporting multiple calibers via the use of quick-release adapters.  On its own, the platform does nothing; each adapter, however, allows it to chamber and fire a different type of round.\"\n\n\"Each new HWP is printed to order.  Materials will require eight HGC up front, and fabrication will take seven days."),
    replies = {
        {
            text = ccb.content.text("[8 HGC] A week is fine."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_STARTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 8),
            actions = { actions.handler("dlg_a_dda_8948663cd33d"), actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_3b89db9308f4"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes") },
        },
        {
            text = ccb.content.text("Tell me about the adapters.  Does it come with any?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_ADAPTERS",
        },
        {
            text = ccb.content.text("A week feels like an eternity these days.  Why the wait?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_TIMEGATE",
        },
        {
            text = ccb.content.text("Why should I use this over something like a rifle that doesn't need proprietary parts?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_BENEFITS",
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
