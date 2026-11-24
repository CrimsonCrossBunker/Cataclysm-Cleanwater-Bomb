local ccb = require("ccb")

-- Appears in the refugee center as shopkeeper with missions.  Faction critical.  Real name: Gavin Wheeler
ccb.content.define_npc {
    id = "free_merchants_merchant",
    unique_name = ccb.content.text("Smokes"),
    gender = "male",
    suffix = ccb.content.text("Merchant"),
    class = "NC_FREE_MERCHANTS_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_FREE_MERCHANTS_MERCHANT",
    missions_offered = "MISSION_FREE_MERCHANTS_EVAC_1",
    faction = "free_merchants",
}

-- Smokes is a firefighter that volunteered to take stock of what was available and keep inventory. He's gradually had more lumped onto him as the Free Merchants struggle to put themselves together, but he feels obligated to help, even though he doesn't really want to have all the responsibility he does.
-- He's also quite chatty and will gladly talk about the way things are these days. This is deliberate, since Free Merchants are very likely to be the first faction players encounter.
-- Most of his dialogue goes in 'free_merchant_shopkeep_dialogue.json'. Dialogue that just does worldbuilding goes into 'free_merchant_shopkeep_dialogue_fluff.json'.
ccb.content.define_npc_class {
    id = "NC_FREE_MERCHANTS_MERCHANT",
    name = ccb.content.text("Merchant"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    common = false,
    sells_belongings = false,
    strength = 4,
    dexterity = 2,
    shop_groups = { { id = "FREE_MERCHANTS_Shop", rigid = true } },
    consumption_rates = "smokes_shop_rates",
    worn = "NC_FREE_MERCHANTS_MERCHANT_worn",
    weapon = "NC_FREE_MERCHANTS_MERCHANT_carried",
    traits = {
        { trait = "GOODCARDIO" },
        { trait = "FLEET" },
        { trait = "OPTIMISTIC" },
        { trait = "STRONGBACK" },
        { trait = "THIRST" },
        { trait = "SLEEPY" },
        { trait = "CLUMSY" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_Irish" },
    },
    skills = {
        { skill = "firstaid", bonus = 3 },
        { skill = "mechanics", bonus = 2 },
        { skill = "melee", bonus = 2 },
        { skill = "speech", bonus = 3 },
        { skill = "swimming", bonus = 3 },
    },
}

-- Retained to prevent errors.
ccb.content.define_npc_class {
    id = "NC_EVAC_SHOPKEEP",
    name = ccb.content.text("Merchant"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    collector = { rng = { 1, 5 } },
    shop_groups = "NC_EVAC_SHOPKEEP_misc",
    carry = "NC_EVAC_SHOPKEEP_misc",
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
