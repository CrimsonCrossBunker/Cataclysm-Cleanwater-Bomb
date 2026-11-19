local ccb = require("ccb")

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_LORD",
    name = ccb.content.text("Wondrous Dreamer"),
    job_description = ccb.content.text("I created this place from dreams and magic."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { rng = { 20, 25 } },
    perception = { rng = { 20, 25 } },
    shop_groups = {
        { id = "NC_FORGE_LORD_SHOP", rigid = true },
        {
            id = "NC_FORGE_LORD_ACCEPTED_BOOKS",
            strict = true,
            refusal = ccb.content.text("<npc_name> will never give you their stories."),
            condition_handler = "forge_of_wonders_display_stock_is_sellable",
        },
    },
    price_rules = { { group = "NC_FORGE_LORD_ACCEPTED_BOOKS", price = 2500, fixed_adjustment = 0 } },
    whitelist = "NC_FORGE_LORD_WHITELIST",
    worn = "NC_FORGE_LORD_clothes",
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
        { skill = "speech", bonus = { rng = { 10, 20 } } },
    },
}
