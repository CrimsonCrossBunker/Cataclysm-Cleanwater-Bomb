local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_KINDRED_COOPER",
    name = ccb.content.text("Rogue Kindred"),
    job_description = ccb.content.text("I have to gather more bones."),
    traits = {
        { trait = "OUTDOORSMAN" },
        { trait = "INSOMNIA" },
        { trait = "GOODCARDIO2" },
        { trait = "STRONGSTOMACH" },
        { trait = "SPIRITUAL" },
        { trait = "TERRIFYING" },
        { trait = "PSYCHOPATH" },
        { trait = "seer_mark" },
        { group = "Appearance_Caucasian" },
        { trait = "hair_short", variant = "brown" },
        { trait = "natural_hair_color_brown" },
        { trait = "FACIAL_HAIR_3DAYSTUBBLE" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { rng = { 0, 2 } },
    strength = { rng = { 0, 2 } },
    worn = "KINDRED_COOPER_worn",
    weapon = "KINDRED_COOPER_wield",
    shop_groups = "NC_KINDRED_COOPER_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 5, 7 } } },
        { skill = "cutting", bonus = { rng = { 4, 6 } } },
    },
}

-- A once member of a doomsday cult.
ccb.content.define_npc {
    id = "KINDRED_Darren_Cooper",
    unique_name = ccb.content.text("Darren Cooper"),
    gender = "male",
    suffix = ccb.content.text("Rogue Kindred"),
    class = "NC_KINDRED_COOPER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_KINDRED_COOPER",
    faction = "no_faction",
}

