local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery-Firebricks1",
    line = ccb.content.gendered_line("Seriously?  You've already done so much.  I won't say no, though.", { "speaker" }),
    on_enter = {
        { actions = { actions.offer_mission("MISSION_TACOMA_Pablo_Firebricks"), actions.set_actor_value("speaker", "firebricks_tacoma_bakery", "helped") } },
    },
    replies = {
        {
            text = ccb.content.text("No problem.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Well, I'd better go look into that."),
            next_topic = "TALK_DONE",
        },
    },
}
