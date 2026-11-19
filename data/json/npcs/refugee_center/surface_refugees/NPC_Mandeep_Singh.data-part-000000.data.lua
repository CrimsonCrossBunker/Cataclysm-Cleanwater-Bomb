local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_MandeepSingh",
    unique_name = ccb.content.text("Mandeep Singh"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Mandeep",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Mandeep_1",
    faction = "free_merchants",
}

-- Mandeep is the father of a small family.  They've made it through this unscathed and have a lot of survivor's guilt as a result.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Mandeep",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Mandeep_worn",
    carry = "REFUGEE_Mandeep_carried",
    weapon = "EMPTY_GROUP",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_SouthAsian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "driving", bonus = { rng = { 0, 2 } } },
        { skill = "computer", bonus = { rng = { 0, 2 } } },
        { skill = "firstaid", bonus = { rng = { 0, 2 } } },
    },
}
