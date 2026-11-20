local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_meteorologist_5",
    generic_rewards = false,
    name = ccb.content.text("Find the meteorologist's crashed drone"),
    description = ccb.content.text("The meteorologist asked to bring him his crashed drone."),
    goal = "MGOAL_FIND_ITEM",
    item = "module_meteorologist",
    item_count = 1,
    difficulty = 0,
    value = 100,
    start = {
        target = { terrain = "field", reveal_radius = 1, search_range = 50, min_distance = 15, random = true },
        map_updates = {
            {
                layout = {
                    item_placements = {
                        { id = "module_meteorologist", x = { 5, 15 }, y = { 5, 15 } },
                        { id = "scrap", x = { 5, 15 }, y = { 5, 15 }, repetitions = { 5, 30 } },
                        {
                            id = "lens_small",
                            x = { 5, 15 },
                            y = { 5, 15 },
                            chance = 45,
                            repetitions = { 1, 3 },
                        },
                        { id = "cable", x = { 5, 15 }, y = { 5, 15 }, repetitions = { 1, 2 } },
                    },
                    monster_placements = {
                        { id = "mon_mi_go", x = { 5, 15 }, y = { 5, 15 }, repetitions = { 2, 5 } },
                    },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +4).
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "flag_mission_u_helped_meteorologist", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I've lost the drone, we should find out what happened…"),
        offer = ccb.content.text("I'm glad that you are alive and that you haven't forgot about me.  The drone turned out to be great, it managed to take off and even was able to fly several hundred meters!  Unfortunately, after that, I lost control of it… I don't know what happened to it, though.  Maybe you can check?  I'm a little afraid to go out there…"),
        accepted = ccb.content.text("I'm waiting for you."),
        rejected = ccb.content.text("Maybe another time…"),
        advice = ccb.content.text("I don't know quite what happened.  Maybe something noticed my drone and tried to bring it down.  Be careful."),
        inquire = ccb.content.text("How's it going?"),
        success = ccb.content.text("Hmm, I see that the drone is not with you.  Maybe at least the memory module remains?  Okay, show it to me… hmm, situation is worse than I expected, much, much worse… I'm not feeling good.  I don't feel safe in this place anymore.  I have to run, run somewhere.  But where to run if these monsters are everywhere…"),
        success_lie = ccb.content.text("Why do you say that?"),
        failure = ccb.content.text("…"),
    },
}
