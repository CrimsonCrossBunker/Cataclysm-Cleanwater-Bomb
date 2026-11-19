local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_get_food",
    line = ccb.content.text("It's been a while since anyone gave out meals.  We're low on supplies around here, I can't spare any.  I'm sorry."),
    replies = {
        {
            text = ccb.content.text("Would you accept any money for it?"),
            next_topic = "TALK_GODCO_chef_get_food_bribe",
        },
        {
            text = ccb.content.text("Please?  I need it for my family."),
            next_topic = "TALK_GODCO_chef_get_food_family",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}
