local ccb = require("ccb")

ccb.content.define_npc {
    id = "refugee_DanaNunez",
    unique_name = ccb.content.text("Dana Nunez"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Dana",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Dana_1_firstmeet",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Dana_Sourdough",
    age = 26,
    height = 164,
    strength = 8,
    dexterity = 9,
    intelligence = 9,
    perception = 11,
    personality = { aggression = -10, bravery = -5, collector = 1, altruism = 4 },
}

-- Dana is a young woman who survived with her husband, but she was pregnant and lost the baby.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Dana",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    worn = "REFUGEE_Dana_worn",
    carry = "REFUGEE_Dana_carried",
    weapon = "REFUGEE_Dana_wield",
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
        { skill = "cutting", bonus = 1 },
        { skill = "driving", bonus = 2 },
        { skill = "melee", bonus = 1 },
        { skill = "speech", bonus = 1 },
        { skill = "unarmed", bonus = 1 },
    },
}
