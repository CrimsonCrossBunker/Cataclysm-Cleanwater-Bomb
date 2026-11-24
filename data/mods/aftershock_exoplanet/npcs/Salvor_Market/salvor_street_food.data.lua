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

ccb.content.define_dialogue_topic {
    id = { "NC_SALVOR_STREET_FOOD", "NC_SALVOR_STREET_FOOD_SAFE" },
    line = ccb.content.text("&The food stall is a colorful array of various dishes, and the smell of spices and cooked meats cuts easily through the frozen air.  The vendor  is busy preparing a meal when you approach.\n\"Oh steemd do you see anything you like?\""),
    replies = {
        {
            text = ccb.content.text("I'll have whatever it is you're cooking."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Are these things safe to eat?"),
            next_topic = "NC_SALVOR_STREET_FOOD_SAFE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_SALVOR_STREET_FOOD_SAFE" },
    line = ccb.content.text("&The vendor chuckles at your question, wiping his hands on his apron.\n\"Safe?  Yes, very safe steemd, snow dry and clean steemd.  In home we do not have so much snow, but here it is very good for food.\""),
}
