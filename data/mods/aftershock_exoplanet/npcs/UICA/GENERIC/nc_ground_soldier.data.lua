local ccb = require("ccb")

-- Soldiers on ground installations
ccb.content.define_npc_class {
    id = "NC_UICA_GROUND_SOLDIER",
    name = ccb.content.text("UICA Installation Security"),
    job_description = ccb.content.text("Just move along"),
    common = false,
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_UICA_GROUND_SOLDIER_worn",
    carry = "NC_UICA_GROUND_SOLDIER_carry",
    weapon = "NC_UICA_GROUND_SOLDIER_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -1 } } } },
        { skill = "gun", bonus = { rng = { 4, 6 } } },
        { skill = "pistol", bonus = { rng = { 4, 6 } } },
        { skill = "smg", bonus = { rng = { 4, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 6 } } },
    },
}