ccb.content.define_dialogue_topic {
    id = "TALK_KINDRED_COOPER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }),
        yes = {
            when = predicates.has_trait("speaker", "seer_mark"),
            yes = {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
                yes = ccb.content.text("Kindred.  What can I do for you?"),
                no = ccb.content.text("What do you want, Kindred?"),
            },
            no = {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
                yes = ccb.content.text("Hello again, traveler."),
                no = ccb.content.text("Yes?"),
            },
        },
        no = {
            when = predicates.has_trait("speaker", "seer_mark"),
            yes = ccb.content.gendered_line("How do you do.  Name's Cooper.  What's your- wait… that's the Mark of the Seer on your hand.  You're Kindred.  So I guess you know who I am, then.", { "speaker" }),
            no = ccb.content.text("How do you do.  Name's Cooper.  And you are?"),
        },
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_cooper", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I do.  Brigitte told me about you, and that you're dangerous."),
            next_topic = "TALK_KNOWS_COOPER1",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_confronted_cooper" } })), predicates.has_trait("speaker", "seer_mark"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } })) }),
        },
        {
            text = ccb.content.text("Brigitte told me everything.  What could drive a man to carve the bones of living people?"),
            next_topic = "TALK_KNOWS_COOPER_CARVE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_confronted_cooper" } })), predicates.has_trait("speaker", "seer_mark"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("Brigitte told me about you.  I think what you do might be what's necessary, even if Brigitte doesn't agree."),
            next_topic = "TALK_COOPER_AGREE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_confronted_cooper" } })), predicates.has_trait("speaker", "seer_mark"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_admires_cooper" } }) }),
        },
        {
            text = ccb.content.text("I can't say that I do.  Should I?"),
            next_topic = "TALK_COOPER_NOTFMLR",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })), predicates.has_trait("speaker", "seer_mark"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } })) }),
        },
        {
            text = ccb.content.text("Just a traveler, trying to survive.  What about you?  Scavenging?"),
            next_topic = "TALK_COOPER_INTRODUCTION",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })) }),
        },
        {
            text = ccb.content.text("Wait, Cooper?  Brigitte LaCroix mentioned someone by that name.  You're the man who carved the bones of living people."),
            next_topic = "TALK_KNOWS_COOPER_CARVE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("Cooper?  I met a woman who mentioned you, Brigitte.  She said you're dangerous."),
            next_topic = "TALK_COOPER_INTRODUCTION_QUERY",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } })) }),
        },
        {
            text = ccb.content.text("Wait, Cooper?  I heard about you.  A woman, Brigitte LaCroix, said that you're dangerous, but seems to me like you're just doing what it takes."),
            next_topic = "TALK_COOPER_AGREE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_admires_cooper" } }) }),
        },
        {
            text = ccb.content.text("Why did Brigitte say you're dangerous?"),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } })) }),
        },
        {
            text = ccb.content.text("Why do you kill people?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("Could you tell me about yourself?"),
            next_topic = "TALK_COOPER_ABOUT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } })) }),
        },
        {
            text = ccb.content.text("Remind me what happened between you and Brigitte."),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.has_trait("speaker", "seer_mark") }),
        },
        {
            text = ccb.content.text("I've been thinking about what you do.  I can't let you keep hurting people.  You have to be stopped."),
            next_topic = "TALK_COOPER_FIGHT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("Could you remind me of your goal again?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } }) }),
        },
        {
            text = ccb.content.text("You mentioned that you have a goal.  What is that exactly?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_dk" } }) }),
        },
        {
            text = ccb.content.text("The woman you mentioned - Brigitte - why isn't she with you?"),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } }),
        },
        {
            text = ccb.content.text("I was just checking in.  Take care."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KNOWS_COOPER1",
    line = ccb.content.text("I suppose she probably said I'm some sort of a maniac and that you should kill me on the spot, correct?"),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_cooper_confronted_cooper", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I want to hear your side of the story.  You make it sound like it's not so cut and dry."),
            next_topic = "TALK_COOPERS_SIDE",
        },
        {
            text = ccb.content.text("You kill innocent people and butcher them like animals.  I don't care what you say.  You have to be stopped."),
            next_topic = "TALK_COOPER_FIGHT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_INTRODUCTION_QUERY",
    line = ccb.content.text("I see.  Would you like to hear my side, or is your mind made up already?"),
    replies = {
        { text = ccb.content.text("I'm curious.  Go on."), next_topic = "TALK_COOPERS_SIDE" },
        {
            text = ccb.content.text("She told me to stop you, and that's what I'll do."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        {
            text = ccb.content.text("I don't care about any of this.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KNOWS_COOPER_CARVE",
    line = ccb.content.text("What?  I'd never do anything like that!  Dammit… if she thinks I did that, that would explain why she's not willing to work with me.  Maybe there's still some hope she'll understand what's necessary."),
    replies = {
        { text = ccb.content.text("So what happened then?"), next_topic = "TALK_COOPERS_SIDE" },
        {
            text = ccb.content.text("You're still a killer, and I can't let you keep going."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        { text = ccb.content.text("I don't really care.  I'm leaving."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPERS_SIDE",
    line = ccb.content.text("I met Brigitte shortly after everything collapsed.  Seeing so much death and insanity around me… it almost crushed me, but when she explained everything about the bones to me, it gave me a sliver of hope, that one time, things might turn around.  For that, I am grateful to her.  But we'll never change anything if we keep using scraps of bones found on corpses on the side of the road.  By the time the animals are done with those, there is barely any Song left to be used.  It's not enough.  I had to leave, to work on my own.  To do what's necessary."),
    replies = {
        {
            text = ccb.content.text("What do you mean by 'necessary'?"),
            next_topic = "TALK_COOPER_NECESSARY",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } })),
        },
        {
            text = ccb.content.text("What are you actually trying to accomplish?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })),
        },
        {
            text = ccb.content.text("Can't have been easy to split off, but I understand why you did it."),
            next_topic = "TALK_COOPER_AGREE",
        },
        {
            text = ccb.content.text("Necessary?  You kill innocent people!"),
            next_topic = "TALK_COOPER_NECESSARY",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_NECESSARY",
    line = ccb.content.text("People will die in this world overrun with monsters.  There is no avoiding it.  But I can give those deaths meaning, allow them to help the world after death, more than they could in life.  It brings me no pleasure, but… yes, some must give their life for the greater good.  It's the only way.  Wish there was an alternative, but it must be done.  I only take people from this world to save it.  Make no mistake though, the only people that I… kill are those who would not survive anyway."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_kindred_cooper_knows_cooper_kill", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Why do you kill people?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })),
        },
        {
            text = ccb.content.text("Are you going to kill me?"),
            next_topic = "TALK_COOPER_KILL_PLAYER",
        },
        { text = ccb.content.text("You're a monster."), next_topic = "TALK_COOPER_MONSTER" },
        {
            text = ccb.content.text("You're just a murderer with a shoddy excuse.  I can't let you keep doing this."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        {
            text = ccb.content.text("You have a point.  The ends justify the means."),
            next_topic = "TALK_COOPER_AGREE",
        },
        {
            text = ccb.content.text("Do you have any proof that this will work?"),
            next_topic = "TALK_COOPER_WORK",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_MONSTER",
    line = ccb.content.gendered_line("And how many people have you killed?  Maybe it was in self defense, maybe because you wanted their gear.  It's all the same.  I give their death meaning.  I hate that I have to do it, I truly do, but you really must understand, there is no other way.  The sooner I finish my mission, the sooner all this madness can end.", { "speaker" }),
    replies = {
        { text = ccb.content.text("I suppose you're right."), next_topic = "TALK_COOPER_AGREE" },
        {
            text = ccb.content.text("You're mad.  You have to be stopped."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        { text = ccb.content.text("Whatever.  I'm leaving."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_FIGHT",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.text("I knew a Kindred would not understand.  But I can't allow you to stop me.  If you try, I'll have no option but to fight you.  But know that should you win, you'll be ridding the world of the only hope it has."),
        no = ccb.content.text("I can't allow you to stop me.  If you try, I'll have no option but to fight you.  Maybe I'll die, or maybe you will.  But know that should you win, you'll be ridding the world of the only hope it has."),
    },
    replies = {
        {
            text = ccb.content.text("All I'm ridding the world of is a dangerous madman.  Now die."),
            next_topic = "TALK_DONE",
            actions = {
                "hostile",
                actions.set_actor_value("speaker", "dialogue_cooper_fought_cooper", "yes"),
            },
        },
        {
            text = ccb.content.text("This is a waste of time not worth the risk.  I'm out of here."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_AGREE",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.gendered_line("You're like me then, Kindred.  I'm glad I'm not the only one who realizes what's necessary.  Perhaps one day, we'll be able to work together, but what I do now, I must do alone.", { "speaker" }),
        no = ccb.content.text("I'm glad you realize the necessity of the burden I bear.  Maybe someday we'll even join our forces, but for now, I have to do this alone."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_cooper_cooper_friendly", "yes") },
        },
    },
    replies = {
        { text = ccb.content.text("I won't delay you then.  Good luck."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("That being said, I need to know why you do it - what purpose it fills."),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_WORK",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.gendered_line("You're Kindred, and yet you question the power the bones hold, the Song itself?  This hypocrisy is why I set off on my own.  Stop wasting my time and get out of my way.", { "speaker" }),
        no = ccb.content.text("I know it's hard to comprehend when you can't hear the song.  The bones hold power, you just don't hear it yet.  But you will, eventually."),
    },
    replies = {
        {
            text = ccb.content.text("I meant no offense.  I'm sure you have your reasons."),
            next_topic = "TALK_COOPER_AGREE",
        },
        {
            text = ccb.content.text("What about the woman you mentioned - Brigitte - what happened to her?"),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } }),
        },
        {
            text = ccb.content.text("Brigitte was right.  I can't reason with you.  You have to be stopped."),
            next_topic = "TALK_COOPER_FIGHT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("You're rambling.  I can't let you keep hurting people.  This ends now."),
            next_topic = "TALK_COOPER_FIGHT",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("This is a waste of time.  I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_NOTFMLR",
    line = ccb.content.text("Brigitte did not mention me?  I'm surprised.  Perhaps she's starting to understand I was right.  I was with her for a time, learned from her.  I'm still on her side, but she doesn't realize it yet."),
    replies = {
        {
            text = ccb.content.text("You know Brigitte?  What happened with you two?"),
            next_topic = "TALK_COOPERS_SIDE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_INTRODUCTION",
    line = ccb.content.text("I scavenge only so I can survive, but I have a much greater goal than just to live."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_cooper_goal_dk", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("A… goal?  What do you mean?  What is there to do other than survive?"),
            next_topic = "TALK_COOPER_GOAL",
        },
        {
            text = ccb.content.text("Uh, okay then.  I have to go now; have a nice day."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_GOAL",
    line = ccb.content.text("Something changed during the Collapse - the apocalypse, if you prefer that.  The way the dead rise again and again, it's tied to their bones - notice that only when you pulp and crush them properly do they actually die.  A woman I met - Brigitte was her name - taught me how to use the power.  We call it the Song, since if you know how, you can hear it, a quiet hum in the bones.  If I collect enough Song, the concentrated power can reverse the Cataclysm.  Undo all of this."),
    on_enter = {
        {
            actions = {
                actions.clear_actor_value("speaker", "dialogue_first_meeting_cooper_goal_dk"),
                actions.set_actor_value("speaker", "dialogue_first_meeting_cooper_goal_k", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Do you have any proof that this will work?"),
            next_topic = "TALK_COOPER_WORK",
        },
        {
            text = ccb.content.text("You mentioned a woman, Brigitte.  Why isn't she with you?  What happened?"),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } })),
        },
        {
            text = ccb.content.text("Wait, Brigitte LaCroix?  I've met her."),
            next_topic = "TALK_COOPER_KNOWBRIG",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } })) }),
        },
        { text = ccb.content.text("That's insane.  I'm going."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_KNOWBRIG",
    line = ccb.content.text("Small world, huh?  I hope she's doing fine.  Despite our differences, I owe everything to her.  I hope one day we'll be able to reconcile."),
    replies = {
        {
            text = ccb.content.text("So, how do you know that any of this works?"),
            next_topic = "TALK_COOPER_WORK",
        },
        {
            text = ccb.content.text("What differences?  Why did you part ways?"),
            next_topic = "TALK_COOPERS_SIDE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_ABOUT",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
        yes = ccb.content.text("I was born here in New England, lived here all my life.  Was an accountant before the Collapse, if you can believe that.  There wasn't really anything special about my life before I learned about the Song, so there isn't much to say."),
        no = ccb.content.text("Sorry, but I don't know you that well and I'd rather not go into that."),
    },
    replies = {
        {
            text = ccb.content.text("I understand."),
            next_topic = "TALK_KINDRED_COOPER",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } })),
        },
        {
            text = ccb.content.text("Do you have a favorite food?"),
            next_topic = "TALK_COOPER_FOOD",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
        },
        {
            text = ccb.content.text("I see.  Thanks for sharing."),
            next_topic = "TALK_KINDRED_COOPER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_FOOD",
    line = ccb.content.text("I've always loved crêpes."),
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_KINDRED_COOPER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_KILL_PLAYER",
    line = ccb.content.text("No.  You seem like you have a chance of surviving in this world.  Plus, you took the time to actually hear me out, so there is a chance one day you'll hear the Song the same way I do."),
    replies = {
        {
            text = ccb.content.text("Nevertheless, I can't allow you to keep killing people."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        {
            text = ccb.content.text("I'm glad you see it that way."),
            next_topic = "TALK_COOPER_AGREE",
            when = predicates.negate(predicates.has_trait("speaker", "seer_mark")),
        },
        {
            text = ccb.content.text("Maybe one day I will."),
            next_topic = "TALK_COOPER_AGREE",
            when = predicates.has_trait("speaker", "seer_mark"),
        },
        {
            text = ccb.content.text("This is a waste of time.  I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}
