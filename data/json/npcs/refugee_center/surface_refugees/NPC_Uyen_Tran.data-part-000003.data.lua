local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_1a",
    line = {
        joined = {
            {
                choices = {
                    ccb.content.text("*smiles and brushes her hair out of her eyes.  \""),
                    ccb.content.text("*looks you up and down with a faint smile.  \""),
                    ccb.content.text("*suppresses a yawn, then sees you approaching and nods with recognition.  \""),
                },
            },
            {
                choices = {
                    ccb.content.text("Hello again."),
                    ccb.content.text("Good to see you're still around."),
                    ccb.content.text("Oh, hi."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Uyen.  Got a minute?"), next_topic = "TALK_REFUGEE_Uyen_2" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_1_firstmeet",
    line = ccb.content.text("What brings you around here?  We don't see a lot of new faces."),
    replies = {
        {
            text = ccb.content.text("Just a traveler.  Can I ask you a few things?"),
            next_topic = "TALK_REFUGEE_Uyen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_2",
    line = ccb.content.text("I'm always good for a talk.  It gets pretty boring down here."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Background",
    line = ccb.content.text("I was a paramedic.\"  She idly touches her forehead to brush aside a bit of hair, then notices it's already tucked back.  \"I was there through some of the absolute worst of it, to this day I can't tell you how I made it out.  One thing led to another and I got pushed onto a bus to help take care of a couple people who needed assistance for travel.  Broken arms, that kinda stuff.  I got here early, I was one of the first to arrive.  Then, this woman in processing 'lost' my paperwork while I was busy helping a guy with a bad gash on his head.  If I hadn't made a stink about it, I'd probably be out in the lobby with those poor souls that couldn't get in at all."),
    replies = {
        {
            text = ccb.content.text("You're medically trained?  Do you know if anyone's found any way to deal with zombie bites?"),
            next_topic = "TALK_REFUGEE_Uyen_Bites",
        },
        {
            text = ccb.content.text("Could you teach me a bit about first aid?"),
            next_topic = "TALK_REFUGEE_Uyen_Teach",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Bites",
    line = ccb.content.text("I'm not sure what you mean by 'deal with'.  I've been handling zombie bites the same way I handle any other bite.  Clean it and dress it, try to prevent infection.  There's no, like, venom or anything.  Once the wound is cleaned and dressed, it's not going to do anything special.  Zombie mouths are really dirty though, so you want to make sure you do a good job cleaning it out."),
    replies = {
        {
            text = ccb.content.text("So if the bites aren't turning people into zombies, what is?"),
            next_topic = "TALK_REFUGEE_Uyen_Bites2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Bites2",
    line = ccb.content.text("*shrugs.  \"Darned if I know, that's way past my training.  I don't think anyone figured it out anyway, but you'd want a doctor for ideas on that, not a paramedic.  I stabilize and package patients, I don't research cures and causes.\""),
    replies = {
        {
            text = ccb.content.text("Did you ever think about going into nursing or medicine?"),
            next_topic = "TALK_REFUGEE_Uyen_Training",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Training",
    line = ccb.content.text("I'm going to sound like a massive stereotype here, I know, but my parents always pushed hard for me to go into medicine and be a doctor.  I was still thinking it over when, well,\" she gestures expansively around her.  \"Things got complicated.  Honestly though, if the pay were better for being a paramedic I don't know if I'd want to change at all.  I hear there's a lot of burnout after a while, but I haven't seen it yet.  I really liked the work."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_World",
    line = ccb.content.text("*smiles slightly.  \"Everyone's got some idea, hey?  I really don't know.  It seems crazy to even try to guess.  Can you believe we live in a world where corpses come back to life?  There's weirder stuff out there too.  In the hospital, people had all kinds of injuries and talked about seeing monsters.  On the way here, I saw huge creatures in the distance, the sort of thing that belongs in a kaiju movie, not stomping through suburban Worcester.\"  She shrugs.  \"I guess today I'll go with simulation theory.  None of this is real, we're all in a hyper-detailed computer simulation, and the creator is cruel and messing with us.\"  She briefly stares into space, as though looking directly into some imaginary camera.  \"Honestly I don't think any scientific explanation is ever going to get close to the sheer amount of mind-shattering madness around here.\""),
    replies = {
        {
            text = ccb.content.text("Hey wait, are you a fan of kaiju stuff?"),
            next_topic = "TALK_REFUGEE_Uyen_Kaiju",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Kaiju",
    line = ccb.content.text("*grins more broadly.  \"Busted!  Okay, I'm not like, a superfan.  My sister was huge into it, and I kinda picked it up through her, but yeah.  I'd do anything for a night on the couch with her, a copy of Pacific Rim, and a big bowl of popcorn.\""),
    replies = {
        {
            text = ccb.content.text("Maybe I could help.  There are lots of movie discs out there just collecting dust, and you've got electricity."),
            next_topic = "TALK_REFUGEE_Uyen_Kaiju2",
        },
        {
            text = ccb.content.text("Okay, seriously.  Pacific Rim 2 though… what the heck?"),
            next_topic = "TALK_REFUGEE_Uyen_Pacific",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Pacific",
    line = ccb.content.text("*laughs and makes a waving gesture under her nose.  \"It's too bad they never made a sequel.  Can you imagine?  Oh well, they'd probably have done something *unconscionably stupid* like killing off Mako Mori in the first act.  Good thing *that* never happened.\""),
    replies = {
        {
            text = ccb.content.text("You know, there are lots of movie discs out there just collecting dust, and you've got electricity.  I could probably help you out."),
            next_topic = "TALK_REFUGEE_Uyen_Kaiju2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Kaiju2",
    line = ccb.content.text("Right.\"  Her grin fades slowly.  \"There's one ingredient you can't replace, and without her, I don't…\" her voice catches.  \"Sorry.  That's a sweet offer though, I really appreciate it."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
