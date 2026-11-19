local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_circuit_safari_intel" } }),
        yes = ccb.content.text("Like I said befoah, you're doin' the whole damn world a favor.  Good luck.  Flip on ya' AR headset, and I'll keep an eye on ya' from heah.  Try not to end up beepin' when you back up, yeah?"),
        no = ccb.content.text("I been hearin' a lotta chatter 'bout those freakin' robots 'round heah.  Some kid swears the othah day some OTHAH guy saw one'a those busted-ass… pods, or containahs, or whatevah, and one of those tin-can-robot-fahks looked exactly like his buddy - a buddy who disappeared last week.  You ask me, that's shady as hell - I think those metal bastards are snatchin' people and turnin'em into more robots.  Like that Star Trek crap, yah?  The Blorgs, or whatevah.\n\nAnyway, if you're goin' out huntin' one, you're doin' everybody a favah.  And you'd be doing that poor bastard they turned into a friggin' robot a mercy, ya know?  Put'em outta his misery.\n\nActually, kid told me where that one's at.  You want the coordinates?"),
    },
    replies = {
        {
            text = ccb.content.text("Sure, I think it's worth checking out.  What are the coordinates?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_circuit_safari_intel" } })),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_INTEL",
        },
        {
            text = ccb.content.text("Actually, I've had a bit of experience with the Exodii.  In fact, they installed a bionic implant in my brain, and they made me work to get it.  Don't seem to me the type to abduct people."),
            when = predicates.all({ predicates.has_trait("speaker", "CBM_Interface"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } })) }),
            actions = { actions.set_actor_value("speaker", "robofac_pat_knows_u_cyborg", "yes") },
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_TELL_PAT_ABOUT_IMPLANT",
        },
        {
            text = ccb.content.text("I think I got this, but thanks, Pat."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_INTEL",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&Your HUD flicks on and low-resolution version of Pat's computer desktop becomes visible.  They drop a pin on your map application.  \"Right heah'.  Make sure ya' leave ya' headset on so I can keep an eye on ya'.  And make sure you don't get yaself turned into a toaster.\""),
        no = ccb.content.text("&Pat flips open their laptop and wiggles the cable attached to a makeshift battery.  It boots up after a moment and they clack away, scanning an old, offline version of Google maps until they find a dropped pin.  \"Right heah'.  And hey, batteries ain't cheap anymore, so don't come back needin' em.\""),
    },
    replies = {
        {
            text = ccb.content.text("Thanks, Pat.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_CIRCUIT_SAFARI_RECON"),
                actions.set_actor_value("speaker", "robofac_pat_gave_circuit_safari_intel", "yes"),
            },
        },
    },
}
