local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Introdialogue",
    line = ccb.content.text("Years ago, you and your old group of friends made a pact.  It seemed like a joke at the time: if the world ended, you'd all meet up at Liam's cabin, if you could, and work together to help each other out.  Now, the unthinkable has happened, and somehow you've made it out in one piece.  It's been years since you saw those friends, though you've kept a little bit in touch on social media, and you can only hope that the others perhaps took the idea seriously.  Even if they did, it would be a hard trip.  The roads were blocked off by military forces trying to prevent the riots from spreading, and you had to make the last part of the journey on foot.\n\nAs the morning light breaks into day, you've reached Liam's cabin, a ramshackle building in the woods outside <city>.  You can see Liam's car in front, looking a bit more run down since you last saw him a few years ago.  You feel a swell of relief: at least Liam seems to have made it!  As you approach the door, you hear a shout of terror from inside, and then the unmistakable sound of a gunshot.  Were you a moment too late?"),
    replies = {
        {
            text = ccb.content.text("I'd better get in there and check it out."),
            next_topic = "TALK_DONE",
        },
    },
}
