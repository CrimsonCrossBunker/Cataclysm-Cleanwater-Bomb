local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
