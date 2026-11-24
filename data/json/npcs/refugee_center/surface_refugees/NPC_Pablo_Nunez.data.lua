local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_PabloNunez",
    unique_name = ccb.content.text("Pablo Nunez"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Pablo",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Pablo_1",
    age = 28,
    height = 184,
    strength = 10,
    dexterity = 8,
    intelligence = 10,
    perception = 10,
    personality = { aggression = -10, bravery = -5, collector = 2, altruism = 3 },
    faction = "free_merchants",
}

-- Pablo is a young professional who survived with his wife, but she was pregnant and lost the baby.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Pablo",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    worn = "REFUGEE_Pablo_worn",
    carry = "REFUGEE_Pablo_carried",
    weapon = "REFUGEE_Pablo_wield",
    traits = {
        { trait = "QUICK" },
        { trait = "Exp_Bookkeeping1" },
        { trait = "SKIN_MEDIUM" },
        { trait = "eye_color", variant = "brown" },
        { trait = "hair_short", variant = "black" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        { skill = "bashing", bonus = 1 },
        { skill = "computer", bonus = 4 },
        { skill = "cooking", bonus = 1 },
        { skill = "driving", bonus = 2 },
        { skill = "fabrication", bonus = 1 },
        { skill = "mechanics", bonus = 1 },
        { skill = "melee", bonus = 2 },
        { skill = "speech", bonus = 2 },
        { skill = "swimming", bonus = 1 },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Pablo_1_firstmeet", "TALK_REFUGEE_Pablo_2", "TALK_REFUGEE_Pablo_Background1",
        "TALK_REFUGEE_Pablo_Background2_pregnancy", "TALK_REFUGEE_Pablo_Background2_sorry",
        "TALK_REFUGEE_Pablo_Background2_survivors", "TALK_REFUGEE_Pablo_Background2_cleared",
        "TALK_REFUGEE_Pablo_Situation", "TALK_REFUGEE_Pablo_Tacoma", "TALK_REFUGEE_Pablo_Tacoma2",
        "TALK_REFUGEE_Pablo_Recruit",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Pablo_Background1",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Pablo_Situation",
        },
        {
            text = ccb.content.text("Dana wanted me to be the one to let you know: they've got work for you over at the ranch.  You could get out of here if you want."),
            next_topic = "TALK_REFUGEE_Pablo_Tacoma2",
            when = predicates.all({ predicates.has_mission("MISSION_TACOMA_Nunez"), predicates.any_equal({ "phase_3", { scope = "speaker", key = "recruit_general_Nunez_Tacoma" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Pablo."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_1",
    line = ccb.content.text("*looks up at you with a young faced lined prematurely with concern.  \"Hi there.  I'm Pablo, nice to see a new face.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Pablo_Nunez", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Pablo_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Pablo, hey?  Nice to meet you."),
            next_topic = "TALK_REFUGEE_Pablo_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Pablo, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_1a",
    line = {
        joined = {
            ccb.content.text("*dusts off his jacket and makes eye contact with you.  \""),
            {
                choices = {
                    ccb.content.text("Hello, nice to see you again."),
                    ccb.content.text("It's good to see you're still around."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Pablo.  What's up?"), next_topic = "TALK_REFUGEE_Pablo_2" },
        {
            text = ccb.content.text("Hi Pablo, nice to see you too.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_1_firstmeet",
    line = ccb.content.text("We don't get many new faces around here.  How can I help you?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_2",
    line = ccb.content.text("It's been a rough time, adapting to everything that's going on.  What would you like to know about?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background1",
    line = ccb.content.text("I was an accountant before.  Just finished my CPA last year and I already had a position as a manager at my firm.  Everything was looking good.  We decided we were ready for a baby.  Hindsight makes us idiots, hey?"),
    replies = {
        {
            text = ccb.content.text("How did you wind up in this place?"),
            next_topic = "TALK_REFUGEE_Pablo_Background2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2",
    line = ccb.content.text("Dana and I were evacuated early, because of her pregnancy.  They took us to a concentration center, and then we got on a bus to come here.  The bus though, it was rolled over by a giant monster, and many died.  We made it out along with a few others, and we kept going until we made it here.  It wasn't much farther, and for some reason the monster didn't chase us, just kept tearing at the bus."),
    replies = {
        {
            text = ccb.content.text("What about the pregnancy?"),
            next_topic = "TALK_REFUGEE_Pablo_Background2_pregnancy",
        },
        {
            text = ccb.content.text("What happened to the other crash survivors?"),
            next_topic = "TALK_REFUGEE_Pablo_Background2_survivors",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Pablo."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2_pregnancy",
    line = ccb.content.text("The doctor did what she could but after the accident and the stress of the attack… No."),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss."),
            next_topic = "TALK_REFUGEE_Pablo_Background2_sorry",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2_sorry",
    line = ccb.content.text("Thanks.  No, really, thank you.  Others have gone through so much I feel like we should suck it up, but Rhy says we should let ourselves mourn properly and she seems to know her stuff."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2_survivors",
    line = ccb.content.text("From the bus?  A few of us made it in the end; the Singh family were on that bus with us.  We were some of the last refugees to arrive.\"  He gestures to three people gathered together a short distance away.  \"They put us into a room for processing, where a bunch of the wounded were being handled as best as they could manage.  They were short staffed though, and they missed one.  We all thought he was just having a nap, but he wasn't,\" Pablo wipes his face with his hand and pauses for a moment.  \"When he got back up as a zombie, there was a huge panic.  Gunshots in a small, crowded room, and trampling… it was really ugly.  We were close to the door and managed to get out right away, but then a couple panicking people closed the place off and left innocent people in there for what seemed like ages, calling it an 'outbreak'.  By the time leveler heads prevailed, there weren't many people left in there to recover."),
    replies = {
        {
            text = ccb.content.text("I've been back to the quarantined area, cleared it out.  It was ugly back there."),
            next_topic = "TALK_REFUGEE_Pablo_Background2_cleared",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2_cleared",
    line = ccb.content.text("Thanks for that, both for taking away the constant worry about all those <zombies> close at hand, and for putting those poor souls at rest at last."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Situation",
    line = {
        when = predicates.handler("dlg_p_dda_defb5ab5fdd2"),
        yes = ccb.content.text("It's pretty tough here.  People have made so much effort to make things better, and the group is kind of coming together, but I just don't feel like I could ever belong, you know?  I need somewhere with a sky, and a little privacy."),
        no = ccb.content.text("It's pretty tough here.  We're packed into too small a location with too many people.  Everyone is dealing with their own trauma.  Rhy is trying to help out, but she can't be a proper counselor in these circumstances.  I don't know how we're going to survive for long.  As for me, I wish I could be anywhere but here.  I need to see the sky again, or I'm going to go insane."),
    },
    replies = {
        {
            text = ccb.content.text("Why not move to the Tacoma Commune?"),
            next_topic = "TALK_REFUGEE_Pablo_Tacoma",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_flag_tacoma_started" } }), predicates.negate(predicates.has_mission("MISSION_TACOMA_Nunez")) }),
            actions = { actions.assign_mission("MISSION_TACOMA_Nunez") },
        },
        {
            text = ccb.content.text("I've got a secure base.  You and your wife could come with me."),
            next_topic = "TALK_REFUGEE_Pablo_Recruit",
            when = predicates.handler("dlg_p_dda_451497940a38"),
            actions = { actions.set_actor_value("speaker", "recruit_general_Pablo_ask_recruit", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Tacoma",
    line = ccb.content.text("I heard about that place.  What use would they have for an accountant, though?  If they have work for my wife Dana and I, I'd definitely consider it."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Tacoma2",
    line = ccb.content.text("This is amazing news!  Thank you so much!  I've talked to some of the traders who have been there and I really think I can help, mostly with the manual labor but also with the bookkeeping end.  It sounds so much better than this place.  Thanks, my friend!  We'll get packing, and see if we can get a place on the next caravan out.  It'll be a little while I'm sure, but at least our child won't be born in captivity."),
    on_enter = {
        { actions = { actions.finish_mission("MISSION_TACOMA_Nunez", { success = true }), actions.handler("w16b_a_dda_346a0ec563b7"), actions.clear_actor_value("speaker", "tacoma_nunez_trailer_arrive") } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Recruit",
    line = ccb.content.text("Really?  I might consider it.  Talk to my wife, Dana.  She's put down a lot more roots here, it would be up to her I think.  I'd go anywhere right now."),
}

ccb.content.define_mission {
    id = "MISSION_TACOMA_Nunez",
    name = ccb.content.text("Find out if the Nunez family can find work at Tacoma Ranch."),
    goal = "MGOAL_NULL",
    difficulty = 2,
    value = 1000,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Find out if the Nunez family can find work at Tacoma Ranch."),
        offer = ccb.content.text("n/a"),
        accepted = ccb.content.text("n/a"),
        rejected = ccb.content.text("n/a"),
        advice = ccb.content.text("n/a"),
        inquire = ccb.content.text("n/a"),
        success = ccb.content.text("n/a"),
        success_lie = ccb.content.text("n/a"),
        failure = ccb.content.text("n/a"),
    },
}
