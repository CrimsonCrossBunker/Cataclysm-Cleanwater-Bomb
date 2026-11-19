local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_EVACUATION",
    line = ccb.content.text("Oh yeah, that was a hell of a shitstorm.  We were waiting back there for 'processing' for hours and hours, with the sick and wounded.  One guy died, we all thought he was sleeping until he got back up.  That started a panic, gunshots in a closed area, that kind of stuff.  In just a few minutes, a bunch more people were dead.  Then the assholes called it an 'outbreak' and tried to barricade us in… took us way too long to convince the panicking guards that we were alive and needed to get out.  I'll give the one guy credit, Sean: when he found out they'd locked living people in with zombies, he came in himself, as some of the newly dead were starting to get back up, and he held them off for us to escape.  That… that was probably the only actual good thing I've seen since before the end of the world: he owned his error and he put himself in harm's way to make up for it.  Massive respect to that guy.  So, of course, he's a zombie now.  Fuck, thanks for reminding me of all that sunny fun."),
    replies = {
        {
            text = ccb.content.text("Sorry for bringing it up. What were you saying?"),
            next_topic = "TALK_NONE",
        },
    },
}
