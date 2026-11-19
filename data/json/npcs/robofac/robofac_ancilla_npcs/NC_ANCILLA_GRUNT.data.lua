local ccb = require("ccb")

-- An experienced survivor doing low importance work for Hub 01, or working under another ancillary. Has no access to Hub 01s custom gear.
ccb.content.define_npc_class {
    id = "NC_ANCILLA_GRUNT",
    name = ccb.content.text("Mercenary"),
    job_description = ccb.content.text("Fighting in the name of Hub 01 and money, mostly money."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_ANCILLA_GRUNT_worn",
    carry = "NC_ANCILLA_GRUNT_carry",
    weapon = "NC_ANCILLA_GRUNT_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
}
