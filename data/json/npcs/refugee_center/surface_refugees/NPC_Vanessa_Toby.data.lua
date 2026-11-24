local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_VanessaToby",
    unique_name = ccb.content.text("Vanessa Toby"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Vanessa",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Vanessa_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Vanessa_1",
}

-- Vanessa is a middle-aged hairdresser.  She doesn't want to talk about her past.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Vanessa",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 0 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { -4, 2 } },
    perception = { rng = { -1, 4 } },
    worn = "REFUGEE_Vanessa_worn",
    carry = "REFUGEE_Vanessa_carried",
    weapon = "REFUGEE_Vanessa_wield",
    traits = {
        { trait = "SKIN_TAN" },
        { trait = "hair_medium", variant = "gray" },
        { trait = "natural_hair_color_gray" },
        { group = "NPC_starting_traits" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -5 } } } } } },
        },
        { skill = "tailor", bonus = { rng = { 1, 2 } } },
        { skill = "swimming", bonus = { rng = { 1, 2 } } },
        { skill = "cooking", bonus = { rng = { 0, 2 } } },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Vanessa_1_firstmeet", "TALK_REFUGEE_Vanessa_2", "TALK_REFUGEE_Vanessa_Background",
        "TALK_REFUGEE_Vanessa_Situation",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Vanessa_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Vanessa_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Vanessa_Situation",
        },
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("I'd like to hire out those scissors of yours."),
            next_topic = "TALK_REFUGEE_Vanessa_Haircut",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "vanessa_haircut_in_progress")), predicates.negate(predicates.has_effect("interlocutor", "vanessa_shave_in_progress")), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Vanessa_Mission1" } }) }),
        },
        {
            text = ccb.content.text("Hmm, can we change this haircut a little please?"),
            next_topic = "TALK_CUT_YOUR_HAIR",
            when = predicates.has_effect("interlocutor", "vanessa_haircut_in_progress"),
        },
        {
            text = ccb.content.text("Hmm, can we change this shave a little please?"),
            next_topic = "TALK_CUT_YOUR_BEARD",
            when = predicates.has_effect("interlocutor", "vanessa_shave_in_progress"),
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
    id = "TALK_REFUGEE_Vanessa_1",
    line = ccb.content.text("*looks you up and down for several seconds before speaking.  \"Oh, great.\"  Her voice is husky with years of smoking, and her glare suggests it's a habit she's recently given up.  \"Another new mouth to feed?  Just what we need.  Well, I'm Vanessa.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Vanessa_Toby", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Vanessa_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm not a new mouth to feed, but nice to meet you too."),
            next_topic = "TALK_REFUGEE_Vanessa_1_firstmeet",
        },
        { text = ccb.content.text("Yeah, no.  I'm going."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_1a",
    line = ccb.content.gendered_line("*peers at you for a while before speaking.  \"Oh, you're back.\"", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Hi, Vanessa.  What's up?"),
            next_topic = "TALK_REFUGEE_Vanessa_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_1_firstmeet",
    line = ccb.content.text("Well that's good.\"  She purses her lips and gives you another judgmental stare.  \"If you're going to pull your own weight I guess that's an improvement."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_2",
    line = ccb.content.text("Not much is up.  Not enough, in fact.  Here we are stuck in this slum pit with a bunch of strangers, and all we can do is sit around staring at our hands."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Background",
    line = ccb.content.text("I don't really want to talk about my life before this shit-show, if that's what you mean.\"  She shrugs.  \"I don't need a shoulder to cry on.  I'm a hairdresser, is that enough personal information for you?"),
    replies = {
        {
            text = ccb.content.text("Could you give me a haircut?"),
            next_topic = "TALK_REFUGEE_Vanessa_Haircut_no",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Vanessa_Mission1" } })),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Situation",
    line = {
        joined = {
            {
            when = predicates.handler("dlg_p_dda_defb5ab5fdd2"),
            yes = ccb.content.text("Well, I'm stuck in a dank shitty brick building with two dozen strangers, the world's dead"),
            no = ccb.content.text("You want the sarcastic version, or the really sarcastic version?  I'm stuck in a dank shitty brick building with two dozen strangers, the world's dead"),
        },
            {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_flag_tacoma_started" } }),
            yes = ccb.content.text(", and all anyone will talk about is this new ranch they're building, as though it'll solve all our food problems"),
            no = ccb.content.text(", and there's not enough food to go around"),
        },
            {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Vanessa_Mission1" } }),
            yes = ccb.content.text(".  At least I can do some work to keep me busy though, and the extra merch does go a long way to keeping my belly full.  People like getting a good haircut."),
            no = ccb.content.text(".  Why don't you fuckin' figure it out?"),
        },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Haircut_no",
    line = ccb.content.text("I can see you need one, but last time I used these shears it was to stab a zombie in the face.  I don't think you'd want them in your hair.  Maybe you could help me get set up properly?"),
    replies = {
        {
            text = ccb.content.text("What can I do to help you out?"),
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
    id = "TALK_REFUGEE_Vanessa_Haircut",
    line = ccb.content.text("Sure, I can give you a haircut.  It'll be six merch for a haircut, or three for a shave, okay?"),
    replies = {
        {
            text = ccb.content.text("[6 merch] Please give me a haircut."),
            next_topic = "TALK_CUT_YOUR_HAIR",
            when = predicates.has_inventory("speaker", "FMCNote", 6),
            actions = { actions.transfer_items("FMCNote", 6), "buy_haircut", actions.add_effect("interlocutor", "vanessa_haircut_in_progress", { turns = 100 }) },
        },
        {
            text = ccb.content.text("[3 merch] Please give me a shave."),
            next_topic = "TALK_CUT_YOUR_BEARD",
            when = predicates.has_inventory("speaker", "FMCNote", 3),
            actions = { actions.transfer_items("FMCNote", 3), "buy_shave", actions.add_effect("interlocutor", "vanessa_shave_in_progress", { turns = 100 }) },
        },
        {
            text = ccb.content.text("Actually, you owe me a free haircut, remember?"),
            next_topic = "TALK_CUT_YOUR_HAIR",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_services_owed_haircut_1" } }),
            actions = { actions.set_actor_value("interlocutor", "mission_services_owed_haircut_1", "no"), actions.add_effect("interlocutor", "vanessa_haircut_in_progress", { turns = 100 }) },
        },
        {
            text = ccb.content.text("Could you fix it to where I can grow my hair out, please?"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "natural_hair_growth")),
            actions = { actions.replace_mutation("speaker", "natural_hair_growth") },
        },
        {
            text = ccb.content.text("I'd like it if my hair didn't grow out anymore.  Can you help me with that?"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "natural_hair_growth"),
            actions = { actions.handler("dlg_a_dda_d8cf71f883be") },
        },
        {
            text = ccb.content.text("Could you fix it to where I can grow my facial hair out, please?"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "natural_beard_growth")),
            actions = { actions.replace_mutation("speaker", "natural_beard_growth") },
        },
        {
            text = ccb.content.text("I'd like it if my facial hair didn't grow out anymore.  Can you help me with that?"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "natural_beard_growth"),
            actions = { actions.handler("dlg_a_dda_c4a0ea5c8862") },
        },
        {
            text = ccb.content.text("That's a bit rich for my blood.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("That's a bit rich for my blood.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Refuse_Boris_Mission_1",
    line = ccb.content.text("Ha ha ha ha!  No."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("I don't know what I expected."), next_topic = "TALK_DONE" } },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Vanessa_1",
    name = ccb.content.text("Make a makeshift haircut kit for Vanessa Toby in the refugee center"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "survivor_hairtrimmer",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("If I had some equipment, I could do some hairdresser work here."),
        offer = ccb.content.text("I didn't think to pack my hairdressing equipment when I was evacuated.  If you could put together a basic hair cutting kit for me, I could do a bit of styling for people around here.  I'll even give you a free haircut for your troubles."),
        accepted = ccb.content.text("Cool, thanks.  It'll be good to have something useful to do, and to not be staring at so many shaggy slobs."),
        rejected = ccb.content.text("Whatever, I'll keep twiddling my thumbs then."),
        advice = ccb.content.text("I don't need too much.  Scissors, a small mirror, a bit of cloth, and some way to keep it all stored clean when I'm not using it, like a leather pouch or something.  I can get the rest of what I need from shelter supplies."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Well, this is pretty serviceable.  Heck, these scissors are nice enough that I could probably inexplicably make your hair longer or a different color with them."),
        success_lie = ccb.content.text("What good does this do me?"),
        failure = ccb.content.text("Seriously?  You failed to find *scissors*?  How do you tie your shoes in the morning?"),
    },
    finish = {
        handler = "advance_counter_refugee_center_refugee_happiness_by_2",
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_Vanessa_Mission1", "yes"),
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_services_owed_haircut_1", "yes"),
        },
    },
}
