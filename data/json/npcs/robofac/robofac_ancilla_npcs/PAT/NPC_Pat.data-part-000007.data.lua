local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MORALE_CHAT",
    line = {
        choices = {
            ccb.content.text("Tell me ya haven't seen the LAST Sox game.  Found it recorded on a scrap tablet.  Absolute heartbreak, even now.  So in the ninth…"),
            ccb.content.text("You wouldn't believe the data I pulled last night.  Before all this, never seem storms like these.  Lemme tell ya'…"),
            ccb.content.text("Kinda weird, right?  Apocalypse an' I'm still doin' weathah modeling like it matters.  Look at this latest one…"),
            ccb.content.text("You drink rum before noon now, or we still pretendin' it's a bad habit?  Ya' know, I had this rum once…"),
            ccb.content.text("Portal storms ain't random, by the way.  Anyone tells ya that's full a shit.  Listen…"),
            ccb.content.text("This might sound stupid, but it reminds me a little a how things used ta be…"),
            ccb.content.text("So, uh… you trust these folks, or we just survivin' near 'em?  I got ideas…"),
            ccb.content.text("I been rationin' smokes, but yeah, this feels like a good exception…"),
            ccb.content.text("Nevah been a menthol-smoker, but post-apocalypse, they're not bad…"),
            ccb.content.text("Popcorn.  Hot dogs.  Some smuggled-in Rum.  THAT was a ball game…"),
            ccb.content.text("I was thinkin' about the Sox, an' now I'm in a wicked bad mood…"),
            ccb.content.text("I had this theory once, back before everythin' went ta hell…"),
            ccb.content.text("Wicked cool gear you got theah.  Tell me where ya' found it?"),
            ccb.content.text("You wouldn't believe the asshole came through heah earliah…"),
            ccb.content.text("So I been thinkin' about somethin' I saw out theah today…"),
            ccb.content.text("Yeah, sure.  Can I run somethin' by ya?  Nothin' serious…"),
            ccb.content.text("So, we callin' these things zombies?  I dunno…"),
            ccb.content.text("So I've been scannin' the radio waves, and…"),
            ccb.content.text("This reminds me of a bar back home…"),
            ccb.content.text("So what's ya favorite cocktail?"),
        },
    },
    on_enter = {
        {
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
    replies = { { text = ccb.content.text("[Have a chat then say goodbye]"), next_topic = "TALK_DONE" } },
}
