local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_AUGUSTMOON_GENETECH_TRADER",
    name = ccb.content.text("Mercurial augmentation tech."),
    job_description = ccb.content.text("Outfitter Clerk"),
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
    worn = "NC_AUGUSTMOON_TOOL_TRADER_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    skills = { { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } } },
    shop_groups = { { id = "afs_augustmoon_genetech_trader", rigid = true } },
    price_rules = { { group = "afs_augustmoon_genetech_trader", markup = 1.1 } },
}

ccb.content.define_npc {
    id = "augustmoon_mercurial_clerk",
    suffix = ccb.content.text("Mercurial augmentation tech."),
    class = "NC_AUGUSTMOON_GENETECH_TRADER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_AUGUSTMOON_GENETECH_TRADER",
    faction = "mercurial",
}
