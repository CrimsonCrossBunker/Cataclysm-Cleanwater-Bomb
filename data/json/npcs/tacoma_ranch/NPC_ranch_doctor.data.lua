local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Provides advanced medical attention.
ccb.content.define_npc {
    id = "ranch_doctor",
    suffix = ccb.content.text("Doctor"),
    class = "NC_DOCTOR",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_DOCTOR",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_aid" } }),
        yes = ccb.content.text("How can I help you today?"),
        no = ccb.content.text("I'm sorry, I don't have time to help you at the moment."),
    },
    replies = {
        {
            text = ccb.content.text("Is there anything else I can help with?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_completed_supplies" } }) }),
        },
        {
            text = ccb.content.text("Maybe I could help you with something?"),
            next_topic = "TALK_RANCH_DOCTOR_SUPPLIES",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_completed_supplies" } })), predicates.negate(predicates.has_mission("MISSION_RANCH_DOCTOR_SUPPLIES")) }),
            actions = { actions.offer_mission("MISSION_RANCH_DOCTOR_SUPPLIES"), actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_completed_supplies", "no") },
        },
        {
            text = ccb.content.text("I couldn't find any crutches, but I made these.  Will they work?"),
            next_topic = "TALK_RANCH_DOCTOR",
            when = predicates.all({ predicates.has_inventory("speaker", "makeshift_crutches", 1), predicates.has_mission("MISSION_RANCH_DOCTOR_CRUTCHES") }),
            actions = { actions.handler("dlg_a_dda_d1e14371ac3a"), "mission_success", "clear_mission" },
        },
        {
            text = ccb.content.text("Could you help me with some bionics?"),
            next_topic = "TALK_RANCH_DOCTOR_BIONICS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodization_u_knows_exodiilore" } }),
        },
        {
            text = ccb.content.text("I could use your medical assistance."),
            next_topic = "TALK_RANCH_DOCTOR_AID",
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_AID",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_aid" } }),
        yes = {
            when = predicates.has_effect("interlocutor", "currently_busy"),
            yes = ccb.content.text("I have other patients to attend to.  Come back later."),
            no = ccb.content.text("What can I help you with?"),
        },
        no = ccb.content.text("I can't right now, I have other matters to attend to."),
    },
    replies = {
        {
            text = ccb.content.text("[80 merch, 30m] I need you to patch me up."),
            next_topic = "TALK_RANCH_DOCTOR_AID_DONE",
            when = predicates.all({ predicates.has_inventory("speaker", "FMCNote", 80), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_aid" } }) }),
            actions = { actions.handler("dlg_a_dda_c9a8f16599db"), "give_aid" },
        },
        {
            text = ccb.content.text("[200 merch, 1h] I need you to patch my friends up."),
            next_topic = "TALK_RANCH_DOCTOR_AID_DONE",
            when = predicates.all({ predicates.has_inventory("speaker", "FMCNote", 200), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_aid" } }) }),
            actions = { actions.handler("dlg_a_dda_4e70409e125d"), "give_all_aid" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_AID_DONE",
    line = ccb.content.gendered_line("Take it easy now.  Wouldn't want you coming back here too soon.", { "speaker" }),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_BIONICS",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_surgery" } }),
        yes = ccb.content.text("If you mean something like pacemaker, then maybe.  What's the trouble?"),
        no = ccb.content.text("If you mean something like pacemaker, we can't really do much without anesthesia."),
    },
    replies = {
        {
            text = ccb.content.text("No, i mean something, eeh, more sci-fi.  There are robo-guys in a stone castle, they say they have such technology.  They even installed something into me, look!"),
            next_topic = "TALK_RANCH_DOCTOR_BIONICS_DUNNO",
            when = predicates.handler("dlg_p_dda_ccdeb4054639"),
        },
        {
            text = ccb.content.text("No, i mean something, eeh, more sci-fi.  There are robo-guys in a stone castle, they say they have such technology."),
            next_topic = "TALK_RANCH_DOCTOR_BIONICS_DUNNO",
            when = predicates.handler("dlg_p_dda_d84e565d8670"),
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_BIONICS_DUNNO",
    line = {
        when = predicates.handler("dlg_p_dda_ccdeb4054639"),
        yes = ccb.content.text("Curious.  Sorry, i have no idea how it works, and i'd be afraid to even touch this parts."),
        no = ccb.content.text("Are you all right?  Sci-fi bionic by robots in a stone castle?  I have some antipsychotics, if it helps."),
    },
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_SUPPLIES",
    line = ccb.content.text("I'm running out of office supplies.  I know… of all the things to need at a time like this!  I just need to be able to keep track of and organize medical records so that I can focus on helping people.  Ten binders and a ream of paper should tide me over until some shipments come in."),
    replies = {
        {
            text = ccb.content.text("I'll see what I can find."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_completed_supplies", "no"),
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC_DELIVERED",
    line = ccb.content.text("Thanks, this will help a lot."),
    replies = {
        { text = ccb.content.text("Glad to help."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_DOCTOR_SUPPLIES",
    name = ccb.content.text("Collect Office Supplies"),
    description = ccb.content.text("The doctor needs office supplies to keep track of medical records.  Bring them 10 Book binders and 500 paper."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RANCH_DOCTOR_CRUTCHES",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Have you found the supplies yet?"),
        success = ccb.content.text("Thanks!  This should help keep things organized for a while."),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = {
                    item_group_placements = {
                        {
                            group = "ranch_doctor_filing_cabinets",
                            x = { 5, 8 },
                            chance = 100,
                            y = 0,
                            repetitions = 5,
                            faction = "tacoma_commune",
                        },
                        {
                            group = "ranch_doctor_filing_cabinets",
                            x = { 5, 8 },
                            chance = 100,
                            y = 2,
                            repetitions = 5,
                            faction = "tacoma_commune",
                        },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "furniture",
                            id = "f_filing_cabinet",
                            x = 5,
                            y = 0,
                            end_x = 8,
                            end_y = 0,
                        },
                        {
                            shape = "rectangle",
                            operation = "furniture",
                            id = "f_filing_cabinet",
                            x = 5,
                            y = 2,
                            end_x = 8,
                            end_y = 2,
                        },
                    },
                },
            },
        },
        before_rewards = { "deliver_paper_500_items", "deliver_book_binder_10_items" },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_completed_supplies", "yes"),
        },
    },
    complete_when = "complete_mission_ranch_doctor_supplies",
}

ccb.content.define_mission {
    id = "MISSION_RANCH_DOCTOR_CRUTCHES",
    name = ccb.content.text("A Crutch to Lean on"),
    description = ccb.content.text("Bring the doctor some crutches."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 2500,
    item = "crutches",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_DOCTOR_MEDICAL_GLOVES",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("One of the laborers injured their foot pretty badly and I don't want them walking on it for a few days at least.  Do you think you could find a pair of crutches?"),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You might be able to find some in hospitals, but some makeshift crutches would be better than nothing."),
        inquire = ccb.content.text("Do you have the crutches?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_DOCTOR_MEDICAL_GLOVES",
    name = ccb.content.text("Find 5 Pairs of Medical Gloves"),
    description = ccb.content.text("Bring the doctor 5 pairs of medical gloves."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 3500,
    item = "gloves_medical",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We're getting a lot of scrapes and bruises coming in right now, but it's only a matter of time before we see a serious injury.  I'm not prepared for when that happens and I'm hoping you can help.  To start off, I'm going to need some more medical gloves to help prevent infections.  Can you bring me 5 pairs?"),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Hospitals or clinics might have a few sitting around."),
        inquire = ccb.content.text("Do you have the medical gloves?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_provides_aid", "yes"),
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC",
    name = ccb.content.text("Anesthetic for the Doctor"),
    description = ccb.content.text("Bring the doctor 3000 units of anesthetic.  Ask around the commune for assistance in building an anesthetic machine."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_NULL",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I want to make sure we are setup to handle any major surgeries that come our way, but pain management is going to be an issue.  For longer surgeries, we're going to need some anesthetic.  Can you bring me 3000 units to start?  We're also going to need an anesthetic machine to deliver it.  Maybe some people around the commune can help with that?"),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Hospitals or clinics might have some.  Labs could have some as well."),
        inquire = ccb.content.text("Any progress on getting some anesthetic or parts?"),
        success = ccb.content.text("The scavengers found more medical equipment than I expected and with the help from the scrappers, I've been able to get most of it up and running.  I should be able to perform more operations now."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = {
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_anesthetic", x = 19, y = 19 },
                    },
                },
            },
        },
        before_rewards = { "set_mission_flag_Doctor_rewarded_to_no", "deliver_anesthetic_3000_items" },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_provides_surgery", "yes"),
        },
    },
    complete_when = "complete_mission_ranch_doctor_medical_anesthetic",
}
