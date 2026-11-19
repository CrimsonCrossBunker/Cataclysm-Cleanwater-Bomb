local ccb = require("ccb")

-- Patriarch of the Isherwood family.
ccb.content.define_npc {
    id = "isherwood_jack",
    unique_name = ccb.content.text("Jack Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_JACK",
    attitude = 0,
    mission = "GUARD",
    age = 73,
    height = 184,
    chat = "TALK_ISHERWOOD_JACK",
    missions_offered = "MISSION_ISHERWOOD_JACK_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_JACK",
    name = ccb.content.text("Jack Isherwood"),
    job_description = ccb.content.text("I'm the patriarch of the Isherwood family"),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_male_worn",
    weapon = "NC_ISHERWOOD_rifle",
    shop_groups = "NC_ISHERWOOD_JACK_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "pistol", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
    },
}
