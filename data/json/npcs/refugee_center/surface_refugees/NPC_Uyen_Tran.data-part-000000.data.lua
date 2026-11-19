local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_UyenTran",
    unique_name = ccb.content.text("Uyen Tran"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Uyen",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_REFUGEE_Uyen_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Uyen_1",
}

-- A paramedic who suffers a bit of racism for being Asian
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Uyen",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 0, 3 } },
    perception = { rng = { -1, 3 } },
    worn = "REFUGEE_Uyen_worn",
    carry = "REFUGEE_Uyen_carried",
    weapon = "REFUGEE_Uyen_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_SouthAsian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    proficiencies = { "prof_knitting" },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -2, 2 } } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 3, 5 } } },
        { skill = "speech", bonus = { rng = { 0, 2 } } },
    },
}
