local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_godco_russell",
    name = ccb.content.text("Hunter"),
    job_description = ccb.content.text("I am a member of the New England Church Community."),
    common = false,
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { -1, 0 } },
    perception = 4,
    worn = "GODCO_russell_worn",
    carry = "GODCO_russell_carried",
    weapon = "GODCO_russell_wield",
    proficiencies = { "prof_traps", "prof_trapsetting", "prof_tanning_basic" },
    shop_groups = {
        { id = "GODCO_russell_sell", rigid = true },
        {
            id = "GODCO_russell_carried",
            rigid = true,
            refusal = ccb.content.text("<npcname> will never sell this"),
            condition_handler = "shopkeeper_stock_override_enabled",
        },
    },
    traits = {
        { trait = "NIGHTVISION" },
        { trait = "OUTDOORSMAN" },
        { trait = "EAGLEEYED" },
        { group = "Appearance_demographics" },
        { trait = "FACIAL_HAIR_BEARD" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 2, 3 } } },
        { skill = "fabrication", bonus = { rng = { 1, 2 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "cutting", bonus = { rng = { 1, 2 } } },
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
}
