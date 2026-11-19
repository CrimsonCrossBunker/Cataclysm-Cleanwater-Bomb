local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A_Story",
    line = ccb.content.text("We were at the same little evacuation hut, but it was all messed up, just used condoms and broken bottles and lipstick writing on the walls.  We found another group of refugees like us on the road, but they had all been killed, all ripped up, blood everywhere.  We took their food and made it all the way to a big refugee center, but somebody there with a gun told us there was no room, so we're going to a FEMA camp.  They should have more room and supplies.  No guarantees, but it's a chance."),
    replies = {
        {
            text = ccb.content.text("Can you give me directions to that FEMA camp?  I want to go there too if it's so great."),
            next_topic = "TALK_CARAVAN_REFUGEE_A_FEMA",
        },
        {
            text = ccb.content.text("I haven't been to any refugee center.  Can you tell me where it is?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A_CENTER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for the story.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
