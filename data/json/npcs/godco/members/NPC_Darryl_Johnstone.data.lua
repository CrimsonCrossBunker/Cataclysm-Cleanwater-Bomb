local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Darryl_2", "TALK_GODCO_Darryl_Mood", "TALK_GODCO_Darryl_Story", "TALK_GODCO_Darryl_Farm", "TALK_GODCO_Darryl_BarterSuccess" },
    replies = {
        {
            text = ccb.content.text("About that well…"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "in-progress", { scope = "interlocutor", key = "mission_completed_godco_darryl_mission1" } }),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Darryl_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Darryl_Mood",
        },
        {
            text = ccb.content.text("Nice farm you have here."),
            next_topic = "TALK_GODCO_Darryl_Farm",
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_GODCO_Darryl_Trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.gendered_line("What the hell are you, sinner?  Get away from me.", { "speaker" }),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Shove off, we've got no good words for each other."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_darryl" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("Welcome back."),
                        ccb.content.gendered_line("Nice to see you again, survivor.", { "speaker" }),
                    },
                },
                no = ccb.content.gendered_line("Well I'll be damned, a fellow survivor!  I'm Darryl, nice to meet you.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("About that well…"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_46b33dcc78ef"),
        },
        {
            text = ccb.content.text("Nice to meet you too, Darryl.  Neat farm you have here."),
            next_topic = "TALK_GODCO_Darryl_Farm",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_darryl" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_darryl", "yes") },
        },
        {
            text = ccb.content.text("Hey Darryl.  Got a minute?"),
            next_topic = "TALK_GODCO_Darryl_2",
            when = predicates.handler("dlg_p_dda_66dc1578f526"),
        },
        {
            text = ccb.content.text("Hey Darryl.  Got a minute?"),
            next_topic = "TALK_GODCO_Darryl_Angry",
            when = predicates.handler("dlg_p_dda_146b37bb9c95"),
        },
        {
            text = ccb.content.text("Hey Darryl.  Care to trade?"),
            next_topic = "TALK_GODCO_Darryl_Trade",
            when = predicates.handler("dlg_p_dda_66dc1578f526"),
        },
        {
            text = ccb.content.text("Hey Darryl.  Care to trade?"),
            next_topic = "TALK_GODCO_Darryl_Angry",
            when = predicates.handler("dlg_p_dda_146b37bb9c95"),
        },
        {
            text = ccb.content.text("How are the chickens?"),
            next_topic = "TALK_GODCO_Darryl_Trade_Eggs",
            when = predicates.handler("dlg_p_dda_d20fc79f5ca2"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("What's the poor attitude about?"),
            next_topic = "TALK_GODCO_Darryl_You_Mutant",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
        {
            text = ccb.content.text("Fuck you <name_b>, I'm outta here."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_2",
    line = ccb.content.text("I guess I can spare a few minutes.  What is it?"),
    replies = {
        { text = ccb.content.text("Can I buy anything?"), next_topic = "TALK_GODCO_Darryl_Trade" },
        {
            text = ccb.content.text("How are the chickens?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_trade_darryl_built_coop" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_darryl" } }) }),
            next_topic = "TALK_GODCO_Darryl_Trade_Eggs",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_Darryl_Wife",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Mood",
    line = ccb.content.text("This uncertainty is eating me inside, to be frank with you.  I'm a simple man: I tend my farm, I scare off vermin, but even I can see somethin' ain't right here.  I've talked to my wife, I had a word with Damien, they told me to have more faith in God.  It's the last sliver of hope I have left, and I was told that's enough."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Story",
    line = ccb.content.text("Well, I'd rather not get into my life before all this.  I have a farm to maintain, after all.  Would be nice, sharing our tales while sipping cold brew beer.  Not at a time like this.  Now if you'll excuse me, I'll be back to work."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'll leave you to it."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Farm",
    line = ccb.content.text("Took us three days and four hard-working hands to clear this humble little land.  It's a far-cry from my old garden, it really is.  I heard theories, from Tom of course, that really messed with my head.  You can never know what's in one of them toxic clouds, can ya?  I suspect goo-puker blood.  That putrid oil is a sure way to make any soil infertile, or so that nitwit says.  Here I go again, ramblin' once more.  One of my bad habits."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'll leave you to it."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Trade",
    line = ccb.content.text("Huh, never would have thought you were interested in the fine art of farming.  Sure, I've got seeds I can say goodbye to… if you have the appropriate money of course."),
    replies = {
        { text = ccb.content.text("Let's trade, then."), next_topic = "TALK_GODCO_Darryl_Trade2" },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Trade_Eggs",
    line = ccb.content.text("It's finished, and I've got eggs!  I'd be willing to sell ya some, a dozen for seven icons."),
    replies = {
        {
            text = ccb.content.text("I'll buy some."),
            next_topic = "TALK_GODCO_Darryl_1",
            when = predicates.has_inventory("speaker", "icon", 7),
            actions = { actions.transfer_items("icon", 7), actions.handler("dlg_a_dda_a4b64a894b0d") },
        },
        {
            text = ccb.content.text("That's a bit rich for my blood.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Trade2",
    line = ccb.content.text("All right, this is what I've got:  I can give cucumber, barley or blackberry seeds for one icon; carrot, buckwheat or cranberry seeds for two icons; oat, sugar beet or potato seeds for three icons."),
    replies = {
        {
            text = ccb.content.text("I'll buy cucumber seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 1),
            actions = { actions.transfer_items("icon"), actions.handler("dlg_a_dda_6c850cbcb4f3") },
        },
        {
            text = ccb.content.text("I'll buy barley seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 1),
            actions = { actions.transfer_items("icon"), actions.handler("dlg_a_dda_e3e9d30006d6") },
        },
        {
            text = ccb.content.text("I'll buy blackberry seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 1),
            actions = { actions.transfer_items("icon"), actions.handler("dlg_a_dda_d8dfb1090c0c") },
        },
        {
            text = ccb.content.text("I'll buy carrot seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 2),
            actions = { actions.transfer_items("icon", 2), actions.handler("dlg_a_dda_c60894d72732") },
        },
        {
            text = ccb.content.text("I'll buy buckwheat seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 2),
            actions = { actions.transfer_items("icon", 2), actions.handler("dlg_a_dda_24f8b2f15533") },
        },
        {
            text = ccb.content.text("I'll buy cranberry seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 2),
            actions = { actions.transfer_items("icon", 2), actions.handler("dlg_a_dda_bd6e4ac73144") },
        },
        {
            text = ccb.content.text("I'll buy oat seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 3),
            actions = { actions.transfer_items("icon", 3), actions.handler("dlg_a_dda_194ff38eda8d") },
        },
        {
            text = ccb.content.text("I'll buy sugar beet seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 3),
            actions = { actions.transfer_items("icon", 3), actions.handler("dlg_a_dda_3131e9fb995f") },
        },
        {
            text = ccb.content.text("I'll buy potato seeds."),
            next_topic = "TALK_GODCO_Darryl_Trade2",
            when = predicates.has_inventory("speaker", "icon", 3),
            actions = { actions.transfer_items("icon", 3), actions.handler("dlg_a_dda_c048c0261c0a") },
        },
        {
            text = ccb.content.text("Can't you just give them to me for free?  You said you didn't need them."),
            when = predicates.negate(predicates.has_effect("speaker", "godco_darryl_bartered")),
            trial = { kind = "persuade", difficulty = 25, modifiers = { { score = "trust", scale = 5 } } },
            success = { next_topic = "TALK_GODCO_Darryl_BarterSuccess", actions = { actions.add_effect("interlocutor", "godco_darryl_bartered", { permanent = true }), actions.handler("dlg_a_dda_c048c0261c0a") } },
            failure = { next_topic = "TALK_GODCO_Darryl_BarterFail", opinion = { trust = -6 } },
        },
        {
            text = ccb.content.text("That's a bit rich for my blood.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_BarterSuccess",
    line = ccb.content.gendered_line("Well, you got me there.  I sure ain't one to block a fellow farmer's right to reclaim this God-given earth.", { "speaker" }),
    replies = { { text = ccb.content.text("Thank you.  See you around, Darryl."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_BarterFail",
    line = ccb.content.text("It really isn't difficult to earn your money here.  Hard labor, like the rest of us."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Wife",
    line = ccb.content.text("I've got a wife, Gemma.  She's a grand lady, should be around here somewhere.  She used to teach biology, and we both love gardenin'; that's how we met, ya see.  She 'aint been herself lately, I'm startin' to worry."),
    replies = {
        {
            text = ccb.content.text("What about your parents?"),
            next_topic = "TALK_GODCO_Darryl_Mom&Dad",
        },
        {
            text = ccb.content.text("I'll check on her.  I hope everything works out for you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Mom&Dad",
    line = ccb.content.text("Oh, they passed a long time ago.  Wish they could've seen Gemma and I marry…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'm sorry for your loss."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_You_Mutant",
    line = ccb.content.text("I've heard of unnatural monsters such as yourself causing chaos after the fall of civilization, and how men have transformed into horrors and gone mad with sin.  This is the judgment of God upon you heathens for your wicked ways, and I want nothing to do with it."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Angry",
    line = ccb.content.text("No, I fucking well don't, not with you at least.  I ain't interested in whatever you've got to say."),
    replies = { { text = ccb.content.text("See you later then."), next_topic = "TALK_DONE" } },
}
