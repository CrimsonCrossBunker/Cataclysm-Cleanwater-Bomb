local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear",
    line = ccb.content.text("*looks thoughtful.  \"Well, we can wear our usual wrangling gear, but you're right.  It's no good against those claws.\"  He sighs.  \"I don't want to delay, but I don't want to lose another family member either.  If we could get our hands on some riot gear, that might give us a better chance to fend off the monsters.  Not too far away, our corrupt-as-hell local cops kept enough of that gear on hand to easily set our family up.  As if they needed it in this place.  Just used it to keep the boot on, y'know?\"  He spits on the ground.  \"I can show you where their stores were, it'd feel nice to put that stuff to good use.  Of course, any riot gear would do, if you happen to have already looted some.\""),
    replies = {
        {
            text = ccb.content.text("I think you're right, that would take too long.  We'll have to count on offense being our best defense."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
        },
        {
            text = ccb.content.text("Show me where, and I'll try to get some riot gear for you."),
            actions = { actions.assign_mission("MISSION_ISHERWOOD_CHRIS_1_GET_GEAR") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
