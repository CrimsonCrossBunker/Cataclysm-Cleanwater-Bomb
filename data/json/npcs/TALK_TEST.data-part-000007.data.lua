local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_ITEM_WIELDED",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a u_has_wielded_with_weapon_category LONG_SWORDS test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5a2e2bb9902f"),
        },
        {
            text = ccb.content.text("This is a u_has_wielded_with_weapon_category KNIVES test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_79acc4f3a7ea"),
        },
    },
}
