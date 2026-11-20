local ccb = require("ccb")

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
