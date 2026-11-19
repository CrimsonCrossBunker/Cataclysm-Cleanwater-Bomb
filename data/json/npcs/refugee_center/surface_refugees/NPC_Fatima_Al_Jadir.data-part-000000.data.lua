local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_FatimaalJadir",
    unique_name = ccb.content.text("Fatima al Jadir"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Fatima",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Fatima_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Fatima_1",
}

-- A welder, culturally muslim but only recently practicing since the Cataclysm has made her rethink her connections to her family's religion
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Fatima",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 3 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 1 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Fatima_worn",
    carry = "REFUGEE_Fatima_carried",
    weapon = "REFUGEE_Fatima_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_SouthAsian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    proficiencies = { "prof_metalworking", "prof_welding_basic", "prof_welding" },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -2, 1 } } } } } },
        },
        { skill = "fabrication", bonus = { rng = { 3, 7 } } },
        { skill = "mechanics", bonus = { rng = { 3, 7 } } },
    },
}
