local ccb = require("ccb")

ccb.content.define_npc {
    id = "NPC_lumbermill_logger",
    class = "NC_LUMBERJACK",
    suffix = ccb.content.text("logger"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_NPC_LUMBERMILL_LOGGER",
    faction = "wasteland_scavengers",
}

ccb.content.define_npc {
    id = "NPC_lumbermill_merchant",
    class = "NC_LUMBERJACK_MERCHANT",
    suffix = ccb.content.text("manager"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_NPC_LUMBERMILL_MERCHANT",
    faction = "wasteland_scavengers",
    missions_offered = "MISSION_GET_DRIVEBELTS",
}

ccb.content.define_npc_class {
    id = "NC_LUMBERJACK",
    name = ccb.content.text("Lumberjack"),
    common = false,
    job_description = ccb.content.text("I felled trees before the apocalypse.  Zombies shouldn't be as tough."),
    traits = {
        { group = "BG_survival_story_LUMBERMILL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "GETS_RANDOM_MISSION_NOMOVE" },
    },
    worn = "NC_LUMBERJACK_worn",
    weapon = "NC_LUMBERJACK_tools",
    strength = { rng = { 1, 2 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 0, 2 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "cutting", bonus = { rng = { 1, 2 } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_LUMBERJACK_MERCHANT",
    name = ccb.content.text("Lumberjack"),
    job_description = ccb.content.text("I felled trees before the apocalypse.  Zombies shouldn't be as tough."),
    traits = {
        { group = "BG_survival_story_LUMBERMILL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    worn = "NC_LUMBERJACK_worn",
    weapon = "NC_LUMBERJACK_tools",
    strength = { rng = { 1, 2 } },
    common = false,
    sells_belongings = false,
    restock_interval = "1 day",
    shop_groups = { { id = "LUMBERMILL_MERCHANT_trade", rigid = true } },
    blacklist = "LUMBERMILL_MERCHANT_blacklist",
    price_rules = {
        { item = "2x4", price = 100 },
        { item = "plank_short", price = 70 },
        { item = "plank_long", price = 150 },
        { item = "wooden_post", price = 100 },
        { item = "wooden_post_short", price = 70 },
        { item = "wooden_post_long", price = 150 },
        { item = "wood_panel", price = 800 },
        { item = "wood_sheet", price = 1600 },
        { item = "wood_beam", price = 2500 },
        { item = "log", price = 500 },
        { item = "long_pole", price = 250 },
        { item = "wood_block", price = 5 },
        { item = "stick_long", price = 3 },
        { item = "stick", price = 2 },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 0, 2 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "cutting", bonus = { rng = { 1, 2 } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
    },
}
