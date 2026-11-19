local ccb = require("ccb")

-- Horse trainer for the Isherwood family.
ccb.content.define_npc {
    id = "isherwood_jesse",
    unique_name = ccb.content.text("Jesse Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_JESSE",
    attitude = 0,
    mission = "GUARD",
    age = 43,
    height = 168,
    strength = 7,
    dexterity = 9,
    intelligence = 8,
    perception = 9,
    personality = { aggression = 2, bravery = 4, collector = 1, altruism = 3 },
    chat = "TALK_ISHERWOOD_JESSE",
    missions_offered = "MISSION_ISHERWOOD_JESSE_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_JESSE",
    name = ccb.content.text("Jesse Isherwood"),
    job_description = ccb.content.text("I'm a horse trainer, part of the Isherwood family"),
    traits = {
        { trait = "WEAKSTOMACH" },
        { trait = "ANTIJUNK" },
        { trait = "ANIMALEMPATH" },
        { trait = "SKIN_PINK" },
        { trait = "eye_color", variant = "blue" },
        { trait = "hair_ponytail", variant = "brown" },
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
        { skill = "speech", bonus = { rng = { 6, 9 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 6 } } },
        { skill = "archery", bonus = { rng = { 4, 6 } } },
    },
}
