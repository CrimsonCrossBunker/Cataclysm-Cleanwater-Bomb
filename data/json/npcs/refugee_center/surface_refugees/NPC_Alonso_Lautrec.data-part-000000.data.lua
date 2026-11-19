local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_AlonsoLautrec",
    unique_name = ccb.content.text("Alonso Lautrec"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Alonso",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Alonso_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Alonso_pants",
}

-- Alonso wants to be the town bicycle, but isn't getting as much interest as he'd hoped.  He'll trade a morale bonus for condoms.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Alonso",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 1 } },
    dexterity = { rng = { -2, 4 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Alonso_worn",
    carry = "REFUGEE_Alonso_carried",
    weapon = "REFUGEE_Alonso_wield",
    traits = {
        { trait = "PRETTY" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -5 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 0, 1 } } },
    },
}
