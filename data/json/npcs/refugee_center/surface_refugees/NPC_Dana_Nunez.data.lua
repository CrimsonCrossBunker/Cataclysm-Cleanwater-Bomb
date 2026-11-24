local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_DanaNunez",
    unique_name = ccb.content.text("Dana Nunez"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Dana",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Dana_1_firstmeet",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Dana_Sourdough",
    age = 26,
    height = 164,
    strength = 8,
    dexterity = 9,
    intelligence = 9,
    perception = 11,
    personality = { aggression = -10, bravery = -5, collector = 1, altruism = 4 },
}

-- Dana is a young woman who survived with her husband, but she was pregnant and lost the baby.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Dana",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    worn = "REFUGEE_Dana_worn",
    carry = "REFUGEE_Dana_carried",
    weapon = "REFUGEE_Dana_wield",
    traits = {
        { trait = "PAINRESIST" },
        { trait = "MYOPIC" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "hair_ponytail", variant = "red" },
        { trait = "SKIN_LIGHT" },
        { trait = "eye_color", variant = "blue" },
    },
    skills = {
        { skill = "cooking", bonus = 6 },
        { skill = "cutting", bonus = 1 },
        { skill = "driving", bonus = 2 },
        { skill = "melee", bonus = 1 },
        { skill = "speech", bonus = 1 },
        { skill = "unarmed", bonus = 1 },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Dana_1", "TALK_REFUGEE_Dana_Background", "TALK_REFUGEE_Dana_Background_baking",
        "TALK_REFUGEE_Dana_Background_baking_revival", "TALK_REFUGEE_Dana_Situation",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("I spoke to the foreman over at Tacoma Ranch.  If you're willing to put in the work, they'll find some work for you over there."),
            next_topic = "TALK_REFUGEE_Dana_Tacoma2",
            when = predicates.all({ predicates.has_mission("MISSION_TACOMA_Nunez"), predicates.any_equal({ "phase_2", { scope = "speaker", key = "recruit_general_Nunez_Tacoma" } }) }),
            actions = { actions.set_actor_value("speaker", "recruit_general_Nunez_Tacoma", "phase_3") },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Dana_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Dana_Situation",
        },
        {
            text = ccb.content.text("I spoke to your husband about getting you a job at the Tacoma Ranch.  What would you think about that?"),
            next_topic = "TALK_REFUGEE_Dana_Tacoma",
            when = predicates.has_mission("MISSION_TACOMA_Nunez"),
        },
        {
            text = ccb.content.text("Your husband said to ask you what you'd think about getting out of this place and coming to work for me at my own camp."),
            next_topic = "TALK_REFUGEE_Dana_Recruit",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "recruit_general_Pablo_ask_recruit" } }),
        },
        {
            text = ccb.content.text("You seem pretty unhappy about the quality of your bread.  Is there something I can do to help?"),
            next_topic = "TALK_DANA_Sourdough",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_Dana_Sourdough" } }) }),
        },
        {
            text = ccb.content.text("I've got your sourdough."),
            next_topic = "TALK_DANA_Sourdough3",
            when = predicates.has_item("speaker", "landough_calrisean"),
        },
        {
            text = ccb.content.text("Got any more bread I can trade flour for?"),
            next_topic = "TALK_REFUGEE_Dana_Background_baking",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_trade_Dana_Bread_Sales" } }), predicates.negate(predicates.has_effect("interlocutor", "dana_sourdough_revival")) }),
        },
        {
            text = ccb.content.text("Got any more bread I can trade flour for?"),
            next_topic = "TALK_REFUGEE_Dana_Background_baking_revival",
            when = predicates.has_effect("interlocutor", "dana_sourdough_revival"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_1_firstmeet",
    line = ccb.content.text("*is a pale woman with a broad, friendly face.  She seems to start opening with a wide grin, then notices her somber surroundings and dials it back to a pleasant smile.  \"Hi there.  I'm Dana, Dana Nunez.  Nice to see a new face.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Dana_Nunez", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Dana_1"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Dana, hey?  Nice to meet you.  How are things here?"),
            next_topic = "TALK_REFUGEE_Dana_Situation",
        },
        {
            text = ccb.content.text("Nice to meet you, Dana.  What's your story?"),
            next_topic = "TALK_REFUGEE_Dana_Background",
        },
        {
            text = ccb.content.text("Hi Dana, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_1",
    line = {
        joined = {
            {
                choices = {
                    ccb.content.text("*beams at you as you approach.  \""),
                    ccb.content.text("*turns from her conversation with Pablo, and smiles as she sees you.  \""),
                },
            },
            {
                choices = {
                    ccb.content.text("Hello, nice to see you again.  What brings you around today?"),
                    ccb.content.text("It's good to see you're still around."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi Dana, nice to see you too.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background",
    line = ccb.content.text("I was working in a nice restaurant as a baker, until <the_cataclysm>.  I was pregnant, and it was getting close to time to go on mat leave; lots of time on my feet, getting up stupid-early to make pastries, you know.  Because of the pregnancy we were evacuated early and shipped out this way, but our bus was attacked in the chaos.  We managed to escape, but had to hike the rest of the way, with the Singhs and a few other refugees that didn't make it.  I lost the baby.  It wasn't a good time."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "knowledge_dana_pregnancy", "knows") } } },
    replies = {
        {
            text = ccb.content.text("Have you done any baking lately?"),
            next_topic = "TALK_REFUGEE_Dana_Background_baking",
        },
        {
            text = ccb.content.text("I'm sorry for your loss."),
            next_topic = "TALK_REFUGEE_Dana_Background_sorry",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Dana."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_Dana_Background_baking", "TALK_TACOMA_Dana_Baking", "TALK_REFUGEE_Dana_Background_baking2_nobarter", "TALK_REFUGEE_Dana_Background_baking2_yesbarter" },
    replies = {
        {
            text = ccb.content.text("[8 flour] That sounds like a great deal, here's some flour for you."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.has_inventory("speaker", "flour", 8), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            actions = { actions.transfer_items("flour", 8), actions.handler("dlg_a_dda_070edb08b9e3") },
        },
        {
            text = ccb.content.text("[2 merch] I got two merch for you."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.has_inventory("speaker", "FMCNote", 2), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            actions = { actions.transfer_items("FMCNote", 2), actions.handler("dlg_a_dda_070edb08b9e3") },
        },
        {
            text = ccb.content.text("[6 flour] Thanks for cutting me a deal, here's the six cups of flour."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.has_effect("interlocutor", "dana_barter_success"), predicates.has_inventory("speaker", "flour", 6), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            actions = { actions.transfer_items("flour", 6), actions.handler("dlg_a_dda_070edb08b9e3") },
        },
        {
            text = ccb.content.text("[1 merch] All right, one merch as agreed."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.has_effect("interlocutor", "dana_barter_success"), predicates.has_inventory("speaker", "FMCNote", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            actions = { actions.transfer_items("FMCNote"), actions.handler("dlg_a_dda_070edb08b9e3") },
        },
        {
            text = ccb.content.text("[8 flour] That sounds like a great deal, here's some flour for you."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.has_inventory("speaker", "flour", 8), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            actions = { actions.transfer_items("flour", 8), actions.handler("dlg_a_dda_e61dd25a5265") },
        },
        {
            text = ccb.content.text("[2 merch] I got two merch for you."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.has_inventory("speaker", "FMCNote", 2), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            actions = { actions.transfer_items("FMCNote", 2), actions.handler("dlg_a_dda_e61dd25a5265") },
        },
        {
            text = ccb.content.text("[6 flour] Thanks for cutting me a deal, here's the six cups of flour."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.has_effect("interlocutor", "dana_barter_success"), predicates.has_inventory("speaker", "flour", 6), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            actions = { actions.transfer_items("flour", 6), actions.handler("dlg_a_dda_e61dd25a5265") },
        },
        {
            text = ccb.content.text("[1 merch] All right, one merch as agreed."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.has_effect("interlocutor", "dana_barter_success"), predicates.has_inventory("speaker", "FMCNote", 1), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            actions = { actions.transfer_items("FMCNote"), actions.handler("dlg_a_dda_e61dd25a5265") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_Dana_Background_baking", "TALK_TACOMA_Dana_Baking" },
    line = {
        when = predicates.has_effect("interlocutor", "dana_baking_sold"),
        yes = ccb.content.text("Not since I last saw you, sorry.  Come by tomorrow and I'll try to keep a loaf set aside for you, but they disappear fast."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_trade_Dana_Bread_Sales" } }),
            yes = ccb.content.text("I sure do, if you've got the flour or the merch for me, I'd be happy to trade you another loaf."),
            no = ccb.content.text("I do a bit.  I got a sourdough starter going almost as soon as I arrived, and it's making passable bread already.  I cooked some up yesterday actually, I could probably trade a loaf of fresh bread for, say, about eight cups of flour, or two merch."),
        },
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "knowledge_trade_Dana_Bread_Sales", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("[BARTER] Is that the lowest you can go?  I'd love some bread, but I can't quite make that."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_fail")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            trial = { kind = "persuade", difficulty = 20 },
            failure = {
                next_topic = "TALK_REFUGEE_Dana_Background_baking2_nobarter",
                actions = { actions.add_effect("interlocutor", "dana_barter_fail", { turns = 86400 }) },
            },
            success = {
                next_topic = "TALK_REFUGEE_Dana_Background_baking2_yesbarter",
                actions = { actions.add_effect("interlocutor", "dana_barter_success", { turns = 86400 }) },
            },
        },
        {
            text = ccb.content.text("[BARTER] Aw, c'mon.  I rescued Landough, can't you cut me a little deal?"),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_fail")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            trial = { kind = "persuade", difficulty = 5 },
            failure = {
                next_topic = "TALK_REFUGEE_Dana_Background_baking2_nobarter",
                actions = { actions.add_effect("interlocutor", "dana_barter_fail", { turns = 86400 }) },
            },
            success = {
                next_topic = "TALK_REFUGEE_Dana_Background_baking2_yesbarter",
                actions = { actions.add_effect("interlocutor", "dana_barter_success", { turns = 86400 }) },
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking",
    replies = {
        {
            text = ccb.content.text("Thanks, can we talk about something else?"),
            next_topic = "TALK_REFUGEE_Dana_1",
        },
        {
            text = ccb.content.text("I'll look into that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- see above for responses to buy bread at original price.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking2_nobarter",
    line = ccb.content.text("Sorry, it's not something I can bend on.  I don't make a big profit off this, I use what I get to make more bread.  If I cut you a deal, I'll run out of supplies."),
    replies = {
        {
            text = ccb.content.text("Thanks, but I think I'll pass.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking2_yesbarter",
    line = ccb.content.text("Oh, fine.  Six cups of flour, or one merch.  I'm not going any lower, I got a business to run here."),
    replies = {
        {
            text = ccb.content.text("You know, I think I changed my mind.  <done_conversation_section>"),
            next_topic = "TALK_REFUGEE_Dana_1",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_sorry",
    line = ccb.content.text("That's kind of you to say.  I'm doing my best to move on… it hurts, but in the scale of things it could be worse.  Pablo and I still have each other, that's a lot more than most."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Dana."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking2",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }),
        yes = {
            choices = {
                ccb.content.text("Great, here's a loaf of the best damn sourdough bread in the world.  I used to make that claim as a joke, but I feel like now there's a fighting chance nobody else can beat me."),
                ccb.content.text("Nice.  Enjoy the mighty bounty of Landough Calrisean."),
                ccb.content.text("Here you go, from the family recipe."),
                ccb.content.text("Hope you enjoy it as much as I do, this is the best damn bread in the world now."),
            },
        },
        no = ccb.content.text("Great, here's a loaf of my locally-famous, not-very-mature sourdough.  It's not too bad honestly.  Everyone here seems to like it."),
    },
    on_enter = {
        {
            actions = {
                actions.add_effect("interlocutor", "dana_baking_sold", { turns = 64800 }),
                actions.set_actor_value("speaker", "knowledge_Dana_Sourdough", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("You seem pretty unhappy about the quality of your bread.  Is there something I can do to help?"),
            next_topic = "TALK_DANA_Sourdough",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })),
        },
        {
            text = ccb.content.text("It smells awesome.  <end_talking_leave>  Thanks!"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DANA_Sourdough",
    line = ccb.content.text("Sure.  If you really like this second-rate bread, you could risk your life for something actually worth it.  I left my actual sourdough starter back in the bakery where I worked.  That baby is a hundred years old, and has been in my family for generations… if you can bring him to me, I'll bake you the finest bread you've ever had."),
    replies = {
        {
            text = ccb.content.text("Why not?  I'll see what I can do."),
            next_topic = "TALK_DANA_Sourdough2",
            actions = { actions.offer_mission("MISSION_REFUGEE_Dana_Sourdough"), actions.set_actor_value("speaker", "mission_flag_Dana_Sourdough", "yes") },
        },
        {
            text = ccb.content.text("Maybe not right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DANA_Sourdough2",
    line = ccb.content.text("Take care of yourself out there.\"  She jots down directions to her bakery and hands them to you.  \"His name is Landough, Landough Calrisean.  He'll be in the right-hand fridge, in a jar with a picture of the Millennium Falcon on it.  And listen, when you bring my sourdough back, I don't want to see a scratch on him, you understand?"),
    replies = {
        { text = ccb.content.text("Right.  Sure."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("All right, old buddy.  You know, I know what he means to you.  I'll take good care of him, so that he won't get a scratch."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DANA_Sourdough3",
    line = ccb.content.text("*takes the jar from you eagerly, studying it with care.  \"He's been through a lot, hasn't he.  Poor guy.  Aw man.\"  She turns back to you, beaming.  \"Oh, you will not regret this.  He may not look like much, but he's got it where it counts, kid.  It's gonna take me a few days to revive him after being abandoned so long, but he'll be operational soon and then you can come back for some real bread.\"  She frowns.  \"I don't really have much to give you in return, but I'll cut you a deal on bread if that helps.\""),
    on_enter = {
        { actions = { actions.transfer_items("landough_calrisean"), actions.finish_mission("MISSION_REFUGEE_Dana_Sourdough", { success = true }) } },
    },
    replies = {
        {
            text = ccb.content.text("I'll hold you to that."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm just glad to help."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking_revival",
    line = ccb.content.text("Sorry, not quite yet.  Landough was in pretty rough shape.  No fault of yours, it was no good having him cooped up in a dank fridge for that long… and I think my apprentice baker may have fucked with him before the Cataclysm too.  He'd better hope he's a zombie now, because if I see him alive… anyway, it's gonna take a few more feeds before I can get him ready for prime time, check back in a couple days."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Dana."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Situation",
    line = ccb.content.text("Things are tense at the best of times.  We didn't choose this crowd, so not all of us really get along.  I like Jenny and Fatima, and the three of us are kind of lucky to have friends here, but that doesn't make up for us being a bunch of unfamiliar faces crammed into a tiny space.  Someone's gonna murder someone soon, mark my words."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Dana."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Tacoma",
    line = {
        when = predicates.any_equal({ "phase_1", { scope = "speaker", key = "recruit_general_Nunez_Tacoma" } }),
        yes = ccb.content.gendered_line("Have you heard anything back from the ranch about jobs yet?", { "speaker" }),
        no = ccb.content.text("Huh.  I've made a few friends here, but not so much as I'd stick around here with no future prospects, hoping someone downstairs dies to make room for me.  It does sound nice, if they're looking for more workers."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "recruit_general_Nunez_Tacoma", "phase_1") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll look into that.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'll look into that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Tacoma2",
    line = ccb.content.text("All right.  I've taken some time to think about it, and I'm willing to go.  I'm sure they'll have use for a baker over there, after all, and if I don't get out of this place there's a very real chance I'm going to snap.  You can go let Pablo know first hand, if you want; he's been pretty excited about the idea."),
    replies = { { text = ccb.content.text("Sure, I'll go tell him.  Cool!"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Recruit",
    line = ccb.content.text("Pablo's a little quicker on the trigger than I am.  We're trying to have a baby, did you know that?  It's a bit crazy in this world, but I won't change those plans.  Tell you what: if your camp has access to a doctor and some medical facilities, in case I actually can get pregnant again, I would consider getting out of here and signing up."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "knowledge_dana_pregnancy", "knows") } } },
    replies = {
        {
            text = ccb.content.text("I'll look into that.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'll look into that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Dana_Sourdough",
    name = ccb.content.text("Find Dana's family sourdough culture"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    item = "landough_calrisean",
    start = {
        target = { terrain = "bakery", reveal_radius = 1, random = true, search_range = 800 },
        map_updates = { { layout = { item_placements = { { id = "landough_calrisean", x = 5, y = 16 } } } } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_Dana_Sourdough", "in_progress"),
        },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_Dana_Sourdough", "yes"),
            ccb.content.dialogue_actions.add_effect("interlocutor", "dana_sourdough_revival", { turns = 604800 }),
        },
        handler = "advance_counter_refugee_center_refugee_happiness_by_2",
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I could get my real sourdough starter…"),
        offer = ccb.content.text("If you really like this second-rate bread, you could risk your life for something actually worth it.  I left my actual sourdough starter back in the bakery where I worked.  That baby is a hundred years old, and has been in my family for generations… if you can bring him to me, I'll bake you the finest bread you've ever had."),
        accepted = ccb.content.text("Take care of yourself out there.  And listen, when you bring my sourdough back, I don't want to see a scratch on him, you understand?"),
        rejected = ccb.content.text("I can understand why you think you wouldn't want to risk your life for a bread starter.  You haven't tried that bread."),
        advice = ccb.content.text("He'll be in the right-hand fridge, in a jar with a picture of the Millennium Falcon on it."),
        inquire = ccb.content.text("So, you seen my sourdough starter?"),
        success = ccb.content.text("Oh, you will not regret this.  He may not look like much, but he's got it where it counts, kid.  It's gonna take me a few days to revive him after being abandoned so long, but he'll be operational soon and then you can come back for some real bread."),
        success_lie = ccb.content.text("This ain't it."),
        failure = ccb.content.text("I am not sure if I'm gonna make it through the Cataclysm without my special jar of goop."),
    },
}

ccb.content.define_item {
    id = "Dana_sourdough_bread",
    name = ccb.content.plural_text("Dana's sourdough bread", "Dana's sourdough bread"),
    copy_from = "sourdough_bread",
    looks_like = "sourdough_bread",
    description = ccb.content.text("This round loaf of bread has a thick, dark crust, and smells very enticing."),
    comestible = {},
    inheritance = { scale = { fun = 2, price = 2 } },
}
