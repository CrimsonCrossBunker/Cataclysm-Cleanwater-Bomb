local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_EVAC_4",
    name = ccb.content.text("Solar Power"),
    description = ccb.content.text("Deliver 10 solar panel arrays to help the Free Merchants set up a renewable power grid, in exchange for a handsome reward."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 400000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_FREE_MERCHANTS_EVAC_5",
    finish = {
        item_rewards = { { item = "FMCNote", count = 100 } },
        handler = { "mark_mission_flag_FMShopkeep_Mission4", "deliver_mission_free_merchants_evac_4" },
    },
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We are starting to build new infrastructure here and would like to get a few new electrical systems online… unfortunately our existing system relies on an array of something called RTGs.  Running generators isn't a viable option underground, of course.  We have a big flat roof up top, and if we had a few solar panel arrays we could use them to top up our usage.  We could pay you pretty handsomely to bring us, say, ten solar panel arrays?  If you find any advanced solar panels, those are even better."),
        accepted = ccb.content.text("If you can do this for us our survival options would vastly increase."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("Solar panel arrays are pretty common on solar farms and on rooftops.  Each advanced solar panel array is worth two solar panel array."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great, I know it isn't much but we hope to continue to expand thanks to your help."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    complete_when = "complete_mission_free_merchants_evac_4",
}
