local ccb = require("ccb")

ccb.content.define_npc {
    id = "augustmoon_doctor",
    unique_name = ccb.content.text("Mercurial Medical Agent"),
    gender = "male",
    class = "NC_MERCURIAL_DOCTOR",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_MERCURIAL_DOCTOR",
    faction = "mercurial",
}

ccb.content.define_npc_class {
    id = "NC_MERCURIAL_DOCTOR",
    name = ccb.content.text("Mercurial Medical Agent"),
    job_description = ccb.content.text("I try to keep this gang in one piece.  It's a full time job."),
    traits = {
        { group = "NPC_starting_traits" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { rng = { 5, 7 } },
    worn = "NC_AUGUSTMOON_DOCTOR_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    shop_groups = { { id = "NC_AUGUSTMOON_DOCTOR_stock", rigid = true } },
    price_rules = { { group = "NC_AUGUSTMOON_DOCTOR_stock", fixed_adjustment = 0 } },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "firstaid", bonus = 7 },
    },
}
