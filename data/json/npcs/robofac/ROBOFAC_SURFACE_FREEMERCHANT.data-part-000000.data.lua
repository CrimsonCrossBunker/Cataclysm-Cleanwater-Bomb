local ccb = require("ccb")

-- A free merchant caravanner that temporarily supplies the hq with foodstuff.
ccb.content.define_npc {
    id = "roabofac_free_merchant",
    suffix = ccb.content.text("Free Merchant"),
    class = "NC_ROBOFAC_FREE_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_FREE_MERCHANT",
    faction = "free_merchants",
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_ROBOFAC_FREE_MERCHANT",
    name = ccb.content.text("Caravaneer"),
    job_description = ccb.content.text("I'm the owner of a trade caravan."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = { { id = "NC_ROBOFAC_FREE_MERCHANT_misc", rigid = true } },
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
        { skill = "speech", bonus = { rng = { 3, 5 } } },
    },
}
