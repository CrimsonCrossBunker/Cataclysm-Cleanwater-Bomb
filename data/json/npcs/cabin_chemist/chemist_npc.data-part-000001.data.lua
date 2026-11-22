local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_NPC_CABIN_CHEMIST", "TALK_NPC_CABIN_CHEMIST_INTRO" },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_STORY",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_story_told_u_backstory" } })), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }) }),
        },
        {
            text = ccb.content.text("Could you tell me about yourself again?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_STORY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_story_told_u_backstory" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }) }),
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_HOME",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("Brewed anything new lately?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_ASK_INTERVAL",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'd like to buy in bulk."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_trade_mass_chem_tradeable" } }) }),
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text("It's nice to see you again <u_name>.  What can I do for you?"),
        no = ccb.content.gendered_line("It's nice to see a new face around here.  I'm <npc_name>, it's a pleasure meeting you.", { "interlocutor" }),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, I'm <u_name>."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
            next_topic = "TALK_NPC_CABIN_CHEMIST_INTRO",
        },
        {
            text = ccb.content.text("Hands up!  Hand over everything you've got, and nobody gets hurt!"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
