local ccb = require("ccb")

-- Matriarch of the Isherwood family.
ccb.content.define_npc {
    id = "isherwood_claire",
    unique_name = ccb.content.text("Claire Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_CLAIRE",
    attitude = 0,
    mission = "GUARD",
    age = 67,
    height = 153,
    chat = "TALK_ISHERWOOD_CLAIRE",
    missions_offered = "MISSION_ISHERWOOD_CLAIRE_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_CLAIRE",
    name = ccb.content.text("Claire Isherwood"),
    job_description = ccb.content.text("I'm the matriarch of the Isherwood family"),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_female_worn",
    weapon = "NC_ISHERWOOD_rifle",
    shop_groups = "NC_ISHERWOOD_CLAIRE_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "cooking", bonus = { rng = { 4, 8 } } },
        { skill = "firstaid", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "pistol", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
    },
}
