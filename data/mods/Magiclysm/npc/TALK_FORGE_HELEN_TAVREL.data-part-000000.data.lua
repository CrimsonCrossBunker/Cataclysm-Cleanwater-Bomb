local ccb = require("ccb")

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_LORD_REAGENT",
    name = ccb.content.text("Pirate Queen"),
    job_description = ccb.content.text("My adventures would curdle your blood."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = {
        { id = "NC_FORGE_LORD_STORE_REAGENT_SHOP", rigid = true },
        {
            id = "forge_lord_pirate_treasure",
            strict = true,
            refusal = ccb.content.text("<npc_name> will never give you their treasures."),
            condition_handler = "forge_of_wonders_display_stock_is_sellable",
        },
    },
    price_rules = {
        { category = "guns", premium = 1 },
        { category = "ammo", premium = 1 },
        { group = "forge_lord_pirate_treasure", premium = 1.2 },
    },
    whitelist = "FORGE_REAGENT_WHITELIST",
    worn = "NC_FORGE_REAGENT_clothes",
    weapon = "NC_FORGE_REAGENT_wield",
    carry = "EMPTY_GROUP",
    sells_belongings = false,
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "computer", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 1, 3 } } },
    },
}
