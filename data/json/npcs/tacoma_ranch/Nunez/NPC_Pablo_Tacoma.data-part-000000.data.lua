local ccb = require("ccb")

ccb.content.define_npc {
    id = "tacoma_PabloNunez",
    unique_name = ccb.content.text("Pablo Nunez"),
    gender = "male",
    suffix = ccb.content.text("bookkeeper"),
    class = "NC_TACOMA_Pablo",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_TACOMA_Pablo_1",
    age = 28,
    height = 184,
    strength = 10,
    dexterity = 8,
    intelligence = 10,
    perception = 10,
    personality = { aggression = 1, bravery = 3, collector = 1, altruism = 3 },
    faction = "free_merchants",
}

-- Pablo is a young professional who survived with his wife, but she was pregnant and lost the baby.
ccb.content.define_npc_class {
    id = "NC_TACOMA_Pablo",
    name = ccb.content.text("Bookkeeper"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    worn = "TACOMA_Pablo_worn",
    carry = "TACOMA_Pablo_carried",
    weapon = "TACOMA_Pablo_wield",
    traits = {
        { trait = "QUICK" },
        { trait = "Exp_Bookkeeping1" },
        { trait = "SKIN_MEDIUM" },
        { trait = "eye_color", variant = "brown" },
        { trait = "hair_short", variant = "black" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        { skill = "bashing", bonus = 3 },
        { skill = "computer", bonus = 4 },
        { skill = "cooking", bonus = 1 },
        { skill = "driving", bonus = 2 },
        { skill = "fabrication", bonus = 2 },
        { skill = "mechanics", bonus = 2 },
        { skill = "melee", bonus = 3 },
        { skill = "speech", bonus = 2 },
        { skill = "swimming", bonus = 1 },
    },
}
