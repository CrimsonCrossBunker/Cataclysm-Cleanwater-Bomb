local ccb = require("ccb")

ccb.content.define_npc {
    id = "exodii_weaponmaster",
    suffix = ccb.content.text("Weaponmaster"),
    class = "NC_EXODII_TYPE_9_Weaponmaster",
    unique_name = ccb.content.text("Nine"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_WEAPONMASTER_INTRO_1",
    faction = "exodii",
    personality = { aggression = -2, bravery = 2, collector = 2, altruism = -2 },
}

ccb.content.define_npc_class {
    id = "NC_EXODII_TYPE_9_Weaponmaster",
    name = ccb.content.text("Cyborg, type 9"),
    job_description = ccb.content.text("I'm a cyborg."),
    work_hours = { 6, 22 },
    traits = {
        { trait = "EXODII_BODY_9" },
        { trait = "IGNORE_SOUND" },
        { trait = "MUTE" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { 0, 2 } },
    dexterity = { rng = { 0, 1 } },
    intelligence = { rng = { 0, 6 } },
    perception = { rng = { 0, 1 } },
    shop_groups = {
        { id = "EXODII_Shop_Guns_Tier0", rigid = true },
        { id = "EXODII_Shop_OldArmour", rigid = true },
        { id = "EXODII_Shop_Guns_Tier1", rigid = true, trust = 1 },
        { id = "EXODII_Shop_Guns_Tier2", rigid = true, trust = 10 },
        { id = "EXODII_Shop_Guns_Tier3", rigid = true, trust = 20, strict = true },
        { id = "EXODII_Shop_Guns_caotel", rigid = true, trust = 20, strict = true },
    },
    price_rules = {
        { group = "EXODII_Shop_Guns_caotel", markup = 10 },
        { item = "caotel_cell_spent", fixed_adjustment = 80 },
    },
    consumption_rates = "basic_shop_rates",
    blacklist = "cyborg_type_9_shopkeep_blacklist",
    weapon = "brogyeki_weapon_override",
    worn = "EMPTY_GROUP",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = 0 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { rng = { 5, 7 } } },
        { skill = "electronics", bonus = { rng = { 3, 6 } } },
        { skill = "firstaid", bonus = { rng = { 2, 4 } } },
        { skill = "gun", bonus = { rng = { 6, 9 } } },
        { skill = "rifle", bonus = { rng = { 6, 9 } } },
        { skill = "unarmed", bonus = { rng = { 4, 7 } } },
        { skill = "speech", bonus = { rng = { 5, 8 } } },
    },
}
