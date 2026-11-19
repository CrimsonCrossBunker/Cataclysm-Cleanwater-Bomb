local ccb = require("ccb")

-- All guns are more expensive here.
ccb.content.define_npc_class {
    id = "NC_AUGUSTMOON_GUNTRADER",
    name = ccb.content.text("Gun trader "),
    job_description = ccb.content.text("Gun trader"),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { trait = "RETURN_TO_START_POS" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "AUGUSTMOON_GUNTRADER_worn",
    carry = "afs_civilian_armory",
    weapon = "EMPTY_GROUP",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
    shop_groups = {
        { id = "afs_augustmoon_guntrader", rigid = true },
        {
            id = "afs_augustmoon_guntrader_military",
            rigid = true,
            refusal = ccb.content.text("You need an armament license to buy this."),
            condition_handler = "augustmoon_armament_license",
        },
    },
    price_rules = { { group = "afs_general_armory", fixed_adjustment = 0 } },
}
