local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_ANCILLA_DOCTOR",
    name = ccb.content.text("Ancilla Doctor"),
    job_description = ccb.content.text("I try to keep this gang in one piece.  It's a full time job."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { rng = { 3, 5 } },
    worn = "NC_ANCILLA_DOCTOR_worn",
    carry = "NC_ANCILLA_BARKEEP_carry",
    weapon = "NC_ANCILLA_BARKEEP_wield",
    shop_groups = {
        { id = "NC_ANCILLA_DOCTOR_stock", rigid = true },
        {
            id = "NC_ANCILLA_DOCTOR_bionics",
            rigid = true,
            strict = true,
            condition_handler = "ancilla_bionics_unlocked",
        },
        {
            id = "NC_ANCILLA_DOCTOR_bionics_LENS",
            rigid = true,
            strict = true,
            condition_handler = "ancilla_bionics_lenses_unlocked",
        },
    },
    price_rules = {
        { group = "NC_ANCILLA_DOCTOR_stock", premium = 2.0 },
        { group = "NC_ANCILLA_DOCTOR_EXPENSIVE_ITEMS", premium = 6.0 },
        { item = "RobofacCoin", price = 5000, fixed_adjustment = 0 },
    },
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
