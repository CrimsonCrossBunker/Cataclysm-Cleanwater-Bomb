local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP",
    name = ccb.content.text("Hub Scientist"),
    job_description = ccb.content.text("A Hub 01 scientist."),
    common = false,
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_worn",
    carry = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_carry",
    weapon = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_wield",
    skills = { { skill = "firstaid", bonus = 8 }, { skill = "electronics", bonus = 8 } },
}

ccb.content.define_npc {
    id = "robofac_chop_shop_scientist_1",
    unique_name = ccb.content.text("Michael Harlow"),
    suffix = ccb.content.text("Hub Scientist"),
    class = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP",
    attitude = 1,
    mission = "GUARD",
    chat = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
    on_death = "robofac_chop_shop_scientist_death",
}
