local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH" },
    line = ccb.content.text("Wait.  Hold on a second, please don't take this the wrong way, but wouldn't you happen to be from Earth by any chance?"),
    replies = {
        {
            text = ccb.content.text("How can you tell?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_TRUTH",
        },
        {
            text = ccb.content.text("Sorry, you're mistaken."),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_LIE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_TRUTH" },
    line = ccb.content.text("I knew it!  I'm from Earth too so I could just tell.  The way you carry yourself, it's not like the rest of the salvors around here.  But you get it right?"),
    replies = {
        {
            text = ccb.content.text("I know what you mean."),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_TRUTH_2",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_TRUTH_2" },
    line = ccb.content.text("Right?  Right!  Of course you do.  You understand!  This place is about as far a cry from civilization as you can get.  And the people, god, the people!  This post sees a never-ending deluge of criminals and brawn for brains.  And it's like none of them have even heard of a shower!  Just the other day, a man emerged from the icy waste covered in blood and viscera.  And everyone just ignored him acting like that was a completely normal thing to do!  I am going to get off this god-forsaken rock if it's the last thing I do, I swear it."),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_LIE" },
    line = ccb.content.text("No, don't give me that!  I can tell, just by looking at you, I know.  Don't worry, I'm from Earth too!  I get it: some people around here get all weird when they find out where you're from.  But you won't get that from me. Us Earthers got to stick together, right?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN",
        },
        {
            text = ccb.content.text("I don't know what you're talking about."),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_LIE2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_LIE2" },
    line = ccb.content.text("Sure, whatever you say, pal."),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_INTRODUCTION_EARTH_EXPLAIN",
        },
    },
}
