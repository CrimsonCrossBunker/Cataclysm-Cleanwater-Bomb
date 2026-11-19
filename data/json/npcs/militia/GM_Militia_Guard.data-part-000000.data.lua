local ccb = require("ccb")

-- A member of the Gray Moose Lodge, trying to safe in their isolated location
ccb.content.define_npc {
    id = "MILITIA_GUARD1",
    class = "MILITIA_GUARD1",
    attitude = 0,
    suffix = ccb.content.text("Militia Guard"),
    mission = "GUARD_PATROL",
    chat = "TALK_MILITIA_Guard1",
    faction = "GM_militia_faction",
}

ccb.content.define_npc_class {
    id = "MILITIA_GUARD1",
    name = ccb.content.text("Guard"),
    job_description = ccb.content.text("I'm a local guard."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 3, 5 } } },
    },
}
