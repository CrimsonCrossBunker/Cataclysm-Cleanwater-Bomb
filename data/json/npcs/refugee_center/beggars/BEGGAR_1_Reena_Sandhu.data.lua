local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Hungry beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar1",
    unique_name = ccb.content.text("Reena Sandhu"),
    gender = "female",
    suffix = ccb.content.text("Teacher"),
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_1",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_1",
    faction = "lobby_beggars",
}

-- All the beggars have been camping inside the evac shelter because they're too weak and unskilled to make it on their own.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_1",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -6, -2 } },
    dexterity = { rng = { -4, -1 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { -3, -1 } },
    worn = "NC_BEGGAR_1_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "GLASSJAW" },
        { trait = "VEGETARIAN" },
        { trait = "SQUEAMISH" },
        { trait = "MOODSWINGS" },
        { trait = "SEASONAL_ALLERGIES" },
        { trait = "SLOWHEALER" },
        { trait = "SLOWRUNNER" },
        { trait = "DISORGANIZED" },
        { trait = "BADKNEES" },
        { trait = "FLIMSY3" },
        { trait = "MYOPIC" },
        { trait = "PACIFIST" },
        { trait = "Exp_Teaching2" },
        { group = "Appearance_Mixed" },
    },
    skills = {
        { skill = "speech", bonus = { rng = { 0, 3 } } },
        { skill = "cooking", bonus = { rng = { 0, 3 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_reena_recruited" } }),
        yes = {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            yes = ccb.content.text("So, any luck with convincing the others to come on your crazy adventure yet?"),
            no = ccb.content.gendered_line("I'm sorry to say it after all you've done for me, but… I don't suppose you've got anything to eat?", { "speaker" }),
        },
        no = {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            yes = ccb.content.text("Thank you again.  I really appreciate the food."),
            no = {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text("Please, help me.  I need food.  Aren't you their sheriff?  Can't you help me?"),
                no = ccb.content.text("Please, help me.  I need food."),
            },
        },
    },
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
            text = ccb.content.text("I've talked to the others, and they're all willing to come.  So, you joining us?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUITED",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_INTRO",
        },
        {
            text = ccb.content.text("Hey, here, I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            text = ccb.content.text("Get away from me."),
            next_topic = "TALK_DONE",
            opinion = { trust = -1, value = -1, anger = 1 },
        },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_INTRO",
    line = {
        joined = {
            ccb.content.text("They won't let me in.  They say they're too full.  I'm allowed to camp out here as long as I keep it clean and don't make a fuss"),
            {
                when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
                yes = ccb.content.text(", but I'm reduced to begging to survive."),
                no = ccb.content.text(", but I'm so hungry."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_LEAVE",
        },
        {
            text = ccb.content.text("Why don't you scavenge your own food?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text("I've got some more food, if you want it."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
    line = ccb.content.text("Thank you so much."),
    replies = {
        { text = ccb.content.text("Can I ask you something else first?"), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("I'm sorry, I was wrong.  I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
    repeat_replies = {
        {
            categories = { "food" },
            reply = {
                text = ccb.content.text("Here, you can have this <topic_item>."),
                next_topic = "TALK_REFUGEE_BEGGAR_1_GAVE_FOOD",
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_LEAVE",
    line = ccb.content.text("Where else?  I can't fight those things out there.  I'm in terrible physical condition, don't have any useful skills, and I'm terrified of <zombies> and violence.  How am I supposed to find a safe place?"),
    replies = {
        {
            text = ccb.content.text("Why don't you scavenge your own food?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
        },
        {
            text = ccb.content.text("Come with me.  Maybe you're not the greatest adventurer, but it's better than living here."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp of my own, away from here.  You could come there.  There aren't many people left, we could use anyone regardless of skills."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT1",
            when = predicates.handler("dlg_p_dda_ee51db677ef6"),
        },
        {
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        },
        {
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
    line = ccb.content.text("Out there?  That's suicide!  People that go out there don't come back, people who can hold their own… unlike me.  I'd rather take my chances begging for scraps and waiting for someone in the center to die and make room for me, thanks."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_LEAVE",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
        },
        {
            text = ccb.content.text("Come with me.  Maybe you're not the greatest adventurer, but it's better than living here."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp of my own, away from here.  Maybe you can't scavenge, but we can use any warm bodies that can lift a tool.  You'd be safer and better fed there."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT1",
            when = predicates.handler("dlg_p_dda_ee51db677ef6"),
        },
        {
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        },
        {
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
    line = ccb.content.text("I was a high school math teacher.  It was a good job, I loved it.  Funny enough, it's not super applicable after the end of the world.  I mean, at some point people are going to need a teacher again, but right now they just want food, shelter, and clothing."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_LEAVE",
        },
        {
            text = ccb.content.text("Why don't you scavenge your own food?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
        },
        {
            text = ccb.content.text("Come with me.  Maybe you're not the greatest adventurer, but it's better than living here."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp of my own, away from here.  Maybe they can't use your skills here, but I could."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT1",
            when = predicates.handler("dlg_p_dda_ee51db677ef6"),
        },
        {
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        },
        {
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_GAVE_FOOD",
    line = ccb.content.text("This is wonderful of you, I really appreciate it."),
    on_enter = {
        { actions = { "u_bulk_donate" } },
        { actions = { actions.handler("w16b_a_dda_ee5ac56a72a9") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_INTRO",
        },
        {
            text = ccb.content.text("No problem.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_JOIN",
    line = ccb.content.text("That's a kind offer of you, but I think I'd rather take my chances here than risking it out there again.  I remember <the_cataclysm>, I'm not in any hurry to face that again."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_LEAVE",
        },
        {
            text = ccb.content.text("Why don't you scavenge your own food?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
}

-- This is a very difficult sell-job unless you've earned her trust with food
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_RECRUIT1",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.text("That's quite the offer, but I don't think I'd survive the trip.  I don't think you realize how useless I am in this world."),
        no = ccb.content.text("I'm sorry, I'm too hungry to make a big decision like that."),
    },
    replies = {
        {
            text = ccb.content.text("I can keep you safe.  I'll take you there myself."),
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            trial = {
                kind = "persuade",
                difficulty = 100,
                modifiers = {
                    { score = "TRUST", scale = 4 },
                    { score = "VALUE", scale = 2 },
                    { score = "OWED", scale = 3 },
                    { score = "ANGER", scale = -2 },
                    { score = "FEAR", scale = -6 },
                    { score = "BRAVERY", scale = 1 },
                },
            },
            success = {
                next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT2",
                actions = { actions.set_actor_value("speaker", "general_recruit_reena_recruited", "yes") },
            },
            failure = { next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT_NO" },
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_RECRUIT_NO",
    line = ccb.content.text("I really appreciate everything you've done for me, but I don't think you get it.  I can't go out there.  I will die.  I know it's horrible camping out here, but I just can't face that nightmare again."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I hope you'll reconsider eventually.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_RECRUIT2",
    line = ccb.content.gendered_line("Well… you have shown that you can survive out there, and you've been able to provide food, so I know you're thriving more than we are here.  All right, I'll tell you what.  I'm not going anywhere without my friends here, we've been through way too much together.  If you can convince Luo, Brandon, and Yusuke to come along, then I'll go.", { "speaker" }),
    replies = {
        { text = ccb.content.text("OK.  <done_conversation_section>"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("OK, I'll talk to them too."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_RECRUITED",
    line = ccb.content.gendered_line("Well… you have shown that you can survive out there, and you've been able to provide food, so I know you're thriving more than we are here.  All right, I'll tell you what.  I'm not going anywhere without my friends here, we've been through way too much together.  If you can convince Luo, Brandon, and Yusuke to come along, then I'll go.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("All right!  <lets_go>"),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
        },
    },
}
