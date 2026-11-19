local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT_World",
    line = {
        choices = {
            ccb.content.text("There could be anything out there.  Remember towards the end before the apocalypse?  I remember tons of weird stuff I heard on the radio.  Like, I heard out past Bunyan there were strange trees and species showing up in the deep woods, stuff no one had ever seen before.  The Border Patrol was going in about 'species previously thought extinct' or something like that.  Didn't make sense to me.  Why the heck was the *Border Patrol* talking about *closing off forests*?  Weird stuff.  I guess that means I don't have a clue what's out there now."),
            ccb.content.text("I still can't decide if our leaders thought Canada was a threat or what?  Why else did they militarize the border patrol up here just as bad it had been on the southern border for decades?"),
            ccb.content.text("I remember talking to a friend coming back from Vegas a few years back and he mentioned Border Patrol had those big armored Bear Cub vehicles with a roadblock going into one of the canyons outside of Vegas.  Hundreds of miles from any border.  Weird stuff man, I wonder if it's all connected?"),
        },
    },
    replies = { { text = ccb.content.text("[Continue chatting.]"), next_topic = "TALK_DONE" } },
}
