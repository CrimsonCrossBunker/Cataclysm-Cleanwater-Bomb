local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_GuneetSingh",
    unique_name = ccb.content.text("Guneet Singh"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Guneet",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Guneet_1",
    faction = "free_merchants",
}

-- Guneet is the Singhs' sixteen year old son.  Like his parents, he is wracked with survivor's guilt for his family having made it out intact.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Guneet",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Guneet_worn",
    carry = "REFUGEE_Guneet_carried",
    weapon = "REFUGEE_Guneet_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_SouthAsian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -5 } } } } } },
        },
    },
}
