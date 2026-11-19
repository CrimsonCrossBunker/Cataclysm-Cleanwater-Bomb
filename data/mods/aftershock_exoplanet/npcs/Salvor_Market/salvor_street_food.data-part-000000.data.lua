local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_SALVOR_STREET_FOOD",
    name = ccb.content.text("hawker"),
    job_description = ccb.content.text("A vendor selling street food."),
    common = false,
    traits = {
        { group = "NPC_starting_traits" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 2, 3 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 1, 3 } },
    worn = "NC_SALVOR_STREET_FOOD_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    skills = {
        { skill = "speech", bonus = { rng = { 4, 5 } } },
        { skill = "survival", bonus = { rng = { 2, 6 } } },
        { skill = "cooking", bonus = { rng = { 3, 5 } } },
    },
    restock_interval = "15 seconds",
    shop_groups = {
        { id = "afs_street_vendor_food", rigid = true },
        { id = "afs_street_dry_food", rigid = true },
    },
    price_rules = {
        { group = "afs_street_vendor_food", markup = 4 },
        { group = "afs_street_dry_food", markup = 10 },
    },
}

ccb.content.define_npc {
    id = "salvor_street_food",
    unique_name = ccb.content.text("Trés Landwell"),
    suffix = ccb.content.text("hawker"),
    gender = "male",
    age = 39,
    height = 160,
    class = "NC_SALVOR_STREET_FOOD",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "NC_SALVOR_STREET_FOOD",
    faction = "UICA",
}
