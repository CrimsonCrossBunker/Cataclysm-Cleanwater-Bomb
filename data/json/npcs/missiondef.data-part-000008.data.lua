local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_RELIC",
    name = ccb.content.text("Find Relic"),
    description = ccb.content.text("Find a relic of a forgotten saint.  Places like <color_yellow>cathedrals</color> or <color_yellow>museums</color> might have one."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "small_relic",
    start = { reveal_terrain = { "cathedral_1", "museum" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RECOVER_PRIEST_DIARY",
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("As the world seems to abandon the reality that we once knew, it becomes plausible that the old superstitions that were cast aside may have had some truth to them.  Please go and find me a religious relic… I doubt it will be of much use but I've got to hope in something."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("I suppose a large church or cathedral may have something."),
        inquire = ccb.content.text("Any luck?  Please find me a small relic.  Any relic will do."),
        success = ccb.content.text("Thank you, I need some time alone now…"),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
