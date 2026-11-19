local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_FM_DOCTOR",
    name = ccb.content.text("Doctor"),
    job_description = ccb.content.text("I'm looking for wounded to help."),
    common = false,
    traits = {
        { group = "BG_survival_story_MEDICAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { -2, 0 } },
    intelligence = { rng = { 0, 2 } },
    perception = { one_in = 4 },
    shop_groups = "NC_DOCTOR_misc",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 3, 2 } }, { rng = { -1, -3 } } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 2, 6 } } },
    },
}

-- Appears in the refugee center as a source of missions and info.  Faction critical.
-- Possibly should change to NPC_MISSION_SHOPKEEP and sell medical supplies.
ccb.content.define_npc {
    id = "science_rep",
    suffix = ccb.content.text("Doctor"),
    class = "NC_FM_DOCTOR",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SCIENCE_REP",
    faction = "old_guard",
    missions_offered = "MISSION_SCIENCE_REP_1",
}
