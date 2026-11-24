local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_RECON_DIRECTIONS_NO",
    line = ccb.content.text("Nothing new.  Check back later."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  I'll check back later."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_RECON_DIRECTIONS_YES",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&Your HUD flicks on and low-resolution version of Pat's computer desktop becomes visible.  \"Heah's what we got for the moment, yeah?\""),
        no = ccb.content.text("&Pat boots up their laptop and pulls out a stack of maps, photos, and documents.  \"Let's see what we have heah, yeah?\""),
    },
    replies = {
        {
            text = ccb.content.text("[Photo of a farmstead] What's this?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_1",
            when = predicates.handler("dlg_p_dda_a3d6e4384be8"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_1") },
        },
        {
            text = ccb.content.text("[Photo of large gate] What's this?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_2",
            when = predicates.handler("dlg_p_dda_1c05067be15a"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_2") },
        },
        {
            text = ccb.content.text("[Map with red marks on it] What's this?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_3",
            when = predicates.handler("dlg_p_dda_62a9119d72be"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_3") },
        },
        {
            text = ccb.content.text("[Series of photos] This looks new.  What is it?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_4",
            when = predicates.handler("dlg_p_dda_06a68a2bea7f"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_4") },
        },
        {
            text = ccb.content.text("[Image of a strange castle] What is that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_5",
            when = predicates.handler("dlg_p_dda_0cf126c72708"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_5") },
        },
        {
            text = ccb.content.text("[Documents marked CLASSIFIED] Ooh?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_6",
            when = predicates.handler("dlg_p_dda_b3e08a2ee841"),
        },
        {
            text = ccb.content.text("[Image of a test tube with a hunk of meat in it] What's this?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_7",
            when = predicates.handler("dlg_p_dda_4d3ff720fdff"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_7") },
        },
        {
            text = ccb.content.text("[Image of a glowing smear] What's that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_8",
            when = predicates.handler("dlg_p_dda_ebb60da2c217"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_8") },
        },
        {
            text = ccb.content.text("[A pin on Pat's digital map] What's that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_9",
            when = predicates.handler("dlg_p_dda_d0462abad931"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_9") },
        },
        {
            text = ccb.content.text("[A pin on Pat's digital map] What's that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_10",
            when = predicates.handler("dlg_p_dda_fb7ee155fe94"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_10") },
        },
        {
            text = ccb.content.text("[An old cassette player and an audio file] Haven't seen one of those in a while."),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_11",
            when = predicates.handler("dlg_p_dda_5cbf7f6a57a4"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_11") },
        },
        {
            text = ccb.content.text("[A scanned sheet of paper with several spirals drawn on it] What's that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_12",
            when = predicates.handler("dlg_p_dda_9c0b06ae2d63"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_12") },
        },
        {
            text = ccb.content.text("[A blurry polaroid of a scarlet storm cloud] That cloud looks nasty.  Who gave you that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_13",
            when = predicates.handler("dlg_p_dda_65d1ba71c183"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_13") },
        },
        {
            text = ccb.content.text("Nothing looks interesting to me.  I'll check in again later."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_1",
    line = ccb.content.text("I bought these photos off a merc.  Just looks like some house outta town, but look, there are some odd ahrtifacts - little floatin' distortions - all over'em.  I've seen ghost shows.  The merc was a believah, so they didn't try and loot it.  Gotta be somethin' there, though.  Worth a scan."),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_2",
    line = ccb.content.text("Shared a smoke with a merc that took these photos of a Depahtment of Energy facility.  Nothin' more ominous than the DOE, yeah?  Worth a scan."),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_3",
    line = ccb.content.text("Fahka' sold me this - for a full coin I might add - said it's a fahkin' treasure map.  I was hard up for fresh data, so I bought it.  Says there's a grate out in the contry, and treasure underneath.  Figured it's worth checkin' out, anyway."),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_4",
    line = ccb.content.text("Check out these photos - looks like some kind of minin' operation.  But the strange thing is that, apparently, the ground was a rumblin', and the tradah that passed by swore they heard screams.  Not the zombie kind neithah.  Worth a scan - from the pahking lot, maybe."),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_5",
    line = ccb.content.text("This is a doozy.  This guy, all out of his mind, came by and swore he saw this scrap-metal castle just fahkin' BLIP into existence.  So crazy a story I doubt he made it up.  Lock'n'load and check it out, yeah?"),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_6",
    line = ccb.content.text("I picked these up off a tradah in exchange for some cigs - didn't tell me where they got'em.  Most of it's redacted, which probably means strange shit, no?  But I'm seein' here all these order forms for materials to build ventilation shafts, and a few geological reports say somethin' about forests.  It isn't much to go on, but keep an eye out for strange shit in the woods, yeah?"),
    replies = { { text = ccb.content.text("I'll keep an eye out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_7",
    line = ccb.content.text("Came fresh off another merc claims they got it on a job from our employah, but wouldn't say too much more.  I coaxed a location out'of'em.  Given how secretive they were, I think it's worth a look and a scan, yeah?"),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_8",
    line = ccb.content.text("All I've got is that photo and a location.  It's some kind of building, glowing all purple.  I'd take a hazmat suit, if you got one.  Maybe it's freakin' nukes or some shit, yeah?"),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_9",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Merc told me she saw some sort'a creature in the woods.  I made her prove it.  She shows me this.\"  Pat uploads a scanned, blurry Polaroid photo showing a fence in the forest, with some small, dark smear of a creature moving behind it.  Pat then drops a digital pin in your HUDs map application.  \"Figure you can't see much, but this place is where the merc saw it.  Maybe worth a look."),
        no = ccb.content.text("Merc told me she saw some sort'a creature in the woods.  I made her prove it.  She shows me this.\"  Pat pulls out a blurry Polaroid photo showing a fence in the forest, with some small, dark smear of a creature moving behind it. \"Figure you can't see much, but this place is where the merc saw it.  Maybe worth a look."),
    },
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_10",
    line = ccb.content.text("This one might be nothin', but the mercs have been talking about this lonah lives out in a cabin - this cabin, heah.  They say he's SEEN things, but everyone's got a different idea about what he's seen.  Maybe you go see for yourself?"),
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_11",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Check this out.\"  Pat double clicks an audio file and an old version of Winamp opens up.  The sound starts immediately, but nothing but static fills your earpiece.  Pat stops it after a moment.  \"Nothin', right?  Wrong.  I recorded somethin' - someone talkin' - but it's just gone.  Just not theah.  Somethin's afoot.  I'm pretty sure the source is this radio tower, heah.  Check it out, maybe?"),
        no = ccb.content.text("Check this out.\"  Pat hits play on the recorder, and nothing but static plays for a moment before they stop it.  \"Nothin', right?  Wrong.  I recorded somethin' - someone talkin' - but it's just gone.  Just not theah.  Somethin's afoot.  I'm pretty sure the source is this radio tower, heah.  Check it out, maybe?"),
    },
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_12",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Right, look at this heah.  Merc I talked to said they wandered deep into this fahkin' mine and found all these strange ass spirals.  Even drew a map.\"  Pat uploads a scan of a sketched map to your headset HUD.  \"Fahkah wasn't right in the head, I'll tell ya' that.  Anyway.  Sounds like the kinda strange shit that's right up your alley, though.  Check it out."),
        no = ccb.content.text("Right, look at this heah.  Merc I talked to said they wandered deep into this fahkin' mine and found all these strange ass spirals.  Even drew a map.\"  Pat flips over the paper to show you a sketched map.  \"Fahkah wasn't right in the head, I'll tell ya' that.  Anyway.  Sounds like the kinda strange shit that's right up your alley, though.  Check it out."),
    },
    replies = { { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_13",
    line = ccb.content.text("This fahkin' merc stumbled in, sweatin' like a pig, and snortin', too.  Well, not snortin', really, but coughing.  They were hawkin' some smokes.  I says: \"that doesn't seem like a good idea, right?\"  Given' the coughin', right?  \"The fahk is in'em,\" I said?  Well, they say: \"ah, the coughin' is from some dust storm.\"  They described it as some sort of fuckin' fog - nasty shit you can't breath in.  Smells like the old Y, apparently.  Doesn't sound safe or natural, but maybe you go see for yourself?  Interestin' weather phenomenon if nothin' else."),
    replies = {
        { text = ccb.content.text("The old Y?"), next_topic = "MISSION_ROBOFAC_PAT_RECON_13_old_y" },
        { text = ccb.content.text("Maybe I'll check it out.  Thanks."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_PAT_RECON_13_old_y",
    line = ccb.content.text("Yeah, the YMCA, ya' know?  The one with the pool.  He said is smells like a fahkin' pool.  You know, right after they dump all that chlorine in.  Bad sign for that cloud being safe, ah'll tell ya' that."),
    replies = {
        {
            text = ccb.content.text("Maybe I'll check it out.  Thanks for the warning, Pat."),
            next_topic = "TALK_DONE",
        },
    },
}
