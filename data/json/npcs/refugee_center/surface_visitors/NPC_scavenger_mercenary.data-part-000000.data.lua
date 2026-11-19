local ccb = require("ccb")

-- Appears in the refugee center as a partner for hire.
ccb.content.define_npc {
    id = "scavenger_merc",
    suffix = ccb.content.text("Merc"),
    age = 37,
    class = "NC_SCAVENGER_MERC",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_SCAVENGER_MERC",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_SCAVENGER_MERC",
    name = ccb.content.text("Mercenary"),
    job_description = ccb.content.text("Fighting for the all-mighty dollar."),
    common = false,
    traits = {
        { trait = "BGSS_Scavenger_Merc_1" },
        { trait = "PSYCHOPATH" },
        { trait = "TOUGH" },
        { trait = "BADTEMPER" },
        { trait = "SLOWREADER" },
        { trait = "INSOMNIA" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 1, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 1, 2 } },
    worn = "NC_SCAVENGER_MERC_worn",
    carry = "NC_SCAVENGER_MERC_carry",
    weapon = "NC_SCAVENGER_MERC_wield",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 1, 4 } } },
        { skill = "stabbing", bonus = { rng = { 1, 4 } } },
        { skill = "dodge", bonus = { rng = { 1, 4 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
        { skill = "swimming", bonus = { rng = { 1, 4 } } },
        { skill = "survival", bonus = { rng = { 0, 3 } } },
        { skill = "speech", bonus = -4 },
    },
}
