local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_BEM_DRUGRUNNER",
    name = ccb.content.text("Mercenary"),
    job_description = ccb.content.text("Drug running for the name of Hub 01 and money, mostly money."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { 2, 1 } },
    perception = { rng = { 1, 2 } },
    worn = "BEM_DRUGRUNNER_worn",
    carry = "BEM_DRUGRUNNER_stock",
    weapon = "NC_ANCILLA_GRUNT_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "firstaid", bonus = { rng = { 4, 6 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
    },
    price_rules = { { group = "BEM_DRUGRUNNER_STOCK", markup = 4.5 } },
}

ccb.content.define_dialogue_topic {
    id = { "BEM_DRUGRUNNER_1" },
    line = ccb.content.gendered_line("&This visitor seems way more watchful than normal.  You notice zip bags peeking out from <mypossesivepronoun> overcoat, they are clearly pushing something.  It doesn't take much longer for them to notice you in kind.\n\"You want something?  Or just gawking?\"", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Sure, let see what you offer."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_DONE" },
    },
}
