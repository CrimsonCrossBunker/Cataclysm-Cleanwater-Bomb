local ccb = require("ccb")

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_LORD_DIVINER",
    name = ccb.content.text("Diviner"),
    job_description = ccb.content.text("I see the past, the present, and the future."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { trait = "LIBRARY_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    worn = "NC_FORGE_LIBRARIAN_clothes",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "unarmed", bonus = { one_in = 2 } },
        { skill = "melee", bonus = { one_in = 2 } },
        { skill = "gun", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 1, 3 } } },
    },
}
