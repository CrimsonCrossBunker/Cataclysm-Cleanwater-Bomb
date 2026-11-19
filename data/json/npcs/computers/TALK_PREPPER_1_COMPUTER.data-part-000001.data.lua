local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_MAIN",
    line = ccb.content.text("You are logged in as: User.\n\n WARNING!  ERROR A104; YOUR COMPUTER HAS RECOVERED FROM AN UNEXPECTED SHUTDOWN.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        { text = ccb.content.text("Messages"), next_topic = "COMP_PREPPER_1_EMAILS" },
        { text = ccb.content.text("My Documents"), next_topic = "COMP_PREPPER_1_DOCUMENTS" },
        { text = ccb.content.text("Script: Open Door"), next_topic = "COMP_PREPPER_1_OPENDOOR" },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_EMAILS",
    line = ccb.content.text("Select the message you would like to view.\n\n WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = {
        {
            text = ccb.content.text("To: monica evers  Subject: Interest in property"),
            next_topic = "COMP_PREPPER_1_LMOEPROPERTY",
        },
        {
            text = ccb.content.text("From: monica evers  Subject: RE: Interest in property"),
            next_topic = "COMP_PREPPER_1_LMOEPROPERTY2",
        },
        {
            text = ccb.content.text("From: Ryan  Subject: RE: Airport Facility"),
            next_topic = "COMP_PREPPER_1_AIRPORTMESSAGE",
        },
        {
            text = ccb.content.text("To: Ryan  Subject: RE: RE: Airport Facility"),
            next_topic = "COMP_PREPPER_1_AIRPORTMESSAGE2",
        },
        {
            text = ccb.content.text("To: Ryan  Subject: RE: RE: RE: Airport Facility"),
            next_topic = "COMP_PREPPER_1_AIRPORTMESSAGE3",
        },
        { text = ccb.content.text("Send/Receive Emails"), next_topic = "COMP_PREPPER_1_NOEMAILS" },
        { text = ccb.content.text("Back"), next_topic = "COMP_PREPPER_1_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_LMOEPROPERTY",
    line = ccb.content.text("&To: monica evers\nSubject: Interest in property\n\nHello, Monica!  I got your information from Tony because I'm in talks to buy one of your properties out of town.  I have a small development firm ready to break ground, but I was wondering if you had any details on radioactive materials or other geology in the area?  I know this is a strange question but certain things will prevent me from building at all.\n\nAlso, given the recent developments in the area since the listing, would it be possible to reduce the price at all?  I asked Tony but he said he would have to run it by you.  Thank you."),
    replies = { { text = ccb.content.text("Back"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_LMOEPROPERTY2",
    line = ccb.content.text("&From: monica evers\nSubject: RE: Interest in property\n\nThanks for reaching out!  I'm glad Tony gave you my details because that bit of land has been on my mind for a long time.  He's an amazing broker.  It's hard to get attention on a lot this size and this far out of town unless there's oil underneath, but Tony knows everyone!  Since I haven't had a buyer in a while, I'm willing to come down maybe another thousand but that's it.\n\nI apologize, but I'm afraid I don't have any information on radiation or magnetism in the area, only basic topographical data the survey team collected after I first bought the property, which I can definitely send, if you like.  Thank you again for your interest!"),
    replies = { { text = ccb.content.text("Back"), next_topic = "TALK_NONE" } },
}
