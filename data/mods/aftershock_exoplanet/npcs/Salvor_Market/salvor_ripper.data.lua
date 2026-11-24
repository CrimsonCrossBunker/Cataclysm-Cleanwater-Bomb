local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_SALVOR_RIPPER",
    name = ccb.content.text("ripper"),
    job_description = ccb.content.text("A salvor who trades salvaged software and data."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { trait = "RETURN_TO_START_POS" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 2, 3 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 1, 3 } },
    worn = "NC_SALVOR_RIPPER_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 4, 6 } } },
        { skill = "survival", bonus = { rng = { 4, 6 } } },
        { skill = "fabrication", bonus = { rng = { 6, 8 } } },
        { skill = "electronics", bonus = { rng = { 4, 6 } } },
        { skill = "mechanics", bonus = { rng = { 1, 3 } } },
    },
    shop_groups = {
        { id = "afs_salvor_ripper_software", rigid = true },
        { id = "afs_salvor_ripper_computers", rigid = true },
    },
    price_rules = {
        { group = "afs_augustmoon_batteries_disposable", markup = 10 },
        { group = "afs_augustmoon_batteries_rechargeable", markup = 20 },
        { group = "afs_salvor_ripper_software", price = 5000 },
        { group = "afs_salvor_ripper_computers", markup = 3 },
        { group = "generated_ruin_data", premium = 2 },
    },
}

