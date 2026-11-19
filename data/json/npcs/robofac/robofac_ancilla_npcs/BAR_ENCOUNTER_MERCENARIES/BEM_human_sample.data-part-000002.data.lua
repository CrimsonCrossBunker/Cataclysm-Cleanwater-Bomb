local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE2",
    line = ccb.content.text("Most I can give is two gold coins.  I've arranged a drop in the nearby woods, put the goods there and you can get your cash with the barkeep here."),
    replies = {
        {
            text = ccb.content.text("It'll get done."),
            actions = { actions.assign_mission("BEM_human_sample_mission"), "end_conversation" },
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Not interested after all?"), next_topic = "TALK_DONE" },
    },
}
