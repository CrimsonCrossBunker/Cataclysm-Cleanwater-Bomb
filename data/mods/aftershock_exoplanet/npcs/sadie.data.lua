local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Sadie_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } }),
        yes = {
            choices = {
                ccb.content.text("Are we meeting again or did we already do that part?"),
                ccb.content.text("You remind me of my friend Billy."),
                ccb.content.text("What an amazing world to be alive in, more or less."),
                ccb.content.text("My head always beats when I see you.  Or is that my heart?  I should check that."),
                ccb.content.text("It's always so nice to be seen."),
            },
        },
        no = ccb.content.text("Hello Billy.  Back again to try and kill me?  It won't work, you should just give up."),
    },
    replies = {
        {
            text = ccb.content.text("What, who is Billy?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_sadie", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } })),
            next_topic = "TALK_sadie_firstmeet",
        },
        {
            text = ccb.content.text("Die foul creature!"),
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_sadie", "yes"),
                "insult_combat",
            },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } })),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("What did you just inject me with?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_injection_sadie_injection" } }),
            next_topic = "TALK_sadie_injection",
        },
        {
            text = ccb.content.text("Would you like to come with me Sadie?"),
            next_topic = "TALK_sadie_follow",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "following")), predicates.any_equal({ "yes", { scope = "speaker", key = "general_heart_sadie_heart" } }) }),
        },
        {
            text = ccb.content.text("Can you inject me with whatever that was again?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_heart_sadie_heart" } }),
            next_topic = "TALK_sadie_injection2",
        },
        {
            text = ccb.content.text("How did you get here?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_heart_sadie_heart" } })) }),
            next_topic = "TALK_sadie_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_heart_sadie_heart" } })) }),
            next_topic = "TALK_sadie_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Goodbye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_firstmeet",
    line = ccb.content.text("Oh.  I see now.  You have different sexual traits than Billy, likely due to a mutation or cybernetic enhancement, useful in mating rituals, the act of reproduction, and establishing social hierarchies.  Very good, I accept that you are either not Billy or have changed enough that we can establish a new relationship beyond violence, for example based around the gathering of food, mating, or shared hobbies such as badminton or photography.  How do you wish to proceed with our relationship not-Billy?"),
    replies = {
        {
            text = ccb.content.text("I'd like to understand more about you first.  Are you human, more or less?"),
            next_topic = "TALK_sadie_what",
        },
        {
            text = ccb.content.text("You are aware of the Cataclysm?"),
            next_topic = "TALK_sadie_cataclysm",
        },
        {
            text = ccb.content.text("I am your new friend and I'm here to help you."),
            next_topic = "TALK_Sadie_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_what",
    line = ccb.content.text("Yes, much of what you see is human I think.  I don't have the proper equipment to be entirely sure and I have some strange memories.  My beacon has already told you that I am Sadie.  Beyond that I don't know much to tell you.  I know a great deal about medicine.  I have some strange responses to physical stimuli that I don't completely understand.  I think I must be a medical experiment of some kind.  My chest hurts in a really yummy way."),
    replies = {
        { text = ccb.content.text("Can I help you?"), next_topic = "TALK_MISSION_LIST" },
        { text = ccb.content.text("I should go."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_ask_past",
    line = ccb.content.text("I have so many memories, but they feel like they belong to other people?  And animals too I think?  It makes me dizzy and I have to sit down."),
    replies = { { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_Sadie_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_cataclysm",
    line = ccb.content.text("I don't know her."),
    replies = {
        {
            text = ccb.content.text("Yes.  Let's talk about something else."),
            next_topic = "TALK_Sadie_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_ask_mood",
    line = ccb.content.text("Things stay pretty much the same here.  Sometimes I feel bad, and that feels good, and sometimes I feel good, and that feels good too.  Overall things are better than you might expect, but this may be a common experience, in which case things are exactly as you might expect.  Does that make sense?"),
    replies = { { text = ccb.content.text("Perfect sense."), next_topic = "TALK_Sadie_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_injection",
    line = ccb.content.text("I hope you like it, it's one of my favorite things in the world, actually a lot of them all blended together.  It should feel really good.  Or really bad, I guess I don't know much about your body chemistry.  You're still alive, that's a really good sign!"),
    replies = {
        {
            text = ccb.content.text("Wonderful.  Please don't inject me with anything else unless I ask for it in the future."),
            actions = {
                actions.clear_actor_value("speaker", "general_injection_sadie_injection"),
                actions.set_actor_value("speaker", "general_heart_sadie_heart", "yes"),
            },
            next_topic = "TALK_Sadie_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_injection2",
    line = ccb.content.text("I'm so glad you liked it.  It really means a lot to me that we have similar body chemistry.  That's so important for all kinds of biological and emotional compatibility for example organ transplants and the reproductive act.  This shows how I feel about you, I think."),
    replies = {
        {
            text = ccb.content.text("I'm glad we get along so well Sadie."),
            actions = { "give_aid", actions.add_effect("speaker", "sadie_injection", { turns = 200000 }) },
            next_topic = "TALK_Sadie_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_follow",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_u_freed_sadie" } }),
        yes = {
            choices = {
                ccb.content.text("Let's go explore.  There's still so much these eyes haven't seen.  Wait, are these new eyes?  Where did I put my old eyes?  Are they pretty?"),
            },
        },
        no = {
            choices = {
                ccb.content.text("I can't wait to see how wonderful the world must be.  I've heard the shrieking and moaning and cries for help and I just know it's going to be perfect if everyone out there is as sweet and loving as you and Billy."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yes, everyone left is exactly like Billy and me, or worse."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_u_freed_sadie" } })),
            actions = { "follow", actions.set_actor_value("speaker", "general_free_u_freed_sadie", "yes") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("They're even better.  Let's go."),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_u_freed_sadie" } }) }),
            actions = { "follow" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_sadie_heart",
    name = ccb.content.text("Heart for Sadie"),
    description = ccb.content.text("Find a special organ"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 0,
    item = "flesh_golem_heart",
    item_count = 1,
    start = {
        target = {
            terrain = "forest_thick",
            reveal_radius = 1,
            random = true,
            search_range = 18,
            min_distance = 5,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_flesh_golem_afs",
                            x = 11,
                            y = 11,
                            target = true,
                            name = ccb.content.text("Billy"),
                        },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I want your organ."),
        offer = ccb.content.text("I've been feeling really yummy since the last time Billy came to work on me, and I think it's because my heart is gone.  Like literally gone.  I checked.  Billy did a really good job taking it out, but I want to leave this storage unit with you and if I'm going to do that I need a working heart.  My first idea was to take yours, but you probably need it even more.  You know who has a nice big juicy heart?  Billy does.  And I bet I know where Billy is."),
        accepted = ccb.content.text("Aw, I heart that you're going to help me get that big organ."),
        rejected = ccb.content.text("This makes me sad.  Which makes me happy.  So thanks?  Let me know if you change your mind.  I probably shouldn't go without a heart for too too long but I'm kind of enjoying it.  It's like always being on the edge of something horrible, but in a nice way."),
        advice = ccb.content.text("Please be careful cutting that heart out.  If you ruin it I don't know about another good one nearby.  Maybe practice on some friends and neighbors first, you really want to be sure and get it right.  If you break Billy's heart I can use a heart from another of whatever Billy is, but I can't use regular hearts, and I don't know where to find more Billy types."),
        inquire = ccb.content.text("Do you have my heart?"),
        success = ccb.content.text("Ooh, Billy had a really good heart.  Can you turn away please?  I just need to do some quick open chest surgery here.  Just a quick cut here *ooh* and I need to break this and this *SNAP* *oh!* and just sew some little things together here quickly.  Not as much blood as you'd think.  I should probably look into that later, there should be more blood in there.  Ah, good enough, I can do a better job closing up later.  Kind of tingly, feeling everything moving again in there.  See, heart surgery isn't hard if you have the right attitude.  Well now, you need a good reward for everything you've done for me.  Here, let me inject you with this."),
        success_lie = ccb.content.text("I don't know why, but I feel better.  Also worse.  Maybe I'm good without it."),
        failure = ccb.content.text("Oh no, my heart.  Thank you for trying though, your failure gives me pleasure.  What else are you bad at?"),
    },
    finish = {
        actions = {
            "give_aid",
            ccb.content.dialogue_actions.add_effect("speaker", "sadie_injection", { turns = 200000 }),
            ccb.content.dialogue_actions.set_actor_value("speaker", "general_injection_sadie_injection", "yes"),
        },
    },
}
