local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_KORD",
    line = ccb.content.text("Where did you… I- I don't know what to say.\"  Jay takes the rifle reverently.  \"What did they do to this thing?  The receiver's all chopped up!\"  He turns it over so carefully that you could mistake him for holding a child instead of a gun.  \"This thing was beautiful.  Modern rails, ergonomic furniture, recoil balancing system… At least it's all still here.  I know Cody thinks that she did something wrong, but all I remember is being so angry… just blindingly furious.  Then I was running.  When I woke up, everything was fine.\"\n\n\"Thank you for letting me see this, and for getting Cody and I talking.  If you could help me out with something for Cody, I'll make this rifle right, and hook you up with a casket mag and a box of the good ammo for it.  Stuff from my reserves."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_mentioned_quest", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "TALK_GUNSMITH_Q1_DETAILS",
            actions = { actions.offer_mission("MISSION_GUNSMITH_1"), actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_accepted_quest", "yes") },
        },
        {
            text = ccb.content.text("Not really interested."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'll think about it."),
            next_topic = "TALK_GUNSMITH_SERVICES",
        },
    },
}
