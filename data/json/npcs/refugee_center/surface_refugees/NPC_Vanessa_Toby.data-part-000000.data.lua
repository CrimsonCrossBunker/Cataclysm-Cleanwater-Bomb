local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_VanessaToby",
    unique_name = ccb.content.text("Vanessa Toby"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Vanessa",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Vanessa_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Vanessa_1",
}

-- Vanessa is a middle-aged hairdresser.  She doesn't want to talk about her past.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Vanessa",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 0 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -4, 2 } },
    perception = { rng = { -1, 4 } },
    worn = "REFUGEE_Vanessa_worn",
    carry = "REFUGEE_Vanessa_carried",
    weapon = "REFUGEE_Vanessa_wield",
    traits = {
        { trait = "SKIN_TAN" },
        { trait = "hair_medium", variant = "gray" },
        { trait = "natural_hair_color_gray" },
        { group = "NPC_starting_traits" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -5 } } } } } },
        },
        { skill = "tailor", bonus = { rng = { 1, 2 } } },
        { skill = "swimming", bonus = { rng = { 1, 2 } } },
        { skill = "cooking", bonus = { rng = { 0, 2 } } },
    },
}
