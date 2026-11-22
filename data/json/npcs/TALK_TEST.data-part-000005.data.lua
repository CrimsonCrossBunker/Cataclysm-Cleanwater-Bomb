local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SWITCH",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a switch 1 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f27c7fa135d4"),
            switch = true,
        },
        {
            text = ccb.content.text("This is a switch 2 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_62effbaca8e0"),
            switch = true,
        },
        {
            text = ccb.content.text("This is a switch default 1 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_46e65cabf8d0"),
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("This is a switch default 2 test response."),
            next_topic = "TALK_DONE",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("This is another basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_OR",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is an or trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_761103366401"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_AND",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is an and cash, available, trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_bab18533190c"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NESTED",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a complex nested test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5748f934bde7"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_TRUE_FALSE_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a true/false true response."),
            false_text = ccb.content.text("This is a true/false false response."),
            text_when = predicates.handler("dlg_p_dda_f27c7fa135d4"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a conditional trial response."),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_f27c7fa135d4") },
            success = { next_topic = "TALK_TEST_TRUE_CONDITION_NEXT" },
            failure = { next_topic = "TALK_TEST_FALSE_CONDITION_NEXT" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_EFFECTS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a u_add_effect - infection response"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "infection", { turns = 10 }) },
        },
        {
            text = ccb.content.text("This is an npc_add_effect - infection response"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("interlocutor", "infection", { permanent = true }) },
        },
        {
            text = ccb.content.text("This is a u_lose_effect - infection response"),
            next_topic = "TALK_DONE",
            actions = { actions.remove_effects("speaker", { "infection" }) },
        },
        {
            text = ccb.content.text("This is an npc_lose_effect - infection response"),
            next_topic = "TALK_DONE",
            actions = { actions.remove_effects("interlocutor", { "infection" }) },
        },
        {
            text = ccb.content.text("This is a u_add_trait - FED MARSHALL response"),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("speaker", "PROF_FED") },
        },
        {
            text = ccb.content.text("This is an npc_add_trait - FED MARSHALL response"),
            next_topic = "TALK_DONE",
            actions = { actions.replace_mutation("interlocutor", "PROF_FED") },
        },
        {
            text = ccb.content.text("This is a u_lose_trait - FED MARSHALL response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_81754e5a66d5") },
        },
        {
            text = ccb.content.text("This is an npc_lose_trait - FED MARSHALL response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_50d73d468457") },
        },
        {
            text = ccb.content.text("This is a u_buy_item bottle of beer response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_3ffe591790ad") },
        },
        {
            text = ccb.content.text("This is a u_spawn_item plastic bottle response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_c17bb5b48c99") },
        },
        {
            text = ccb.content.text("This is a u_spend_cash response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_2a7fd01d93e5") },
        },
        {
            text = ccb.content.text("This is a multi-effect response"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "infected", { turns = 10 }), actions.add_effect("interlocutor", "infected", { permanent = true }), actions.replace_mutation("speaker", "PROF_SWAT"), actions.replace_mutation("interlocutor", "PROF_SWAT"), actions.handler("dlg_a_dda_5b6b079d9623"), "hostile" },
        },
        {
            text = ccb.content.text("This is an opinion response"),
            next_topic = "TALK_DONE",
            opinion = { trust = 10, fear = 11, value = 12, anger = 13, owed = 14 },
        },
        {
            text = ccb.content.text("This is a u_sell_item plastic bottle response"),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("bottle_plastic"), actions.transfer_items("beer", 2) },
        },
        {
            text = ccb.content.text("This is an npc_consume_item beer response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_61f5fdbd8492") },
        },
        {
            text = ccb.content.text("This is a u_spawn_item beer response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_35a16c3a35d1") },
        },
        {
            text = ccb.content.text("This is a u_consume_item beer response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_9f653c35ee47") },
        },
        {
            text = ccb.content.text("This is an npc_class_change response"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_6ec52d7e8a4b") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_HAS_ITEM",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a u_has_item beer test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "beer"),
        },
        {
            text = ccb.content.text("This is a u_has_item bottle_glass test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "bottle_glass"),
        },
        {
            text = ccb.content.text("This is a u_has_items beer test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "beer", 2),
        },
        {
            text = ccb.content.text("Test failure!  This is a u_has_items test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "bottle_glass", 2),
        },
        {
            text = ccb.content.text("This is a u_has_item_category manuals test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c34f43472834"),
        },
        {
            text = ccb.content.text("This is a u_has_item_category manuals count 2 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_2097f4abd0ce"),
        },
        {
            text = ccb.content.text("Failure!  This is a u_has_item_category manuals count 3 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_acda17fe95ce"),
        },
    },
    repeat_replies = {
        {
            items = { "manual_speech" },
            reply = {
                text = ccb.content.text("This is a repeated item manual_speech test response"),
                next_topic = "TALK_DONE",
            },
        },
    },
}
