local ccb = require("ccb")

-- Materials manager and music fan from another Ethiopia.
ccb.content.define_npc {
    id = "exodii_materials",
    suffix = ccb.content.text("Cyborg"),
    class = "NC_EXODII_TYPE_2_Materials",
    unique_name = ccb.content.text("Luliya"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_LULIYA",
    faction = "exodii",
}

ccb.content.define_npc_class {
    id = "NC_EXODII_TYPE_2_Materials",
    name = ccb.content.text("Cyborg, type 2"),
    job_description = ccb.content.text("I'm a cyborg."),
    traits = {
        { trait = "EXODII_BODY_2" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "NPC_STASIS" },
    },
    common = false,
    strength = { rng = { 0, 6 } },
    dexterity = { rng = { 0, 6 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 4 } },
    weapon = "NC_EXODII_TYPE_2_carried",
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
        { skill = "speech", bonus = { rng = { 5, 8 } } },
    },
}
