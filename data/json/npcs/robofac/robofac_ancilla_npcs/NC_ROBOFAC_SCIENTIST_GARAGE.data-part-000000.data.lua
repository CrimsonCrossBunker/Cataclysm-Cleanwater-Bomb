local ccb = require("ccb")

ccb.content.define_npc {
    id = "robofac_garage_scientist_1",
    unique_name = ccb.content.text("Sebastian Smith"),
    suffix = ccb.content.text("Hub Scientist"),
    class = "NC_ROBOFAC_SCIENTIST_GARAGE",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_SCIENTIST_GARAGE",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_SCIENTIST_GARAGE",
    name = ccb.content.text("Hub Scientist"),
    job_description = ccb.content.text("A Hub 01 scientist."),
    common = false,
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_ROBOFAC_SCIENTIST_GARAGE_worn",
    weapon = "NC_ROBOFAC_SCIENTIST_GARAGE_wield",
    skills = { { skill = "firstaid", bonus = 8 }, { skill = "electronics", bonus = 8 } },
}
