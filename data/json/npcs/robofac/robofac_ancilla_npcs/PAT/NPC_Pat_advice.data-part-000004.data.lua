local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_2",
    line = ccb.content.text("Now we're talkin'.  Seems to me the sorta' thing you should do from a distance, yeah?  Need you a sniper rifle!  I dunno where to get one'a those, but I do know the military had set up some bullshit camps out near my cousin's place before it all happened.  Maybe check it out, get yaself some fiah-powah, yeah?"),
    replies = {
        {
            text = ccb.content.text("Thanks a lot.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_FIAH_POWAH"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_outpost", "yes"),
            },
        },
    },
}
