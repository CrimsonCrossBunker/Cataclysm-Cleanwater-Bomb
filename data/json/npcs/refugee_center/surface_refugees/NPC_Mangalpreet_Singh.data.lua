local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_MangalpreetSingh",
    unique_name = ccb.content.text("Mangalpreet Kaur"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Mangalpreet",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Mangalpreet_1",
    faction = "free_merchants",
}

-- Mangalpreet is the mother of a small family.  They've made it through this unscathed and have a lot of survivor's guilt.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Mangalpreet",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -2, 2 } },
    perception = { rng = { -2, 2 } },
    worn = "REFUGEE_Mangalpreet_worn",
    carry = "REFUGEE_Mangalpreet_carried",
    weapon = "EMPTY_GROUP",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_SouthAsian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "cooking", bonus = { rng = { 3, 4 } } },
        { skill = "tailor", bonus = { rng = { 2, 4 } } },
        { skill = "fabrication", bonus = { rng = { 1, 2 } } },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Mangalpreet_2",
        "TALK_REFUGEE_Mangalpreet_Background",
        "TALK_REFUGEE_Mangalpreet_Situation",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Mangalpreet_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Mangalpreet_Situation",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_1",
    line = ccb.content.gendered_line("*is a well-kept middle aged woman with dark hair tied back in a long braid.  She looks surprised as you approach.  \"Ah!  You are new.  I'm sorry, I'm Mangalpreet.\"", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Mangalpreet_Singh", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Mangalpreet_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Mangalpreet."),
            next_topic = "TALK_REFUGEE_Mangalpreet_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Mangalpreet, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_1a",
    line = {
        joined = {
            ccb.content.text("*gives you a solemn nod of recognition.  \""),
            {
                choices = {
                    ccb.content.text("Hello again."),
                    ccb.content.text("Hi there."),
                    ccb.content.text("Oh, hello there."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Mangalpreet."), next_topic = "TALK_REFUGEE_Mangalpreet_2" },
        {
            text = ccb.content.text("Hi Mangalpreet.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_1_firstmeet",
    line = ccb.content.text("Yes, I'm glad to meet you too.  Will you be staying with us?  I thought they were taking no more refugees."),
    replies = {
        {
            text = ccb.content.text("I'm a traveler actually.  Just saying hello."),
            next_topic = "TALK_REFUGEE_Mangalpreet_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_2",
    line = ccb.content.text("Is there anything you'd like to talk about?"),
    replies = { { text = ccb.content.text("Not really.  <end_talking_leave>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_Background",
    line = ccb.content.text("Before the end of the world, I was the vice principal of an elementary school.  Now, I'm not sure what I am.  A person without a purpose."),
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
    id = "TALK_REFUGEE_Mangalpreet_Situation",
    line = {
        joined = {
            ccb.content.text("I have my family.  I have the Guru Granth Sahib"),
            {
            when = predicates.handler("dlg_p_dda_f4f8d93f10a9"),
            yes = ccb.content.text(".  For a while, I thought these might not be enough but… I am allowing myself to hope"),
            no = ccb.content.text(".  I have these things, but I do not have peace.  No one here does"),
        },
            {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
            yes = ccb.content.text(".  Still, we have so much work to do to make a home here."),
            no = ccb.content.text(".  We are crowded, we are plagued by the sounds and the memories of the dead.  The situation is grim."),
        },
        },
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
