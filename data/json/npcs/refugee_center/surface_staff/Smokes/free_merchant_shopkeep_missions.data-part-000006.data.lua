local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac2",
    line = ccb.content.text("I could share the dropoff location if you want to bring the drive there for us, but whatever's there, I'm not sure it's worth all the trouble.  I'll reward you for your trouble."),
    replies = {
        {
            text = ccb.content.text("That seems fine to me.  I'll take your drive for you."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Robofac_Start",
            actions = { actions.offer_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1"), actions.set_actor_value("speaker", "general_free_merchants_u_hub01_breadcrumb_accepted", "yes") },
        },
        {
            text = ccb.content.text("Actually, I can see why you haven't done it yet.  Hold that thought for now."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac_Start",
    line = ccb.content.text("I was hoping you'd say that.  It's an old isolated building not too far from here; you should probably just leave the drive to whoever's there and be on your way.  And like I said, be careful approaching the place.  I wouldn't like leading you straight into your death."),
    replies = {
        {
            text = ccb.content.text("Don't worry, I'll be careful.  I'll let you know when it's done."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("I'm sure I'll manage."), next_topic = "TALK_DONE" },
    },
}
