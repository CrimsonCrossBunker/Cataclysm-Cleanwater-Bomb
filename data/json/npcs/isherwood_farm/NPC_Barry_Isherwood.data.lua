local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_BARRY",
    name = ccb.content.text("Barry Isherwood"),
    job_description = ccb.content.text("Missing member of the Isherwood family."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    perception = { one_in = 4 },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "rifle", bonus = { rng = { 7, 10 } } },
        { skill = "archery", bonus = { rng = { 8, 10 } } },
    },
    worn = "naked_prisoner",
    carry = "naked_prisoner",
    weapon = "naked_prisoner",
}

ccb.content.define_npc {
    id = "isherwood_barry",
    unique_name = ccb.content.text("Barry Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_BARRY",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ISHERWOOD_BARRY_RESCUE",
    faction = "isherwood_family",
    on_death = "isherwood_barry_death",
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_RESCUE",
    line = ccb.content.text("*crouches on the bottom of his cell, shivering, then looks up as you approach.  He blinks a few times, then stands up.  He's totally nude, and his tanned body is covered in tiny, precise-looking scars of varying ages.  \"I can't believe my eyes.  Please get me outta here…\""),
    replies = {
        {
            text = ccb.content.text("Are you Barry Isherwood?"),
            next_topic = "TALK_ISHERWOOD_BARRY_ID",
            when = predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1"),
        },
        {
            text = ccb.content.text("I'll get you out of here, just stay calm.  <lets_go>"),
            next_topic = "TALK_ISHERWOOD_BARRY_Escaping",
            when = predicates.negate(predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1")),
        },
        {
            text = ccb.content.text("I'm Luke Skywalker, I'm here to rescue you."),
            actions = { actions.set_actor_value("speaker", "too_short_to_be_a_stormtrooper", "unclear") },
            next_topic = "TALK_ISHERWOOD_BARRY_BADJOKE",
        },
        {
            text = ccb.content.text("You just hold tight here for a second."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_BADJOKE",
    line = ccb.content.text("What?\"  The naked, traumatized man stares at you blankly, as though he'd never seen Star Wars, which is clearly ridiculous.  \"Rescue me?  Yes, oh please yes!"),
    replies = {
        {
            text = ccb.content.text("Are you Barry Isherwood?"),
            next_topic = "TALK_ISHERWOOD_BARRY_ID",
            when = predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1"),
        },
        {
            text = ccb.content.text("Okay then, your family's outside.  Let me go get them."),
            next_topic = "TALK_DONE",
            when = predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1"),
            actions = { actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY") },
        },
        {
            text = ccb.content.text("Let's go."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1")),
            actions = { "follow_only", actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY"), actions.assign_mission("MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM") },
        },
        {
            text = ccb.content.text("Hang on.  I've got questions."),
            next_topic = "TALK_ISHERWOOD_BARRY_ID2",
        },
        {
            text = ccb.content.text("Just hold on a little longer, okay?"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_ID",
    line = ccb.content.text("*gulps.  \"I sure as hell am.  Did my family send you?  Please, we gotta go.  There are more of those things.  They're everywhere.\""),
    replies = {
        {
            text = ccb.content.text("Yeah, they did, I'll go get them."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_25f8b6ccfbd6"),
            actions = { actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY") },
        },
        {
            text = ccb.content.text("Yeah, Chris did, we're taking you home."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_79ff390b1048"),
            actions = { "follow_only", actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY"), actions.assign_mission("MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM") },
        },
        {
            text = ccb.content.text("Hang on.  I've got questions."),
            next_topic = "TALK_ISHERWOOD_BARRY_ID2",
        },
        {
            text = ccb.content.text("Just hold on a little longer, okay?"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_ID2",
    line = ccb.content.text("*switches, abruptly, to pure white-hot rage.  \"DOES THIS LOOK LIKE A TIME FOR FUCKING QUESTIONS?\"  He stops, shaking, and returns to how he was before.  \"I'm sorry.  I'm so sorry.  Oh god, I'm sorry.  I need to get out of here.\""),
    replies = {
        {
            text = ccb.content.text("Okay, me too, let's go."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_79ff390b1048"),
            actions = { "follow_only", actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY"), actions.assign_mission("MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM") },
        },
        {
            text = ccb.content.text("All right, we're leaving, but you better not test me again."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_79ff390b1048"),
            actions = { "follow_only", actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY"), actions.assign_mission("MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM") },
        },
        {
            text = ccb.content.text("Okay, me too.  I'll go get your family."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_25f8b6ccfbd6"),
            actions = { actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY") },
        },
        {
            text = ccb.content.text("All right, we're leaving, but you better not test me again.  I'll be back with your family."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_25f8b6ccfbd6"),
            actions = { actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY") },
        },
        {
            text = ccb.content.text("Pff.  If you're gonna treat me like that, you can stay here."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_Escaping",
    line = ccb.content.text("Let's get back to the farm, as fast as possible."),
    replies = {
        {
            text = ccb.content.text("What farm?"),
            next_topic = "TALK_ISHERWOOD_BARRY_Escaping_What_Farm",
            when = predicates.negate(predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1")),
            actions = { actions.set_actor_value("speaker", "general_knowledge_u_dont_know_about_farm", "yes") },
        },
        {
            text = ccb.content.text("That shouldn't take long, your family's outside waiting.  I'll be back with them."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_25f8b6ccfbd6"),
            actions = { actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY") },
        },
        {
            text = ccb.content.text("That shouldn't take long, I brought some of your family with me.  Let's get you home."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_645e47120623"),
            actions = { "follow_only", actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY"), actions.assign_mission("MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_Escaping_What_Farm",
    line = ccb.content.text("\"Oh, so my family didn't send you then.\"  Barry looks downtrodden for a brief moment.  \"Look, we just need to get out of here first, I'll tell you about it later.\""),
    replies = {
        {
            text = ccb.content.text("Okay, sounds good to me.  <lets_go>"),
            next_topic = "TALK_DONE",
            actions = { "follow_only", actions.set_actor_value("speaker", "general_meeting_barry_following", "yes"), actions.handler("dlg_a_dda_ae8215ae9312"), actions.set_first_topic("TALK_ISHERWOOD_BARRY") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ISHERWOOD_BARRY", "TALK_ISHERWOOD_BARRY_askback" },
    replies = {
        {
            text = ccb.content.text("Sorry about the Luke Skywalker joke."),
            next_topic = "TALK_ISHERWOOD_BARRY_Skywalker",
            when = predicates.handler("dlg_p_dda_83412419eedf"),
        },
        {
            text = ccb.content.text("Hey buddy, feel like talking about what you saw in that tower?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_no",
            when = predicates.handler("dlg_p_dda_61f35a916aef"),
        },
        {
            text = ccb.content.text("Hey buddy, feel like talking about what you saw in that tower?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_fresh1",
            when = predicates.handler("dlg_p_dda_fce8b3e8f29e"),
        },
        {
            text = ccb.content.text("What farm were you going to tell me about earlier?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_farm",
            when = predicates.handler("dlg_p_dda_40f45cad35d8"),
        },
        {
            text = ccb.content.text("I've thought about it some more, and I'd like to have the directions to your farm."),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_farm_directions",
            when = predicates.handler("dlg_p_dda_90081a4518b7"),
        },
        {
            text = ccb.content.text("Maybe let's talk about you a little bit.  What's your role in this family?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_family1",
            when = predicates.handler("dlg_p_dda_72f3f2dcc42f"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_a3533956124c"),
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_ed841dee1cbd"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY",
    line = {
        when = predicates.handler("dlg_p_dda_f09586a92822"),
        yes = ccb.content.text("Come on, let's get out of here while we still can.  I don't want to spend any longer around here than we need to."),
        no = {
            when = predicates.handler("dlg_p_dda_a1724e70f34f"),
            yes = ccb.content.text("Come on, let's get out of here while we still can.  I don't want to spend any longer around here than we need to."),
            no = {
                when = predicates.handler("dlg_p_dda_8ea3f4781fac"),
                yes = ccb.content.text("Come on, let's get out of here while we still can.  I don't want to spend any longer around here than we need to."),
                no = {
                    when = predicates.handler("dlg_p_dda_2ca4afb3a151"),
                    yes = ccb.content.text("Come on, let's get out of here while we still can.  I don't want to spend any longer around here than we need to."),
                    no = {
                        joined = {
                            ccb.content.text("*lights up as you approach, but also looks wary.  \""),
                            {
                            when = predicates.any_equal({ "unclear", { scope = "speaker", key = "too_short_to_be_a_stormtrooper" } }),
                            yes = ccb.content.text("Hey, Jedi.\""),
                            no = ccb.content.text("Hey, <name_g>.\""),
                        },
                            {
                            when = predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1"),
                            yes = ccb.content.text("I can't wait to get back home and see everyone.\""),
                            no = "",
                        },
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_askback",
    line = ccb.content.text("*nods.  \"Of course, what'd you want to ask?\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_no",
    line = ccb.content.text("Yeah, I think we need to talk about it, but I'm not ready yet.  Let me reclaim my life for a while."),
    replies = { { text = ccb.content.text("Sounds good, Barry."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_Skywalker",
    line = ccb.content.text("*laughs.  \"It was terrible timing, but I have to admit, you don't see many situations that perfect for that reference.  Sorry I didn't get it at the time.\""),
    replies = {
        {
            text = ccb.content.text("Can I ask you some questions?"),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_fresh1",
    line = ccb.content.text("It's still a bit fresh, but okay.  Yeah.  Let me sit down first.\"  Barry takes a seat, his hands shaking even at the prospect of discussing the tower and the things he saw.  \"What should we talk about?"),
    replies = {
        {
            text = ccb.content.text("What happened to you in there?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_fresh2",
        },
        {
            text = ccb.content.text("On second thought, I think you should recover more."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_fresh2",
    line = ccb.content.text("*shivers, though the room is warm, and moves his mouth wordlessly for a few seconds.  \"It's hard to remember details.  The air in that place messes with your brain, makes it all feel like some kind of dream.  Makes it so you can't fight back.  Not that I could have anyway.\"  He stares into space for a moment, then swallows hard.  \"They cut into me, over and over.  I don't think they took anything out.  They just opened me up, poked around.  I was awake for all of it, as awake as for anything else.  Sometimes I felt pain, other times they did something to me so I could feel it but it didn't hurt.  There were big, pale ones that did the cutting.\"  His voice gets increasingly detached as he speaks, and his shaking grows worse.  You're not sure it would be wise for him to go further."),
    on_enter = {
        { once = "barry_PTSD1", actions = { actions.handler("dlg_a_dda_0f0f5ab4b53f") } },
    },
    replies = {
        {
            text = ccb.content.text("[Let him continue.]"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_fresh3",
        },
        {
            text = ccb.content.text("That's enough for now, Barry."),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_fresh_stop",
        },
        {
            text = ccb.content.text("On second thought, I think you should recover more."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_fresh3",
    line = ccb.content.text("*shudders, looking like he might vomit.  \"What did they want?  Why me?  Every time, they'd put me back together again, seal it up and make it look almost like nothing happened.\"  He yanks up his shirt to show the scars.  \"But I know what happened, it was REAL, goddammit!\"  He drops the shirt, bends forward, and dry heaves for a few seconds.  Wordless, he hides his face in his hands, and stops responding."),
    replies = { { text = ccb.content.text("[Leave.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_fresh_stop",
    line = ccb.content.text("Yeah.  Yeah.\"  He takes a long, shaky breath.  \"Yeah, you're right.  This isn't going anywhere good.  Claire's been talking about making some dandelion wine,\" he says with a hollow smile.  \"Maybe I'll go see if she needs help."),
    replies = {
        {
            text = ccb.content.text("How about we change the subject instead?  What's your role in this family?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_family1",
        },
        { text = ccb.content.text("Good idea."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_family1",
    line = ccb.content.text("&He wipes his hand across his face, tension leaving him as he runs his fingers through his hair.  \"Yeah, okay.  To be honest, years ago I was the black sheep.  Moved off the family farm, lived out in Bunyan.  Went to college, thought I'd get a job in computers.\"  He shuffles in his chair, smiling half-heartedly.  \"I did sysadmin stuff for a while, back when the internet was fairly new.  Then my dad died.  Carlos and Jesse had just gotten married, and at the time it looked like they might be getting some land of their own, and Eddie was out finding himself.  My dad and I had never got along, but Jack…\" he stops.  \"Sorry, I don't think you were looking for my life story.  What did you ask, again?\""),
    replies = {
        { text = ccb.content.text("No, go on."), next_topic = "TALK_ISHERWOOD_BARRY_TOWER_family2" },
        {
            text = ccb.content.text("You're right.  I was asking something different."),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
        },
        { text = ccb.content.text("It's okay, I'm going to head out."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_family2",
    line = ccb.content.text("Fair enough, you asked for it.\"  He stretches his arms out.  \"Jack and I stayed close, even after my old man and I fell out, so when it looked like he was going to be saddled with the entire farm to run, I took a good long look at my life and realized I hated it.  It was never the farm I was trying to get away from, you know?  I packed up my things, quit my job, and came out to help Jack.  Never looked back.\"  He chuckles.  \"Damn hard finding a partner for a guy like me out here though.  I was in a long-term relationship when I left, but that fell apart.  I haven't been too lonely though, I've got my people."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_knows_barry_family_story", "yes") } } },
    replies = {
        {
            text = ccb.content.text("[PER 9] Was your choice in partners part of the problem with your father?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_family3",
            when = predicates.minimum_attribute("speaker", "perception", 9),
        },
        {
            text = ccb.content.text("Thanks for taking the time to talk to me.  I had some other questions."),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
        },
        {
            text = ccb.content.text("Thanks for the story.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_family3",
    line = ccb.content.text("&His eyebrows shoot up, briefly surprised, then he smiles.  \"You nailed it in one.  Yeah, we're talking about a rural farmer in the nineties, here.  My dad never understood me, even before he knew, and he did find out, although I tried to keep the closet door closed.  Jack, though, he always saw me for me.  Never let it change our relationship.  That's real love, and that's what made me come back when he needed me.  Meanwhile, the man I thought I'd marry, back in Bunyan, he couldn't be assed even to come out and see the family farm, let alone think about moving here.  He was dead weight, and I've never doubted that decision.\"  He shrugs.  \"There's folks like me wherever you go, I've had a few relationships since then.  Just nothing that stuck, and I'm okay with that.  If nothing else, it proved what I already knew: aside from my old man, none of my family treated me or them any different for it.  They're good people.\""),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_knows_barry_is_gay", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for taking the time to talk to me.  I had some other questions."),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
        },
        {
            text = ccb.content.text("Thanks for the story.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_farm",
    line = ccb.content.text("Oh, yeah, now I remember.  That farm I was talking about is where I live, almost the whole Isherwood family lives there, including me.  I just wanted to get back home as fast as possible so I can see everyone again, and so everyone knows that I'm okay."),
    on_enter = {
        {
            once = "u_learned_about_farm",
            actions = { actions.clear_actor_value("speaker", "general_knowledge_u_dont_know_about_farm") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you give me some directions to it?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_farm_directions",
        },
        {
            text = ccb.content.text("That's pretty cool.  <done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
            actions = { actions.set_actor_value("speaker", "general_knowledge_u_thinking_about_farm", "yes") },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_knowledge_u_thinking_about_farm", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_farm_directions",
    line = ccb.content.text("Sure, can I please see your map?\"  Barry takes your map, orients himself, and points out a route to the farm.  \"Once we've done that, I'll head on myself so everyone won't be surprised by you coming.  Sound good?"),
    replies = {
        {
            text = ccb.content.text("Sounds good to me, let's hit the road."),
            next_topic = "TALK_DONE",
            actions = {
                actions.assign_mission("MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM"),
                actions.clear_actor_value("speaker", "general_knowledge_u_thinking_about_farm"),
            },
        },
        {
            text = ccb.content.text("I'd like to think about it some more."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_knowledge_u_thinking_about_farm", "yes") },
        },
    },
}

-- Dialogue is handled externally.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM",
    name = ccb.content.text("Return Barry to Isherwood's farm."),
    goal = "MGOAL_GO_TO",
    difficulty = 3,
    value = 20000,
    destination = "dairy_farm_isherwood_W",
    start = {
        target = { terrain = "dairy_farm_isherwood_W", special = "Isherwood Farm Mutable", reveal_radius = 3 },
    },
    finish = {
        handler = { "set_world_isherwood_barry_rescued_to_1", "mark_u_saved_barry_isherwood" },
        native_actions = { "stop_following" },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = "",
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}
