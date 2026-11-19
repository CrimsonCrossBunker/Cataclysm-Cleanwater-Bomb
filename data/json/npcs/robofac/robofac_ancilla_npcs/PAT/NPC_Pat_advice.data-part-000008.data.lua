local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_EVAC_SMOKER_GET_CIGARETTES",
    line = ccb.content.text("Well, if you're gatherin' cigs, maybe bring some back for me, yeah?  Tell ya' what I bet they got crates full of them in shipping containahs, if you're willin' to dig around.  My cousin's fathah - not really my uncle, but long story - ran one close by.  His name's Mike.  If ya' see'im, ask how his mothah is.  But seriously, if ya' go, go careful, yeah?  I bet we ain't the first to think about this."),
    replies = {
        {
            text = ccb.content.text("Thanks a lot.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_CONTAINAH"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_container", "yes"),
            },
        },
    },
}
