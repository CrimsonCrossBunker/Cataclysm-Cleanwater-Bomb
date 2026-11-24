local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_AUGUSTMOON_TOOL_TRADER",
    name = ccb.content.text("gadget store clerk"),
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
    shop_groups = { { id = "afs_augustmoon_tool_trader", rigid = true } },
    price_rules = {
        { group = "afs_augustmoon_batteries_disposable", markup = 10 },
        { group = "afs_augustmoon_batteries_rechargeable", markup = 20 },
        { group = "afs_augustmoon_tools_premium", markup = 3 },
    },
}

ccb.content.define_npc {
    id = "augustmoon_tool_trader",
    suffix = ccb.content.text("gadget store clerk"),
    class = "NC_AUGUSTMOON_TOOL_TRADER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_AUGUSTMOON_TOOL_TRADER",
    faction = "UICA",
}

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_TOOL_TRADER" },
    line = ccb.content.text("&The store is full of high tech gadgets, both new and salvaged.  The clerk behind the counter looks up as you enter, and gives you a nod."),
    replies = {
        {
            text = ccb.content.text("I want to buy some gear."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}
