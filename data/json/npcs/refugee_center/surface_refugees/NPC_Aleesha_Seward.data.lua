local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_AleeshaSeward",
    unique_name = ccb.content.text("Aleesha Seward"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Aleesha",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Aleesha_1",
    faction = "free_merchants",
}

-- Aleesha is fourteen and lost her family
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Aleesha",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -4, -2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -1, 4 } },
    perception = { rng = { -1, 1 } },
    worn = "REFUGEE_Aleesha_worn",
    carry = "REFUGEE_Aleesha_carried",
    weapon = "REFUGEE_Aleesha_wield",
    traits = { { group = "Appearance_African" }, { trait = "NO_BASH" }, { trait = "RETURN_TO_START_POS" } },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Aleesha_2", "TALK_REFUGEE_Aleesha_Background",
        "TALK_REFUGEE_Aleesha_Background_caretaker", "TALK_REFUGEE_Aleesha_Background_influencers",
        "TALK_REFUGEE_Aleesha_Situation",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            trial = { kind = "persuade", difficulty = 25 },
            success = { next_topic = "TALK_REFUGEE_Accept_Boris_Mission_1" },
            failure = { next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1" },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Aleesha_Background",
        },
        {
            text = ccb.content.text("What's your take on the situation here?"),
            next_topic = "TALK_REFUGEE_Aleesha_Situation",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_1",
    line = ccb.content.gendered_line("*seems impossibly young at first glance, her dark face nervous when she sees you looking her way.  On closer inspection as you approach, you see that she is likely in her early teens, but the contrast to the weary faces around makes her age stand out.  \"Oh, uh… hi.  You look new.  I'm Aleesha.\"", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Aleesha_Seward", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Aleesha_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, kid.  What's up?"),
            next_topic = "TALK_REFUGEE_Aleesha_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Aleesha, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_1a",
    line = {
        joined = {
            ccb.content.text("*doesn't quite meet your gaze as you approach.  \""),
            {
                choices = {
                    ccb.content.text("Hey there."),
                    ccb.content.text("Oh, hey, it's you again."),
                    ccb.content.text("What's up?"),
                    ccb.content.gendered_line("You're back, and still alive!  Whoa.", { "speaker" }),
                    ccb.content.text("Aw hey, look who's back."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Aleesha.  What's up?"),
            next_topic = "TALK_REFUGEE_Aleesha_2",
        },
        { text = ccb.content.text("Hi Aleesha.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_1_firstmeet",
    line = {
        when = predicates.handler("dlg_p_dda_1e3f5a885a23"),
        yes = {
            when = predicates.handler("dlg_p_dda_2abaf18a0216"),
            yes = ccb.content.text("I'm not a kid, okay?  I'm sixteen."),
            no = ccb.content.text("I'm not a kid, okay?  I'm fifteen."),
        },
        no = ccb.content.text("I'm not a kid, okay?  I'm fourteen."),
    },
    replies = {
        {
            text = ccb.content.text("Sorry, I didn't mean anything by it.  What's up?"),
            next_topic = "TALK_REFUGEE_Aleesha_2",
        },
        {
            text = ccb.content.text("Sorry, I didn't mean anything by it.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_2",
    line = {
        when = predicates.handler("dlg_p_dda_37c4c4e2de83"),
        yes = ccb.content.text("We're just standing around here waiting, like a bunch of idiots.  We're supposedly waiting to go downstairs to the shelter, but it's been over a month.  I don't think it's happening.  I don't know what we're doing here.  I've read all the books, and there's zombies outside so we're stuck in here.  We can hear them at night."),
        no = ccb.content.text("I don't know what's up.  I'm not sure what we're even doing here.  They say we're supposed to wait until we can be moved to the shelter downstairs, but we've been here days and there's no word on how long we'll be waiting.  It's all so stupid, and nobody can tell me anything.\"  She glances at the shuttered windows.  \"Jenny figures they're never going to let us go down there, so I guess we're going to sort it out up here, one way or another.  It's not fair, but 'fair' doesn't mean much in my life anymore."),
    },
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_Background",
    line = ccb.content.text("*narrows her eyes, her words coming out hoarse and clipped.  \"You can't just go asking people questions like that nowadays.  I'm a teenaged girl alone in an evacuation center after, like, literally everyone in the world died and came back as zombies.  What do you think my story is?  My entire family died, came back as zombies, and I somehow wound up here.\""),
    replies = {
        {
            text = ccb.content.text("Who takes care of you here?"),
            next_topic = "TALK_REFUGEE_Aleesha_Background_caretaker",
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
    id = "TALK_REFUGEE_Aleesha_Background_caretaker",
    line = ccb.content.text("Nobody really.  I'm old enough to work and get merch for my rations.  Jenny and Rhy look out for me though.  They think I don't notice that they're looking out for me, but I do.  It's okay, they're both cool."),
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
    id = "TALK_REFUGEE_Aleesha_Situation",
    line = ccb.content.text("I don't have much of a hot take besides what I just said.  It's shit.  Not enough to do to stay busy, not enough to eat, and even if I had internet, all the YouTubers I follow are dead."),
    replies = {
        {
            text = ccb.content.text("What YouTubers did you follow?"),
            next_topic = "TALK_REFUGEE_Aleesha_Background_influencers",
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
    id = "TALK_REFUGEE_Aleesha_Background_influencers",
    line = ccb.content.text("*looks you up and down, an uncharacteristic glint of humor in her eyes.  \"Why, you thinking of subscribing?  I don't think you'd have heard of them, and even if you had, there's definitely no way for them to get any new content out.  Not anything worth watching anyway.\""),
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
