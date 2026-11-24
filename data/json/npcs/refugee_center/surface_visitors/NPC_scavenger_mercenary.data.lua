local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Appears in the refugee center as a partner for hire.
ccb.content.define_npc {
    id = "scavenger_merc",
    suffix = ccb.content.text("Merc"),
    age = 37,
    class = "NC_SCAVENGER_MERC",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_SCAVENGER_MERC",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_SCAVENGER_MERC",
    name = ccb.content.text("Mercenary"),
    job_description = ccb.content.text("Fighting for the all-mighty dollar."),
    common = false,
    traits = {
        { trait = "BGSS_Scavenger_Merc_1" },
        { trait = "PSYCHOPATH" },
        { trait = "TOUGH" },
        { trait = "BADTEMPER" },
        { trait = "SLOWREADER" },
        { trait = "INSOMNIA" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 1, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 1, 2 } },
    worn = "NC_SCAVENGER_MERC_worn",
    carry = "NC_SCAVENGER_MERC_carry",
    weapon = "NC_SCAVENGER_MERC_wield",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 1, 4 } } },
        { skill = "stabbing", bonus = { rng = { 1, 4 } } },
        { skill = "dodge", bonus = { rng = { 1, 4 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
        { skill = "swimming", bonus = { rng = { 1, 4 } } },
        { skill = "survival", bonus = { rng = { 0, 3 } } },
        { skill = "speech", bonus = -4 },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.gendered_line("I haven't done anything wrong…", { "interlocutor" }),
        no = ccb.content.text("…"),
    },
    replies = {
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_SCAVENGER_MERC_NEW" },
        {
            text = ccb.content.text("Any tips for surviving?"),
            next_topic = "TALK_SCAVENGER_MERC_TIPS",
        },
        {
            text = ccb.content.text("What would it cost to hire you?"),
            next_topic = "TALK_SCAVENGER_MERC_HIRE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_NEW",
    line = ccb.content.text("I'm just a hired hand.  Someone pays me and I do what needs to be done."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_SCAVENGER_MERC" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_TIPS",
    line = ccb.content.text("If you have to fight your way out of an ambush, the only thing that is going to save you is having a party that can return fire.  People who work alone are easy pickings for monsters and bandits."),
    replies = {
        {
            text = ccb.content.text("I suppose I should hire a party then?"),
            next_topic = "TALK_SCAVENGER_MERC",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_HIRE",
    line = ccb.content.text("I'm currently waiting for a customer to return… I'll make you a deal though, 750 merch will cover my expenses if I get a small cut of the loot."),
    replies = {
        {
            text = ccb.content.text("What the heck is a merch?"),
            next_topic = "TALK_SCAVENGER_MERC_MERCH",
        },
        {
            text = ccb.content.text("I might be back."),
            next_topic = "TALK_SCAVENGER_MERC",
        },
        {
            text = ccb.content.text("[750 merch] You have a deal."),
            next_topic = "TALK_SCAVENGER_MERC_HIRE_SUCCESS",
            when = predicates.has_inventory("speaker", "FMCNote", 750),
            actions = { actions.handler("dlg_a_dda_fe6648a62eb4") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_MERCH",
    line = ccb.content.text("Merch is what they call dollar bills around here.  Free Merchant Credit Notes or something.  If you want to buy stuff around here and you don't want to barter away your guns, you need merch."),
    replies = {
        {
            text = ccb.content.text("I see.  Let's try this again from the start."),
            next_topic = "TALK_SCAVENGER_MERC",
        },
        {
            text = ccb.content.text("Okay, how much merch do I need?"),
            next_topic = "TALK_SCAVENGER_MERC_HIRE",
        },
        {
            text = ccb.content.text("Well, thanks for the info.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_HIRE_SUCCESS",
    line = ccb.content.text("I guess you're the boss."),
    replies = {
        {
            text = ccb.content.text("Glad to have you aboard."),
            success = {
                native_actions = { "follow" },
                opinion = { trust = 1, value = 1 },
                next_topic = "TALK_DONE",
            },
        },
    },
}
