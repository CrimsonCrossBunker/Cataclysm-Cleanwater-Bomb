local ccb = require("ccb")

ccb.content.define_npc {
    id = "yoshimi",
    unique_name = ccb.content.text("Yoshimi"),
    suffix = ccb.content.text("DinoLab survivor"),
    class = "dm_dinolab_survivor",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_Yoshimi_1",
    faction = "no_faction",
    missions_offered = "MISSION_DinoLab_Yos_1",
}

ccb.content.define_npc_class {
    id = "dm_dinolab_survivor",
    name = ccb.content.text("DinoLab survivor"),
    job_description = ccb.content.text("Need to learn what happened…"),
    common = false,
    worn = "lab_torso",
    carry = "NC_DOCTOR_misc",
    weapon = "EMPTY_GROUP",
    traits = {
        { "PRETTY", 100 },
        { "ANIMALEMPATH2", 100 },
        { "QUICK", 100 },
        { "LIZ_EYE", 100 },
        { "SCALES", 100 },
        { "NAILS", 100 },
        { "RAP_TALONS", 100 },
        { "THRESH_RAPTOR", 100 },
        { "ARM_FEATHERS", 100 },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 4, 8 } } },
    },
}
