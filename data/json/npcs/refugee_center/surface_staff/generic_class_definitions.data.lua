local ccb = require("ccb")

-- These people have nowhere to run to and will fight with everything they have to protect their home.
ccb.content.define_npc_class {
    id = "NC_FREE_MERCH_GUARD",
    name = ccb.content.text("Guard"),
    job_description = ccb.content.text("I'm on a guard shift."),
    work_hours = { 9, 21 },
    weapon = "NC_FREE_MERCH_GUARD_wield_phase1",
    worn = "NC_FREE_MERCH_GUARD_worn_phase1",
    strength = { rng = { 1, 3 } },
    dexterity = { rng = { 1, 3 } },
    perception = { rng = { 0, 3 } },
    aggression = { rng = { 10, 15 } },
    bravery = { rng = { 10, 15 } },
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -4 } } } },
        { skill = "bashing", bonus = { rng = { 2, 4 } } },
        { skill = "cutting", bonus = { rng = { 2, 4 } } },
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "stabbing", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_FREE_MERCH_GUARD_NIGHT",
    copy_from = "NC_FREE_MERCH_GUARD",
    name = ccb.content.text("Night Guard"),
    job_description = ccb.content.text("I'm on the night watch."),
    work_hours = { 21, 9 },
}
