local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_GuneetSingh",
    unique_name = ccb.content.text("Guneet Singh"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Guneet",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Guneet_1",
    faction = "free_merchants",
}

-- Guneet is the Singhs' sixteen year old son.  Like his parents, he is wracked with survivor's guilt for his family having made it out intact.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Guneet",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Guneet_worn",
    carry = "REFUGEE_Guneet_carried",
    weapon = "REFUGEE_Guneet_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_SouthAsian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -5 } } } } } },
        },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Guneet_2", "TALK_REFUGEE_Guneet_Background", "TALK_REFUGEE_Guneet_Situation",
        "TALK_REFUGEE_Guneet_Family",
    },
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
            next_topic = "TALK_REFUGEE_Guneet_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Guneet_Situation",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_1",
    line = ccb.content.text("*is a young man in a white turban, surprisingly clean compared to the rest of his outfit.  He turns from the window as you approach, then raises his eyebrows when he sees you're a new face.  \"Oh, hello.  I don't think I've seen you around before.  I'm Guneet, people call me Gunny.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Guneet_Singh", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Guneet_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Gunny."),
            next_topic = "TALK_REFUGEE_Guneet_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Gunny, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_1a",
    line = {
        joined = {
            ccb.content.text("*turns away from the window, noticing you coming close.  \""),
            {
                choices = {
                    ccb.content.text("Hey there."),
                    ccb.content.text("Hi."),
                    ccb.content.text("Hey again."),
                    ccb.content.text("Oh, hi."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Gunny.  What's up?"), next_topic = "TALK_REFUGEE_Guneet_2" },
        { text = ccb.content.text("Hi Gunny.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_1_firstmeet",
    line = ccb.content.text("I guess we're still doing that stuff?  Cool.  Nice to meet you too.  What's up?"),
    replies = {
        {
            text = ccb.content.text("I just had some questions."),
            next_topic = "TALK_REFUGEE_Guneet_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_2",
    line = ccb.content.text("What's up?\"  He stares at you for a moment.  \"What a weird question.  The world ended.  That's what's up.  What am I supposed to answer to that one?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_Background",
    line = ccb.content.text("I was in high school, you know.\"  Gunny jabs his thumb at his shirt, which reads 'Alexander Bullock High'.  \"Most of the way through my junior year.  'My story'?  I got on a bus with my parents, the bus crashed, and everyone died except a few people, most of whom are crammed into this little shelter now.  Who knows when we're getting out."),
    replies = {
        {
            text = ccb.content.text("Your family all made it here?"),
            next_topic = "TALK_REFUGEE_Guneet_Family",
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
    id = "TALK_REFUGEE_Guneet_Family",
    line = ccb.content.text("Yeah, we did.\"  He gestures to a turbaned older man, speaking quietly with a small woman a little way away.  \"Seems like it should be a great thing, right?  It is.  We're super lucky.  But I can't help feel like people blame us for it.  I keep wondering, y'know, 'why us'.  What makes me so special?  And how can I even enjoy this, when everyone around me is hurting so bad?"),
    replies = {
        {
            text = ccb.content.text("Is there something you could do to help the others?"),
            next_topic = "TALK_REFUGEE_Guneet_Help",
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
    id = "TALK_REFUGEE_Guneet_Help",
    line = ccb.content.text("*shrugs.  \"I don't have any skills.  I'm just a kid.  What am I going to do?\"  Before you can answer, he shakes his head.  \"I'm being pathetic, sorry.  You're right, I should see if there's something I can give back to the community, maybe make my place in it.  That's a good call.\"  He scratches his chin and looks out a gap in the shutters on the window.  \"Thanks.\""),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_9c8e651a478c") } },
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
    id = "TALK_REFUGEE_Guneet_Situation",
    line = {
        joined = {
            ccb.content.text("It sucks in here, there's no two ways about it"),
            {
            when = predicates.handler("dlg_p_dda_f4f8d93f10a9"),
            yes = ccb.content.text(".  Still, we're starting to find a bit of a place for ourselves.  I've been hanging out with Aleesha a bit, I didn't used to think we'd have a lot in common but there's more than you'd think.  My mom and dad are starting to relax a little too."),
            no = ccb.content.text(".  People don't talk to us because we wear turbans and we still have each other.  They think because we're still together, we didn't lose anything.  My dad believes it, too, and I think my mom's on the fence."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Your family all made it here?"),
            next_topic = "TALK_REFUGEE_Guneet_Family",
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
