local ccb = require("ccb")

-- A generic guard for Hub 01.
ccb.content.define_npc {
    id = "hub_security",
    suffix = ccb.content.text("Hub Security"),
    class = "NC_ROBOFAC_SECURITY",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_HUB_SECURITY",
    faction = "robofac",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_SECURITY",
    name = ccb.content.text("Hub Security"),
    job_description = ccb.content.text("I'm part of the Hub security team."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 1, 3 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { 1, 2 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -2 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
    carry = "NC_robofac_generic_security_misc",
    worn = "NC_robofac_generic_security_worn",
    weapon = "NC_robofac_security_weapon",
}
