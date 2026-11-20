local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_COWBOYT_SHOTGUN",
    name = ccb.content.text("Obtain a Remington 870 Express shotgun"),
    goal = "MGOAL_FIND_ITEM",
    item = "remington_870_express",
    difficulty = 2,
    value = 40000,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Well, now that you mention it…"),
        offer = ccb.content.text("You see, some time ago, I ran into this guy who offered me a substantial payment in exchange for a Remington 870 Express.  I asked if he'd like another weapon, since nowadays, any gun will do, but for some reason, he's dead set on that particular model.  If you could obtain one for me, well, I'd be quite grateful."),
        accepted = ccb.content.text("Great!  Let me know when you get it, and I'll try to get in touch with him."),
        rejected = ccb.content.text("Suit yourself.  Ain't a rush."),
        advice = ccb.content.text("Well, a gun store is a solid bet, but the model is common enough.  Maybe you can find one in a police station, or a store with hunting gear."),
        inquire = ccb.content.text("Any news on that Remington?"),
        success = ccb.content.text("Fantastic!  I'll try and get it to the buyer, if he's still alive.  If not, well, still a good gun to sell.  Now, how would you like to be compensated?"),
        success_lie = ccb.content.text("How did you even get this option to display the hell."),
        failure = ccb.content.text("Then where is it?"),
    },
}
