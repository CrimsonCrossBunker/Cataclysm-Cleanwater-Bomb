local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_JESSE_1",
    name = ccb.content.text("Kill wolves"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 50000,
    followup = "MISSION_ISHERWOOD_JESSE_2",
    start = {
        target = { terrain = "forest_thick", reveal_radius = 1, random = true, min_distance = 8 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_wolf", pack_size = { 4, 8 }, x = 3, y = 9, target = true },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We could use some help killing some wolves."),
        offer = ccb.content.text("There's been some wolves that keep scaring our chickens and horses, I'd be grateful if you can kill them."),
        accepted = ccb.content.text("Wonderful, let me know when it is done."),
        rejected = ccb.content.text("Thanks anyway, we will try some traps."),
        advice = ccb.content.text("A gun will probably help."),
        inquire = ccb.content.text("Did you kill it?"),
        success = ccb.content.text("I appreciate it, I've got this old saddle I want you to have.  I'll be happy to put a horse under it if you want to do some more heroics."),
        success_lie = ccb.content.text("Show me the bodies."),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "horse_tack", count = 1 } } },
}
