local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_npc_class {
    id = "NC_FM_DOCTOR",
    name = ccb.content.text("Doctor"),
    job_description = ccb.content.text("I'm looking for wounded to help."),
    common = false,
    traits = {
        { group = "BG_survival_story_MEDICAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { -2, 0 } },
    intelligence = { rng = { 0, 2 } },
    perception = { one_in = 4 },
    shop_groups = "NC_DOCTOR_misc",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 3, 2 } }, { rng = { -1, -3 } } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 2, 6 } } },
    },
}

-- Appears in the refugee center as a source of missions and info.  Faction critical.
-- Possibly should change to NPC_MISSION_SHOPKEEP and sell medical supplies.
ccb.content.define_npc {
    id = "science_rep",
    suffix = ccb.content.text("Doctor"),
    class = "NC_FM_DOCTOR",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SCIENCE_REP",
    faction = "old_guard",
    missions_offered = "MISSION_SCIENCE_REP_1",
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP",
    line = {
        when = predicates.has_any_trait("speaker", { "PROF_FED" }),
        yes = ccb.content.text("Marshal…"),
        no = ccb.content.text("Citizen…"),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_SCIENCE_REP_NEW",
        },
        {
            text = ccb.content.text("Heard anything about the outside world?"),
            next_topic = "TALK_SCIENCE_REP_WORLD",
        },
        {
            text = ccb.content.text("Can I trade for supplies?"),
            next_topic = "TALK_SCIENCE_REP_ASK_TRADE",
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Can you help me with my bionic implants?"),
            next_topic = "TALK_SCIENCE_REP_CBM",
            when = predicates.handler("dlg_p_dda_9aa5249d2b43"),
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_NEW",
    line = ccb.content.gendered_line("I'm a doctor, one of the several at the outpost.  We were the lucky ones.  Came here right went things started to go wrong, never left.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("So what are you doing right now?"),
            next_topic = "TALK_SCIENCE_REP_NEW_DOING",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_SCIENCE_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_NEW_DOING",
    line = ccb.content.text("The Old Guard--that's what's left of the feds--set me up here to screen any new arrivals for infection risks.  Can't be too paranoid these days.  Sad to have to turn people away, but I like the assignment for the chance to get news about the outside world."),
    replies = {
        { text = ccb.content.text("What kind of news?"), next_topic = "TALK_SCIENCE_REP_NEW_NEWS" },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_SCIENCE_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_NEW_NEWS",
    line = ccb.content.text("Sightings of unusual living dead or new mutations.  The more we know about what's happening, the closer we can get to a treatment or maybe even a cure.  It's a long shot, but you have hope to survive."),
    replies = { { text = ccb.content.text("Good luck with that."), next_topic = "TALK_SCIENCE_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_WORLD",
    line = ccb.content.text("This is no classic zombie outbreak.  The dead seem to be getting stronger as the days go on.  Some survivors too, come in here with… adaptations.  Maybe they're related."),
    replies = { { text = ccb.content.text("Never mind…"), next_topic = "TALK_SCIENCE_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_ASK_TRADE",
    line = ccb.content.text("We can't.  There's nothing we can spare to sell and I've got no budget to buy from you.  I don't suppose you want to donate?"),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_SCIENCE_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCIENCE_REP_CBM",
    line = ccb.content.text("You've got one of those interfaces?  Sure.  Let me fire up the robot."),
    replies = {
        {
            text = ccb.content.text("Would you be able to help me install a bionic implant?"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9aa5249d2b43"),
            actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("Would you be able to take out one of my bionic implants?"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9aa5249d2b43"),
            actions = { "bionic_remove" },
        },
        {
            text = ccb.content.text("Never mind…"),
            next_topic = "TALK_SCIENCE_REP",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_1",
    name = ccb.content.text("Procure a centrifuge"),
    description = ccb.content.text("You need to bring me a <color_light_blue>centrifuge</color>, equipment like this can most commonly be found at <color_light_blue>hospitals</color>, but you can also try to search for it at <color_light_blue>medical labs</color> then bring it back to the <color_light_blue>Doctor</color>."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 50000,
    start = { target = { terrain = "hospital_2", reveal_radius = 3 } },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_SCIENCE_REP_2",
    dialogue = {
        describe = ccb.content.text("It could be very useful to be able to perform an analysis of zombie blood…"),
        offer = ccb.content.text("We don't have the equipment for real analysis here so I'll need you to bring me one.  I've been authorized to reward the completion of this job with 30 merch, a sizeable sum of the local currency."),
        accepted = ccb.content.text("Excellent.  Here, I'll note the location of a hospital nearby, with some luck you should be able to find a centrifuge in working condition there."),
        rejected = ccb.content.text("Are you sure?  The data we could extract with that equipment could be priceless…"),
        advice = ccb.content.text("Centrifuges can be a bit heavy; you might want to locate a smaller one if you can, it will be way easier to transport."),
        inquire = ccb.content.text("Well, do you have the centrifuge yet?"),
        success = ccb.content.text("Excellent!  This may be the key to removing the infection."),
        success_lie = ccb.content.text("Wait, you couldn't possibly have the centrifuge!  Liar!"),
        failure = ccb.content.text("What a shame, that equipment could have proved invaluable…"),
    },
    finish = {
        before_rewards = "deliver_doctor_centrifuge",
        item_rewards = { { item = "FMCNote", count = 30 } },
        handler = "mark_proven_worth_to_old_guard_representative",
    },
    complete_when = "complete_mission_science_rep_1",
}

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_2",
    name = ccb.content.text("Download Workstation Data"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "software_lab_data",
    start = {
        target = {
            terrain = "microlab_generic_surface",
            special = "4x4_microlab_surface",
            reveal_radius = 3,
            cant_see = true,
        },
        map_updates = {
            {
                terrain = "microlab_generic_surface_connector",
                layout = {
                    computer_placements = {
                        {
                            name = ccb.content.text("Laboratory Archives"),
                            chat_topics = { "mission_science_rep_2_computer_main" },
                            x = 21,
                            y = 14,
                            dialogue_on_access = true,
                        },
                    },
                    tile_edits = { { shape = "point", operation = "remove_items", x = 21, y = 14 } },
                },
            },
        },
        actions = { { group = "mission_science_rep_secure_usb_blank" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_SCIENCE_REP_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The medical software didn't just analyze the blood, it triggered a government alert.  Medical staff was under orders to immediately drive any matching samples to the nearest laboratory.  That must mean the government knew!  We have the destination address.  Go there, get in, and bring back any records you can download off a computer.  Like last time, I can compensate you, and the Old Guard saw enough promise in this assignment to spare a larger sum of 60 merch.  I'm sure you're also free to lay claim to any valuables you might find at the target location."),
        accepted = ccb.content.text("Great!  I've mapped out a route to the address.  Bring back anything you find on this secure USB drive."),
        rejected = ccb.content.text("Can't blame you, but come back if you change your mind."),
        advice = ccb.content.text("If the laboratory is locked, maybe you can find an id card from employees who died in the evacuation.  Don't forget the secure USB drive."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("Thanks!  This data looks damaged, but maybe I can make something out of it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = { actions = { { item = "FMCNote", count = 60 } } },
}

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_3",
    name = ccb.content.text("Download Encryption Codes"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "software_encryption_codes",
    start = {
        target = {
            terrain = "lab_subway_vent_shaft_surface",
            special = "microlab_mutable",
            reveal_radius = 3,
            cant_see = true,
        },
        map_updates = {
            {
                terrain = "microlab_portal_dressroom",
                layout = {
                    computer_placements = {
                        {
                            name = ccb.content.text("Security Console"),
                            chat_topics = { "mission_science_rep_3_computer_main" },
                            x = 9,
                            y = 18,
                            dialogue_on_access = true,
                        },
                    },
                    tile_edits = { { shape = "point", operation = "remove_items", x = 9, y = 18 } },
                },
            },
        },
        actions = { { group = "mission_science_rep_secure_usb_blank" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_SCIENCE_REP_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Unfortunately the data you got was incomplete and mostly encrypted.  There may be a way to get encryption codes, though.  I found a complaint by the infosec team that they were unable to deliver critical security updates to one research site.  It was some kind of more restricted secondary site, they weren't allowed in.  That means it should have unsecured computers we can get the codes from.  I couldn't secure any funding for this due to a lack of obvious results, but if you believe in this enough, maybe we can convince them otherwise?"),
        accepted = ccb.content.text("Great!  I've mapped out a route to the address.  Use this secure USB drive as usual."),
        rejected = ccb.content.text("Can't blame you, but come back if you change your mind."),
        advice = ccb.content.text("Expect the lab to be locked as usual.  Don't forget the secure USB drive."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("Wonderful!  Now I just need to get an undamaged, complete archive, and we can really figure out what happened."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_4",
    name = ccb.content.text("Download Research Archives"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "software_archived_data",
    start = {
        target = {
            terrain = "lab_subway_vent_shaft_surface",
            special = "microlab_mutable",
            reveal_radius = 3,
            cant_see = true,
        },
        map_updates = {
            {
                terrain = "microlab_portal_MSU14",
                layout = {
                    computer_placements = {
                        {
                            name = ccb.content.text("Laboratory Archives"),
                            chat_topics = { "mission_science_rep_4_computer_main" },
                            x = 13,
                            y = 5,
                            dialogue_on_access = true,
                        },
                    },
                    tile_edits = { { shape = "point", operation = "remove_items", x = 21, y = 14 } },
                },
            },
        },
        actions = { { group = "mission_science_rep_secure_usb_blank" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_SCIENCE_REP_5",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("So there looks to be months, maybe years of experiments, and that data set must be huge.  That data will have to be backed up somewhere secure and remote.  I heard of a lab that has data servers hidden in a high security vault on lower floors.  I bet the archives inside that lab are still working.  The Old Guard didn't seem very convinced, but still ended up providing 100 merch for this."),
        accepted = ccb.content.text("Excellent!  I've mapped out a route to the address.  Bring back anything you find on this secure USB drive."),
        rejected = ccb.content.text("Can't blame you, but come back if you change your mind."),
        advice = ccb.content.text("That lab is going to be protected by various security systems.  You may need special access cards or a way to cut your way in.  Don't forget the secure USB drive."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("Thanks!  This is a lot of data to go through."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = { actions = { { item = "FMCNote", count = 100 } } },
}

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_5",
    name = ccb.content.text("Find Lab Tunnels"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "train_data",
    start = {
        target = {
            terrain = "underground_lab_cargo_stationA",
            special = "lab_mutagen_6_level",
            reveal_radius = 1,
            cant_see = true,
            z = -4,
        },
        item_rewards = { { group = "mission_science_rep_secure_usb_blank" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("In the data we found a major contract for tunneling and train equipment, ordered eight months ago.  It's the best lead we have.  Here's the address of the government lab where the equipment was delivered.  I want you to go there, find the tunnels that they dug, and download everything you can about the train network.  On the other hand, our sponsors were extremely impressed in getting this far without their direction, and would like to apologize by supporting this mission with a whole 300 merch!"),
        accepted = ccb.content.text("So glad for your help."),
        rejected = ccb.content.text("Can't blame you, but come back if you change your mind."),
        advice = ccb.content.text("The equipment was rated for 50 feet underground, so that tunnel entrance is going to be deeper inside a lab than a normal subway.  Fifty feet would mean maybe four stories down.  Don't forget the secure USB drive."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("Fantastic!  I should be able to reconstruct what cargo moved between which labs.  I wonder what was really going on down there."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = { item_rewards = { { item = "FMCNote", count = 300 } } },
}
