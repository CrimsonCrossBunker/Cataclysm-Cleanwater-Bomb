local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- This mission is assigned and completed using dialogue and EOCs. As such, we don't have any goal, which would make it auto-complete under certain circumstances.
-- All dialogue about this mission is handled through talk_topics, so we don't use any of these strings.
ccb.content.define_mission {
    id = "BEM_human_sample_mission",
    name = ccb.content.text("Fleshmonger"),
    goal = "MGOAL_NULL",
    description = ccb.content.text("Deposit a human sample in a pit within the dead drop location.  Pick up your reward at the Terminal once that's done."),
    difficulty = 1,
    value = 0,
    start = {
        target = { terrain = "forest", reveal_radius = 2, random = true, search_range = 40, z = 0 },
        map_updates = {
            {
                layout = {
                    flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
                    terrain_placements = { { id = "t_pit_BEM_human_sample", x = 9, y = 3 } },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE_1",
    line = {
        when = predicates.has_mission("BEM_human_sample_mission"),
        yes = ccb.content.text("Not in the mood for a talk, sorry."),
        no = ccb.content.gendered_line("&The mercenary stares at the window, and speaks in a quiet and terse manner.  \"I have a client looking for a medical-grade human biopsy sample, no questions asked.  Are you the right one for the job?\"", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("Oh yes.  I actually have one right here."),
            when = predicates.all({ predicates.has_inventory("speaker", "human_sample", 1), predicates.negate(predicates.has_mission("BEM_human_sample_mission")) }),
            next_topic = "BEM_HUMAN_SAMPLE_FINISH",
        },
        {
            text = ccb.content.text("I might be."),
            when = predicates.negate(predicates.has_mission("BEM_human_sample_mission")),
            next_topic = "BEM_HUMAN_SAMPLE2",
        },
        {
            text = ccb.content.text("No, but I might be looking to buy some."),
            when = predicates.negate(predicates.has_mission("BEM_human_sample_mission")),
            next_topic = "BEM_HUMAN_SAMPLE_BUY",
        },
        {
            text = ccb.content.text("No, not at all."),
            when = predicates.negate(predicates.has_mission("BEM_human_sample_mission")),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Sure, whatever."),
            when = predicates.has_mission("BEM_human_sample_mission"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE2",
    line = ccb.content.text("Most I can give is two gold coins.  I've arranged a drop in the nearby woods, put the goods there and you can get your cash with the barkeep here."),
    replies = {
        {
            text = ccb.content.text("It'll get done."),
            actions = { actions.assign_mission("BEM_human_sample_mission"), "end_conversation" },
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Not interested after all?"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE_FINISH",
    line = ccb.content.text("&<mypronoun> quickly removes the offending piece of meat from your hand and places two golden coins on the table, apparently unshaken by the prospect of meeting someone who casually visits bars while carrying cuts of human flesh.  \"Now if you please, I have a meal to get rid of.\" <mypronoun> says, between poorly masked bouts of nausea."),
    on_enter = {
        { actions = { actions.transfer_items("human_sample"), actions.handler("dlg_a_dda_3cea5fb343d4") } },
    },
    replies = {
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
            actions = { "end_conversation" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE_BUY",
    line = ccb.content.gendered_line("&The mercenary gives you a quick appraisal.  \"Five coins for three, special price just for you.  Pay in advance, and I'll arrange a drop in the subway rails here for you to pick within two days.  Deal or not?\"", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("[5 HGC] Its a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 5),
            actions = { actions.transfer_items("RobofacCoin", 5), actions.handler("w16b_a_dda_44ca1332f016") },
        },
        {
            text = ccb.content.text("Sure, just let me find the cash."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_inventory("speaker", "RobofacCoin", 5)),
        },
        {
            text = ccb.content.text("No deal."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "EOC_BEM_HUMAN_SAMPLE_BUY_MAP",
    layout = {
        loot_placements = { { group = "BEM_human_sample_drop", x = 13, y = 4, repetitions = { 1, 3 } } },
    },
}
