local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REACH_REFUGEE_CENTER",
    line = ccb.content.text("Sweet, road trip!  That sounds like as good a plan as any, my friend.  Gives me some first season Walking Dead vibes, you know?  Maybe the place will be run by sinister G-men, or a lone crazy scientist who thinks he can cure zombies if he can just get his hands on one super-rare ingredient.  Road trip!"),
    replies = {
        {
            text = ccb.content.text("Road trip!  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
