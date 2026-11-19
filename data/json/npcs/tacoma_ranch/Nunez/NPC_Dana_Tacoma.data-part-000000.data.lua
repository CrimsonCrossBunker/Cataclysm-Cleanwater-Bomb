local ccb = require("ccb")

ccb.content.define_npc {
    id = "tacoma_DanaNunez",
    unique_name = ccb.content.text("Dana Nunez"),
    gender = "female",
    suffix = ccb.content.text("baker"),
    class = "NC_TACOMA_Dana",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_TACOMA_Dana_1",
    faction = "free_merchants",
    age = 26,
    height = 164,
    strength = 8,
    dexterity = 9,
    intelligence = 9,
    perception = 11,
    personality = { aggression = -2, bravery = -1, collector = 1, altruism = 4 },
}

-- Dana is a young woman who survived with her husband, but she was pregnant and lost the baby.  This class def is for after she moves to Tacoma.
ccb.content.define_npc_class {
    id = "NC_TACOMA_Dana",
    name = ccb.content.text("baker"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    worn = "TACOMA_Dana_worn",
    carry = "TACOMA_Dana_carried",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "PAINRESIST" },
        { trait = "MYOPIC" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "hair_ponytail", variant = "red" },
        { trait = "SKIN_LIGHT" },
        { trait = "eye_color", variant = "blue" },
    },
    skills = {
        { skill = "cooking", bonus = 6 },
        { skill = "cutting", bonus = 3 },
        { skill = "driving", bonus = 2 },
        { skill = "fabrication", bonus = 1 },
        { skill = "melee", bonus = 3 },
        { skill = "speech", bonus = 1 },
        { skill = "survival", bonus = 1 },
        { skill = "unarmed", bonus = 1 },
    },
}
