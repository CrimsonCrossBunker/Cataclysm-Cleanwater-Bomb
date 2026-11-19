local ccb = require("ccb")

-- The Exodii autodoc operator
ccb.content.define_npc {
    id = "exodii_surgeon",
    suffix = ccb.content.text("Cyborg"),
    class = "NC_EXODII_TYPE_1b_surgeon",
    unique_name = ccb.content.text("Venn"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_EXODII_VENN",
    faction = "exodii",
}

ccb.content.define_npc_class {
    id = "NC_EXODII_TYPE_1b_surgeon",
    name = ccb.content.text("Cyborg, type 1b"),
    job_description = ccb.content.text("I'm a cyborg."),
    traits = {
        { trait = "EXODII_BODY_1b" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { 0, 6 } },
    dexterity = { rng = { 0, 6 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 4 } },
    weapon = "EMPTY_GROUP",
    worn = "EMPTY_GROUP",
    shop_groups = { { id = "EXODII_Bionic_Limb_Store_Tier1", rigid = true } },
    consumption_rates = "basic_shop_rates",
    blacklist = "rubik_shopkeep_blacklist",
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
        { skill = "speech", bonus = { rng = { 5, 8 } } },
    },
}
