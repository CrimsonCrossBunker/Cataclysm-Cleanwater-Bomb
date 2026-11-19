local ccb = require("ccb")

-- Dairy farmer's son in the Isherwood family.
-- Son of Eddie, nephew of Carlos and Jesse.  Cousin of Lisa and Chris.  Grandson of Claire and Jack, great-nephew of Barry.
ccb.content.define_npc {
    id = "isherwood_luke",
    unique_name = ccb.content.text("Luke Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_LUKE",
    attitude = 0,
    mission = "GUARD",
    age = 16,
    height = 181,
    strength = 8,
    dexterity = 9,
    intelligence = 7,
    perception = 8,
    personality = { aggression = 2, bravery = 8, collector = 1, altruism = 2 },
    chat = "TALK_ISHERWOOD_LUKE",
    missions_offered = "MISSION_ISHERWOOD_LUKE_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_LUKE",
    name = ccb.content.text("Luke Isherwood"),
    job_description = ccb.content.text("I'm Eddie's son, part of the Isherwood family"),
    traits = {
        { trait = "FLEET" },
        { trait = "TOUGH" },
        { trait = "SKIN_TAN" },
        { trait = "eye_color", variant = "hazel" },
        { trait = "hair_short", variant = "black" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
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
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
        { skill = "fabrication", bonus = { rng = { 2, 7 } } },
        { skill = "archery", bonus = { rng = { 4, 8 } } },
    },
}
