local ccb = require("ccb")

-- Security within ships and ports
ccb.content.define_npc_class {
    id = "NC_UICA_NAVAL_POLICE",
    name = ccb.content.text("Augustmoon Security"),
    job_description = ccb.content.text("Just move along"),
    common = false,
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_UICA_NAVAL_POLICE_worn",
    carry = "NC_UICA_NAVAL_POLICE_carry",
    weapon = "NC_UICA_NAVAL_POLICE_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -1 } } } },
        { skill = "gun", bonus = { rng = { 4, 6 } } },
        { skill = "pistol", bonus = { rng = { 4, 6 } } },
        { skill = "shotgun", bonus = { rng = { 4, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 6 } } },
    },
}
