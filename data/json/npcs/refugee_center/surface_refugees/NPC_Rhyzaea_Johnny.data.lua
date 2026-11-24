local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_RhyzaeaJohnny",
    unique_name = ccb.content.text("Rhyzaea Johnny"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Rhyzaea",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Rhyzaea_1",
    faction = "free_merchants",
}

-- A counselor from far away, Rhy can offer a lot of supports to player and survivors if she can get herself sorted a little
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Rhyzaea",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 0, 3 } },
    perception = { rng = { -1, 3 } },
    worn = "REFUGEE_Rhyzaea_worn",
    carry = "office",
    weapon = "REFUGEE_Rhyzaea_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_Mixed" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -2, 1 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 3, 7 } } },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Rhyzaea_1_firstmeet", "TALK_REFUGEE_Rhyzaea_2", "TALK_REFUGEE_Rhyzaea_Background",
        "TALK_REFUGEE_Rhyzaea_Situation",
    },
    line = ccb.content.text("What brings you around here?  We don't see a lot of new faces."),
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_REFUGEE_Accept_Boris_Mission_1" },
            failure = { next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1" },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Rhyzaea_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Rhyzaea_Situation",
        },
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
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
    id = "TALK_REFUGEE_Rhyzaea_1",
    line = ccb.content.text("Hi there.  I don't think we've met before.  I'm Rhyzaea, people call me Rhy."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Rhyzaea_Johnny", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Rhyzaea_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Rhy."),
            next_topic = "TALK_REFUGEE_Rhyzaea_1_firstmeet",
        },
        {
            text = ccb.content.text("Nice to meet you, Rhy.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_1a",
    line = {
        joined = {
            ccb.content.text("*tilts her head in recognition as you approach.  \""),
            {
                choices = {
                    ccb.content.text("Hello again."),
                    ccb.content.text("Good to see you're still around."),
                    ccb.content.text("Oh, hi."),
                    ccb.content.text("Need to talk?"),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Rhy.  How's it going?"),
            next_topic = "TALK_REFUGEE_Rhyzaea_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_1_firstmeet",
    line = ccb.content.text("So, what's your story?  We don't see a lot of new people back here."),
    replies = {
        {
            text = ccb.content.text("Just a curious traveler.  What's up with you?"),
            next_topic = "TALK_REFUGEE_Rhyzaea_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_2",
    line = ccb.content.text("I'm doing as well as can be expected, I suppose.  Nice of you to ask."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_Background",
    line = ccb.content.text("It's a long, long story.  I'm not from around here, I'm actually from way out in Western Canada.  I'd always wanted to see New England, and I was down here on vacation when, well, you know.  I got evacuated, but because I'm not a US citizen they weren't willing to take me downstairs.  I can understand that, even if I don't like it much.  To tell you the truth I'm still coming to terms with the fact that I'll probably never know how my family and my band are doing."),
    replies = {
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Background2",
        },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Family",
        },
        {
            text = ccb.content.text("Tell me about your band."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Band",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_Background2",
    line = ccb.content.text("I was a counselor actually, I worked for my band, Gitxsan.  Did a lot of mental health and addictions for people that had been through some really tough stuff.  Maybe not zombies eating your child level tough, but surprisingly not far off.  My people have gone through some real messy crap."),
    replies = {
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Family",
        },
        {
            text = ccb.content.text("Tell me about your band."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Band",
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
    id = "TALK_REFUGEE_Rhyzaea_Band",
    line = ccb.content.text("My band is Gitxsan, we're from Northwestern British Columbia, around the Skeena River.  I'm from Hazelton, myself.  It's a beautiful place.  Tall mountains, temperate rainforests… I partly came here because I love those wet coastal forests, and I love exploring them in other countries.  I've been to Korea and Slovenia for the same reason.  I guess I'm a bit of a forest tourist?  I don't know if I'll ever see my own forest again, and the thought breaks my heart."),
    replies = {
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Background2",
        },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Family",
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
    id = "TALK_REFUGEE_Rhyzaea_Family",
    line = ccb.content.text("My mom and dad are back in Hazelton, they live with my grandma and my older brother; he took a hard knock to the head doing dumb things as a kid, and he can't really take care of himself now.  I have a daughter, Angel, she's sixteen and didn't want to come with me on this trip.  God help me, I can't bear to think of her, she must think I'm dead."),
    replies = {
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Background2",
        },
        {
            text = ccb.content.text("Tell me about your band."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Band",
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
    id = "TALK_REFUGEE_Rhyzaea_Situation",
    line = {
        when = predicates.handler("dlg_p_dda_0878c016a807"),
        yes = {
            when = predicates.handler("dlg_p_dda_d82dc5cb5113"),
            yes = {
                when = predicates.handler("dlg_p_dda_defb5ab5fdd2"),
                yes = ccb.content.text("It's tense here.  Maybe it always will be.  Still, things have been getting a bit better lately, and it's showing in a bit of a cascade effect.  It's hard to say what will be the ongoing effects of the trauma we've been through, but in the short term, people are starting to settle into whatever this new life we've got is.  I hope we can keep that going."),
                no = ccb.content.text("There have been a lot of improvements around here, and I think the pressure has gone off a bit.  There's a lot that still needs to be done, of course.  I don't think we're out of the woods yet.  We've all seen things that are hard to even wrap your head around; you know how that is."),
            },
            no = ccb.content.text("Things are maybe looking up, a tiny bit.  At least there's been some positive change.  Still, people up here are barely hanging on.  I've seen trauma before, a lot, but this is pretty much the worst imaginable.  Everyone has lost everything, with a huge dose of nightmare on top of it all.  We're putting on a brave face, and a little bit of hope is going a long way."),
        },
        no = ccb.content.text("People up here are barely hanging on.  I've seen trauma before, a lot, but this is pretty much the worst imaginable.  Everyone has lost everything, with a huge dose of nightmare on top of it all.  We're putting on a brave face, but without help, things are going to break, really soon."),
    },
}
