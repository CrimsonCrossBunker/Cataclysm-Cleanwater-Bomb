local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_VARS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a u_add_var test response."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "test_var_test_test", "beer") },
            when = predicates.negate(predicates.any_equal({ "beer", { scope = "speaker", key = "test_var_test_test" } })),
        },
        {
            text = ccb.content.text("This is an npc_add_var test response."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "test_var_test_test", "reeb") },
            when = predicates.negate(predicates.any_equal({ "beer", { scope = "speaker", key = "test_var_test_test" } })),
        },
        {
            text = ccb.content.text("This is a compare_string, u_remove_var test response."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "beer", { scope = "speaker", key = "test_var_test_test" } }),
            actions = { actions.clear_actor_value("speaker", "test_var_test_test") },
        },
        {
            text = ccb.content.text("This is a compare_string, npc_remove_var test response."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "reeb", { scope = "interlocutor", key = "test_var_test_test" } }),
            actions = { actions.clear_actor_value("interlocutor", "test_var_test_test") },
        },
    },
}
