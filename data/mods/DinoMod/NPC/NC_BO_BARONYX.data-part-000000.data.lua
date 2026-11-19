local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_SWAMPER",
    name = ccb.content.text("Swamper"),
    job_description = ccb.content.text("The great eaters have returned and they must be fed."),
    traits = { { trait = "SPIRITUAL" }, { trait = "PRETTY" }, { trait = "PSYCHOPATH" } },
    common = false,
    perception = { rng = { 0, 2 } },
    strength = { rng = { 0, 2 } },
    intelligence = { rng = { 0, 2 } },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "bashing", bonus = { rng = { 3, 6 } } },
        { skill = "cutting", bonus = { rng = { 3, 6 } } },
    },
}

-- A charismatic religious leader and CEO.
ccb.content.define_npc {
    id = "SWAMPER_Bo_Baronyx",
    unique_name = ccb.content.text("Bo Baronyx"),
    gender = "male",
    suffix = ccb.content.text("CEO"),
    class = "NC_SWAMPER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SWAMPER",
    faction = "swamper",
    missions_offered = "MISSION_SWAMPER_GATHER_MEAT",
}
