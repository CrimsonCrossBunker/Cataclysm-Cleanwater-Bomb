local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_UICA_GROUND_QUARTERMASTER",
    name = ccb.content.text("UICA Quartermaster"),
    job_description = ccb.content.text("Supply Trader"),
    common = false,
    traits = {
        { group = "NPC_starting_traits" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_UICA_GROUND_SOLDIER_worn",
    carry = "NC_UICA_GROUND_SOLDIER_carry",
    weapon = "NC_UICA_GROUND_SOLDIER_wield",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -1 } } } },
        { skill = "gun", bonus = { rng = { 4, 6 } } },
        { skill = "pistol", bonus = { rng = { 4, 6 } } },
        { skill = "smg", bonus = { rng = { 4, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 6 } } },
    },
    shop_groups = {
        { id = "afs_uica_quartermaster_money", rigid = true },
        { id = "afs_uica_quartermaster_armor", rigid = true },
        { id = "afs_uica_quartermaster_medical", rigid = true },
        { id = "afs_uica_quartermaster_military", rigid = true },
    },
    price_rules = { { group = "afs_general_armory", fixed_adjustment = 0 } },
}

ccb.content.define_npc {
    id = "uica_quartermaster",
    suffix = ccb.content.text("UICA Quartermaster"),
    class = "NC_UICA_GROUND_QUARTERMASTER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_UICA_GROUND_QUARTERMASTER",
    faction = "UICA",
}
