local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_CHOP_SHOP",
    line = {
        choices = {
            ccb.content.text("&This merc's gear is drab, a bit bloody, and hangs loose on them.  They look like they haven't washed in some time.  Their eyes are wide and they stare off into the distance.  They address you in an emotionless tone: \"Talk to David.  He's the boss.\""),
            ccb.content.text("&The merc doesn't even look at you.  They just stare off at the horizon."),
            ccb.content.text("&The merc jumps nervously as you approach, stares a moment, and speaks, looking suddenly disgusted: \"Talk to David, not me.\""),
            ccb.content.text("&The merc sits slowly rubbing the back of their neck, staring at the ground.  They don't acknowledge you."),
            ccb.content.text("&The merc is silently cleaning the outside of their bloodied firearm.  \"Fuck off.\" they say, their voice completely lacking any emotion."),
            ccb.content.text("&You think the merc may be crying.  Their eyes are bloodshot and wet.  They ignore you."),
            ccb.content.text("&This merc is filthy, and clearly hasn't washed in a while.  They nervously rub their hands together before staring sternly at you.  Then, they look at the other mercs and just motion toward them with a nod of their head."),
            ccb.content.text("Fuck off.  I don't feel like talkin'.  Talk to the boss."),
            ccb.content.text("Get tha fuck outta'heah, ya' fuckin' shit."),
            ccb.content.text("I don't want anything to do with you, dude.  Go talk to Dave, or get the fuck outta dodge."),
        },
    },
    replies = { { text = ccb.content.text("Bye."), next_topic = "TALK_DONE" } },
}
