local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_fresh2",
    line = ccb.content.text("*shivers, though the room is warm, and moves his mouth wordlessly for a few seconds.  \"It's hard to remember details.  The air in that place messes with your brain, makes it all feel like some kind of dream.  Makes it so you can't fight back.  Not that I could have anyway.\"  He stares into space for a moment, then swallows hard.  \"They cut into me, over and over.  I don't think they took anything out.  They just opened me up, poked around.  I was awake for all of it, as awake as for anything else.  Sometimes I felt pain, other times they did something to me so I could feel it but it didn't hurt.  There were big, pale ones that did the cutting.\"  His voice gets increasingly detached as he speaks, and his shaking grows worse.  You're not sure it would be wise for him to go further."),
    on_enter = {
        { once = "barry_PTSD1", actions = { actions.handler("dlg_a_dda_0f0f5ab4b53f") } },
    },
    replies = {
        {
            text = ccb.content.text("[Let him continue.]"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_fresh3",
        },
        {
            text = ccb.content.text("That's enough for now, Barry."),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_fresh_stop",
        },
        {
            text = ccb.content.text("On second thought, I think you should recover more."),
            next_topic = "TALK_DONE",
        },
    },
}
