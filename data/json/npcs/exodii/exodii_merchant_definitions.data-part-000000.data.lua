local ccb = require("ccb")

ccb.content.define_npc {
    id = "exodii_merchant",
    suffix = ccb.content.text("Cyborg"),
    class = "NC_EXODII_TYPE_1_Merchant",
    unique_name = ccb.content.text("Rubik"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_EXODII_MERCHANT",
    faction = "exodii",
    personality = { aggression = -1, bravery = 2, collector = -3, altruism = 3 },
    farewell = "…",
}

ccb.content.define_npc_class {
    id = "NC_EXODII_TYPE_1_Merchant",
    name = ccb.content.text("Cyborg, type 1"),
    job_description = ccb.content.text("I'm a cyborg."),
    work_hours = { 6, 22 },
    traits = {
        { trait = "EXODII_BODY_1" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { 0, 6 } },
    dexterity = { rng = { 0, 6 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 4 } },
    shop_groups = {
        { id = "EXODII_Shop_Tier0", rigid = true },
        { id = "EXODII_Shop_NomadGear_Tier0", rigid = true },
        { id = "EXODII_CBM_Store_Tier1", rigid = true },
        { id = "EXODII_CBM_Store_tier1_extra", rigid = true, trust = 1 },
        { id = "EXODII_CBM_Store_Tier2", rigid = true, trust = 10 },
        { id = "EXODII_CBM_Store_Tier3", rigid = true, trust = 20, strict = true },
        { id = "EXODII_Store_Salvage_Tech", rigid = true, trust = 20 },
        { id = "EXODII_CBM_Store_Tier4", rigid = true, trust = 40, strict = true },
    },
    consumption_rates = "basic_shop_rates",
    weapon = "NC_EXODII_TYPE_1_carried",
    blacklist = "rubik_shopkeep_blacklist",
    worn = "EMPTY_GROUP",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = 0 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "firstaid", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 2, 4 } } },
        { skill = "speech", bonus = 10 },
    },
}
