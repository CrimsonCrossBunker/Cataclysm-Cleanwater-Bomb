local ccb = require("ccb")

-- Jenny Forcette is an experienced mechanical engineer.  Like the other refugees in the center, she's terrified of the outside world.  Unlike many, she has some ideas what to do about it.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Jenny",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -4, -2 } },
    dexterity = { rng = { -2, 1 } },
    intelligence = { rng = { 3, 4 } },
    perception = { rng = { -1, 1 } },
    worn = "REFUGEE_Jenny_worn",
    carry = "REFUGEE_Jenny_carried",
    weapon = "REFUGEE_Jenny_wield",
    traits = {
        { trait = "PACIFIST" },
        { group = "Appearance_Caucasian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    proficiencies = { "prof_elec_soldering", "prof_metalworking", "prof_welding_basic" },
    skills = {
        { skill = "mechanics", bonus = { rng = { 5, 6 } } },
        { skill = "computer", bonus = { rng = { 2, 5 } } },
        { skill = "electronics", bonus = { rng = { 3, 6 } } },
        { skill = "fabrication", bonus = { rng = { 2, 5 } } },
    },
}

ccb.content.define_npc {
    id = "refugee_JennyForcette",
    unique_name = ccb.content.text("Jenny Forcette"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Jenny",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_JENNY_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Jenny_GET_MOTOR",
}
