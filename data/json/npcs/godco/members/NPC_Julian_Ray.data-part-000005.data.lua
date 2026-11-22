local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Joinee",
    line = ccb.content.text("Your name is now on the books.  Here's your blanket, joinee.  Those two beds next to the window, you can choose one of them.  It's safe, don't worry.  I'm armed.  By the way, if you're hungry you can go bug Simon for a meal, up to one in a day."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_a026e5b0762a"), actions.set_actor_value("speaker", "general_meeting_godco_joinee", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you.  See you around, Julian."),
            next_topic = "TALK_DONE",
        },
    },
}
