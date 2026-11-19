local ccb = require("ccb")

-- Dairy farmer the Isherwood family.
-- Brother of Eddie, husband of Jesse.  Father of Lisa and Chris, cousin of Luke.  Son of Claire and Jack, nephew of Barry.
ccb.content.define_npc {
    id = "isherwood_carlos",
    unique_name = ccb.content.text("Carlos Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_CARLOS",
    attitude = 0,
    mission = "GUARD",
    age = 44,
    height = 176,
    strength = 9,
    dexterity = 8,
    intelligence = 7,
    perception = 9,
    personality = { aggression = -2, bravery = 4, collector = -2, altruism = -1 },
    chat = "TALK_ISHERWOOD_CARLOS",
    missions_offered = "MISSION_ISHERWOOD_CARLOS_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_CARLOS",
    name = ccb.content.text("Carlos Isherwood"),
    job_description = ccb.content.text("I'm Jesse's husband, part of the Isherwood family."),
    traits = {
        { trait = "NIGHTVISION" },
        { trait = "BADKNEES" },
        { trait = "GOODMEMORY" },
        { trait = "SKIN_TAN" },
        { trait = "eye_color", variant = "gray" },
        { trait = "hair_short", variant = "gray" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
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
