local ccb = require("ccb")

-- Override to erase shopkeep item groups appearing when spawned! A tiny bit safer than overriding all the item groups themevles
ccb.content.define_npc_class {
    id = "NC_SCAVENGER_PREPPER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "GETS_RANDOM_MISSION_NOMOVE" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

-- Override to erase shopkeep item groups appearing when spawned! A tiny bit safer than overriding all the item groups themevles
ccb.content.define_npc_class {
    id = "NC_SCAVENGER_MOONSHINER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "GETS_RANDOM_MISSION_NOMOVE" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}
