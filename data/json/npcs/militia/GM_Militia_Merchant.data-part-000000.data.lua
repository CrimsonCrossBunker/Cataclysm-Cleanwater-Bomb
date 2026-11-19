local ccb = require("ccb")

-- A member of the Gray Moose Militia, trying to safe in their isolated location
ccb.content.define_npc {
    id = "MILITIA_MERCHANT",
    unique_name = ccb.content.text("Darby Sutton"),
    class = "MILITIA_MERCHANT",
    attitude = 0,
    suffix = ccb.content.text("Survivor"),
    mission = "SHOPKEEP",
    chat = "TALK_MILITIA_MAIN",
    faction = "GM_militia_faction",
}

ccb.content.define_npc_class {
    id = "MILITIA_MERCHANT",
    name = ccb.content.text("Merchant"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = "MILITIA_MERCHANT_misc",
    carry = "MILITIA_MERCHANT_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 3, 5 } } },
    },
}
