local ccb = require("ccb")

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
