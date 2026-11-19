local ccb = require("ccb")

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_LORD_ALCHEMIST",
    name = ccb.content.text("Forge Alchemist"),
    job_description = ccb.content.text("I brew potions and alchemical concoctions."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    sells_belongings = false,
    shop_groups = { { id = "NC_FORGE_LORD_STORE_POTION_SHOP", rigid = true } },
    whitelist = "FORGE_ALCHEMIST_WHITELIST",
    price_rules = {
        { item = "denarius", price = 2500, fixed_adjustment = 0 },
        { item = "mercury", premium = 1 },
        { group = "magic_plants_common", premium = 1, markup = 3 },
        { group = "magic_plants_uncommon", premium = 1.2, markup = 2 },
        { group = "magic_plants_rare", premium = 1.5, markup = 1.8 },
        { group = "potions_common", premium = 0.5, markup = 3 },
        { group = "potions_uncommon", premium = 0.9, markup = 2.4 },
        { group = "potions_rare", premium = 1.2, markup = 1.5 },
        { group = "potions_illegal", premium = 1.5, markup = 3 },
    },
    worn = "NC_FORGE_ALCHEMIST_clothes",
    carry = "EMPTY_GROUP",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "chemistry", bonus = { one_in = 2 } },
        { skill = "unarmed", bonus = { one_in = 2 } },
        { skill = "melee", bonus = { one_in = 2 } },
        { skill = "gun", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 1, 3 } } },
    },
    proficiencies = { "prof_alchemy" },
}
