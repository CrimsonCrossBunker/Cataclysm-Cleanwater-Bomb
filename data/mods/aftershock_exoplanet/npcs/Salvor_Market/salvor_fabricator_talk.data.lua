local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_MAIN" },
    line = ccb.content.text("Welcome back.  Planning on buying something or did you just come here to gawk?"),
    replies = {
        {
            text = ccb.content.text("Show me what you have in stock."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What brought you to Salus?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_START",
        },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_START" },
    line = ccb.content.text("Came in with a crew trying to cozy up 'ere on the DL.  It was a shit plan from the start, told 'em as much.  But those scrap-for brains couldn't see the forest for the trees.  Figured they pull a fortune of ship parts from the graveyards and skip planet fat and happy."),
    replies = {
        {
            text = ccb.content.text("What happened to your crew?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_CREW",
        },
        {
            text = ccb.content.text("Did you ever find anything interesting?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_STUFF",
        },
        { text = ccb.content.text("Nevermind"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_CREW" },
    line = ccb.content.text("They're pushing daisies in the great beyond.  Not a single one of them made it off this hell.  Not like I didn't warn them.  They just kept fooling around in places one of us had any business being."),
    replies = { { text = ccb.content.text("I'm sorry for your loss."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_STUFF" },
    line = ccb.content.text("Tch, sure.  Plenty.  But we never got our hands on any of it.  Not a single thing worth taking comes as easily as you like, and you'd do well to remember that."),
    replies = {
        {
            text = ccb.content.text("What happened to your crew?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_CREW",
        },
        {
            text = ccb.content.text("What was the coolest thing you ever found?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF",
        },
        { text = ccb.content.text("Noted."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF" },
    line = ccb.content.text("Drive Core, Cruiser class, mostly intact.  We picked it up on scanners in the stern section of a Titan II class.  It was partially buried at the bottom of a ravine, old gal must a split in the atmo.  Only ever managed a glimpse of the damn thing though."),
    replies = {
        {
            text = ccb.content.text("What happened?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF_WHAT_HAPPENED",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF_WHAT_HAPPENED" },
    line = ccb.content.text("Net Breacher woke up the Ship's AI.  The bastard fried her brain from the inside out.  Rail from a Wraith turned another two to paste while everyone was still losing their shit.  Rest is a haze of bloody screams and a hail of bullets and plasma.  Few that got out died later of blood loss or froze from suits full o' holes.\"\nVeronica removes her glove revealing a metallic hand that glints brightly in the dim light of the structure.\n\"Woulda been dead myself but the plasma burst that took my arm cauterized the wound.  Patched the suit up with foamcrete on my way out.  The Doc had a lot of fun with that one."),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss."),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF_WARNING",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF_WARNING" },
    line = ccb.content.text("&Veronica slowly slides her glove back over her hand and meets your eyes with a scornful gaze.\n\"Those kids were hopeful idiots but they knew what they were doing.  This place 'ill take everything from you no matter how prepared you think you are.  Leave as soon as you can.  And stay the hell away from the graveyards.\""),
    replies = {
        {
            text = ccb.content.text("What happened afterwards, how did you end up here?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_CURRENT_DAY",
        },
        { text = ccb.content.text("I'll keep that in mind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_CURRENT_DAY" },
    line = ccb.content.text("I pulled myself together and set up this little abode.  Been selling tools and gear to the folk that come through 'ere for a time now.  Buncha upstarts followed suit and set up their own little places.  And now we got our own neighborhood.  If it weren't for the nosey UICA pricks and especially that little shit Atermis I'd almost call it livable."),
    replies = {
        {
            text = ccb.content.text("Why stay?  You must have enough to leave the planet by now?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_CURRENT_DAY_WHY_STAY",
        },
    },
}

-- In the future if the player demonstrates capability. Veronica will ask you to go to the ship her crew died at and blow up the Ship AI Core. Optionally she will reward you extra for recovering keepsakes from her crew.
ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_CURRENT_DAY_WHY_STAY" },
    line = ccb.content.text("Well, it ain't like I got someplace to be.  And, well, I can't rightly explain it, but, I feel like I still got business here.  There's a score that needs to be settled, and it just wouldn't sit right leaving things at that.  Salus ain't through with me yet."),
    replies = { { text = ccb.content.text("I understand."), next_topic = "TALK_DONE" } },
}
