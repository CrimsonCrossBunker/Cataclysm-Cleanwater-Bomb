local ccb = require("ccb")

-- A survivor raising rabbits, all by themselves. Give special quests to give rabbits to player
ccb.content.define_npc {
    id = "warrener",
    unique_name = ccb.content.text("Mr. Lapin"),
    suffix = ccb.content.text("Warrener"),
    gender = "male",
    class = "NC_Rabbit_Raiser",
    attitude = 0,
    mission = "GUARD",
    missions_offered = "MISSION_Warrener_LOG_1",
    chat = "TALK_WARRENER",
    faction = "lapin",
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_Rabbit_Raiser",
    name = ccb.content.text("Mr. Lapin"),
    job_description = ccb.content.text("I raise rabbits."),
    common = false,
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "survival", bonus = { rng = { 1, 5 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
    },
    traits = {
        { "FLEET2", 100 },
        { "GOODHEARING", 100 },
        { "DEFT", 100 },
        { "ANIMALEMPATH2", 100 },
        { "LIGHTFUR", 100 },
        { "HOOVES", 100 },
    },
}
