local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "CRYO_HACKER",
    name = ccb.content.text("Thawed Hacker"),
    job_description = ccb.content.text("I'm looking for some choice systems to hack."),
    traits = {
        { group = "BG_survival_story_TEENAGER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "AFS_CRYOADAPTATION" },
    },
    strength = { rng = { -4, 0 } },
    dexterity = { rng = { -2, 0 } },
    intelligence = { rng = { 1, 5 } },
    perception = { rng = { -2, 0 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -2 } } } } } },
        },
        { skill = "electronics", bonus = { rng = { 1, 4 } } },
        { skill = "computer", bonus = { rng = { 3, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "CRYO_DOCTOR",
    name = ccb.content.text("Thawed Doctor"),
    job_description = ccb.content.text("I'm looking for wounded to help."),
    traits = {
        { group = "BG_survival_story_MEDICAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "AFS_CRYOADAPTATION" },
        { trait = "PROF_MED" },
    },
    strength = { rng = { -2, 0 } },
    intelligence = { rng = { 0, 2 } },
    perception = { one_in = 4 },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 3, 2 } }, { rng = { -1, -3 } } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 2, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "CRYO_SCIENTIST",
    name = ccb.content.text("Thawed Scientist"),
    job_description = ccb.content.text("I'm looking for clues concerning these monsters' origins…"),
    traits = {
        { group = "BG_survival_story_LAB" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "AFS_CRYOADAPTATION" },
    },
    strength = { rng = { -1, -3 } },
    dexterity = { rng = { -1, 0 } },
    intelligence = { rng = { 2, 5 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "computer", bonus = { rng = { 1, 5 } } },
        { skill = "electronics", bonus = { rng = { 1, 5 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
    },
}
