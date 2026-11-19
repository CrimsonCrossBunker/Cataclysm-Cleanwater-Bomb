local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_CAMPUS_GUARD",
    name = ccb.content.text("Guard"),
    job_description = ccb.content.text("I'm on a guard shift."),
    weapon = "NC_CAMPUS_GUARD_wield_phase1",
    worn = "NC_CAMPUS_GUARD_worn_phase1",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    skills = {
        { skill = "bashing", bonus = { rng = { 1, 2 } } },
        { skill = "cutting", bonus = { rng = { 1, 2 } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
        { skill = "stabbing", bonus = { rng = { 1, 2 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
    },
}
