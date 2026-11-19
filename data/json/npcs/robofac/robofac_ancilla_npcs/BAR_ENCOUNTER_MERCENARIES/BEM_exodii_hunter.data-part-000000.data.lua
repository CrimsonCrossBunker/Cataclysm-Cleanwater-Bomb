local ccb = require("ccb")

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
