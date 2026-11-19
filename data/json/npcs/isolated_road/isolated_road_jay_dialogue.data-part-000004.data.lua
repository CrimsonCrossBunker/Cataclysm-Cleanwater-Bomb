local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_LOCATION_ABOUT",
    line = ccb.content.text("It's my house.  Cody's in the other building, if you've met her.  We dug a trench and set up some milspec turrets.  I programmed them, Cody armored them.  Now we're just trying to get by.  This ain't the wizard of Oz, you can look behind the curtain over there."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_mentioned_cody", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Where'd you get half a dozen milspec turrets?"),
            next_topic = "TALK_GUNSMITH_TURRETS",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}
