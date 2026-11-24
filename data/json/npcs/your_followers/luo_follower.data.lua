local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_Luo", "TALK_FRIEND_Luo_Abilities" },
    line = { when = predicates.conversation_state("radio"), yes = ccb.content.text(" *pshhhttt* Hey stinkyface.  It's your favorite mushroom girl.  Over."), no = { when = predicates.conversation_state("has_reason"), yes = { special = "consume_reason" }, no = ccb.content.text("So, here we are.  What's up?") } },
    replies = {
        {
            text = ccb.content.text("[rules] Let's talk about how we'll work together."),
            next_topic = "TALK_DONE",
            actions = { "npc_rules_menu" },
        },
        {
            text = ccb.content.text("I'd like to know a bit more about your abilities."),
            next_topic = "TALK_FRIEND_Luo_Abilities",
            actions = { "reveal_stats" },
        },
        {
            text = ccb.content.text("Please go to this location."),
            next_topic = "TALK_GOTO_LOCATION",
            actions = { "goto_location" },
        },
        {
            text = ccb.content.text("There's something I want you to do."),
            next_topic = "TALK_LUO_ORDERS",
        },
        {
            text = ccb.content.text("I just wanted to talk for a bit."),
            next_topic = "TALK_LUO_SOCIAL",
            when = predicates.handler("dlg_p_dda_5d493fb3087d"),
        },
        {
            text = ccb.content.text("Can you help me understand something?  (HELP/TUTORIAL)"),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("I'm going to go my own way for a while."),
            next_topic = "TALK_LEAVE",
        },
        {
            text = ccb.content.text("[DEBUG MIND CONTROL] Now listen closely… (DEBUG FUNCTIONS)"),
            next_topic = "TALK_ALLY_DEBUG",
            when = predicates.has_trait("speaker", "DEBUG_MIND_CONTROL"),
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD_Luo",
    line = ccb.content.text("I love just standing around, it's what I was made for."),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND_Luo",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND_Luo" },
        { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Luo_Abilities",
    line = ccb.content.text("My 'abilities'?  I can shapeshift, and teleport, but I can't do it on command.  Also, I have unique powers of thyroid failure."),
}

ccb.content.define_dialogue_topic {
    id = { "TALK_LUO_SOCIAL" },
    line = ccb.content.text("Sure.  Here we are, talking."),
    replies = {
        { text = ccb.content.text("What's your story, anyway?"), next_topic = "BGSS_Luo1" },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "BGSS_Luo_Expertise",
        },
        {
            text = ccb.content.text("I just wanted to chat, you know.  To relax."),
            next_topic = "TALK_FRIEND_LUO_CHAT",
            when = predicates.negate(predicates.has_effect("interlocutor", "asked_to_socialize")),
        },
        {
            text = ccb.content.text("I changed my mind, wanted to ask you something else."),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}

-- TK: custom chat topics here that actually include small talk that expands her character, while still giving the socialize bonus.
ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_LUO_CHAT",
    line = ccb.content.gendered_line("Seen any good movies lately?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<chitchat_player_responses>"),
            next_topic = "TALK_DONE",
            switch = true,
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_LUO_ORDERS" },
    line = {
        choices = {
            ccb.content.text("Seriously?  You figure you're the boss of me now?  Fine, whatever, what do you want me to do."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you teach me anything?"),
            when = predicates.negate(predicates.conversation_state("radio")),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_24352433e095") },
            success = { next_topic = "TALK_DENY_TRAIN" },
            failure = { next_topic = "TALK_TRAIN_PERSUADE_Luo" },
        },
        {
            text = ccb.content.text("Can you host a training seminar?"),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_6df687e81cfd") },
            success = { next_topic = "TALK_DENY_TRAIN_SEMINAR" },
            failure = { next_topic = "TALK_TRAIN_SEMINAR_PERSUADE_Luo" },
        },
        {
            text = ccb.content.text("I have something to teach you."),
            next_topic = "TALK_TRAIN_NPC",
            when = predicates.handler("dlg_p_dda_6347d53c499b"),
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_FRIEND_Luo",
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")), predicates.negate(predicates.conversation_state("radio")) }),
            actions = { "start_trade" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("I want you to use this item."),
            next_topic = "TALK_FRIEND_Luo",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "npc_gets_item_to_use" },
        },
        {
            text = ccb.content.text("Hold on to this item."),
            next_topic = "TALK_FRIEND_Luo",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "npc_gets_item" },
        },
        {
            text = ccb.content.text("Guard this position."),
            next_topic = "TALK_FRIEND_GUARD_Luo",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "assign_guard" },
        },
        {
            text = ccb.content.text("Find a horse and mount up!"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e15f2a008540"),
            actions = { "find_mount" },
        },
        {
            text = ccb.content.text("Drop off any items you're not using."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "drop_items_in_place" },
        },
        {
            text = ccb.content.text("Get off your mount, please."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_dc5e444f6fd5"),
            actions = { "dismount" },
        },
        {
            text = ccb.content.text("Let's talk about your current activity."),
            next_topic = "TALK_ACTIVITIES",
        },
        {
            text = ccb.content.text("Let's talk about the camp."),
            next_topic = "TALK_CAMP",
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_PERSUADE_Luo",
    line = ccb.content.text("Yeah, sure, why not.  I love hearing myself talk.  What did you want to know about?"),
    replies = {
        {
            text = ccb.content.text("You mean you'll talk about more than just mushrooms?  What've you got?"),
            next_topic = "TALK_TRAIN",
            actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_SEMINAR_PERSUADE_Luo",
    line = ccb.content.text("What?  You're not content with me being a personal tutor, now you want to start a post-apocalyptic university?"),
    replies = {
        {
            text = ccb.content.text("Come on, you love hearing yourself talk."),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = {
                    { score = "TRUST", scale = 6 },
                    { score = "VALUE", scale = 2 },
                    { score = "ANGER", scale = -6 },
                },
            },
            success = { next_topic = "TALK_TRAIN_SEMINAR" },
            failure = {
                next_topic = "TALK_DENY_PERSONAL",
                actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo1",
    line = ccb.content.text("You kind of already know, don't you?  I used to be a post-doc researcher in mycology, then I wound up stuck in the lobby at that stupid refugee center, then you came and yeeted us all out of there.  What more is there?"),
    replies = {
        {
            text = ccb.content.text("I don't remember, did you tell me how you wound up in that place?"),
            next_topic = "BGSS_Luo2",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "BGSS_Luo_Expertise",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo2",
    line = ccb.content.text("Pretty sure I did, but I do love hearing the sound of my own voice.  I got evacuated on to the local concentration center, then picked up on a repurposed school bus and dragged out to that shithole.  We heard the place was getting more people than they could fit, and the few who'd got there first had set up some sort of self-appointed processing lineup.  The chick processing me to get in saw my Chinese name and conveniently 'lost' my paperwork.  I was sent out to the lobby to wait for 'further processing', while I watched busloads of people get processed and taken in.  By the time they 'found' my paperwork, wouldn't you know it, the place was too full for me.  They oh-so-kindly let me camp out in the front since I'd been on one of the first buses."),
    replies = {
        {
            text = ccb.content.text("You think you were treated like that because of your race?"),
            next_topic = "BGSS_Luo2_Racism",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "BGSS_Luo_Expertise",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo2_Racism",
    line = ccb.content.text("I can read the newspapers as well as anyone, I know how people who look like me get smeared.  My grandparents were from China.  That means I'm obviously personally responsible for all this.  I don't know any other reason they let hundreds of other educated people in and left me sitting out there to rot."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "BGSS_Luo_Expertise",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo_Expertise",
    line = ccb.content.text("Well, before <the_cataclysm> I was working at a university bookstore, remember?  But that was just an in-between after finishing my PhD, while I looked for a post-doc placement I was interested in.  Which, I suppose, I've got now?  You didn't recruit my for my fragile body, intractable obesity, or sunny disposition."),
    replies = {
        {
            text = ccb.content.text("How do you know I didn't recruit you for your sass, though?"),
            next_topic = "BGSS_Luo_Expertise_Sass",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo_Expertise_Sass",
    line = ccb.content.text("*gives a single rough laugh.  \"Fair call, sass like mine is what will get us through these trying times.\""),
    replies = { { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" } },
}
