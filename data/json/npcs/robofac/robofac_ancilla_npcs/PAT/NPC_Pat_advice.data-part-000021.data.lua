local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BUILD_CAMP",
    line = ccb.content.text("Best bet for all that shit they'll need is a lumbahmill.  In fact, I heard some mercs talkin' about one that's occupied by friendly-ish tradahs.  Heah, check it out."),
    replies = {
        {
            text = ccb.content.text("Thanks.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_LUMBERMILL"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_lumbermill", "yes"),
            },
        },
    },
}
