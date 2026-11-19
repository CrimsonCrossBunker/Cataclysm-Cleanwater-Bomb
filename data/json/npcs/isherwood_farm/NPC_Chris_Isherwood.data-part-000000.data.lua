local ccb = require("ccb")

-- Part of the Isherwood family.  Does not spawn until you get a mission from Carlos to track him down.
-- Son of Carlos and Jesse, nephew of Eddie.  Brother of Lisa, cousin of Luke.  Grandson of Claire and Jack, great-nephew of Barry.
ccb.content.define_npc {
    id = "isherwood_chris",
    unique_name = ccb.content.text("Chris Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_CHRIS",
    attitude = 0,
    mission = "GUARD",
    age = 21,
    height = 177,
    strength = 8,
    dexterity = 9,
    intelligence = 8,
    perception = 9,
    personality = { aggression = 2, bravery = 5, collector = -3, altruism = 1 },
    chat = "TALK_ISHERWOOD_CHRIS",
    missions_offered = "MISSION_ISHERWOOD_CHRIS_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_CHRIS",
    name = ccb.content.text("Chris Isherwood"),
    job_description = ccb.content.text("I'm Jesse and Carlos' son, part of the Isherwood family"),
    traits = {
        { trait = "FLEET" },
        { trait = "LIGHTSTEP" },
        { trait = "WEAKSTOMACH" },
        { trait = "ANTIJUNK" },
        { trait = "PRETTY" },
        { trait = "SKIN_LIGHT" },
        { trait = "eye_color", variant = "blue" },
        { trait = "hair_medium", variant = "black" },
        { trait = "NO_BASH" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_male_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "rifle", bonus = { rng = { 7, 10 } } },
        { skill = "archery", bonus = { rng = { 8, 10 } } },
    },
}
