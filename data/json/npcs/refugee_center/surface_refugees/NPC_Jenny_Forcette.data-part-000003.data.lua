local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Background1",
    line = ccb.content.text("Me?  I trained at MIT in mechanical engineering, I worked for a long time as senior engineer at Marduk Thermal in Rhode Island.  It was a good job, but I landed my dream gig at Boston Dynamics and moved up north to start there.\"  She tips back her head and lets out a long, wistful sigh.  \"I had just finished my orientation and was going to start work when the riots started.  Just my damn luck."),
    replies = {
        {
            text = ccb.content.text("That's impressive, but there must be more to you than just your job."),
            next_topic = "TALK_REFUGEE_JENNY_Background2",
        },
        {
            text = ccb.content.text("You must know some great stuff.  Can you teach me anything?"),
            next_topic = "TALK_REFUGEE_JENNY_Teach1",
            when = predicates.handler("dlg_p_dda_40f96f0660d7"),
        },
        {
            text = ccb.content.text("So, did anyone tell you there are actual no-kidding talking cyborg-robot people out there now?"),
            next_topic = "TALK_REFUGEE_JENNY_Exodii",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        },
        {
            text = ccb.content.text("Sorry about your luck.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
