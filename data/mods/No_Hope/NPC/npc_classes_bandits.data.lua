local ccb = require("ccb")

-- These are here to workaround the bug of NPCs spawning without weapons due to either marksmanship or melee being their highest skill, and thus not knowing what weapon to give them.
ccb.content.define_npc_class {
    id = "NC_THUG",
    name = ccb.content.text("Thug"),
    job_description = ccb.content.text("I'm just here for the paycheck."),
    traits = {
        { group = "BG_survival_story_CRIMINAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -4 } } } },
        { skill = "melee", bonus = 2 },
        { skill = "dodge", bonus = { rng = { 1, 3 } } },
        { skill = "unarmed", bonus = { rng = { 1, 3 } } },
        { skill = "bashing", bonus = { rng = { 2, 5 } } },
        { skill = "stabbing", bonus = { rng = { 2, 5 } } },
        { skill = "cutting", bonus = { rng = { 2, 5 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_SCAVENGER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = 2 },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
        { skill = "shotgun", bonus = { rng = { 2, 4 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_SOLDIER",
    name = ccb.content.text("Soldier"),
    job_description = ccb.content.text("I'm just here for the paycheck."),
    traits = {
        { group = "BG_survival_story_SOLDIER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 2 } },
    dexterity = { one_in = 2 },
    intelligence = { rng = { 0, -2 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = 3 },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "unarmed", bonus = { rng = { 1, 2 } } },
        { skill = "rifle", bonus = { rng = { 4, 6 } } },
    },
}
