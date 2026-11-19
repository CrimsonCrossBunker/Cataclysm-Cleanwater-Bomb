local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_SALVOR_FABRICATOR",
    name = ccb.content.text("salvor fabricator"),
    job_description = ccb.content.text("Salvor Fabricator"),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { trait = "RETURN_TO_START_POS" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 2, 3 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 1, 3 } },
    worn = "NC_SALVOR_FABRICATOR_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 4, 6 } } },
        { skill = "survival", bonus = { rng = { 4, 6 } } },
        { skill = "fabrication", bonus = { rng = { 6, 8 } } },
        { skill = "electronics", bonus = { rng = { 4, 6 } } },
        { skill = "mechanics", bonus = { rng = { 1, 3 } } },
    },
    shop_groups = { { id = "afs_salvor_fabricator_trade", rigid = true } },
    price_rules = {
        { group = "afs_augustmoon_batteries_disposable", markup = 10 },
        { group = "afs_augustmoon_batteries_rechargeable", markup = 20 },
        { group = "afs_salvor_fabricator_tools", markup = 80 },
        { group = "afs_salvor_fabricator_scraps", markup = 3 },
        { group = "afs_salvor_fabricator_tools_aftershock", markup = 3 },
        { group = "afs_salvor_fabricator_combat_gear", markup = 3 },
    },
}

ccb.content.define_npc {
    id = "salvor_fabricator",
    unique_name = ccb.content.text("Veronica Donaldson"),
    suffix = ccb.content.text("salvor fabricator"),
    gender = "female",
    age = 62,
    height = 182,
    class = "NC_SALVOR_FABRICATOR",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SALVOR_FABRICATOR",
    faction = "UICA",
}
