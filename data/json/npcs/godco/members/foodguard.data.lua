local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_idlechat",
    line = {
        choices = {
            ccb.content.text("Sure, what's happening?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Could you tell me a bit about yourself?"),
            next_topic = "TALK_GODCO_guard_food_about_self",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What are you planning on doing in the future?"),
            next_topic = "TALK_GODCO_guard_food_future_plans",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could I borrow something from the stock?"),
            next_topic = "TALK_GODCO_guard_food_borrow",
        },
        {
            text = ccb.content.text("Would you be willing to buy any food?"),
            next_topic = "TALK_GODCO_guard_food_buy",
        },
        {
            text = ccb.content.text("Has anyone stolen from here?"),
            next_topic = "TALK_GODCO_guard_food_theft",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How much food do you have?"),
            next_topic = "TALK_GODCO_guard_food_stock",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Is there anything I can do to help you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Good luck with that."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_who",
    line = {
        choices = {
            ccb.content.text("Name's Eddie.  I'm making sure this stockpile is alright."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Could you just chat for a bit?"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("Is there anything I can do to help you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Could I borrow something from the stock?"),
            next_topic = "TALK_GODCO_guard_food_borrow",
        },
        {
            text = ccb.content.text("Has anyone stolen from here?"),
            next_topic = "TALK_GODCO_guard_food_theft",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How much food do you have?"),
            next_topic = "TALK_GODCO_guard_food_stock",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Good luck with that."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_borrow",
    line = {
        choices = {
            ccb.content.text("Nope, you can't do that.  I'd like to help you, but we've already got enough mouths to feed."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Could some money persuade you?"),
            trial = { kind = "persuade", difficulty = 10 },
            failure = { next_topic = "TALK_GODCO_guard_food_bribe_fail", opinion = { trust = -2 } },
            success = { next_topic = "TALK_GODCO_guard_food_bribe_success" },
        },
        {
            text = ccb.content.text("I can give these people one less mouth to feed, if you'd prefer that."),
            trial = { kind = "intimidate", difficulty = 10 },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
            success = { next_topic = "TALK_GODCO_guard_food_intimidate_success", opinion = { trust = -4 } },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food",
        },
        { text = ccb.content.text("Alright.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_theft",
    line = {
        choices = {
            ccb.content.text("Nobody's tried to yet.  It can get a little boring sometimes, standing around and doing nothing."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I can understand that.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food",
        },
        {
            text = ccb.content.text("I hope it isn't too boring.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_stock",
    line = { choices = { ccb.content.text("That's private info, <name_g>.") } },
    replies = {
        { text = ccb.content.text("Okay."), next_topic = "TALK_GODCO_guard_food" },
        { text = ccb.content.text("Alright.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_bribe_fail",
    line = {
        choices = {
            ccb.content.text("Nope, it couldn't.  Don't try and fuckin' bribe me again."),
        },
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_71e2f9ff2d65") } },
    },
    replies = {
        {
            text = ccb.content.text("Geez, I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_intimidate_success",
    line = {
        choices = {
            ccb.content.text("Alright, alright.  Here's some food and water, <name_b>.  Get out of my sight."),
        },
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_8dfe391a29e6") } },
    },
    replies = {
        {
            text = ccb.content.text("Keep that in mind."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5ebf903ac122") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_bribe_success",
    line = {
        choices = {
            ccb.content.text("Okay, here's some food and water.  Don't tell anyone I gave you that."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I won't.  Pleasure doin' business."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5ebf903ac122") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_about_self",
    line = {
        choices = {
            ccb.content.text("I'm just a regular guy, been with the Church for a while now.  I kept a good, solid job before <the_cataclysm>, lived in a nice apartment on Chestnut Street."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What did you do for a job before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_guard_food_precata_job",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Do you have any hobbies?"),
            next_topic = "TALK_GODCO_guard_food_hobbies",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What are you planning on doing in the future?"),
            next_topic = "TALK_GODCO_guard_food_future_plans",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_family",
    line = {
        choices = {
            ccb.content.text("I used to, me and my mother were pretty close.  I didn't know my father very well for the first four years of my life, he was always out on deployment with the Navy someplace.  Me and him got to know each other after he retired from the service, we'd always go fishing on Sunday afternoons for years.  My mother though, she was the sweetest lady you'd ever meet, always took care of me and Dad.  Now they're gone, been that way for the last three years."),
        },
    },
    replies = {
        {
            text = ccb.content.text("You're mother must've been very nice."),
            next_topic = "TALK_GODCO_guard_food_mother",
        },
        {
            text = ccb.content.text("What was your father like?"),
            next_topic = "TALK_GODCO_guard_food_father",
        },
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
    id = "TALK_GODCO_guard_food_mother",
    line = {
        choices = {
            ccb.content.text("She sure was, helped me through some very hard times in my life.  I used to be bullied in middle school, whenever I'd get beat up, she'd always help clean me up and tell me I'd be alright.  She had this recipe for peach casserole too, best one in the world.  It was hard for me when she passed, but I found some solace right here in this Church.  We'd always been religious, but this one just clicked for me, ya know?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Is that why you joined the Church?"),
            next_topic = "TALK_GODCO_guard_food_church",
        },
        {
            text = ccb.content.text("What was your father like?"),
            next_topic = "TALK_GODCO_guard_food_father",
        },
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
    id = "TALK_GODCO_guard_food_father",
    line = {
        choices = {
            ccb.content.text("He was a nice fellow, taught me everything I know about firearms, wildlife, and sailing.  We lived next to this big ol' lake, so we had plenty of opportunities to catch bass and catfish.  He'd skin and filet them, and we'd have it for dinner.  My mother always cooked them, and she was great at it."),
        },
    },
    replies = {
        {
            text = ccb.content.text("You're mother sounds very nice, what was she like?"),
            next_topic = "TALK_GODCO_guard_food_mother",
        },
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
    id = "TALK_GODCO_guard_food_church",
    line = {
        choices = {
            ccb.content.text("Yeah, her death was hard on me.  I wound up goin' here one day, and I felt something come over me, like I belonged here.  I haven't left since, and I've been able to move on with them."),
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
    id = "TALK_GODCO_guard_food_precata_job",
    line = {
        choices = {
            ccb.content.text("I used to work for the U.S Postal Service, I was a mail carrier.  Delivered all the letters, packages, and mail orders to the residents of <city>, door-to-door.  It was pretty hard at times, but it kept me fit and on the road."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Do you have any hobbies?"),
            next_topic = "TALK_GODCO_guard_food_hobbies",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_hobbies",
    line = {
        choices = {
            ccb.content.text("I really like to draw things, I primarily did landscapes in my spare time.  I like paper-and-pencil sketches, but I have worked with watercolors and oil canvases.  Never could get my head around the digital stuff, though, too complex for me and I never had a good free hand with a stylus.  I also shot a bit, went hunting a few times.  I mainly went to the gun range though, shotguns were always my forte.  Besides that, I watched some TV and regular ol' stuff.  I also like to read quite a bit, too."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I guess those shooting skills come in handy these days."),
            next_topic = "TALK_GODCO_guard_food_gunskills_inhandy",
        },
        {
            text = ccb.content.text("You must be a very good artist then.  Do you still have time to draw?"),
            next_topic = "TALK_GODCO_guard_food_art",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What did you do for a job before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_guard_food_precata_job",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_gunskills_inhandy",
    line = {
        choices = {
            ccb.content.text("I guess they will.  I pray to God that I won't have to shoot someone, I never want to be forced into deciding between life or death."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What did you do for a job before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_guard_food_precata_job",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me about your hobbies again?"),
            next_topic = "TALK_GODCO_guard_food_hobbies",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_art",
    line = {
        choices = {
            ccb.content.text("I'm alright at it, I guess.  I'm no Van Gough or Botticelli, but I get along with it and do my best.  I've started using the desk up here to work on these days, I just need to keep my firearm close and one eye on the door."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What did you do for a job before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_guard_food_precata_job",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me about your hobbies again?"),
            next_topic = "TALK_GODCO_guard_food_hobbies",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

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
