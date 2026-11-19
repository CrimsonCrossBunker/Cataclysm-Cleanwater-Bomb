local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_GarryVilleneuve",
    unique_name = ccb.content.text("Garry Villeneuve"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Garry",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Garry_1",
    faction = "free_merchants",
}

-- Garry is a Stan's older brother.  He's grateful he's made it to help support his brother, but he's very worried about Stan.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Garry",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { 0, 4 } },
    dexterity = { rng = { -1, 3 } },
    intelligence = { rng = { -1, 3 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Garry_worn",
    carry = "REFUGEE_Garry_carried",
    weapon = "REFUGEE_Garry_wield",
    traits = {
        { trait = "MYOPIC" },
        { group = "Appearance_Germanic" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 3, 4 } } },
        { skill = "electronics", bonus = { rng = { 1, 2 } } },
    },
}
