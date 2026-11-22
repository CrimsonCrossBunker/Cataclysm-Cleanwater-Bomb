local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION", "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION_WHERE" },
    line = ccb.content.text("It's from our employers.  Apparently, it's a custom platform they make for field agents.  It's got quick swap barrels for 9mm, the standard NATO cartridges, and shotgun shells too.  It's great for if you're on a long field mission and run out of ammo.  A lot of dudes bit the dust on their way home from the gun store with a box of nine-mil.  I guess it's better them than us; they don't need it now."),
    on_enter = {
        { once = "robofac_merc_1_HWP", actions = { actions.set_actor_value("speaker", "dialogue_robofac_merc_1_robofac_merc_1_HWP", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Damn.  Where can I get one of those?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION_WHERE",
        },
        {
            text = ccb.content.text("I've helped you out now.  Do you think you could vouch for me with our employers?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_YES",
            when = predicates.handler("dlg_p_dda_83478589bcf4"),
        },
        {
            text = ccb.content.text("I see."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}
