local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_BorisBorichenko",
    unique_name = ccb.content.text("Boris Borichenko"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Boris",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Boris_1",
    missions_offered = "MISSION_REFUGEE_Boris_CLEANUP",
    faction = "free_merchants",
}

-- Boris is nice, but shy and sad.  He was a carpenter; he and his partner lost their son in the Cataclysm, and it makes it harder for them to make friends in the survivor group.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Boris",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { 1, 4 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { -3, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Boris_worn",
    carry = "REFUGEE_Boris_carried",
    weapon = "REFUGEE_Boris_wield",
    traits = {
        { trait = "OUTDOORSMAN" },
        { trait = "PAINRESIST" },
        { group = "trait_group_STRONGBACK" },
        { group = "Appearance_Caucasian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    proficiencies = { "prof_carpentry_basic", "prof_carving", "prof_plumbing" },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "fabrication", bonus = { rng = { 3, 4 } } },
        { skill = "survival", bonus = { rng = { 1, 2 } } },
    },
}
