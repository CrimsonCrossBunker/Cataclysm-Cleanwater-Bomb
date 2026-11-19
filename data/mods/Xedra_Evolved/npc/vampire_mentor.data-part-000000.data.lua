local ccb = require("ccb")

ccb.content.define_npc {
    id = "xe_vampire_mentor",
    suffix = ccb.content.text("vampire"),
    class = "NC_NPC_XE_VAMPIRE_MENTOR",
    attitude = 0,
    mission = "SHELTER",
    chat = "TALK_VAMPIRE_MENTOR",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_NPC_XE_VAMPIRE_MENTOR",
    name = ccb.content.text("Vampire Mentor"),
    job_description = ccb.content.text("An ancient vampire, willing to assist those who want to further their curse."),
    common = false,
    sells_belongings = false,
    skills = {
        { skill = "speech", bonus = { rng = { 3, 6 } } },
        { skill = "chemistry", bonus = { rng = { 2, 3 } } },
        { skill = "gun", bonus = { rng = { 2, 3 } } },
        { skill = "pistol", bonus = { rng = { 2, 3 } } },
        { skill = "rifle", bonus = { rng = { 2, 3 } } },
        { skill = "swimming", bonus = { rng = { 2, 3 } } },
        { skill = "firstaid", bonus = { rng = { 2, 3 } } },
        { skill = "cooking", bonus = { rng = { 2, 3 } } },
    },
    intelligence = { rng = { 2, 4 } },
    perception = { rng = { 2, 4 } },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 2, 4 } },
    weapon = "EMPTY_GROUP",
    traits = {
        { group = "Appearance_demographics" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_Vampire_Mentor_starting_traits" },
        { group = "trait_group_complete_vampire" },
        { trait = "MENTOR_PEACE", weight = 100 },
        { trait = "PSYCHOPATH", weight = 100 },
    },
}