ccb.content.define_npc {
    id = "salvor_ripper",
    unique_name = ccb.content.text("Raxell"),
    suffix = ccb.content.text("ripper"),
    gender = "male",
    age = 28,
    height = 182,
    class = "NC_SALVOR_RIPPER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SALVOR_RIPPER",
    faction = "independents",
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER",
    line = ccb.content.text("&The stall is uncharacteristically colorful, plastered with advertisements for computers and lit by the contrasting glow of blue and green neon.  Its owner lies slumped in a chair, lazily tapping away at a wrist computer.  They don't bother to look at you until its clear you are here to trade."),
    replies = {
        {
            text = ccb.content.text("[Approach the counter]"),
            next_topic = "TALK_SALVOR_RIPPER_MAIN",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } }),
        },
        {
            text = ccb.content.text("[Approach the counter]"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } })),
            trial = { kind = "condition", when = predicates.handler("dlg_p_aftershock_exoplanet_a094262cd7c4") },
            success = { next_topic = "TALK_SALVOR_RIPPER_MAIN" },
            failure = { next_topic = "TALK_SALVOR_RIPPER_INTRO_UNSKILLED" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_INTRO_UNSKILLED",
    line = ccb.content.text("Huh?  You barely look like you know your way around a computer, let alone know what I do here.  Why don't you go bother someone else?"),
    replies = {
        {
            text = ccb.content.text("Yeah, I was hoping to start learning here."),
            trial = { kind = "persuade", difficulty = 50 },
            success = { next_topic = "TALK_SALVOR_RIPPER_PERSUADE_SUCCESS" },
            failure = { next_topic = "TALK_SALVOR_RIPPER_FAIL" },
        },
        {
            text = ccb.content.text("[LIE] I know a thing or two."),
            trial = { kind = "lie", difficulty = 50 },
            success = { next_topic = "TALK_SALVOR_RIPPER_PERSUADE_SUCCESS" },
            failure = { next_topic = "TALK_SALVOR_RIPPER_FAIL" },
        },
        {
            text = ccb.content.text("[$400] My money spends just as well as anyone's."),
            trial = { kind = "persuade", difficulty = 90 },
            success = { next_topic = "TALK_SALVOR_RIPPER_BRIBE_SUCCESS" },
            failure = { next_topic = "TALK_SALVOR_RIPPER_FAIL" },
        },
        {
            text = ccb.content.text("Maybe I should…"),
            actions = { actions.set_first_topic("TALK_SALVOR_RIPPER_IGNORE") },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_PERSUADE_SUCCESS",
    line = ccb.content.text("&The ripper looks you up and down again.  They nod slowly, as if coming to a decision.  \"Cute, and stupid.  Alright maybe you aren't a complete write-off.  Name's Raxell, I run this salvage op.  Digital stuff, data, software, archives, that kind of thing.  I don't have time to teach you how to do it, but if you want to buy or sell some stuff, I'm open.\""),
    replies = { { text = ccb.content.text("Wont be a problem."), next_topic = "TALK_SALVOR_RIPPER_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_BRIBE_SUCCESS",
    line = ccb.content.text("Alright, alright.  You can buy stuff here, but don't expect help when you get in over your head."),
    on_enter = {
        { actions = { actions.handler("dlg_a_aftershock_exoplanet_e04f10f958b7") } },
    },
    replies = {
        {
            text = ccb.content.text("Wont be a problem."),
            next_topic = "TALK_SALVOR_RIPPER_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_FAIL",
    line = ccb.content.text("&The ripper scoffs at you, clearly not taking you seriously.  \"Come back when you know what you're doing.\""),
    on_enter = { { actions = { actions.set_first_topic("TALK_SALVOR_RIPPER_IGNORE") } } },
    replies = {
        { text = ccb.content.text("I don't think I will."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Yeah.  Sure thing."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_IGNORE",
    line = ccb.content.text("&The ripper is ignoring you.  They continue to tap away at their wrist computer, occasionally glancing up to make sure you're still there, but otherwise not acknowledging your presence."),
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("[Ancient Mercurial ID codes] I've found something you want.  Lets have a real talk."),
            next_topic = "TALK_SALVOR_MERCURIAL_IDENTS",
            when = predicates.has_item("speaker", "ruin_data_mercurial_id"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_MERCURIAL_IDENTS",
    line = ccb.content.text("&The ripper's eyes widen as they see the data shard you are showing them.  They snatch it out of your hand and quickly scan it with their wrist computer.  After a moment, they look up at you with a new level of respect.  \"… these are legit.  Where did you even get these?\""),
    replies = {
        {
            text = ccb.content.text("You know, here and there.  I want 60K."),
            next_topic = "TALK_SALVOR_RIPPER_MERCURIAL_IDENTS_SELL",
        },
        {
            text = ccb.content.text("Well I was thinking 20K and you keeping me in mind for future deals."),
            next_topic = "TALK_SALVOR_RIPPER_MERCURIAL_IDENTS_FAVOUR",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_MERCURIAL_IDENTS_SELL",
    line = ccb.content.text("Done."),
    on_enter = {
        { actions = { actions.handler("dlg_a_aftershock_exoplanet_281bd652ca97") } },
    },
    replies = {
        {
            text = ccb.content.text("A pleasure doing business."),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("ruin_data_mercurial_id") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_MERCURIAL_IDENTS_FAVOUR",
    line = ccb.content.text("For sure.  Just wait to see the things I'll cook up with these."),
    on_enter = {
        { actions = { actions.handler("dlg_a_aftershock_exoplanet_c1d7af39b63a") } },
    },
    replies = {
        {
            text = ccb.content.text("A pleasure doing business."),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("ruin_data_mercurial_id") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_RIPPER_MAIN" },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
            once = "ripper_intro_complete",
        },
    },
    line = ccb.content.text("&The ripper glances up at you as you approach, eyes briefly flicking over you before returning to the screen of their wrist computer.  They don't say anything, but it's clear they are waiting for you to make the first move."),
    replies = {
        {
            text = ccb.content.text("Lets trade."),
            next_topic = "TALK_SALVOR_RIPPER_MAIN",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("[Ancient Mercurial ID codes] I've found something you want.  Lets talk about real things."),
            next_topic = "TALK_SALVOR_MERCURIAL_IDENTS",
            when = predicates.has_item("speaker", "ruin_data_mercurial_id"),
        },
        {
            text = ccb.content.text("What is it that you do here?"),
            next_topic = "TALK_SALVOR_RIPPER_EXPLAIN",
        },
        { text = ccb.content.text("That's all for now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_EXPLAIN",
    line = ccb.content.text("&The ripper looks up at you, surprised that you would ask such a thing.  See all these brutes out here?  I try to make them realize the computers they smash for bits have useful stuff in them beyond the pretty crystals, and that they should try some data recovering and bring that to me.\"\n\n\"But they usually don't care.  Now though if you want into the buisness, I can sell you a computer and a copy of OpenVault, so you can start salvaging data yourself.  Or you can just go back to your smashing, whatever.\""),
    replies = { { text = ccb.content.text("Interesting."), next_topic = "TALK_SALVOR_RIPPER_MAIN" } },
}
