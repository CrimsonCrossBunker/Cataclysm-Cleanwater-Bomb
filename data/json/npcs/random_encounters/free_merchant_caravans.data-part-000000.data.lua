local ccb = require("ccb")

-- Random NPC, non persistent, can direct you to the free merchants and sell you things.
ccb.content.define_npc {
    id = "FM_caravan_merchant_random",
    suffix = ccb.content.text("Caravan Merchant"),
    class = "NC_CARAVAN_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_CARAVAN_MERCHANT_1",
    faction = "free_merchants",
}

-- Random NPC, non persistent, tells you about being a guard and directs you to free merchants.
ccb.content.define_npc {
    id = "FM_caravan_guard_A",
    suffix = ccb.content.text("Caravan Guard"),
    class = "NC_CARAVAN_GUARD",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_CARAVAN_GUARD_A1",
    faction = "free_merchants",
}

-- Random NPC, non persistent, doesn't have much to say.
ccb.content.define_npc {
    id = "FM_caravan_guard_B",
    suffix = ccb.content.text("Caravan Guard"),
    class = "NC_CARAVAN_GUARD",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_CARAVAN_GUARD_B",
    faction = "free_merchants",
}

ccb.content.define_npc_class {
    id = "NC_CARAVAN_MERCHANT",
    name = ccb.content.text("Trader"),
    job_description = ccb.content.text("I'm collecting gear and selling it."),
    common = false,
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
}

ccb.content.define_npc_class {
    id = "NC_CARAVAN_GUARD",
    name = ccb.content.text("Bounty Hunter"),
    job_description = ccb.content.text("I'm a killer for hire."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
}
