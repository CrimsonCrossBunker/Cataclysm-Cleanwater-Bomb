local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_START",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = { { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_FAIL_RESPONSE",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("Never See this."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            failure_topic = "TALK_TEST_START",
            failure_explanation = ccb.content.text("Impossible Test"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SIMPLE_STATS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a strength test response."),
            next_topic = "TALK_DONE",
            when = predicates.minimum_attribute("speaker", "strength", 7),
        },
        {
            text = ccb.content.text("This is a dexterity test response."),
            next_topic = "TALK_DONE",
            when = predicates.minimum_attribute("speaker", "dexterity", 7),
        },
        {
            text = ccb.content.text("This is an intelligence test response."),
            next_topic = "TALK_DONE",
            when = predicates.minimum_attribute("speaker", "intelligence", 7),
        },
        {
            text = ccb.content.text("This is a perception test response."),
            next_topic = "TALK_DONE",
            when = predicates.minimum_attribute("speaker", "perception", 7),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NEGATED_STATS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a low strength test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.minimum_attribute("speaker", "strength", 7)),
        },
        {
            text = ccb.content.text("This is a low dexterity test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.minimum_attribute("speaker", "dexterity", 7)),
        },
        {
            text = ccb.content.text("This is a low intelligence test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.minimum_attribute("speaker", "intelligence", 7)),
        },
        {
            text = ccb.content.text("This is a low perception test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.minimum_attribute("speaker", "perception", 7)),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_WEARING_AND_TRAIT",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }),
        },
        {
            text = ccb.content.text("This is a short trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "ELFA_EARS"),
        },
        {
            text = ccb.content.text("This is a wearing test response."),
            next_topic = "TALK_DONE",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("This is an NPC trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("interlocutor", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }),
        },
        {
            text = ccb.content.text("This is an NPC short trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "ELFA_EARS"),
        },
        {
            text = ccb.content.text("This is a trait flags test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_flag("speaker", "PSYCHOPATH"),
        },
        {
            text = ccb.content.text("This is an NPC trait flags test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_flag("interlocutor", "SAPIOVORE"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_EFFECT",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is an NPC effect test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("interlocutor", "gave_quest_item"),
        },
        {
            text = ccb.content.text("This is a player effect test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("speaker", "gave_quest_item"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SERVICE",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a cash test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f27c7fa135d4"),
        },
        {
            text = ccb.content.text("This is an NPC service test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_87ccf0c55585"),
        },
        {
            text = ccb.content.text("This is an NPC available test response."),
            next_topic = "TALK_DONE",
            when = predicates.actor_state("interlocutor", "available"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_LOCATION",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a om_location_field test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_7efddb1bb928"),
        },
        {
            text = ccb.content.text("This is a faction camp any test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_1dd60607d899"),
        },
        {
            text = ccb.content.text("This is a om_location_field direction variant response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_984ab760e381"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_ROLE",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a nearby role test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_7413844009f7"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_CLASS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a class test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_48323e72abf5"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_ALLIES",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is an NPC allies 1 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_430389987a1c"),
        },
        {
            text = ccb.content.text("This an error!  npc allies 2 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c64ba9d1f4e7"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_RULES",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is an NPC engagement rule test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e858505b4f4f"),
        },
        {
            text = ccb.content.text("This is an NPC aim rule test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_3053cf449896"),
        },
        {
            text = ccb.content.text("This is an NPC rule test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_7464481c8b48"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_NEEDS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is an NPC thirst test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_116846416c99"),
        },
        {
            text = ccb.content.text("This is an NPC hunger test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b661ecaa4a50"),
        },
        {
            text = ccb.content.text("This is an NPC sleepiness test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_db3bbd60cd2c"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_MISSION_GOAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a mission goal test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_1236053a2f9b"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SEASON",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a season spring test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d7c0a82ef9e4"),
        },
        {
            text = ccb.content.text("This is a days since Cataclysm 30 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_37c4c4e2de83"),
        },
        {
            text = ccb.content.text("This is a season summer test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e13e38001d0d"),
        },
        {
            text = ccb.content.text("This is a days since Cataclysm 120 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_1a1ea07b65c8"),
        },
        {
            text = ccb.content.text("This is a season autumn test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c76eb4551f41"),
        },
        {
            text = ccb.content.text("This is a days since Cataclysm 210 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0cab2db62407"),
        },
        {
            text = ccb.content.text("This is a season winter test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0b5c98d989be"),
        },
        {
            text = ccb.content.text("This is a days since Cataclysm 300 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_8ed8637b0254"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_TIME",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a is day test response."),
            next_topic = "TALK_DONE",
            when = predicates.conversation_state("daylight"),
        },
        {
            text = ccb.content.text("This is a is night test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.conversation_state("daylight")),
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_ITEM_REPEAT",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = { { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" } },
    repeat_replies = {
        {
            items = { "beer", "bottle_glass" },
            reply = {
                text = ccb.content.text("This is a repeated item beer, bottle_glass test response"),
                next_topic = "TALK_DONE",
            },
        },
        {
            categories = { "manuals" },
            reply = {
                text = ccb.content.text("This is a repeated category manuals test response"),
                next_topic = "TALK_DONE",
            },
        },
        {
            categories = { "manuals", "food" },
            reply = {
                text = ccb.content.text("This is a repeated category manuals, food test response"),
                next_topic = "TALK_DONE",
            },
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_VARS_TIME",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a u_add_var time test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_39c984351a3f"),
            actions = { actions.handler("dlg_a_dda_0800348406d2") },
        },
        {
            text = ccb.content.text("This is an npc_add_var time test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_39c984351a3f"),
            actions = { actions.handler("dlg_a_dda_251811359f38") },
        },
        {
            text = ccb.content.text("This is a u_compare_var time test response for > 3_days."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_2cf14bc9b169"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_BIONICS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a u_has_bionics bio_ads test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_47d2b82345f3"),
        },
        {
            text = ccb.content.text("Failure!  This is an npc_has_bionics bio_ads test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_02144db8685d"),
        },
        {
            text = ccb.content.text("This is an npc_has_bionics ANY response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_40cd89da0fd5"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_SIMPLE",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_a80805708528") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_SIMPLE_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { when = predicates.handler("dlg_p_dda_6b4f20e24d78"), actions = { actions.handler("dlg_a_dda_6f2ec01fa962") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_SENTINEL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { once = "spend500", actions = { actions.handler("dlg_a_dda_aa997daca7f5") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_SENTINEL_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { when = predicates.handler("dlg_p_dda_da708d01c100"), once = "spend500", actions = { actions.handler("dlg_a_dda_235092572aa0") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_COMPOUND",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_592da6fe3d02") } },
        { actions = { actions.handler("dlg_a_dda_86691d1371f8") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_COMPOUND_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { when = predicates.handler("dlg_p_dda_4d28545eb132"), actions = { actions.handler("dlg_a_dda_d43155ec8917") } },
        { when = predicates.handler("dlg_p_dda_da708d01c100"), actions = { actions.handler("dlg_a_dda_df5564bf69d7") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_COMPOUND_SENTINEL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { once = "spend250", actions = { actions.handler("dlg_a_dda_be9ba3691f85") } },
        { actions = { actions.handler("dlg_a_dda_05ace2c4f108") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_COMPOUND_SENTINEL_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { when = predicates.handler("dlg_p_dda_da708d01c100"), once = "spend250", actions = { actions.handler("dlg_a_dda_398033f945ab") } },
        { when = predicates.handler("dlg_p_dda_da708d01c100"), once = "spend500", actions = { actions.handler("dlg_a_dda_e027d7a1d297") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_MAPGEN",
    line = {
        choices = {
            ccb.content.text("This is an example of mapgen_update effect variations"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Please test some simple remote mapgen"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_61bf0c87d3ec") },
        },
        {
            text = ccb.content.text("Please test mapgen_update multiples"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_d0e782f9bda5") },
        },
        {
            text = ccb.content.text("Please test mapgen_update linked"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_a474cd6dbb19") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SIMPLE_SKILLS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a driving test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_6403ff9d30c2"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NEGATED_SKILLS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a low driving test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d0df4f6aff30"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SET_TOPIC",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is an npc_first_topic test response."),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("TALK_TEST_SET_TOPIC") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_COMPARE_INT_OP",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("Two = five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_ce4c1dc2145d"),
        },
        {
            text = ccb.content.text("Two == five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_ce4c1dc2145d"),
        },
        {
            text = ccb.content.text("Two != five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_bb158f4d9754"),
        },
        {
            text = ccb.content.text("Two <= five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c1731e2fa3b9"),
        },
        {
            text = ccb.content.text("Two >= five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_24a5044163c9"),
        },
        {
            text = ccb.content.text("Two < five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f4b958fc8ef3"),
        },
        {
            text = ccb.content.text("Two > five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_6288704ce042"),
        },
        {
            text = ccb.content.text("Five = five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_22605a00be9f"),
        },
        {
            text = ccb.content.text("Five == five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_22605a00be9f"),
        },
        {
            text = ccb.content.text("Five != five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_77c226e13c5a"),
        },
        {
            text = ccb.content.text("Five <= five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_37248ea12a17"),
        },
        {
            text = ccb.content.text("Five >= five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5399cdd1bdb2"),
        },
        {
            text = ccb.content.text("Five < five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_fb3111db504f"),
        },
        {
            text = ccb.content.text("Five > five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_041ace24eff5"),
        },
        {
            text = ccb.content.text("Five = two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_2ad236a7138a"),
        },
        {
            text = ccb.content.text("Five == two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_2ad236a7138a"),
        },
        {
            text = ccb.content.text("Five != two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e36c8ed15a11"),
        },
        {
            text = ccb.content.text("Five <= two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_ac70001677cd"),
        },
        {
            text = ccb.content.text("Five >= two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c8d1256a1445"),
        },
        {
            text = ccb.content.text("Five < two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e83c8a5dc991"),
        },
        {
            text = ccb.content.text("Five > two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f1643b5e2873"),
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_COMPARE_INT",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a math test response that increments by 1."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_48b645e592e5") },
        },
        {
            text = ccb.content.text("This is a math test response that increments by 2."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_a1814a6695f8") },
        },
        {
            text = ccb.content.text("This is a u_add_var time test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_1c58771228a9"),
            actions = { actions.handler("w16b_a_dda_2894c75d3664") },
        },
        {
            text = ccb.content.text("PC strength is five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_ea5bf90cef0b"),
        },
        {
            text = ccb.content.text("PC dexterity is six."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_6fea91d5bb4d"),
        },
        {
            text = ccb.content.text("PC intelligence is seven."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_43e22f7e9eae"),
        },
        {
            text = ccb.content.text("PC perception is eight."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_a08e07d0fdc4"),
        },
        {
            text = ccb.content.text("NPC strength is nine."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_b42a5c8ace2d"),
        },
        {
            text = ccb.content.text("NPC dexterity is ten."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_3a23bb33cc46"),
        },
        {
            text = ccb.content.text("NPC intelligence is eleven."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_e23e09fa3832"),
        },
        {
            text = ccb.content.text("NPC perception is twelve."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_22ead6136828"),
        },
        {
            text = ccb.content.text("PC Custom var is one."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_802fe4499a68"),
        },
        {
            text = ccb.content.text("NPC Custom var is two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_996003377408"),
        },
        {
            text = ccb.content.text("This is a u_var time test response for > 3_days."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_731030200866"),
        },
        {
            text = ccb.content.text("time_since_cataclysm > 3_days."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_a5d0be804693"),
        },
        {
            text = ccb.content.text("time_since_cataclysm in days > 3"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_97a897240b77"),
        },
        {
            text = ccb.content.text("This is a time since u_var test response for > 3_days."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_dacccbaaba96"),
        },
        {
            text = ccb.content.text("Allies equals 1"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_d6a4df3bce6d"),
        },
        {
            text = ccb.content.text("Cash equals 13"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_ea38d9832630"),
        },
        {
            text = ccb.content.text("Owed amount equals 14"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_2b1254eb4fba"),
        },
        {
            text = ccb.content.text("Driving skill more than or equal to 5"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_cb4aa6b41926"),
        },
        {
            text = ccb.content.text("Temperature is 21."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_2563f67083af"),
        },
        {
            text = ccb.content.text("Windpower is 15."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_8ce79186006d"),
        },
        {
            text = ccb.content.text("Humidity is 16."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_62fb6ceaf359"),
        },
        {
            text = ccb.content.text("Pressure is 17."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_f59862852067"),
        },
        {
            text = ccb.content.text("Pos_x is -1."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_95289e55d756"),
        },
        {
            text = ccb.content.text("Pos_y is -2."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_27758327e663"),
        },
        {
            text = ccb.content.text("Pos_z is -3."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_8dfc2fdf3dfd"),
        },
        {
            text = ccb.content.text("Pain level is 21."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_a04859da77d7"),
        },
        {
            text = ccb.content.text("Bionic power is 22."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_a2c57ec76b37"),
        },
        {
            text = ccb.content.text("Bionic power max is 44."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_88a96a2e8c2c"),
        },
        {
            text = ccb.content.text("Bionic power is at 50%."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_f209a481c625"),
        },
        {
            text = ccb.content.text("Morale is 23."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_688b0787b602"),
        },
        {
            text = ccb.content.text("Focus is 24."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_436f11a7f423"),
        },
        {
            text = ccb.content.text("Mana is 25."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_416c48f74e8b"),
        },
        {
            text = ccb.content.text("Mana max is 900."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_732f5d5dda9a"),
        },
        {
            text = ccb.content.text("Mana is at 2%."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_46a1e9e55a4d"),
        },
        {
            text = ccb.content.text("Hunger is 26."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_735386b579a6"),
        },
        {
            text = ccb.content.text("Thirst is 27."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_cb3105d35e85"),
        },
        {
            text = ccb.content.text("Stored kcal is 118'169."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_4441a42133a8"),
        },
        {
            text = ccb.content.text("Has 3 glass bottles."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_16e4aaba5202"),
        },
        {
            text = ccb.content.text("Has more or equal to 35 experience."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_7ef5417321f1"),
        },
        {
            text = ccb.content.text("Highest spell level in school test_trait is 1."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_1435fe7e1b0b"),
        },
        {
            text = ccb.content.text("Spell level of Pew, Pew is 4."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_8b9b62c0ddf5"),
        },
        {
            text = ccb.content.text("Spell level of highest spell is 12."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_e8aa589e96a3"),
        },
        {
            text = ccb.content.text("Exp of Pew, Pew is -1."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_2b2853b944ac"),
        },
        {
            text = ccb.content.text("Exp of Pew, Pew is 11006."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_fdb201c824ef"),
        },
        {
            text = ccb.content.text("Test Proficiency learning is 50% out of 100%."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_5f16cecb862b"),
        },
        {
            text = ccb.content.text("Test Proficiency learning done is 12 hours total."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_8bf1238481f0"),
        },
        {
            text = ccb.content.text("Test Proficiency learning is 50% learnt."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_5f16cecb862b"),
        },
        {
            text = ccb.content.text("Test Proficiency learning is 500 permille learnt."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_6c23c0fa4fb9"),
        },
        {
            text = ccb.content.text("Test Proficiency total learning time is 24 hours."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_862d6e58552b"),
        },
        {
            text = ccb.content.text("Test Proficiency time lest to learn is 12h."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_d2df3b5af968"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_ARITHMETIC",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("Sets time since cataclysm to 1."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_d1b62e3589c1") },
        },
        {
            text = ccb.content.text("Sets temperature to 2."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_0a83d28d6f7b") },
        },
        {
            text = ccb.content.text("Sets windpower to 3."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_845b8147c0bb") },
        },
        {
            text = ccb.content.text("Sets humidity to 4."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_4902b8ddc893") },
        },
        {
            text = ccb.content.text("Sets pressure to 5."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_623880eb6250") },
        },
        {
            text = ccb.content.text("Sets base strength to 6."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_207fb41f2b18") },
        },
        {
            text = ccb.content.text("Sets base dexterity to 7."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_b4c9a0a7674c") },
        },
        {
            text = ccb.content.text("Sets base intelligence to 8."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_5aa773b4f295") },
        },
        {
            text = ccb.content.text("Sets base perception to 9."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_e7347f90de1f") },
        },
        {
            text = ccb.content.text("Sets custom var to 10."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_c1e2b4e0ad3c") },
        },
        {
            text = ccb.content.text("Sets owed to 12."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_0670d453bcdc") },
        },
        {
            text = ccb.content.text("Sets skill level in driving to 10."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_d4b4d11c521c") },
        },
        {
            text = ccb.content.text("Moves character one tile to the west."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_e2904fa1c74d") },
        },
        {
            text = ccb.content.text("Moves character two tiles to the south."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_bb4395a11939") },
        },
        {
            text = ccb.content.text("Sets character z level to -3."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_120d234f7206") },
        },
        {
            text = ccb.content.text("Sets pain to 17."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_df8e5d0d7318") },
        },
        {
            text = ccb.content.text("Sets power to 18."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_65d858935d6c") },
        },
        {
            text = ccb.content.text("Sets power to 20%."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_d3af9b5c9cbc") },
        },
        {
            text = ccb.content.text("Sets focus to 19."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_13c496b2fe31") },
        },
        {
            text = ccb.content.text("Sets mana to 21."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_5d09447434f1") },
        },
        {
            text = ccb.content.text("Sets mana to 25%."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_a0cda0deda0a") },
        },
        {
            text = ccb.content.text("Sets thirst to 22."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_6b06b9425874") },
        },
        {
            text = ccb.content.text("Sets calories to 23."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_84c70d28f09e") },
        },
        {
            text = ccb.content.text("Sets pew pew's level to -1."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_cb127a1d7bb8") },
        },
        {
            text = ccb.content.text("Sets pew pew's level to 4."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_5f2e824e1b69") },
        },
        {
            text = ccb.content.text("Sets pew pew's exp to -1."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_573593b7ac2b") },
        },
        {
            text = ccb.content.text("Sets pew pew's exp to 11006."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_b98cfb2839e4") },
        },
        {
            text = ccb.content.text("Sets Test Proficiency learning done to 12 hours total."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_55a47adcb2f3") },
        },
        {
            text = ccb.content.text("Sets Test Proficiency learning done to -1."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_ebeafd012f70") },
        },
        {
            text = ccb.content.text("Sets Test Proficiency learning done to 24h."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_5be3277e80d1") },
        },
        {
            text = ccb.content.text("Learns Test Proficiency for 1h"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_1027aa3dacc5") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_FACTION_TRUST",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Faction trust is at least 20."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_de8f08751c84"),
        },
        {
            text = ccb.content.text("Add 50 to faction trust."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(50) },
        },
        {
            text = ccb.content.text("Start trade."),
            next_topic = "TALK_DONE",
            actions = { "start_trade" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_META",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Mod TESTING DATA is loaded."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_dea9207e769e"),
        },
        {
            text = ccb.content.text("Mod Innawood is loaded."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_0997d9a9b6c0"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_TOPIC_ITEM_MUTATOR",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = { { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" } },
    repeat_replies = {
        {
            items = { "bottle_glass" },
            reply = {
                text = ccb.content.text("This is a repeated item bottle_glass test response"),
                next_topic = "TALK_TEST_TOPIC_ITEM_MUTATOR_2",
            },
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = { "TALK_TEST_GUARD" },
    replies = {
        {
            text = ccb.content.text("I have a custom response to a common topic"),
            next_topic = "TALK_TEST_FACTION_TRUST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_ALWAYS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should see this response but not be able to select it (except in debug mode)."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_always = true,
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_ALWAYS3",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should always see this response and be able to select it."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_570f78b53fd8"),
            show_always = true,
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_ALWAYS2",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should see this response but not be able to select it (except in debug mode) because"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_always = true,
            show_reason = "zero isn't greater than one.",
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_CONDITION",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should see this response but not be able to select it (except in debug mode) because"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_when = predicates.handler("dlg_p_dda_570f78b53fd8"),
            show_reason = "zero isn't greater than one.",
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_CONDITION2",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should not see this response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_reason = "zero isn't greater than one.",
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_RANDOM",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You will see this response half of the time."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_92305705c4d3"),
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}
