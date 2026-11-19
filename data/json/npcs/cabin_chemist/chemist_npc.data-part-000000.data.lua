local ccb = require("ccb")

ccb.content.define_npc {
    id = "NPC_cabin_chemist",
    class = "NC_CHEM_MERCHANT",
    suffix = ccb.content.text("chemist"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_NPC_CABIN_CHEMIST",
    faction = "wasteland_scavengers",
    missions_offered = "MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
}

ccb.content.define_npc_class {
    id = "NC_CHEM_MERCHANT",
    name = ccb.content.text("Chemist"),
    job_description = ccb.content.text("I make and sell chemicals"),
    common = false,
    traits = {
        { group = "BG_survival_story_RURAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    intelligence = { rng = { 1, 2 } },
    shop_groups = { { id = "cabin_chemist_sell", rigid = true } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 0, 2 } } },
        { skill = "firstaid", bonus = { rng = { 1, 2 } } },
        { skill = "cooking", bonus = { rng = { 1, 2 } } },
        { skill = "chemistry", bonus = { rng = { 3, 5 } } },
    },
}
