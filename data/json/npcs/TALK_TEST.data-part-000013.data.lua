local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
