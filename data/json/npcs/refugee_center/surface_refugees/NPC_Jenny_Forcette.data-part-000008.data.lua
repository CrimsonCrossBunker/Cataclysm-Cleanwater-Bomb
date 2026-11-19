local ccb = require("ccb")

-- The talk_response to lead here should be in TALK_REFUGEE_JENNY_Project1, and should have these components, saved here until we can check for the pneumatics proficiency in conditions: What do you need to know?  I'm pretty handy with pneumatic devices, I can probably help. 'u_add_var: Jenny_pneumatics value: mission_complete'.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Project1_helped",
    line = ccb.content.gendered_line("&\"Holy shit, what are the odds?  OK, stand back and hold on.\"  Jenny begins peppering you with questions, which you answer to the best of your ability.  She seems quite satisfied.  \"Well, I can't thank you enough,\" she smiles after a few minutes.  \"You probably just saved me weeks of reinventing the wheel.  Here, it's not much but it's all I've got.\"  She hands you a bundle of the local currency.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Tell me more about your project."),
            next_topic = "TALK_REFUGEE_JENNY_Project2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
