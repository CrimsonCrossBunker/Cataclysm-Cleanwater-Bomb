local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_BARRY",
    name = ccb.content.text("Barry Isherwood"),
    job_description = ccb.content.text("Missing member of the Isherwood family."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    perception = { one_in = 4 },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "rifle", bonus = { rng = { 7, 10 } } },
        { skill = "archery", bonus = { rng = { 8, 10 } } },
    },
    worn = "naked_prisoner",
    carry = "naked_prisoner",
    weapon = "naked_prisoner",
}

ccb.content.define_npc {
    id = "isherwood_barry",
    unique_name = ccb.content.text("Barry Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_BARRY",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ISHERWOOD_BARRY_RESCUE",
    faction = "isherwood_family",
    on_death = "isherwood_barry_death",
}
