local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_BorisBorichenko",
    unique_name = ccb.content.text("Boris Borichenko"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Boris",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Boris_1",
    missions_offered = "MISSION_REFUGEE_Boris_CLEANUP",
    faction = "free_merchants",
}

-- Boris is nice, but shy and sad.  He was a carpenter; he and his partner lost their son in the Cataclysm, and it makes it harder for them to make friends in the survivor group.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Boris",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { 1, 4 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { -3, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Boris_worn",
    carry = "REFUGEE_Boris_carried",
    weapon = "REFUGEE_Boris_wield",
    traits = {
        { trait = "OUTDOORSMAN" },
        { trait = "PAINRESIST" },
        { group = "trait_group_STRONGBACK" },
        { group = "Appearance_Caucasian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    proficiencies = { "prof_carpentry_basic", "prof_carving", "prof_plumbing" },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "fabrication", bonus = { rng = { 3, 4 } } },
        { skill = "survival", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_Boris_2", "TALK_REFUGEE_Boris_3", "TALK_REFUGEE_Boris_Background", "TALK_REFUGEE_Boris_Background_B", "TALK_REFUGEE_Boris_Background_loss", "TALK_REFUGEE_Boris_Work1", "TALK_REFUGEE_Boris_Situation" },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            next_topic = "TALK_REFUGEE_Boris_Refuse_Boris_Mission_1",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("Boris, I'm sorry, but I could only find two people willing to help.  Can I pitch in myself?  [Spend 5 hours helping]"),
            next_topic = "TALK_REFUGEE_Boris_MakeDoWith2",
            when = predicates.handler("dlg_p_dda_681194643ca7"),
        },
        {
            text = ccb.content.text("Boris, I'm sorry, but I could only find three people willing to help.  Can I pitch in myself?  [Spend 4 hours helping]"),
            next_topic = "TALK_REFUGEE_Boris_MakeDoWith3",
            when = predicates.handler("dlg_p_dda_7ee9ed104324"),
        },
        {
            text = ccb.content.text("I spoke with everyone I could, but only four people agreed to help.  I can pitch in if you want."),
            next_topic = "TALK_REFUGEE_Boris_MakeDoWith4",
            when = predicates.handler("dlg_p_dda_b5e60d60a9f0"),
        },
        {
            text = ccb.content.text("Is there anything I can help you out with?"),
            next_topic = "TALK_REFUGEE_Boris_Work1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } })),
        },
        {
            text = ccb.content.text("Got anything else I can help out with?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_3" } })) }),
        },
        {
            text = ccb.content.text("So, have you had a chance to get that laptop working and look at it yet?"),
            next_topic = "TALK_REFUGEE_Boris_ReadLaptop1",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_3" } }),
        },
        {
            text = ccb.content.text("Now that you've got your tools and shop set up, do you think you could teach me a thing or two about construction?"),
            next_topic = "TALK_REFUGEE_Boris_Teach",
            when = predicates.handler("dlg_p_dda_7202e00080e0"),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Boris_Background",
        },
        {
            text = ccb.content.text("You don't seem to be doing great."),
            next_topic = "TALK_REFUGEE_Boris_Background_B",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Boris_Situation",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1",
    line = ccb.content.text("Ah, another new face.  Hello.  I am Boris."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Boris_Borichenko", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Boris_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Boris."),
            next_topic = "TALK_REFUGEE_Boris_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Boris, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- Subsequent meetings with Boris before you have helped him finish some of his quests
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1a",
    line = {
        joined = {
            ccb.content.text("*stares at you for a moment before nodding in recognition.  \""),
            {
                choices = {
                    ccb.content.gendered_line("Well, well.  You are back.", { "speaker" }),
                    ccb.content.gendered_line("So, you have survived.", { "speaker" }),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Boris.  What's up?"), next_topic = "TALK_REFUGEE_Boris_2" },
        { text = ccb.content.text("Hi Boris.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

-- Later meetings with Boris, after you've started doing quests for him
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1b",
    line = {
        joined = {
            ccb.content.text("*nods at you, his eyes lighting up a little as you approach.  \""),
            {
                choices = {
                    ccb.content.gendered_line("Well, well.  I'm glad you are back.", { "speaker" }),
                    ccb.content.gendered_line("It is good to see you again, my friend.", { "speaker" }),
                    ccb.content.gendered_line("Hello, my friend.", { "speaker" }),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Good to see you, Boris.  Are things looking up for you at all?"),
            next_topic = "TALK_REFUGEE_Boris_3",
        },
        { text = ccb.content.text("Hi Boris.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1_firstmeet",
    line = ccb.content.text("It is nice to meet you too.  To what do I owe the pleasure?"),
    replies = {
        {
            text = ccb.content.text("I'm just a traveler, taking the chance to have some living human company.  What's up in your life these days?"),
            next_topic = "TALK_REFUGEE_Boris_2",
        },
        {
            text = ccb.content.text("I just wanted to say hi.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_2",
    line = ccb.content.text("What is 'up'?  Less than I would like, it seems.  I am better when I am busy, and I am not at all busy."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- This option is Boris' start point after you've finished his first mission and got to know him a bit.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_3",
    line = ccb.content.text("*forces a bit of a smile through his bushy beard, though it doesn't reach his eyes.  \"It is good to see you too.  I would not say things are looking 'up' yet, but they are not so much looking down perhaps.  I am keeping a bit busier.\""),
    replies = {
        {
            text = ccb.content.text("Want to talk about it a little?"),
            next_topic = "TALK_REFUGEE_Boris_Son",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Background",
    line = ccb.content.text("I was a carpenter.  I like to keep my hands busy, especially when I am stressed.  Now, here I am, picking my nose and stuck thinking about my problems and all that I've lost."),
    replies = {
        {
            text = ccb.content.text("What have you lost, if it's okay for me to ask?"),
            next_topic = "TALK_REFUGEE_Boris_Background_loss",
        },
        {
            text = ccb.content.text("It seems like carpentry work would be something the Free Merchants need.  Why are you so bored?"),
            next_topic = "TALK_REFUGEE_Boris_Work1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } })),
        },
        {
            text = ccb.content.text("Could you teach me something about carpentry?"),
            next_topic = "TALK_REFUGEE_Boris_NoTeach",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_2" } })),
        },
        {
            text = ccb.content.text("Could you teach me something about carpentry?"),
            next_topic = "TALK_REFUGEE_Boris_Teach",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_2" } }),
        },
        {
            text = ccb.content.text("Now that things are cleaned up in the back, is there anything holding you back from working?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
        },
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
    id = "TALK_REFUGEE_Boris_Background_B",
    line = ccb.content.text("No, not great.  Like all here, I have lost too much.  I do not feel I can ever come back from it.  Can anyone be strong enough?"),
    replies = {
        {
            text = ccb.content.text("What have you lost, if it's okay for me to ask?"),
            next_topic = "TALK_REFUGEE_Boris_Background_loss",
        },
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
    id = "TALK_REFUGEE_Boris_Background_loss",
    line = ccb.content.text("I would rather talk about what I have left: my husband, Stan, and his brother Garry, my best friend.  Without them, I'd be lost myself.  What we've lost is more than anyone should have to think about."),
    replies = {
        {
            text = ccb.content.text("I'm sorry.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'm sorry.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Son",
    line = ccb.content.text("…Ash.  His name was Ash, and he was ten years old.  Such a light, a spark.  I wanted to see the man he would grow into.  I… now I can barely say his name.  I miss him so much, every instant.  If I did not have Stan, I would walk out through the barbed wire and join the walking dead."),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  Tell me more about Ash."),
            next_topic = "TALK_REFUGEE_Boris_Son_Remember",
        },
        {
            text = ccb.content.text("We've all lost a lot of people.  You can either let yourself die, or learn to survive."),
            next_topic = "TALK_REFUGEE_Boris_Son_Tough",
        },
        {
            text = ccb.content.text("I'm so sorry, man.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Son_Remember",
    line = ccb.content.text("I could talk forever, but it's hard to make the words come.  He was so *smart*.  Always on the computer, writing stories and programming silly games in Scratch.  He had a little robotics toy he made walk around and do funny dances.  It was a challenge to make him play with his friends sometimes, he would get so far into himself and buried in that thing.  So tough to be a parent, you know?  It is good for him to write, to learn, but he also needs to socialize and have friends.  He'll grow out… he…"),
    replies = {
        {
            text = ccb.content.text("Do you have any of his writing?"),
            next_topic = "TALK_REFUGEE_Boris_Son_Writing",
        },
        {
            text = ccb.content.text("We've all lost a lot of people.  You can either let yourself die, or learn to survive."),
            next_topic = "TALK_REFUGEE_Boris_Son_Tough",
        },
        {
            text = ccb.content.text("I'm so sorry, man.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Son_Tough",
    line = ccb.content.text("Of course, yes.  I know this, but it is not so easy, is it?  So many are gone, and I do not know which of the two I would prefer, just yet."),
    replies = {
        {
            text = ccb.content.text("Yeah, fine.  Just wallow in it.  I'm out."),
            next_topic = "TALK_DONE",
        },
    },
}

-- TK add a quest.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Son_Writing",
    line = ccb.content.text("No.  In the evacuation shelter, distracted by grief, I forgot it.  We were rushed onto the bus so quickly, and… well, I don't remember much of that time.  His work was all saved on the hard drive, we thought we could download it from the cloud when we arrived but, well, there is no cloud now.  Even if there were, it would only have his writing, not his little games, his silly voice recordings."),
    replies = {
        {
            text = ccb.content.text("I'm so sorry, man.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Work1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } }),
        yes = ccb.content.text("Well, now that you mention it, with the back bay cleared I could probably set up back there and start work.  I don't know if I can handle it.  The last time I was back there was the last time I saw… if… if someone were to clean up back there, wipe away some memories, then I could start renovating it into a better living space."),
        no = ccb.content.text("There isn't much to do with a hammer and a saw here indoors, and working outside is too dangerous.  If we had enough space for me to do some shuffling around, I could build some privacy walls in here.  I tried to set up a bit of a shop in the garage space, but I had to keep taking everything down for caravan loading and unloading and couldn't get anything done.  The caravans bring food, so they get priority, I can't argue with that."),
    },
    replies = {
        {
            text = ccb.content.text("What do you need to get things cleaned up?  Can I help?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } }),
            next_topic = "TALK_REFUGEE_Boris_Work2",
        },
        {
            text = ccb.content.text("I'm sorry.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Work2",
    line = ccb.content.text("We could put together a little clean up group, but everyone here has terrible memories of that place.  I could not ask anyone here to go back and see the leftovers of people we knew.  Still, it's a big job.  Who here might be able to do it?"),
    replies = {
        {
            text = ccb.content.text("I'm sure there's someone.  Would you like me to ask around?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_NoTeach",
    line = ccb.content.text("I am afraid I cannot teach you right now.  Not only do I have no shop, but I do not think I am in a good place for anything so taxing."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } })),
            next_topic = "TALK_REFUGEE_Boris_Work1",
        },
        {
            text = ccb.content.text("Is there anything more I can do to help?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
            next_topic = "TALK_MISSION_LIST",
        },
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
    id = "TALK_REFUGEE_Boris_Teach",
    line = ccb.content.gendered_line("Yes, my friend.  You have done so much for me, I would be glad to teach you what I can.  I must ask a small amount in trade, for materials.  I hope you understand.", { "speaker" }),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_0957c05f4b74") } },
    },
    replies = {
        {
            text = ccb.content.text("Great!  Let's get started."),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  Let's do this later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Situation",
    line = {
        joined = {
            ccb.content.text("Everyone agrees this is bad.  Sleeping on a cot on the floor, crowded in with strangers"),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
                yes = ccb.content.text(", but it is a bit better since we cleaned up our dead"),
                no = ccb.content.text(", woken by zombies in the night"),
            },
            ccb.content.text(".  To me, though, that is all just a drop in the bucket"),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_3" } }),
                yes = ccb.content.text(".  What is killing me is being forced to sit with nothing but my thoughts of what I've lost."),
                no = ccb.content.text(".  I have spent so much time, just regretting what I have lost.  Thank you for bringing back what little you could."),
            },
        },
    },
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
    id = "TALK_REFUGEE_Boris_ReadLaptop1",
    line = ccb.content.text("It was difficult at first, but yes, I did.  It hurts, but it is good.  I am so proud of him.  Would you like to see some… some of what you brought me?"),
    replies = {
        {
            text = ccb.content.text("Sure, my friend.  I'd love to hear you brag about your boy."),
            next_topic = "TALK_REFUGEE_Boris_ReadLaptop2",
        },
        {
            text = ccb.content.text("That sounds a bit heavy for me right now, let's talk about something else"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Not today, I have to get going.  Just glad I was able to help."),
            next_topic = "TALK_DONE",
        },
    },
}

-- I would like a specialized effect here that reduces the 'guilty about killing' morale penalty while also adding a small morale penalty of its own.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_ReadLaptop2",
    line = {
        choices = {
            ccb.content.text("&Boris boots up the laptop and opens a folder labeled 'ART'.  He shows you simple digital paintings, clearly done by an adolescent.  There's nothing terribly remarkable about them except the number: Ash was a prolific creator.  Boris goes through several, proudly showing how his son learned little lighting tricks, or reminiscing on the time his son showed him the art.  After a while, he stops commenting and just continues quietly clicking through photos.  He seems different in the glow of the screen, like several years dropped away from his face, despite the deep sadness still etched there."),
            ccb.content.text("&Boris boots up the laptop and opens a folder labeled 'STORY 1'.  In it are numerous text files containing smatterings of stream-of-conscious notes, copy-and-pasted bits of fanfictions, notes about how to write a novel, and more.  The story itself is a handful of poorly fleshed out chapters written with the quality level you'd expect from a grade schooler.  Nonetheless it's quite impressive that there's this much stuff on a single topic.  Boris talks for a while about dinner conversations for weeks that would focus on Ash's ideas for his stories.  After a while, he trails off and just continues flipping through the files, reading silently."),
            ccb.content.text("&Boris boots up the laptop and opens the videos folder.  He shows you several self-made videos that follow a loose blog style, of an awkward young man talking about his favorite games, interspersed with comments about art and writing.  Boris comments on little events and laughs a few times, before becoming engrossed in his reminiscence."),
        },
    },
    replies = { { text = ccb.content.text("[Leave Boris alone for now.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Refuse_Boris_Mission_1",
    line = ccb.content.gendered_line("Have you had a problem with memory, friend?  I was the one who asked you this, I thought I explained why I could not.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Oh.  Right.  It's been a long apocalypse.  What were you saying?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sorry.  I didn't notice which dialogue option I was selecting.  I'll just back away slowly now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_MakeDoWith2",
    line = ccb.content.gendered_line("Hmm, well it is not ideal but I appreciate you trying and being willing to help.  I will have to do my best despite the bad memories.  Thank you, my friend.", { "speaker" }),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_d027843b7b0d"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("OK, let's get to work."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_MakeDoWith3",
    line = ccb.content.gendered_line("Thank you for trying, my friend.  With you and me that will be five, I will do my best to be strong and assist in the cleanup.", { "speaker" }),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_6f847e7a3114"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("OK, let's get to work."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_MakeDoWith4",
    line = ccb.content.gendered_line("That is quite alright, four should be enough though I appreciate your offer.  Four people will make the job much easier and I will do my best even if it is painful.  My thanks, friend.", { "speaker" }),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_1771a2e9be11"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Good to hear.  I'm sure everyone will appreciate that place being cleaned up."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Boris_CLEANUP",
    name = ccb.content.text("Find someone to clean up the back bay."),
    description = ccb.content.text("Boris in the refugee center is looking for at least five people to help clean up the back bay."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_CONDITION",
    followup = "MISSION_REFUGEE_Boris_WORKSPACE",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Find a few people able to help clean the back, people without too much trauma there."),
        offer = ccb.content.text("Yes, please.  If you can ask around for someone who can help, I can gather the tools they will need and some payment for them."),
        accepted = ccb.content.text("You are a kind soul."),
        rejected = ccb.content.text("Ah well.  I can ask around myself, perhaps."),
        advice = ccb.content.text("Those of us here in the back have too many bad memories, but perhaps someone who didn't come with the original refugee groups would be less burdened."),
        inquire = ccb.content.text("Greetings, my friend.  Have you found anyone?"),
        success = ccb.content.text("This has great promise.  Perhaps something to keep me busy will help.  Here, I found some small money to thank you."),
        success_lie = ccb.content.text("I see….  Well I shall get things in order!"),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        actions = {
            { item = "FMCNote", count = 5 },
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_completed_Boris_mission_1", "yes"),
            ccb.content.dialogue_actions.set_first_topic("TALK_REFUGEE_Boris_1b"),
            ccb.content.dialogue_actions.set_actor_value("speaker", "proven_worth_to_old_guard_representative", "yes"),
            { handler = "advance_counter_refugee_center_refugee_happiness_by_3" },
            ccb.content.dialogue_actions.update_map("boris_cleanup_garage", "evac_center_8"),
            ccb.content.dialogue_actions.update_map("boris_cleanup_back_bay", "evac_center_9"),
        },
    },
    complete_when = "complete_mission_refugee_boris_cleanup",
}

-- TK add update mapgen.
ccb.content.define_mission {
    id = "MISSION_REFUGEE_Boris_WORKSPACE",
    name = ccb.content.text("Bring Boris a circular saw."),
    description = ccb.content.text("Find a circular saw for Boris.  Smokes might be selling one if it's available in stock."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "circsaw_off",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_REFUGEE_Boris_LAPTOP",
    dialogue = {
        describe = ccb.content.text("Find a circular saw for Boris."),
        offer = ccb.content.text("We now have a space to work in, and I have wood and nails to spare.  All I need is a saw.  I would love a table saw and mitre saw, but I can work with a hand held circular saw for now.  I have looked, and what we have is garbage.  Can you bring me a good one?"),
        accepted = ccb.content.text("You are a kind soul."),
        rejected = ccb.content.text("Ah well.  I can ask around myself, perhaps."),
        advice = ccb.content.text("It is not hard to find.  I have even seen them for sale at the merchants, but they save them as trade goods and will not give me as a gift."),
        inquire = ccb.content.text("Greetings, my friend.  Have you found a saw I can use?"),
        success = ccb.content.text("Ah, good.  VonWalt is good brand, I had a saw like this at home.  Now I shall set to work, and make myself a shop back there.  Oh yes, here is a little payment I saved."),
        success_lie = ccb.content.text("I see…"),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_completed_Boris_mission_2",
            "advance_counter_refugee_center_refugee_happiness_by_2",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Boris_LAPTOP",
    name = ccb.content.text("Bring Boris his son's lost writing."),
    description = ccb.content.text("Find Boris' son's laptop in the evac shelter marked on your map."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "laptop_boris",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    start = {
        target = {
            terrain = "shelter",
            special = "Evac Shelter",
            reveal_radius = 1,
            random = true,
            search_range = 120,
        },
        map_updates = {
            {
                layout = {
                    item_placements = {
                        { id = "laptop_boris", x = 15, y = 12 },
                        { id = "mbag", x = 15, y = 12 },
                    },
                },
            },
        },
    },
    dialogue = {
        describe = ccb.content.text("Find Boris' son's laptop."),
        offer = ccb.content.text("My son, Ash, had a laptop on which he kept his writing.  If you can find it, it would mean so much to me.  I will give you directions to the shelter where he left it.  It was barely a shelter, broken and torn apart.  It should just be on the floor where it was dropped."),
        accepted = ccb.content.text("You are a kind soul."),
        rejected = ccb.content.text("Ah well.  I can ask around myself, perhaps."),
        advice = ccb.content.text("You can tell it is his because he covered it in stickers."),
        inquire = ccb.content.text("I know it is a hard thing to hope, but were you able to find Ash's laptop?"),
        success = ccb.content.text("It is so strange to see this again, like a little piece of my old life.  I don't know if I can bring myself to read what's on it yet, but having this piece of him is a great comfort."),
        success_lie = ccb.content.text("I see…"),
        failure = ccb.content.text("Even that you tried means a lot to me."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_completed_Boris_mission_3",
            "advance_counter_refugee_center_refugee_happiness_by_2",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "boris_cleanup_garage",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 6,
                y = 3,
                end_x = 17,
                end_y = 3,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 3,
                y = 4,
                end_x = 20,
                end_y = 14,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 4,
                y = 15,
                end_x = 20,
                end_y = 15,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 5,
                y = 16,
                end_x = 18,
                end_y = 16,
            },
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 3,
                y = 3,
                end_x = 20,
                end_y = 16,
            },
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 21,
                y = 12,
                end_x = 23,
                end_y = 15,
            },
            {
                shape = "rectangle",
                operation = "remove_fields",
                x = 2,
                y = 2,
                end_x = 21,
                end_y = 17,
            },
            {
                shape = "rectangle",
                operation = "remove_fields",
                x = 22,
                y = 11,
                end_x = 23,
                end_y = 17,
            },
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_rdoor_c",
                x = 21,
                y = 13,
                end_x = 21,
                end_y = 14,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "boris_cleanup_back_bay",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 0,
                y = 4,
                end_x = 17,
                end_y = 22,
            },
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 0,
                y = 4,
                end_x = 17,
                end_y = 22,
            },
            {
                shape = "rectangle",
                operation = "remove_fields",
                x = 0,
                y = 4,
                end_x = 17,
                end_y = 22,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_locker",
                x = 17,
                y = 6,
                end_x = 17,
                end_y = 19,
            },
        },
    },
}
