local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_KINDRED_COOPER",
    name = ccb.content.text("Rogue Kindred"),
    job_description = ccb.content.text("I have to gather more bones."),
    traits = {
        { trait = "OUTDOORSMAN" },
        { trait = "INSOMNIA" },
        { trait = "GOODCARDIO2" },
        { trait = "STRONGSTOMACH" },
        { trait = "SPIRITUAL" },
        { trait = "TERRIFYING" },
        { trait = "PSYCHOPATH" },
        { trait = "seer_mark" },
        { group = "Appearance_Caucasian" },
        { trait = "hair_short", variant = "brown" },
        { trait = "natural_hair_color_brown" },
        { trait = "FACIAL_HAIR_3DAYSTUBBLE" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { rng = { 0, 2 } },
    strength = { rng = { 0, 2 } },
    worn = "KINDRED_COOPER_worn",
    weapon = "KINDRED_COOPER_wield",
    shop_groups = "NC_KINDRED_COOPER_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 5, 7 } } },
        { skill = "cutting", bonus = { rng = { 4, 6 } } },
    },
}

-- A once member of a doomsday cult.
ccb.content.define_npc {
    id = "KINDRED_Darren_Cooper",
    unique_name = ccb.content.text("Darren Cooper"),
    gender = "male",
    suffix = ccb.content.text("Rogue Kindred"),
    class = "NC_KINDRED_COOPER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_KINDRED_COOPER",
    faction = "no_faction",
}
