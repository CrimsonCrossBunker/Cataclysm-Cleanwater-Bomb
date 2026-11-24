local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        yes = ccb.content.text("Hello there.  Nice to see you again."),
        no = ccb.content.text("Who are you?  Would you like to trade?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_first_meeting_talked_to_homeless", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_NPC_HOMELESS_BROKER_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } })),
        },
        {
            text = ccb.content.text("Hands up!"),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = 4, fear = -3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } })),
        },
        {
            text = ccb.content.text("Pleasure to see you again."),
            next_topic = "TALK_NPC_HOMELESS_BROKER_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_INTRO",
    line = ccb.content.text("So, what's up?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_NPC_HOMELESS_BROKER_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        },
        {
            text = ccb.content.text("Where might your friends be?"),
            next_topic = "TALK_NPC_HOMELESS_BROKER_FRIENDS",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_told_about_buddies" } }),
        },
        {
            text = ccb.content.text("Can I stay here?"),
            next_topic = "TALK_NPC_HOMELESS_BROKER_STAY",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_told_about_buddies" } }),
        },
        {
            text = ccb.content.text("Can I purchase some of your wares?"),
            next_topic = "TALK_NPC_HOMELESS_BROKER_INTRO",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("How's that smoker coming along?"),
            next_topic = "TALK_NPC_HOMELESS_BROKER_SMOKERACK",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_trade_smoked_meat_tradeable" } }),
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_STORY",
    line = {
        choices = {
            ccb.content.gendered_line("I was homeless for a while before <the_cataclysm>.  I met some buddies out on the road and we were camping out here.  Now we're just scraping by on what we can find, mostly.  We're willing to trade, though.  Who knows, you might find yourself a good deal.", { "interlocutor" }),
            ccb.content.text("Making ends meet, even in the worst circumstances.  We've been camping out here now, trading with whoever passes by.  If something catches your eye, let me know."),
            ccb.content.text("We got tired of being out on the road and decided to stay here for a bit.  We've found a lot of useful stuff out and about, so if you see anything you need I'll make you a deal."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_first_meeting_told_about_buddies", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Hm."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_FRIENDS",
    line = ccb.content.text("They should be around here somewhere.  We usually go out in teams to scavenge, and they haven't told me about anything yet.  They might have something for you to do."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_STAY",
    line = ccb.content.text("Well, I don't see anything wrong with it.  We should have a spare bed in that tent you could sleep on.  Just don't cause any trouble."),
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_dda_b1ea186390a0") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_MASSTRADE",
    line = ccb.content.text("Sure!  It turned out well enough for us, and it's one of the few fresh meats we can find.  I'll pay fairly for it."),
    repeat_replies = {
        {
            items = { "mutant_meat" },
            reply = { text = ccb.content.text("I have <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("I have nothing."),
            next_topic = "TALK_NPC_HOMELESS_BROKER_INTRO",
        },
        {
            text = ccb.content.text("I have nothing.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_SMOKERACK",
    line = ccb.content.text("It's wonderful!  We've been preserving a lot more of what we manage to scavenge so we won't have to worry about our food going bad for a while.  We'd be willing to sell some of the excess, if you want."),
    replies = {
        {
            text = ccb.content.text("I think I'll buy 10 slices.  [$20]"),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_dda_c65cf13e1f16") },
        },
        {
            text = ccb.content.text("You think 20 slices would be alright?  [$40]"),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_dda_842cd0c2c186") },
        },
        {
            text = ccb.content.text("I'll take 50 slices of the stuff.  [$100]"),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_dda_6cb0766f5089") },
        },
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_NONE",
        },
    },
}
