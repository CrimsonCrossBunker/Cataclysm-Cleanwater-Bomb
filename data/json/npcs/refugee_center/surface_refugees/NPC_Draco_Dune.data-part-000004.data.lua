local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_2",
    line = ccb.content.text("Well, look at you.  Asking after random folks like some sort of shepherd!  No, don't take offense now… I mean it well.  We could use more folks askin' after other folks.  I figure it makes the world go round, now, more than ever.  I'm well, friend, considering I have both of my legs and much of my health left to me.  A bit of pain in the back, but can't really complain much if that's the worst of it, right?  You look like you've had a story of your own to tell, just getting here.  I'm writing it in my imagination right now.  Fought through countless hordes, run ragged, chased at every turn, yeah, no thank-you any more of that for me!"),
    replies = {
        {
            text = ccb.content.text("What about you, what's your story?"),
            next_topic = "TALK_REFUGEE_Draco_3",
            actions = { actions.handler("dlg_a_dda_4776232023da") },
        },
        {
            text = ccb.content.text("No more indeed."),
            next_topic = "TALK_DONE",
        },
    },
}
