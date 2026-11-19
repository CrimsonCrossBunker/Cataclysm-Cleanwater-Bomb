local ccb = require("ccb")

ccb.content.define_npc {
    id = "traveler_camper_van",
    class = "NC_CAMPER_VAN_TRAVELER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_NPC_CAMPER_VAN_TRAVELER",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_CAMPER_VAN_TRAVELER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    price_rules = {
        { category = "food", premium = 2.5 },
        { item = "gasoline", premium = 2.5 },
        { item = "water_clean", premium = 2.5 },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}
