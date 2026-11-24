local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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

ccb.content.define_dialogue_topic {
    id = "TALK_HUB_SECURITY",
    line = {
        choices = {
            ccb.content.text("Keep it civil, merc."),
            ccb.content.text("Just on watch, move along."),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = { choices = { ccb.content.text("Sir.") } },
                no = { choices = { ccb.content.text("Ma'am") } },
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
