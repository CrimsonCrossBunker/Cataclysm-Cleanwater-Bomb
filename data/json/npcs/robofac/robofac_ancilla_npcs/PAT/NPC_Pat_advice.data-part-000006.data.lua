local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_5",
    line = ccb.content.text("So first they got you killin' bandits, and now you're collectin' jahrs?  This really worth the squeeze?  Anyway, just go to the fahkin' supahmahket and start emptyin' shit out for'em.  Here, I'll upload my favorite to your maps."),
    replies = {
        {
            text = ccb.content.text("Thanks a lot.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_GROCERY"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_supermarket", "yes"),
            },
        },
    },
}
