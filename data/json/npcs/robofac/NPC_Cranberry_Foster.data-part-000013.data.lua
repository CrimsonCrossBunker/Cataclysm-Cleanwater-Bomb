local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GOLD_MISSION",
    line = ccb.content.text("I guess I am, yeah.  Feels like a stupid fetch quest.\"  They suddenly pause.  \"Hey.  If you happen across any gold out in the world, I'll pay you to bring it back for me.  Right now my assignment stipulates eight scrip per kilo, and I'd be willing to give you all of that.  I just want something else to do.  Just maybe don't mention it to the intercom, alright?  This is supposed to be my job."),
    replies = {
        {
            text = ccb.content.text("You got it.  I'll let you know if I find any gold."),
            actions = { actions.set_actor_value("speaker", "general_robofac_merc_1_has_gold_deal", "yes") },
            next_topic = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_ACCEPTED",
        },
        {
            text = ccb.content.text("Actually, I don't think I have time for that, sorry."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}
