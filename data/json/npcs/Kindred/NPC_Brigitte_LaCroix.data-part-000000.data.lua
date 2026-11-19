local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_BONE_SEER",
    name = ccb.content.text("Bone Seer"),
    job_description = ccb.content.text("I wish to sing the song of the Bones."),
    traits = {
        { trait = "OUTDOORSMAN" },
        { trait = "HEAVYSLEEPER" },
        { trait = "GOODCARDIO" },
        { trait = "LIGHTSTEP" },
        { trait = "ROBUST" },
        { trait = "SKIN_DARK" },
        { trait = "seer_mark" },
        { trait = "hair_mohawk", variant = "black" },
        { trait = "natural_hair_color_black" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
    },
    common = false,
    perception = { rng = { 0, 2 } },
    strength = { rng = { 0, 2 } },
    intelligence = { rng = { 0, 2 } },
    worn = "BONE_SEER_Brigitte_worn",
    weapon = "BONE_SEER_Brigitte_wield",
    shop_groups = "NC_BONE_SEER_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "survival", bonus = { rng = { 2, 4 } } },
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 6, 8 } } },
        { skill = "bashing", bonus = { rng = { 3, 6 } } },
        { skill = "cutting", bonus = { rng = { 3, 6 } } },
    },
}
