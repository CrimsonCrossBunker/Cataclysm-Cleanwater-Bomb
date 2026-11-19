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
