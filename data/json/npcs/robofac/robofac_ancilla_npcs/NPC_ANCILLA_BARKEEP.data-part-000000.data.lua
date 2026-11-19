local ccb = require("ccb")

ccb.content.define_npc {
    id = "ancilla_barkeep",
    suffix = ccb.content.text("Bartender"),
    class = "NC_ANCILLA_BARTENDER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ANCILLA_BARKEEP",
    missions_offered = "MISSION_RANCH_BARTENDER_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc_class {
    id = "NC_ANCILLA_BARTENDER",
    name = ccb.content.text("Bartender"),
    job_description = ccb.content.text("I'm looking for new drink recipes."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_ANCILLA_BARKEEP_worn",
    carry = "NC_ANCILLA_BARKEEP_carry",
    weapon = "NC_ANCILLA_BARKEEP_wield",
    shop_groups = { { id = "NC_ANCILLA_BARKEEP_stock", rigid = true } },
    price_rules = { { group = "NC_ANCILLA_BARKEEP_stock", markup = 2.5 } },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 5 } } },
    },
}
