local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_AUGUSTMOON_LONGSHOREMAN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_augustmoon_longshoreman_first_meet" } }),
        yes = {
            choices = {
                ccb.content.text("Please retrieve your belongings and move along.  We have a schedule to keep"),
            },
        },
        no = ccb.content.text("Yes yes, welcome to Port Augustmoon.  Please collect your belongings and head down the docking arm.  Port authority won't be liable for any missing items."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_augustmoon_longshoreman_first_meet", "yes"),
            },
            once = "longshoreman_meet",
        },
    },
    replies = {
        {
            text = ccb.content.text("Could you help me with directions?"),
            next_topic = "TALK_AUGUSTMOON_INTRO_LOCATIONS",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}
