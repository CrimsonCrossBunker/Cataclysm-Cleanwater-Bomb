local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_IMPROVE_GEAR_YES",
    line = ccb.content.text("I think this is about as good as my post-apocalyptic engineering will take us, eh?  Unless our employer chips in, or you can dig up one of those cutting-edge military AR units, I think we're S-O-L."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  Maybe sometime in the future."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talked_about_gear_improvement", "yes"),
            },
        },
    },
}
