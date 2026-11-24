local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "NPC_pizzaiolo",
    gender = "male",
    class = "NC_SURVIVOR_CHEF",
    suffix = ccb.content.text("pizzaiolo"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_pizzaiolo_1",
    faction = "no_faction",
    missions_offered = "MISSION_pizzaiolo_1",
}

ccb.content.define_dialogue_topic {
    id = { "TALK_pizzaiolo_1", "TALK_pizzaiolo_Background" },
    line = ccb.content.text_without_extraction("<greet>"),
    replies = {
        {
            text = ccb.content.text("I got the cake.  Shall we move, <name_g>?"),
            when = predicates.all({ predicates.has_item("speaker", "cake2"), predicates.has_mission("MISSION_pizzaiolo_4") }),
            next_topic = "TALK_pizzaiolo_go",
        },
        {
            text = ccb.content.text("About that job…"),
            when = predicates.actor_state("interlocutor", "mission_complete"),
            next_topic = "TALK_MISSION_INQUIRE",
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "TALK_pizzaiolo_Background",
        },
        { text = ccb.content.text("Do you need any help?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("If you still want to travel with me, let's go."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_pizzaiolo_u_helped_pizzaiolo" } }),
            actions = {
                "follow",
                actions.clear_actor_value("interlocutor", "dialogue_pizzaiolo_u_helped_pizzaiolo"),
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_go",
    line = ccb.content.text("Lead the way, <name_g>."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { "follow_only", actions.set_first_topic("TALK_pizzaiolo_following") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_following",
    line = ccb.content.text("Are we there yet, my <name_g>?"),
    replies = {
        {
            text = ccb.content.text("We're here, <name_g>.  Let's celebrate."),
            next_topic = "TALK_pizzaiolo_celebrate",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.has_item("speaker", "cake2") }),
            actions = { "mission_success", "clear_mission", actions.handler("dlg_a_dda_da9f396845ea") },
        },
        {
            text = ccb.content.text("Be patient.  We'll be there soon, <name_g>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_celebrate",
    line = ccb.content.gendered_line("Ah, home sweet home.  It feels like I haven't been here for ages.  Fuck, it looks so horrible now.  I guess it's because of <the_cataclysm>.  Thank you for bringing me here, <name_g>.  Let's eat the cake.", { "interlocutor" }),
    replies = { { text = ccb.content.text("[*NOM-NOM*]"), next_topic = "TALK_pizzaiolo_celebrate1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_celebrate1",
    line = ccb.content.text("Mmm, delicious.  You know, you are good friend, and a good cook.  I'm glad that I'm with you at the day like this.  Say, what do you think about me going with you?  As you can see, my restaurant is thrashes, my house ruined, the only option left is to travel somewhere, and it's better if I do it with someone."),
    on_enter = {
        { actions = { "morale_chat_activity", actions.replace_mutation("interlocutor", "BGSS_pizzaiolo") } },
    },
    replies = {
        {
            text = ccb.content.text("Sure, <name_g>.  <end_talking>"),
            next_topic = "TALK_DONE",
            actions = { "follow" },
        },
        {
            text = ccb.content.text("<end_talking_later>"),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("TALK_pizzaiolo_1"), actions.set_actor_value("interlocutor", "dialogue_pizzaiolo_u_helped_pizzaiolo", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_Background",
    line = ccb.content.gendered_line("I'm just a regular pizzaiolo.  My father was a pizzaiolo, my grandfather was a pizzaiolo and I also became a pizzaiolo.  I was making pizza my whole life, until some American <name_b>s ruined my business!  I couldn't do anything about this, but now, with <the_cataclysm> and <zombies> around, I have a chance to get my revenge!", { "interlocutor" }),
}

ccb.content.define_mission {
    id = "MISSION_pizzaiolo_1",
    name = ccb.content.text("Angry pizzaiolo"),
    description = ccb.content.text("Bring the pizzaiolo to <color_light_blue>their rival's house</color> and don't forget to <color_yellow>bring at least 200 units of gasoline</color>.  After you got there, talk to the pizzaiolo to start burning the house."),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 10000,
    generic_rewards = false,
    start = {
        target = { terrain = "s_restaurant", special = "restraunt", min_distance = 5, z = 0 },
        actions = { "follow_only", ccb.content.dialogue_actions.set_first_topic("MISSION_PYROMANIAC") },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_first_topic("TALK_pizzaiolo_1"),
            "stop_following",
            { handler = "deliver_gasoline_200_items" },
            ccb.content.dialogue_actions.update_map("MISSION_PYROMANIAC_BURN"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_pizzaiolo_2",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("I'm so angry!  I have an enemy that ruined my life, and I want revenge for it!  I don't care about <the_cataclysm>, I just want to burn his <freaking> restaurant!  Will you help me?"),
        accepted = ccb.content.text("Good.  Let's go to his restaurant and fucking burn it!  Oh, by the way, could you bring gasoline with you, <name_g>?  I was so angry I forgot to bring it with me…"),
        rejected = ccb.content.text("What?!  Why do you… ah, forget it."),
        advice = ccb.content.text("Maybe we can find some gasoline at a gas station."),
        inquire = ccb.content.text("Are you ready, <name_g>?"),
        success = ccb.content.text("Sweet, sweet revenge!  It smells so nice!  His restaurant burns, his legacy is now ruined!  Even if he became a <zombie>, it still good."),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}

ccb.content.define_mission {
    id = "MISSION_pizzaiolo_2",
    generic_rewards = false,
    name = ccb.content.text("Find TrueFoodperson"),
    description = ccb.content.text("Help pizzaiolo find TrueFoodperson and kick his ass."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 0,
    value = 10000,
    start = {
        target = { terrain = "s_restaurant_foodplace_roof", min_distance = 5, z = 1 },
        map_updates = {
            {
                terrain = "s_restaurant_foodplace_roof",
                layout = { npc_placements = { { id = "true_foodperson", x = 12, y = 19, target = true } } },
            },
        },
        item_rewards = { { item = "bat" } },
        native_actions = { "follow_only" },
    },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_pizzaiolo_3",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("Ah, it's you, <name_g>.  Wanna continue on my revenge to all American <name_b>s?"),
        accepted = ccb.content.text("Good.  Next stop, Foodplace.  I always hated that place, especially that <freaking> <name_b> in his idiotic mask.  I know he's still alive, hiding in his dumb parody of a restaurant.  Take this bat.  Let's take a visit to him, <name_g>, and kick his <freaking> ass!"),
        rejected = ccb.content.text("What?!  Why do you… ah, forget it."),
        advice = ccb.content.text("I heard that these 'restaurants' use some kind of locking system for staff room, so we would need to find a way to get there."),
        inquire = ccb.content.text("I'm waiting."),
        success = ccb.content.text("Another one bite the dust!  We did good, <name_g>."),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}

ccb.content.define_mission {
    id = "MISSION_pizzaiolo_3",
    generic_rewards = false,
    name = ccb.content.text("Pizza parlor"),
    description = ccb.content.text("Help pizzaiolo take back his restaurant."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 0,
    value = 10000,
    start = {
        target = { terrain = "s_pizza_parlor_1", z = 0 },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "bandit", x = { 7, 22 }, y = { 6, 19 }, target = true },
                        { id = "bandit", x = { 7, 22 }, y = { 6, 19 }, repetitions = { 1, 3 } },
                        { id = "thug", x = { 7, 22 }, y = { 6, 19 }, repetitions = { 2, 4 } },
                    },
                },
            },
        },
        native_actions = { "follow_only" },
    },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_pizzaiolo_4",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("I need to make a last step to achieve my revenge, and the step is - my pizza parlor.  Before <the_cataclysm>, the bank took my place, and now, some <freaking> <name_b>s occupied it and made it their base!  Just unbelievable, I tell ya.  It's time for me to fight back, deal with this <freaking> <name_b>s and regain my honor.  Are you with me, <name_g>?"),
        accepted = ccb.content.text("Very good.  <lets_go>"),
        rejected = ccb.content.text("What?!  Why do you… ah, forget it."),
        advice = ccb.content.text("These <name_b>s might be heavily armed, so we need to prepare to face them."),
        inquire = ccb.content.text("I'm waiting."),
        success = ccb.content.text("Nice, very fucking nice.  Fuck, this placed is thrashed.  <freaking> <name_b>s thrashed my restaurant!  Okay, calm down, calm down, will ya… At least I retrieved my place.  Thank you, <name_g>.  I couldn't make it without you."),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}

ccb.content.define_mission {
    id = "MISSION_pizzaiolo_4",
    generic_rewards = false,
    name = ccb.content.text("Family house"),
    description = ccb.content.text("First bring pizzaiolo some chocolate cake then lead him to his family house."),
    goal = "MGOAL_GO_TO",
    start = {
        target = {
            terrain = "house",
            match = "PREFIX",
            random = true,
            search_range = 75,
            min_distance = 5,
            z = 0,
        },
        actions = {
            { handler = "teach_cake2" },
            ccb.content.dialogue_actions.notify_player(ccb.content.text("You learn how to craft cake.")),
        },
    },
    failure = { actions = { "end_conversation" } },
    difficulty = 0,
    value = 100,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("Now, as my competitors dead, their places are ruined, it's time to relax… I know, let's celebrate it!  Lead me to my house.  Also, we need a cake for that.  What celebration without a cake, right?  I can teach you how to cook it, if you want."),
        accepted = ccb.content.text("Good.  Bring me chocolate cake and talk to me."),
        rejected = ccb.content.text("What?!  Why do you… ah, forget it."),
        advice = ccb.content.text("If you listened to me very closely, it wouldn't be hard for you to make it.  Good luck, <name_g>."),
        inquire = ccb.content.text("I'm waiting."),
        success = ccb.content.text("-"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}

-- MISSION_PYROMANIAC mission set this topic as starting topic for mission giver.
ccb.content.define_dialogue_topic {
    id = "MISSION_PYROMANIAC",
    line = ccb.content.text("Are we there yet, <name_g>?  I can't wait to burn that building!"),
    replies = {
        {
            text = ccb.content.text("We're here.  Let's do it!"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.has_inventory("speaker", "gasoline", 200) }),
        },
        {
            text = ccb.content.text("Be patient, <name_g>, we're getting there soon."),
            next_topic = "TALK_DONE",
        },
    },
}

-- For MISSION_PYROMANIAC. Will spawn fire on tile where PC is standing.
ccb.content.define_mapgen {
    kind = "update",
    id = "MISSION_PYROMANIAC_BURN",
    layout = {
        liquid_placements = { { id = "gasoline", x = { 5, 20 }, y = { 5, 20 }, amount = 5, repetitions = 40 } },
        field_placements = { { id = "fd_fire", x = { 5, 20 }, y = { 5, 20 }, repetitions = 40 } },
    },
}
