local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_SALVOR_RIPPER",
    name = ccb.content.text("ripper"),
    job_description = ccb.content.text("A salvor who trades salvaged software and data."),
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
    worn = "NC_SALVOR_RIPPER_worn",
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
    shop_groups = {
        { id = "afs_salvor_ripper_software", rigid = true },
        { id = "afs_salvor_ripper_computers", rigid = true },
    },
    price_rules = {
        { group = "afs_augustmoon_batteries_disposable", markup = 10 },
        { group = "afs_augustmoon_batteries_rechargeable", markup = 20 },
        { group = "afs_salvor_ripper_software", price = 5000 },
        { group = "afs_salvor_ripper_computers", markup = 3 },
        { group = "generated_ruin_data", premium = 2 },
    },
}

ccb.content.define_npc {
    id = "salvor_ripper",
    unique_name = ccb.content.text("Raxell"),
    suffix = ccb.content.text("ripper"),
    gender = "male",
    age = 28,
    height = 182,
    class = "NC_SALVOR_RIPPER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SALVOR_RIPPER",
    faction = "independents",
}
