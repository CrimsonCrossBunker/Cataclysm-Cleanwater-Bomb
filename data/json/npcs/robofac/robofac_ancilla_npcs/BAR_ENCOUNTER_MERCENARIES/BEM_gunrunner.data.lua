local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_BEM_GUNRUNNER",
    name = ccb.content.text("Mercenary"),
    job_description = ccb.content.text("Fighting for the name of Hub 01 and money, mostly money."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "BEM_GUNRUNNER_worn",
    carry = "BEM_GUNRUNNER_STOCK",
    weapon = "NC_ANCILLA_GRUNT_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
    price_rules = { { group = "BEM_GUNRUNNER_STOCK", markup = 3.5 } },
}

ccb.content.define_dialogue_topic {
    id = { "BEM_GUNRUNNER_1" },
    line = ccb.content.text("&You find the gun runner intently assessing the swirling smoke of a stale cigarette.  <mypronoun> barely acknowledges your approach.  \"Let's cut it short, I have come upon an excess supply of exotic weaponry and let's say that it would be expedient for it to disappear and you seem like just the kind of person I'm looking for.\"\n\n<mypronoun> hands you an inventory list, loosely annotated in a piece of graph paper.\n\n\"No harm in looking right?\""),
    on_enter = { { actions = { actions.set_actor_value("interlocutor", "bool_ancilla_barkeep", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Sure, let's see what you have to offer."),
            next_topic = "TALK_DONE",
            actions = { "start_trade" },
        },
        { text = ccb.content.text("Sorry, not interested."), next_topic = "TALK_DONE" },
    },
}
