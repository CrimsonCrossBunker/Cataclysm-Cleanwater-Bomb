local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_Q1_DETAILS",
    line = ccb.content.text("Alright, so Cody has talked about some cutting-edge tech she's seen displayed.  This thing is called a nano-fabricator.  It's like a complicated, robotic 3D printer.  Cody used to run with some hackers that steal IP, schematics, that sort of thing.  I guess a problem they were running into was the newest tech stuff is all encrypted as templates for these printers.  Well, I know of a colleague who went home with debug software for the system.  You get that for her, and we're in business."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_mentioned_quest", "yes"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("I'll see if I can find it."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Alright."), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}
