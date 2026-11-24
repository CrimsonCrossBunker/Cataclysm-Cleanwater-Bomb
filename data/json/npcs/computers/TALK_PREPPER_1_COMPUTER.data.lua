local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_AIRPORTMESSAGE",
    line = ccb.content.text("&From: Ryan\nSubject: RE: Airport Facility\n\nyes its possible.  most airports have tunnels underneath for staff and others to move around.  obviously ordinary people cant go in and most airports are just normal but there are definitely some international hubs of travel with hidden chambers in them and some even with tunnels out to the surrounding area.  so elites dont have to go anywhere else to do their work and risk being seen.  they have to be staffed by spies or people who dont know whats really going on."),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_AIRPORTMESSAGE2",
    line = ccb.content.text("&To: Ryan\nSubject: RE: RE: Airport Facility\n\nHe only goes to the airport and nowhere else.  I think he has to be one of the people running it.  I remember bragg_eagle saying there were managers in Denver who would spend time where normal employees couldn't go and I don't see ANYONE else going in there.  He dresses like a construction worker or something.  It's not like anything I've ever seen at an airport."),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_AIRPORTMESSAGE3",
    line = ccb.content.text("&To: Ryan\nSubject: RE: RE: RE: Airport Facility\n\nYeah I deleted it, don't worry.  Look, this is what he looks like.\n\nATTACHMENTS: MVI 0022.mov"),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_NOEMAILS",
    line = ccb.content.text("WARNING!  ERROR B231; UNABLE TO CONNECT TO MESSAGING SERVER.\n CONTACT INFORMATION TECHNOLOGY DEPARTMENT IMMEDIATELY!"),
    replies = { { text = ccb.content.text("OK"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOCUMENTS",
    line = ccb.content.text("Select the document you would like to view."),
    replies = {
        { text = ccb.content.text("everything.txt"), next_topic = "COMP_PREPPER_1_DOC_EVERYTHING" },
        {
            text = ccb.content.text("robert williamson.txt"),
            next_topic = "COMP_PREPPER_1_DOC_ROBERT",
        },
        { text = ccb.content.text("shopping list.txt"), next_topic = "COMP_PREPPER_1_DOC_SHOPPING" },
        { text = ccb.content.text("MVI 0022.mov"), next_topic = "COMP_PREPPER_1_DOC_THEFOOTAGE" },
        { text = ccb.content.text("Back"), next_topic = "COMP_PREPPER_1_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOC_EVERYTHING",
    line = ccb.content.text("Enigma code cracked by Turing -> modern encryption technology -> internet sentience arises and gives birth to AI in Chinese lab using new forms of computation, aka: BIO-TECHNOLOGY, human AND robotic components TOGETHER.  State media announces as 'fusion technology'.  Bio-weapon escapes lab, OF COURSE.  Self-replicating bio-technology = imminent replacement of humanity.  US gov now ACTIVELY manufacturing cover-ups for escaped bio-weapon to maintain peace.  Follows same pattern as Roswell, Trinity (what they told the public), oil pollution coverup (in my opinion).  Recent New York 'mass psychosis events' instigated by them as cover.  PAID ACTORS on speed dial but the THREAT IS REAL.  They are buying time, but what is the play?"),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOC_ROBERT",
    line = ccb.content.text("Gov assigns names based off numerological conversions of house numbers.  Robert Williamson: 205 W Orchard Avenue.  Robert (78) + Williamson (127) = 205.  Despite the beautiful weather, he keeps the curtains closed and no one has even visited yet.  And he's been here for more than two weeks!  I only ever see him when he's coming or going from work.  I assume it's work, even if the hours are strange sometimes.  Black car, out of state plates, looks brand new.  Fed behavior, if you ask me… Is he actually going somewhere or just trying to convince me he's legitimate?  Is he on the job when he leaves or on the job when he's here?  Further investigation required."),
    replies = {
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_found_computer", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOC_SHOPPING",
    line = ccb.content.text("Non-perishables, MREs, canned soup, dehydrated milk, oats/rice, lemon juice, protein powder.  Ammo, in crates if possible - just ask Rachel at RFA?  Large drums (HDPE), reusable containers, spare fuel can.  More novels and TV from home.  Iodine, colloidal silver, gas mask and filters for fallout."),
    replies = { { text = ccb.content.text("Back"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOC_THEFOOTAGE",
    line = ccb.content.text("&A video file starts playing.  It's quite low resolution, very shaky, and the sound is somewhat muffled as the cameraperson appears to be filming inside from their car.  On screen a man is walking away from the camera towards a nondescript white building with large windows.  The glare of the sunlight makes it hard to tell but it looks like… an airport terminal!  The man is very far away, wearing an orange safety vest and a hard hat, and he appears to be carrying a laptop bag.  You hear the person behind the camera mutter, \"I've only ever seen him come and go through that door.  No one else in the entire time I've been watching…\"  The man walks straight into the building, only looking back briefly as he swipes a keycard at the door and enters."),
    replies = {
        {
            text = ccb.content.text("Continue watching…"),
            next_topic = "COMP_PREPPER_1_DOC_THEFOOTAGE2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_DOC_THEFOOTAGE2",
    line = ccb.content.text("&The cameraperson sighs.  The view slowly zooms out for a few seconds, but then suddenly jerks to the left.  \"Ay… hey, look at these motherfuckers!\"  The camera zooms in on two teenagers next to a car in the parking lot.  They're both laughing and shouting very loudly, almost seemingly intoxicated…  One kid takes a step back, then kicks in the taillight of the car.  The other appears from around the other side of it, dragging their keys along it, scratching up the paint.  The boy who was kicking begins violently punching the window with his bare fist.  The cameraperson lets out an astonished gasp, \"Like New York…\"  One punch, two punch, and with a third smash his arm goes through the glass!  He stares at the other teenager and they both let out a burst of laughter that lasts a little too long.  The cameraperson mutters a concerned \"Uhhh…\" and sets the camera on the seat.  The recording abruptly ends."),
    replies = { { text = ccb.content.text("Back"), next_topic = "COMP_PREPPER_1_DOCUMENTS" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_PREPPER_1_OPENDOOR",
    line = ccb.content.text("Error: 'open': command not found."),
    replies = { { text = ccb.content.text("Back"), next_topic = "TALK_NONE" } },
}
