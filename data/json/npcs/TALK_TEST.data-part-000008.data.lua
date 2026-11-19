local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_TAGS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("Avatar tag is set to <u_val:test_var>."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("NPC tag is set to <npc_val:test_var>."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Global tag is set to <global_val:test_var>."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Item name is <item_name:test_rock>."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Item description is <item_description:test_rock>"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Trait name is <trait_name:TEST_ENCH_MUTATION>."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Trait description is <trait_description:TEST_ENCH_MUTATION>"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Context tag is set to <context_val:test_var>."),
            next_topic = "TALK_DONE",
        },
    },
}
