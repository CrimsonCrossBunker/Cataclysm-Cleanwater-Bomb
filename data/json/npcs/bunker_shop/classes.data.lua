local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_BUNKER_MERCHANT",
    name = ccb.content.text("Merchant"),
    common = false,
    job_description = ccb.content.text("I sell things to make a living."),
    strength = { rng = { -1, 2 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { -1, 4 } },
    perception = { rng = { -1, 2 } },
    shop_groups = {
        { id = "NC_BUNKER_MERCHANT_misc", rigid = true },
        { id = "NC_BUNKER_MERCHANT_sell", rigid = true },
    },
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { group = "BG_survival_story_RURAL" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = 0 } } } } },
        },
        { skill = "gun", bonus = { rng = { 1, 5 } } },
        { skill = "rifle", bonus = { rng = { 1, 5 } } },
        { skill = "pistol", bonus = { rng = { 1, 4 } } },
        { skill = "smg", bonus = { rng = { 1, 3 } } },
        { skill = "speech", bonus = { rng = { 1, 6 } } },
    },
}
