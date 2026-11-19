local ccb = require("ccb")

-- Generic guard for the old guard.
ccb.content.define_npc {
    id = "old_guard_fob_pilot",
    suffix = ccb.content.text("Pilot"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_OLD_GUARD_FOB_SOLDIER",
    faction = "old_guard",
}

ccb.content.define_npc_class {
    id = "NC_OG_PILOT",
    name = ccb.content.text("Pilot"),
    job_description = ccb.content.text("I'm a pilot."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    worn = "NC_OG_PILOT_worn",
    carry = "NC_OG_PILOT_misc",
    proficiencies = { "prof_helicopter_pilot", "prof_spotting" },
    skills = {
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "pistol", bonus = { rng = { 1, 4 } } },
        { skill = "mechanics", bonus = { rng = { 3, 5 } } },
        { skill = "driving", bonus = { rng = { 5, 8 } } },
        { skill = "electronics", bonus = { rng = { 2, 4 } } },
    },
}
