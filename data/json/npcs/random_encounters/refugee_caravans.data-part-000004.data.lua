local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A_FEMA",
    line = ccb.content.text("Of course, we're all in this together.  Let me mark that on your map."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_FEMA_CA") } } },
    replies = {
        {
            text = ccb.content.text("I haven't been to any refugee center.  Can you tell me where it is?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A_CENTER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for the information.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
