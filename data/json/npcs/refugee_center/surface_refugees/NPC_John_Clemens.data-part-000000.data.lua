local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_JohnClemens",
    unique_name = ccb.content.text("John Clemens"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_John",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_John_1",
    faction = "free_merchants",
}

-- John is a pseudonym.  This guy probably lived in a city before the Cataclysm, but now he either thinks he is or pretends to be a cowboy..
ccb.content.define_npc_class {
    id = "NC_REFUGEE_John",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 2 } },
    dexterity = { rng = { -3, 2 } },
    intelligence = { rng = { -2, 1 } },
    perception = { rng = { -1, 3 } },
    worn = "REFUGEE_John_worn",
    carry = "REFUGEE_John_carried",
    weapon = "REFUGEE_John_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_Caucasian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "fabrication", bonus = { rng = { 0, 1 } } },
        { skill = "swimming", bonus = { rng = { 0, 2 } } },
    },
}
