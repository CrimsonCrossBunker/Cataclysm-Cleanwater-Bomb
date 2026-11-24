local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_UICA_VEHICLE_MERCHANT",
    name = ccb.content.text("garage clerk"),
    job_description = ccb.content.text("Vehicle Garage Clerk"),
    common = false,
    traits = {
        { trait = "BKGR_EARTH" },
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_UICA_GROUND_ENGINEER_worn",
    carry = "NC_UICA_GROUND_ENGINEER_carry",
    weapon = "EMPTY_GROUP",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "fabrication", bonus = { rng = { 4, 6 } } },
        { skill = "electronics", bonus = { rng = { 4, 6 } } },
        { skill = "mechanics", bonus = { rng = { 4, 6 } } },
    },
    shop_groups = {
        { id = "afs_vehicle_merchant", rigid = true },
        { id = "augustmoon_shop_money", rigid = true },
    },
    price_rules = {
        { group = "afs_vehicle_merchant", markup = 80, condition_handler = "uica_other_customer" },
        { group = "afs_vehicle_merchant", markup = 65, condition_handler = "uica_earth_customer" },
        { group = "afs_vehicle_merchant_fuel", markup = 2.5, condition_handler = "uica_other_customer" },
        { group = "afs_vehicle_merchant_fuel", markup = 1.75, condition_handler = "uica_earth_customer" },
    },
}

ccb.content.define_npc {
    id = "uica_vehicle_merchant",
    unique_name = ccb.content.text("Artemis Burton"),
    suffix = ccb.content.text("garage clerk"),
    gender = "male",
    class = "NC_UICA_VEHICLE_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_UICA_VEHICLE_MERCHANT",
    faction = "UICA",
}
