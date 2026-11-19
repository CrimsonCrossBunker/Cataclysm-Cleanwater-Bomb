local ccb = require("ccb")

-- Dairy farmer of the Isherwood family.
-- Brother of Carlos, BIL of Jesse.  Uncle of Lisa and Chris, father of Luke.  Son of Claire and Jack, nephew of Barry.
ccb.content.define_npc {
    id = "isherwood_eddie",
    unique_name = ccb.content.text("Eddie Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_EDDIE",
    attitude = 0,
    mission = "GUARD",
    age = 41,
    height = 179,
    strength = 9,
    dexterity = 7,
    intelligence = 7,
    perception = 8,
    personality = { aggression = -4, bravery = -1, collector = 1, altruism = 1 },
    chat = "TALK_ISHERWOOD_EDDIE",
    missions_offered = "MISSION_ISHERWOOD_EDDIE_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_EDDIE",
    name = ccb.content.text("Eddie Isherwood"),
    job_description = ccb.content.text("I'm a dairy farmer, part of the Isherwood family"),
    traits = {
        { trait = "ASTHMA" },
        { trait = "JITTERY" },
        { trait = "OPTIMISTIC" },
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
    shop_groups = "NC_ISHERWOOD_EDDIE_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
        { skill = "archery", bonus = { rng = { 4, 8 } } },
    },
}
