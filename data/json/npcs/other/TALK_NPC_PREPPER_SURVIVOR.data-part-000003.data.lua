local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_PREPPER_SURVIVOR_STORY",
    line = ccb.content.gendered_line("They all said I was crazy for preparing for <the_cataclysm>.  Now, they're all dead, and I'm still kickin'.  When the riots turned to hordes, I was ready; all I had to do was dodge a few <zombies> to get back to my bastion.  I've been living safely here ever since.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Interesting."), next_topic = "TALK_NPC_PREPPER_SURVIVOR_INTRO" },
        {
            text = ccb.content.text("Can I stay here for a while?"),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_STAY",
        },
    },
}
