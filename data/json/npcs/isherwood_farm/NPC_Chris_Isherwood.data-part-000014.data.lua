local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall",
    line = ccb.content.text("Good idea.  A sandbag wall would be easy enough, we've had to do those a few times when we've had flooding and everyone knows the drill.  Back then we just grabbed supplies from the hardware store, though.  Maybe you'd be able to make a run for those?  Something like 20 canvas bags would probably do it.  We can fill them up in advance and toss them out of the truck to get a decent barricade."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("I think this is going to take too long, honestly.  Let's just stick with the truck."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
        },
        {
            text = ccb.content.text("I know where to find those canvas bags, I'll go get them."),
            actions = { actions.assign_mission("MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS") },
            next_topic = "TALK_DONE",
        },
    },
}
