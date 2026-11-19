local ccb = require("ccb")

-- spider victims could be hosts could be transforming.
ccb.content.define_npc {
    id = "xe_spider_victim",
    suffix = ccb.content.text("spider victim"),
    class = "NC_NPC_XE_SPIDER_VICTIM",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RESCUED_1",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_NPC_XE_SPIDER_VICTIM",
    name = ccb.content.text("Spider Victim"),
    job_description = ccb.content.text("I've been captured by these spider things.  Please rescue me!"),
    common = false,
    skills = {
        { skill = "speech", bonus = { rng = { -3, 3 } } },
        { skill = "chemistry", bonus = { rng = { -3, 3 } } },
        { skill = "gun", bonus = { rng = { -3, 3 } } },
        { skill = "pistol", bonus = { rng = { -3, 3 } } },
        { skill = "rifle", bonus = { rng = { -3, 3 } } },
        { skill = "swimming", bonus = { rng = { -3, 3 } } },
        { skill = "firstaid", bonus = { rng = { -3, 3 } } },
        { skill = "cooking", bonus = { rng = { -3, 3 } } },
    },
    intelligence = { rng = { -4, 4 } },
    perception = { rng = { -4, 4 } },
    strength = { rng = { -4, 4 } },
    dexterity = { rng = { -4, 4 } },
    traits = {
        { group = "Appearance_demographics" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        {
            distribution = {
                { group = "trait_group_spider_victim_eggsac" },
                { group = "trait_group_spider_victim_transformation" },
            },
        },
    },
}

-- someone with dreaming powers
ccb.content.define_npc {
    id = "xe_captured_dreamer",
    suffix = ccb.content.text("rescued dreamer"),
    class = "NC_NPC_XE_CAPTURED_DREAMER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RESCUED_1",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_NPC_XE_CAPTURED_DREAMER",
    name = ccb.content.text("Captured Dreamer"),
    job_description = ccb.content.text("I dreamt of another world and something came and snatched me away from my home."),
    common = false,
    skills = {
        { skill = "speech", bonus = { rng = { -3, 3 } } },
        { skill = "chemistry", bonus = { rng = { -3, 3 } } },
        { skill = "gun", bonus = { rng = { -3, 3 } } },
        { skill = "pistol", bonus = { rng = { -3, 3 } } },
        { skill = "rifle", bonus = { rng = { -3, 3 } } },
        { skill = "swimming", bonus = { rng = { -3, 3 } } },
        { skill = "firstaid", bonus = { rng = { -3, 3 } } },
        { skill = "cooking", bonus = { rng = { -3, 3 } } },
    },
    intelligence = { rng = { -4, 4 } },
    perception = { rng = { -4, 4 } },
    strength = { rng = { -4, 4 } },
    dexterity = { rng = { -4, 4 } },
    traits = {
        { group = "Appearance_demographics" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { distribution = { { group = "trait_group_dreamer_danger" }, { group = "trait_group_dreamer_hero" } } },
    },
}

ccb.content.define_npc {
    id = "bandit_revenant",
    suffix = ccb.content.text("Bandit"),
    class = "NC_SCAVENGER_REVENANT",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- Exists to carry a trait so the revenant can sense them
ccb.content.define_npc_class {
    id = "NC_SCAVENGER_REVENANT",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "XE_REVENANT_SENSING_TRAIT" },
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
