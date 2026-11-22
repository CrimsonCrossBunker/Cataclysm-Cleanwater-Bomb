local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_STOLE_ITEM",
    replies = {
        {
            text = ccb.content.text("<color_light_green>[Hypnotic Gaze] *Look directly into their eyes*</color>."),
            next_topic = "TALK_HYPNOTIC_GAZE_USED",
            when = predicates.handler("dlg_p_xedra_evolved_937b74baf8cf"),
            actions = { actions.handler("dlg_a_xedra_evolved_545c60862204") },
        },
    },
}
