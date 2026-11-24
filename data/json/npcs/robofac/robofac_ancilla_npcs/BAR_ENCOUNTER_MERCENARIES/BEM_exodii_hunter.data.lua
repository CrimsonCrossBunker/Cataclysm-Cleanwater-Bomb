local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_BEM_EXODII_HUNTER",
    name = ccb.content.text("Mercenary"),
    job_description = ccb.content.text("Fighting for the name of Hub 01 and money, mostly money."),
    common = false,
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "BEM_EXODII_HUNTER_worn",
    carry = "BEM_EXODII_HUNTER_STOCK",
    weapon = "BEM_EXODII_HUNTER_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 6, 8 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 6, 8 } } },
    },
    price_rules = { { group = "BEM_EXODII_HUNTER_STOCK", markup = 10 } },
}

ccb.content.define_dialogue_topic {
    id = { "BEM_EXODII_HUNTER_1" },
    line = {
        when = predicates.handler("dlg_p_dda_20bee21da2dc"),
        yes = {
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            yes = ccb.content.text("&The garishly-dressed hunter greets you with a surprised glance, but ultimately, a sly smile and a haughty accent.  An Exodii rifle is resting against the table.  \"You, yes you.  I've heard of you.  I'm a collector, you see, and well, I am told we've developed a rather practical appetite for, let us say, mechanical delights.  So, I've taken the liberty of collecting and cleaning a few choice specimens.  Do have a look.  These are the finest cuts of alien machinery you're likely to find this side of oblivion.\""),
            no = ccb.content.text("&The garishly-dressed hunter greets you with an easy smile and a haughty accent.  Their exotic-looking rifle is resting against the table.  \"Excellent, excellent, come chat, talk, and see.  You, yes you.  I'm a hunter, you see, and I've been stalking those infernal tin nightmares - you know the ones - since the very first tear in the sky.  Capital sport, I assure you.  Splendid chase, even when they shoot back.\"\n\n\"Well, I am told we've developed a rather practical appetite for their innards.  So, I've taken the liberty of collecting and cleaning a few choice specimens.  Do have a look.  These are the finest cuts of alien machinery you're likely to find this side of oblivion.\""),
        },
        no = {
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            yes = ccb.content.text("&The garishly-dressed hunter just stares at you, jaw slightly agape.  An Exodii rifle is resting against the table.  They quickly avoid eye contact, and seem to be ignoring you."),
            no = ccb.content.text("&The garishly-dressed hunter greets you with an easy smile and a haughty accent.  Their exotic-looking rifle is resting against the table.  \"I am here for a drink and a moment's blessed quiet.  Please allow me to enjoy both.  Undisturbed.\""),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "bool_ancilla_barkeep", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Sure, let's see what you have to offer."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_20bee21da2dc"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Sorry, not interested."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_20bee21da2dc"),
        },
        {
            text = ccb.content.text("Alright.  Maybe some other time."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f8514680dee5"),
        },
    },
}
