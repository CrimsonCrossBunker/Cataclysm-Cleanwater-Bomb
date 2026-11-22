local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_TOPIC_ITEM_MUTATOR_2",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_ba7d9970962a") },
        },
    },
}

ccb.content.define_npc_class {
    id = "test_shop_class",
    name = ccb.content.text("Test NPC class"),
    job_description = ccb.content.text("Participating in unit tests."),
    common = false,
    strength = { rng = { -4, 0 } },
    dexterity = { rng = { -2, 0 } },
    intelligence = { rng = { 1, 5 } },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
    },
    shop_groups = {
        { id = "test_npc_belt" },
        { id = "test_npc_eyes", trust = 10 },
        { id = "test_npc_hat", trust = 40, strict = true },
    },
}

-- NPC in unit tests
ccb.content.define_npc {
    id = "test_shopkeep",
    suffix = ccb.content.text("Tester"),
    class = "test_shop_class",
    attitude = 1,
    mission = "NULL",
    chat = "TALK_TEST_FACTION_TRUST",
    faction = "free_merchants",
}

-- NPC in unit tests
ccb.content.define_npc {
    id = "test_talker",
    suffix = ccb.content.text("Tester"),
    class = "NC_DOCTOR",
    attitude = 1,
    mission = "NULL",
    chat = "TALK_TEST_START",
    faction = "tacoma_commune",
    friend_guard_chat = "TALK_TEST_GUARD",
}
