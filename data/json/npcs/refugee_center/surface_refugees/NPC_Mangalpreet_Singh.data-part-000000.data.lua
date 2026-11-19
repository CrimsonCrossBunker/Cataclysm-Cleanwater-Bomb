local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_MangalpreetSingh",
    unique_name = ccb.content.text("Mangalpreet Kaur"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Mangalpreet",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Mangalpreet_1",
    faction = "free_merchants",
}

-- Mangalpreet is the mother of a small family.  They've made it through this unscathed and have a lot of survivor's guilt.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Mangalpreet",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Mangalpreet_worn",
    carry = "REFUGEE_Mangalpreet_carried",
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
        { skill = "cooking", bonus = { rng = { 3, 4 } } },
        { skill = "tailor", bonus = { rng = { 2, 4 } } },
        { skill = "fabrication", bonus = { rng = { 1, 2 } } },
    },
}
