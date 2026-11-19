local ccb = require("ccb")

ccb.content.define_npc {
    id = "robofac_chop_shop_merc_1",
    unique_name = ccb.content.text("David Marceno"),
    suffix = ccb.content.text("Hub Mercenary"),
    class = "NC_ANCILLA_BOSS_CHOP_SHOP",
    attitude = 1,
    mission = "GUARD",
    chat = "NC_ANCILLA_BOSS_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
}

ccb.content.define_npc_class {
    id = "NC_ANCILLA_BOSS_CHOP_SHOP",
    name = ccb.content.text("Hub Mercenary"),
    job_description = ccb.content.text("Fighting in the name of Hub 01 and money, mostly money."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_ANCILLA_BOSS_CHOP_SHOP_worn",
    carry = "NC_ANCILLA_BOSS_CHOP_SHOP_carry",
    weapon = "NC_ANCILLA_BOSS_CHOP_SHOP_wield",
    skills = {
        { skill = "gun", bonus = 4 },
        { skill = "rifle", bonus = 4 },
        { skill = "pistol", bonus = 1 },
        { skill = "melee", bonus = 4 },
        { skill = "cutting", bonus = 3 },
        { skill = "fabrication", bonus = 1 },
        { skill = "firstaid", bonus = 1 },
        { skill = "swimming", bonus = 3 },
        { skill = "survival", bonus = 4 },
        { skill = "cooking", bonus = 4 },
        { skill = "computer", bonus = 6 },
        { skill = "electronics", bonus = 4 },
        { skill = "driving", bonus = 3 },
    },
}
