local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "refugee_UyenTran",
    unique_name = ccb.content.text("Uyen Tran"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Uyen",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_REFUGEE_Uyen_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Uyen_1",
}

-- A paramedic who suffers a bit of racism for being Asian
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Uyen",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 0, 3 } },
    perception = { rng = { -1, 3 } },
    worn = "REFUGEE_Uyen_worn",
    carry = "REFUGEE_Uyen_carried",
    weapon = "REFUGEE_Uyen_wield",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_SouthAsian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    proficiencies = { "prof_knitting" },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -2, 2 } } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 3, 5 } } },
        { skill = "speech", bonus = { rng = { 0, 2 } } },
    },
}

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Uyen_2", "TALK_REFUGEE_Uyen_Background", "TALK_REFUGEE_Uyen_Situation",
        "TALK_REFUGEE_Uyen_Training", "TALK_REFUGEE_Uyen_World", "TALK_REFUGEE_Uyen_Kaiju",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "TALK_REFUGEE_Accept_Boris_Mission_1" },
            failure = { next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1" },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Uyen_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Uyen_Situation",
        },
        {
            text = ccb.content.text("Could you teach me a bit about first aid?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_flag_Uyen_teach" } }),
            next_topic = "TALK_REFUGEE_Uyen_Teach",
        },
        {
            text = ccb.content.text("What do you think happened to the world?"),
            next_topic = "TALK_REFUGEE_Uyen_World",
        },
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_1",
    line = ccb.content.gendered_line("*studies you with interest, her eyes lined with fatigue but still alert.  She brushes a lock of hair off her forehead.  \"Hi there.  You look new, nice to meet you.  My name's Uyen.\"", { "interlocutor" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Uyen_Tran", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Uyen_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Uyen."),
            next_topic = "TALK_REFUGEE_Uyen_1_firstmeet",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_1a",
    line = {
        joined = {
            {
                choices = {
                    ccb.content.text("*smiles and brushes her hair out of her eyes.  \""),
                    ccb.content.text("*looks you up and down with a faint smile.  \""),
                    ccb.content.text("*suppresses a yawn, then sees you approaching and nods with recognition.  \""),
                },
            },
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
        { text = ccb.content.text("Hi, Uyen.  Got a minute?"), next_topic = "TALK_REFUGEE_Uyen_2" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_1_firstmeet",
    line = ccb.content.text("What brings you around here?  We don't see a lot of new faces."),
    replies = {
        {
            text = ccb.content.text("Just a traveler.  Can I ask you a few things?"),
            next_topic = "TALK_REFUGEE_Uyen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_2",
    line = ccb.content.text("I'm always good for a talk.  It gets pretty boring down here."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Background",
    line = ccb.content.text("I was a paramedic.\"  She idly touches her forehead to brush aside a bit of hair, then notices it's already tucked back.  \"I was there through some of the absolute worst of it, to this day I can't tell you how I made it out.  One thing led to another and I got pushed onto a bus to help take care of a couple people who needed assistance for travel.  Broken arms, that kinda stuff.  I got here early, I was one of the first to arrive.  Then, this woman in processing 'lost' my paperwork while I was busy helping a guy with a bad gash on his head.  If I hadn't made a stink about it, I'd probably be out in the lobby with those poor souls that couldn't get in at all."),
    replies = {
        {
            text = ccb.content.text("You're medically trained?  Do you know if anyone's found any way to deal with zombie bites?"),
            next_topic = "TALK_REFUGEE_Uyen_Bites",
        },
        {
            text = ccb.content.text("Could you teach me a bit about first aid?"),
            next_topic = "TALK_REFUGEE_Uyen_Teach",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Bites",
    line = ccb.content.text("I'm not sure what you mean by 'deal with'.  I've been handling zombie bites the same way I handle any other bite.  Clean it and dress it, try to prevent infection.  There's no, like, venom or anything.  Once the wound is cleaned and dressed, it's not going to do anything special.  Zombie mouths are really dirty though, so you want to make sure you do a good job cleaning it out."),
    replies = {
        {
            text = ccb.content.text("So if the bites aren't turning people into zombies, what is?"),
            next_topic = "TALK_REFUGEE_Uyen_Bites2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Bites2",
    line = ccb.content.text("*shrugs.  \"Darned if I know, that's way past my training.  I don't think anyone figured it out anyway, but you'd want a doctor for ideas on that, not a paramedic.  I stabilize and package patients, I don't research cures and causes.\""),
    replies = {
        {
            text = ccb.content.text("Did you ever think about going into nursing or medicine?"),
            next_topic = "TALK_REFUGEE_Uyen_Training",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Training",
    line = ccb.content.text("I'm going to sound like a massive stereotype here, I know, but my parents always pushed hard for me to go into medicine and be a doctor.  I was still thinking it over when, well,\" she gestures expansively around her.  \"Things got complicated.  Honestly though, if the pay were better for being a paramedic I don't know if I'd want to change at all.  I hear there's a lot of burnout after a while, but I haven't seen it yet.  I really liked the work."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_World",
    line = ccb.content.text("*smiles slightly.  \"Everyone's got some idea, hey?  I really don't know.  It seems crazy to even try to guess.  Can you believe we live in a world where corpses come back to life?  There's weirder stuff out there too.  In the hospital, people had all kinds of injuries and talked about seeing monsters.  On the way here, I saw huge creatures in the distance, the sort of thing that belongs in a kaiju movie, not stomping through suburban Worcester.\"  She shrugs.  \"I guess today I'll go with simulation theory.  None of this is real, we're all in a hyper-detailed computer simulation, and the creator is cruel and messing with us.\"  She briefly stares into space, as though looking directly into some imaginary camera.  \"Honestly I don't think any scientific explanation is ever going to get close to the sheer amount of mind-shattering madness around here.\""),
    replies = {
        {
            text = ccb.content.text("Hey wait, are you a fan of kaiju stuff?"),
            next_topic = "TALK_REFUGEE_Uyen_Kaiju",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Kaiju",
    line = ccb.content.text("*grins more broadly.  \"Busted!  Okay, I'm not like, a superfan.  My sister was huge into it, and I kinda picked it up through her, but yeah.  I'd do anything for a night on the couch with her, a copy of Pacific Rim, and a big bowl of popcorn.\""),
    replies = {
        {
            text = ccb.content.text("Maybe I could help.  There are lots of movie discs out there just collecting dust, and you've got electricity."),
            next_topic = "TALK_REFUGEE_Uyen_Kaiju2",
        },
        {
            text = ccb.content.text("Okay, seriously.  Pacific Rim 2 though… what the heck?"),
            next_topic = "TALK_REFUGEE_Uyen_Pacific",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Pacific",
    line = ccb.content.text("*laughs and makes a waving gesture under her nose.  \"It's too bad they never made a sequel.  Can you imagine?  Oh well, they'd probably have done something *unconscionably stupid* like killing off Mako Mori in the first act.  Good thing *that* never happened.\""),
    replies = {
        {
            text = ccb.content.text("You know, there are lots of movie discs out there just collecting dust, and you've got electricity.  I could probably help you out."),
            next_topic = "TALK_REFUGEE_Uyen_Kaiju2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Kaiju2",
    line = ccb.content.text("Right.\"  Her grin fades slowly.  \"There's one ingredient you can't replace, and without her, I don't…\" her voice catches.  \"Sorry.  That's a sweet offer though, I really appreciate it."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Teach",
    line = ccb.content.text("Sure, I don't see why not.  It's always good to have more people who can do it.  I'll need a bit of payment for my time, of course."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "knowledge_flag_Uyen_teach", "yes") } } },
    replies = {
        { text = ccb.content.text("All right, let's do it!"), next_topic = "TALK_TRAIN" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Situation",
    line = {
        joined = {
            ccb.content.text("We've got it okay, I guess"),
            {
            when = predicates.handler("dlg_p_dda_3845f6520b02"),
            yes = ccb.content.text(".  Things have been getting better.  I wasn't even sure it was possible"),
            no = ccb.content.text(", as long as this doesn't last too long."),
        },
            {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
            yes = ccb.content.text(".  With the back room cleared, we've had some chances to come and go, and spread out a bit.  It's made a huge difference to morale.\"  She looks around at the other refugees.  \"We'll have to see what the future holds."),
            no = ccb.content.text(".  The situation is pretty tight, though.\"  She glances around at the huddled crowds of people in the room.  \"If we're stuck here for too long people are going to start getting a bit stir crazy."),
        },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Uyen_1",
    name = ccb.content.text("Find 50 doses of antiseptic"),
    description = ccb.content.text("Find 50 doses of antiseptic for Uyen Tran in the refugee center, in exchange for <reward_count:FMCNote> merch."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "disinfectant",
    item_count = 50,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_REFUGEE_Uyen_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("There's the doc out front helping anyone that can pay… but for us up here, money mostly goes to food.  I could do a lot for basic cuts, bruises, and common stuff if I had some supplies to help out.  Could you bring me some antiseptic?  Six bottles would probably be enough to last us a while."),
        accepted = ccb.content.text("Thanks so much.  It's a small thing but it'd be really helpful."),
        rejected = ccb.content.text("That's okay.  I'm sure we'll make do somehow."),
        advice = ccb.content.text("Lots of people used to have first aid kits in their bathrooms.  I'm sure they can't all have been looted."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks so much.  Listen, I told some of the others what you were up to for us and we pooled our cash to thank you.  It's not much but I hope it helps… these are merch, the local money, you can trade them for goods from the shop.  A lot of us will take them in trade too."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 8 } },
        handler = {
            "mark_mission_flag_Uyen_Mission1",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Uyen_2",
    name = ccb.content.text("Find 30 bandages"),
    description = ccb.content.text("Find 30 bandages for Uyen Tran in the refugee center, in exchange for <reward_count:FMCNote> merch."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "bandages",
    item_count = 30,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_REFUGEE_Uyen_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("There's the doc out front helping anyone that can pay… but for us up here, money mostly goes to food.  I could do a lot for basic cuts, bruises, and common stuff if I had some supplies to help out.  Could you bring me a few extra bandages?  Thirty would probably be enough to last us a while."),
        accepted = ccb.content.text("Thanks so much.  It's a small thing but it'd be really helpful."),
        rejected = ccb.content.text("That's okay.  I'm sure we'll make do somehow."),
        advice = ccb.content.text("Lots of people used to have first aid kits in their bathrooms.  I'm sure they can't all have been looted."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks so much.  Listen, I told some of the others what you were up to for us and we pooled our cash to thank you.  It's not much but I hope it helps… these are merch, the local money, you can trade them for goods from the shop."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 7 } },
        handler = {
            "mark_mission_flag_Uyen_Mission2",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Uyen_3",
    name = ccb.content.text("Find 60 doses of antidepressant"),
    description = ccb.content.text("Find 60 doses of antidepressant for Uyen Tran in the refugee center, in exchange for <reward_count:FMCNote> merch."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "prozac",
    item_count = 60,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We could still use your help…"),
        offer = ccb.content.text("I probably shouldn't be prescribing things, but there's a ton of people needing help with sleep in here.  If you could get us some antidepressants, Rhyzaea and I can probably make sure they're doled out appropriately without people having to starve to pay for them.  Three month's worth - about 6 bottles - would last us a little while."),
        accepted = ccb.content.text("Thanks so much.  It's a small thing but it'd be really helpful."),
        rejected = ccb.content.text("That's okay.  I'm sure we'll make do somehow."),
        advice = ccb.content.text("Antidepressant was really common.  You can probably find it in most medicine cabinets and pharmacies."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks so much.  Listen, I told some of the others what you were up to for us and we pooled our cash to thank you.  You've done a lot to help us out."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_flag_Uyen_Mission3",
            "advance_counter_refugee_center_refugee_happiness_by_3",
        },
    },
}
