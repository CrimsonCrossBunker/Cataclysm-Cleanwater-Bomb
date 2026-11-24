local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_FatimaalJadir",
    unique_name = ccb.content.text("Fatima al Jadir"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Fatima",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Fatima_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Fatima_1",
}

-- A welder, culturally muslim but only recently practicing since the Cataclysm has made her rethink her connections to her family's religion
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Fatima",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 3 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 1 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Fatima_worn",
    carry = "REFUGEE_Fatima_carried",
    weapon = "REFUGEE_Fatima_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_SouthAsian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    proficiencies = { "prof_metalworking", "prof_welding_basic", "prof_welding" },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -2, 1 } } } } } },
        },
        { skill = "fabrication", bonus = { rng = { 3, 7 } } },
        { skill = "mechanics", bonus = { rng = { 3, 7 } } },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Fatima_1_firstmeet", "TALK_REFUGEE_Fatima_2", "TALK_REFUGEE_Fatima_Background",
        "TALK_REFUGEE_Fatima_Situation", "TALK_REFUGEE_Fatima_Welding", "TALK_REFUGEE_Fatima_Cataclysm",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Fatima_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Fatima_Situation",
        },
        {
            text = ccb.content.text("How did you wind up here at the center?"),
            next_topic = "TALK_REFUGEE_Fatima_Cataclysm",
        },
        {
            text = ccb.content.text("Hey, you free for a bit of teaching?"),
            next_topic = "TALK_REFUGEE_Fatima_Teach",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_trade_Fatima_Teacher" } }),
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
    id = "TALK_REFUGEE_Fatima_1",
    line = ccb.content.text("*is a fit young woman dressed in smudged coveralls.  She looks at you with interest and concern.  \"Oh, hey, a new face.  Hi, I'm Fatima.  Just visiting I hope?  It's nice to meet new people but there are no beds to share.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Fatima_al_Jadir", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Fatima_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Fatima.  I'm just passing through."),
            next_topic = "TALK_REFUGEE_Fatima_1_firstmeet",
        },
        {
            text = ccb.content.text("Nice to meet you too, Fatima.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_1a",
    line = {
        joined = {
            ccb.content.text("*futilely dusts a bit of grime on her coveralls, then looks at you.  \""),
            {
                choices = {
                    ccb.content.text("Hello again."),
                    ccb.content.text("Good to see you're still around."),
                    ccb.content.text("Oh, hi."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Fatima.  How are things?"),
            next_topic = "TALK_REFUGEE_Fatima_2",
        },
        { text = ccb.content.text("Hi, Fatima.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_1_firstmeet",
    line = ccb.content.text("Well, cool.  Anything I can help you with?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_2",
    line = ccb.content.text("Oh, you know, the usual.  Trapped in a tight space with a bunch of strangers getting along tenuously at best.  Good times, good times."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Background",
    line = ccb.content.text("Before <the_cataclysm> I had just finished welding school actually, and was about to start looking for a job.  That was fun, being a young Muslim woman in a Massachusetts trade college, let me tell you."),
    replies = {
        {
            text = ccb.content.text("Welding seems like a pretty non-traditional occupational choice; is there a story there?"),
            next_topic = "TALK_REFUGEE_Fatima_Welding",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Welding",
    line = ccb.content.text("You'd be surprised actually!  Metal art has been part of Muslim traditions for years, although that's not why I got into it.  I'm not a very traditional girl.  My parents aren't very traditional either, but my grandparents are really old fashioned and strict.  My sister came out as gay and they made her life really hard; mom and dad thought she should keep it secret, but she didn't believe in that.  I always loved mechanics and working with my hands, so when they started harassing my parents about getting my sister and I married off to nice men so we'd stop being so immoral, I decided to pick a job I liked that would bother them as much as possible.  It was a good choice, not only did it make them livid but I love welding.  I love the feel of standing back and looking at my work, knowing I took a few chunks of scrap metal and made them into something useful.  I love how it feels to make it fit together perfectly.  It just puts me at peace.\n\nI… I do hope my grandparents are okay though.  They were old fashioned, and they made choices I didn't like, but they were family and I still have sweet memories of them from when I was little.  I've had to do a lot more thinking about God since <the_cataclysm>, and while I'd never agree with the decisions they made, I understand more why they thought they had to make them.  They just wanted the whole family to share their relationship with God, in their messed up way."),
    replies = {
        {
            text = ccb.content.text("Welding comes up a lot in my life.  Do you think you could teach me?"),
            next_topic = "TALK_REFUGEE_Fatima_Teach",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Teach",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "barter_flag_Fatima_barter_success" } }),
        yes = ccb.content.text("Sure.  As agreed, 3 merch."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Fatima_Mission1" } }),
            yes = ccb.content.gendered_line("Sure, I could teach you the basics, it'll cost you merch though.  Since you helped me out, I can shave a bit off the price, let's say 4 merch, plus a bit in trade depending on how in-depth you're looking for?", { "speaker" }),
            no = ccb.content.text("Sure, I could teach you the basics, I'll have to charge you though.  Let's say, 5 merch for a teaching session, plus a bit in trade depending on how in-depth you're looking for?"),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "knowledge_trade_Fatima_Teacher", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("[5 merch] All right, here's your money."),
            next_topic = "TALK_TRAIN",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "barter_flag_Fatima_barter_success" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Fatima_Mission1" } })), predicates.has_inventory("speaker", "FMCNote", 5) }),
            actions = { actions.transfer_items("FMCNote", 5) },
        },
        {
            text = ccb.content.text("[4 merch] All right, here's your money."),
            next_topic = "TALK_TRAIN",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "barter_flag_Fatima_barter_success" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Fatima_Mission1" } }), predicates.has_inventory("speaker", "FMCNote", 4) }),
            actions = { actions.transfer_items("FMCNote", 4) },
        },
        {
            text = ccb.content.text("[3 merch] All right, here's your money."),
            next_topic = "TALK_TRAIN",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "barter_flag_Fatima_barter_success" } }), predicates.has_inventory("speaker", "FMCNote", 3) }),
            actions = { actions.transfer_items("FMCNote", 3) },
        },
        {
            text = ccb.content.text("[BARTER] Come on, I'm serious here."),
            when = predicates.handler("dlg_p_dda_891d2a7e9528"),
            trial = { kind = "persuade", difficulty = 35 },
            success = { next_topic = "TALK_REFUGEE_Fatima_Teach_yesbarter" },
            failure = { next_topic = "TALK_REFUGEE_Fatima_Teach_nobarter" },
        },
        {
            text = ccb.content.text("[BARTER] That's still pretty steep, I risked my neck out there for your book.  Can't you manage a little lower?"),
            when = predicates.handler("dlg_p_dda_28ad79fe4659"),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_REFUGEE_Fatima_Teach_yesbarter" },
            failure = { next_topic = "TALK_REFUGEE_Fatima_Teach_nobarter" },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Teach_nobarter",
    line = ccb.content.text("Hey, I appreciate that, but I know what I've got, and I can make good money with that time.  Sorry, my price stands."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_430b6c31392c") } },
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Teach_yesbarter",
    line = ccb.content.text("Oh, fine, you weasel.  I suppose I can manage for 3 notes.  I seriously can't go lower though, we'll be using up my resources and time and I gotta pay for the gas and the food somehow."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "barter_flag_Fatima_barter_success", "yes") },
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
    id = "TALK_REFUGEE_Fatima_Cataclysm",
    line = ccb.content.text("I was on my way to visit my parents back in Burlington, waiting at a bus station, when the evacuation notices started sounding.  I'd been a little out of touch for a bit and didn't realize how bad the rioting was getting.  When my bus arrived it got repurposed into an evacuation vehicle, and took me here.  I… I didn't used to be very religious, it's just something I was born to, but since this happened I've been thinking a lot more about God, and how grateful I am for His help in surviving.  With things still so difficult, it helps to know He's got some plan for me.\n\nAnyway, mine was the second bus to arrive, and they were just getting some triage and processing stuff set up.  I was put in charge of helping with the wounded, along with Uyen.  Things went a little strange later on… one of the women doing triage and processing had a bit of a hang-up about particular, um, colors of people being allowed into the center.  She claimed to have lost our 'papers', along with a lot of other peoples'.  Thankfully because we'd helped so many we were able to argue that they couldn't leave us out, but there was no space left downstairs by the time we got that sorted, so here we are."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Situation",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Jenny_mission_2" } }),
        yes = ccb.content.text("Things are still tense, but I've been busy lately.  Jenny's had her project going and got me started helping her out with it, and for some reason that seems to have been the tipping point: I'm getting chances to do a lot more welding work now.  It's helping.  I feel a bit self-conscious praying in the common areas, and of course, we don't go outside if we can help it."),
        no = ccb.content.text("It's tense here.  I know I'd feel a lot better if I had something to do with my skills, or even if I just had a quiet place to pray sometimes.  I feel a bit self-conscious praying in the common areas.  Jenny was talking about some project ideas she had that could get me doing my job again, but I admit I'm pretty nervous about going outside."),
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Fatima_1",
    name = ccb.content.text("Find a copy of the Quran"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "holybook_quran",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I could use a bit of help to find a copy of the Quran."),
        offer = ccb.content.text("I feel silly asking this, but here goes.  I've never been really into reading holy books and stuff like that.  I usually went to the mosque on Friday, and I try to pray five times a day but I hardly ever manage it.  I guess I'm not a very good Muslim, but with all that's happened I would really love to have a copy of the Quran to read.  This seems like a time to get back in touch with God, you know?"),
        accepted = ccb.content.text("Thank you.  I'll see if I can save up a little reward for you."),
        rejected = ccb.content.text("That's okay.  Thanks for offering."),
        advice = ccb.content.text("It's not as common as the bible, but you should be able to find copies in most libraries and bookstores, or in religious buildings.  Make sure you get the translated version, I can't read Arabic!"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thank you so much.  Just having a copy to keep at hand does actually feel pretty comforting.  I did a few extra rounds of chores and saved the proceeds for if you managed this, here you go.  It's not much but I hope it helps."),
        success_lie = ccb.content.text("What good does this do me?"),
        failure = ccb.content.text("It's okay.  I don't know how much comfort I'd have found in an old book anyway."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_flag_Fatima_Mission1",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}
