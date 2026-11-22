local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_future_plans",
    line = {
        choices = {
            ccb.content.text("I don't know anymore, to tell you the truth.  I was planning on settling down and having kids, but now that everyone's dead and the judgment of God has come to pass, I'll seek His truth and try to keep on living.  One day, when this is all over, I'll fly away to Heaven's pearly gates and be with the angels.  As for the Earth, I'd rather not think about the things that have come to pass."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_buy",
    line = ccb.content.text("Sure, I'd be willing to purchase some.  I'll have to work up the money with Helena, but I'm sure we've got it.  I'd prefer canned, and preserved goods.  How much are you talkin'?"),
    repeat_replies = {
        {
            items = {
                "jerky", "meat_smoked", "fish_smoked", "dry_meat", "dry_veggy", "dry_fruit", "dry_fish",
                "dry_lobster", "dry_corn", "salted_fish", "cooking_oil", "cornmeal", "flour",
                "fruit_wine", "beer", "sugar", "salt", "vinegar", "kompot", "freeze_dried_meal",
                "offal_canned", "can_coconut", "con_milk", "milk_evap", "sauce_red", "can_peach",
                "apple_canned", "fish_canned", "lobster_canned", "can_sardine", "can_tuna", "can_salmon",
                "can_clams", "can_chicken", "can_corn", "meat_canned", "confit_meat", "can_tomato",
                "broth", "broth_bone", "soup_veggy", "soup_meat", "soup_fish", "soup_lobsterstew",
                "curry_veggy", "curry_meat", "soup_woods", "soup_chicken", "soup_mushroom",
                "soup_tomato", "soup_dumplings", "soup_cullenskink", "cooked_pumpkin", "veggy_canned",
            },
            reply = { text = ccb.content.text("I have <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't have anything right now.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("You better step away from me real quick, sinner.  I don't want your kind here."),
        no = {
            when = predicates.handler("w16b_p_dda_866fa9af59a5"),
            yes = ccb.content.text("What brings you around here <name_b>?  I don't want to see your face for a while."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_food_guard" } }),
                yes = {
                    choices = {
                        ccb.content.text("Hey there."),
                        ccb.content.text("You're back."),
                        ccb.content.text("So…?"),
                    },
                },
                no = ccb.content.text("Hello.  What brings you around here?"),
            },
        },
    },
    on_enter = {
        { actions = { actions.handler("w16b_a_dda_63cfbf23b6ac") } },
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_GODCO_guard_food_who",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_food_guard" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_food_guard", "yes") },
        },
        {
            text = ccb.content.text("Just stopping by for a moment.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_food_guard" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_food_guard", "yes") },
        },
        {
            text = ccb.content.text("Who are you again?"),
            next_topic = "TALK_GODCO_guard_food_who",
            when = predicates.handler("w16b_p_dda_68bfd4661f4b"),
        },
        {
            text = ccb.content.text("Care to talk for a bit?"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
            when = predicates.handler("w16b_p_dda_68bfd4661f4b"),
        },
        {
            text = ccb.content.text("I'll see you around."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_68bfd4661f4b"),
        },
        {
            text = ccb.content.text("Alright then, fuck you <name_b>."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_2d84e4efe5a2"),
        },
    },
}
