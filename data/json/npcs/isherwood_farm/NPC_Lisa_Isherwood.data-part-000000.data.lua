local ccb = require("ccb")

-- Part of the Isherwood family.
ccb.content.define_npc {
    id = "isherwood_lisa",
    unique_name = ccb.content.text("Lisa Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_LISA",
    attitude = 0,
    mission = "GUARD",
    age = 20,
    height = 170,
    strength = 8,
    dexterity = 9,
    intelligence = 10,
    perception = 9,
    personality = { aggression = 1, bravery = 5, collector = 1, altruism = 3 },
    chat = "TALK_ISHERWOOD_LISA",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_LISA",
    name = ccb.content.text("Lisa Isherwood"),
    job_description = ccb.content.text("Part of the Isherwood family"),
    traits = {
        { trait = "ANIMALEMPATH" },
        { trait = "ANTIJUNK" },
        { trait = "PRETTY" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    worn = "NC_Isherwood_female_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "rifle", bonus = { rng = { 2, 5 } } },
        { skill = "archery", bonus = { rng = { 2, 5 } } },
    },
}
