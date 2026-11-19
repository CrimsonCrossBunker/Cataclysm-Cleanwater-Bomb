local ccb = require("ccb")

-- Generic guard for the old guard.
ccb.content.define_npc {
    id = "old_guard_fob_officer",
    suffix = ccb.content.text("Officer"),
    unique_name = ccb.content.text("Duhring"),
    class = "NC_OG_OFFICER",
    gender = "male",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_OLD_GUARD_FOB_OFFICER",
    faction = "old_guard",
}

ccb.content.define_npc_class {
    id = "NC_OG_OFFICER",
    name = ccb.content.text("Officer"),
    job_description = ccb.content.text("I'm an officer for FOB Arabella"),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    worn = "NC_OG_OFFICER_worn",
    carry = "NC_OG_OFFICER_misc",
    proficiencies = { "prof_gunsmithing_basic" },
    skills = {
        { skill = "speech", bonus = { rng = { 3, 5 } } },
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "pistol", bonus = { rng = { 3, 5 } } },
        { skill = "rifle", bonus = { rng = { 3, 5 } } },
        { skill = "driving", bonus = { rng = { 1, 3 } } },
    },
}
