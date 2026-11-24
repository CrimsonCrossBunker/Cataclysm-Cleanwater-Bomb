local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "ancilla_barkeep",
    suffix = ccb.content.text("Bartender"),
    class = "NC_ANCILLA_BARTENDER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ANCILLA_BARKEEP",
    missions_offered = "MISSION_RANCH_BARTENDER_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc_class {
    id = "NC_ANCILLA_BARTENDER",
    name = ccb.content.text("Bartender"),
    job_description = ccb.content.text("I'm looking for new drink recipes."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_ANCILLA_BARKEEP_worn",
    carry = "NC_ANCILLA_BARKEEP_carry",
    weapon = "NC_ANCILLA_BARKEEP_wield",
    shop_groups = { { id = "NC_ANCILLA_BARKEEP_stock", rigid = true } },
    price_rules = { { group = "NC_ANCILLA_BARKEEP_stock", markup = 2.5 } },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ANCILLA_BARKEEP", "TALK_ANCILLA_BEM_HUMAN_SAMPLE_REWARD" },
    line = {
        when = predicates.handler("dlg_p_dda_2e6ab3005522"),
        yes = {
            choices = {
                ccb.content.text("Ah great to see you around."),
                ccb.content.text("How goes the surface?  All dead and walkey still?"),
                ccb.content.text("Should hang around one of these days, help me out in the bar for a change, what do you say, eh?"),
                ccb.content.text("Oh, what can I do for you today?"),
            },
        },
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_ancilla_barkeep_first_meet" } }),
            yes = ccb.content.text("Feel free to lounge around, and ask if there's anything you need."),
            no = ccb.content.text("Welcome to the Terminal, scavenger, longest standing underground bar in the state.  Feel free to ask if you need something."),
        },
    },
    on_enter = {
        { once = "bar_meet", actions = { actions.set_actor_value("speaker", "dialogue_ancilla_barkeep_first_meet", "yes"), actions.set_actor_value("interlocutor", "bool_ancilla_barkeep", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Let me see what you keep behind the counter."),
            next_topic = "TALK_ANCILLA_BARKEEP",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What do you have on tap?"),
            next_topic = "TALK_ANCILLA_BARKEEP_TAP",
        },
        {
            text = ccb.content.text("There should be a package for me here."),
            next_topic = "TALK_ANCILLA_BEM_HUMAN_SAMPLE_REWARD",
            when = predicates.handler("dlg_p_dda_57545b08208f"),
        },
        {
            text = ccb.content.text("Any good rumors?"),
            next_topic = "TALK_ANCILLA_BARKEEP_INFORMATION",
        },
        {
            text = ccb.content.text("I'll be going…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_BARKEEP_INFORMATION",
    line = ccb.content.text("If what you want are jobs and opportunities, you'll probably be better off asking to my other patrons.  Have regulars from well across the state, I'm sure some can offer what you want.\"\n\n \"Really, I just tend the bar and don't ask many questions.  Things tend work out better that way."),
    replies = {
        {
            text = ccb.content.text("I'll ask around, thank you."),
            next_topic = "TALK_ANCILLA_BARKEEP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_BARKEEP_TAP",
    line = ccb.content.text("Just the best spirits the whole of New England has to offer.  Well the best we've managed to loot so far at least.\n\n <ANCILLA_barkeep_suggestion>"),
    replies = {
        {
            text = ccb.content.text("Just some water."),
            false_text = ccb.content.text("[$2] Just some water."),
            text_when = predicates.handler("dlg_p_dda_fc580c0c78bf"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_fc580c0c78bf") },
            success = { next_topic = "TALK_DONE", actions = { actions.handler("dlg_a_dda_1dfd46df0f2b") } },
            failure = { next_topic = "TALK_DONE", actions = { actions.handler("dlg_a_dda_d3d52e8fe965") } },
        },
        {
            text = ccb.content.text("[$3] I'll take a beer."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_4269fb161103") },
        },
        {
            text = ccb.content.text("[$3] Get me a cup of red wine."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_9b2df95177fe") },
        },
        {
            text = ccb.content.text("[$3] I'll take a shot of rum."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_9c107a61ce55") },
        },
        {
            text = ccb.content.text("[$3] I'll take a shot of whiskey."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_80d2569046d0") },
        },
        {
            text = ccb.content.text("On second thought, don't bother."),
            next_topic = "TALK_ANCILLA_BARKEEP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_BEM_HUMAN_SAMPLE_REWARD",
    line = ccb.content.text("Oh yes of course, think this should be all, well that's all there is anyhow."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_1b4ead6a5a99"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_3cea5fb343d4") } },
    },
}
