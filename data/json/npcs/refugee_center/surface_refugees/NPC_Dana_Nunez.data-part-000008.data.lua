local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_DANA_Sourdough",
    line = ccb.content.text("Sure.  If you really like this second-rate bread, you could risk your life for something actually worth it.  I left my actual sourdough starter back in the bakery where I worked.  That baby is a hundred years old, and has been in my family for generations… if you can bring him to me, I'll bake you the finest bread you've ever had."),
    replies = {
        {
            text = ccb.content.text("Why not?  I'll see what I can do."),
            next_topic = "TALK_DANA_Sourdough2",
            actions = { actions.offer_mission("MISSION_REFUGEE_Dana_Sourdough"), actions.set_actor_value("speaker", "mission_flag_Dana_Sourdough", "yes") },
        },
        {
            text = ccb.content.text("Maybe not right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
