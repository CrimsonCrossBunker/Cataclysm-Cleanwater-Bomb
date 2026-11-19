local ccb = require("ccb")

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_PIRATE",
    name = ccb.content.text("Pirate"),
    job_description = ccb.content.text("My adventures would curdle your blood."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "TOUGH3" },
    },
    common = false,
    dexterity = { one_in = 4 },
    perception = { one_in = 4 },
    strength = { one_in = 4 },
    worn = "NC_FORGE_PIRATE_clothes",
    weapon = "NC_FORGE_PIRATE_wield",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "unarmed", bonus = { one_in = 2 } },
        { skill = "cutting", bonus = { one_in = 2 } },
        { skill = "pistol", bonus = { rng = { 0, 2 } } },
        { skill = "gun", bonus = { rng = { 1, 3 } } },
        { skill = "melee", bonus = { rng = { 3, 5 } } },
    },
}
