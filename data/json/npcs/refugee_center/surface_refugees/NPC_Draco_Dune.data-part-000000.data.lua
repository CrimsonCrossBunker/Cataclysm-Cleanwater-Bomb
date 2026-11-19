local ccb = require("ccb")

-- Draco is a middle-aged musician, and generally a pretty nice guy.  He's always been a wanderer and this isn't his first time living basically homeless.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Draco",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { -1, 3 } },
    perception = { rng = { -1, 3 } },
    worn = "REFUGEE_Draco_worn",
    carry = "REFUGEE_Draco_carried",
    weapon = "REFUGEE_Draco_wield",
    traits = {
        { trait = "PRETTY" },
        { trait = "OPTIMISTIC" },
        { trait = "BADBACK" },
        { group = "Appearance_African" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 2, 3 } } },
        { skill = "swimming", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_npc {
    id = "refugee_DracoDune",
    unique_name = ccb.content.text("Draco Dune"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Draco",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Draco_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Draco_GET_GUITAR",
}
