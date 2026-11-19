local ccb = require("ccb")

ccb.content.define_npc {
    id = "NPC_meteorologist",
    class = "NC_meteorologist",
    suffix = ccb.content.text("meteorologist"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_meteorologist_1",
    faction = "no_faction",
    missions_offered = "MISSION_meteorologist_1",
}

ccb.content.define_npc_class {
    id = "NC_meteorologist",
    name = ccb.content.text("Meteorologist"),
    job_description = ccb.content.text("Meteorologist."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 2, 5 } },
    perception = { rng = { -1, 3 } },
    worn = "NC_meteorologist_worn",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "BGSS_METEOROLOGIST" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "computer", bonus = { rng = { 2, 3 } } },
        { skill = "electronics", bonus = { rng = { 3, 6 } } },
        { skill = "chemistry", bonus = { rng = { 2, 3 } } },
    },
}
