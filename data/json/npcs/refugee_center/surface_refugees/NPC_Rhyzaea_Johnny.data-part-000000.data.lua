local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_RhyzaeaJohnny",
    unique_name = ccb.content.text("Rhyzaea Johnny"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Rhyzaea",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Rhyzaea_1",
    faction = "free_merchants",
}

-- A counselor from far away, Rhy can offer a lot of supports to player and survivors if she can get herself sorted a little
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Rhyzaea",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 0, 3 } },
    perception = { rng = { -1, 3 } },
    worn = "REFUGEE_Rhyzaea_worn",
    carry = "office",
    weapon = "REFUGEE_Rhyzaea_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_Mixed" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -2, 1 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 3, 7 } } },
    },
}
