local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_4",
    name = ccb.content.text("Secure Trade Route"),
    description = ccb.content.text("One of the Free Merchants silently disappeared while escorting a trade caravan.  Whoever or whatever is responsible must be quick and quiet - investigate the trade route and eliminate the threat."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 100000,
    start = {
        target = { terrain = "field", reveal_radius = 5, random = true, search_range = 30 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_spider_trapdoor_small",
                            x = 12,
                            y = 12,
                            target = true,
                            repetitions = { 3, 5 },
                        },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REP_5",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("There is another monster troubling the merchants but this time it isn't human… at least I don't think.  Guy just disappeared while walking behind a packed caravan.  They didn't hear any shots but I suppose some raider may have been real sneaky.  Check out the area and report anything you find."),
        accepted = ccb.content.text("Thanks, keeping the people safe is what we try and do."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("Search the bushes for any trace?  I'm not an expert tracker but you should be able to find something."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great work, wasn't sure what I was sending you after."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
