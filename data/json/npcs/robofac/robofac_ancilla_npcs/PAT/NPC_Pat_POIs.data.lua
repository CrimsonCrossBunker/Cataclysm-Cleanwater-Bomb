local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  I'm pickin' up some radio disturbances.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  I'm pickin' up some radio disturbances.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm getting close to that farmstead the merc told us about.  Pick up any more recon?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_1"),
        },
        {
            text = ccb.content.text("What kind of disturbances?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard_1",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_unvitrified_orchard_later", "yes"),
            },
        },
        {
            text = ccb.content.text("[Quickly Chirp the radio twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_unvitrified_orchard_later", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard_recon",
    line = ccb.content.text("Ah, yeah, actually, I did.  Listen.  I'm not sure it's a good idea.  Talked to a buddy of that same fahkin' merc.  Turns out the merc was goin' to explore that house, but nevah came back.  On top'a that, now that you're close, the fahkin' feed keeps goin dead.  Don't bode well.  If ya' go, be prepared for somethin' real bad to happen.  Go get a snack, some smokes, and some watah.  Ovah."),
    replies = {
        {
            text = ccb.content.text("Got it.  Thanks, Pat.  Over and out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard_1",
    line = ccb.content.text("Mostly the fahkin' feed keeps goin' dead.  I've been checkin the maps, and it seems worse the closer you get to that house ovah there.  Go check it out, yeah?  Ovah'n'out."),
    replies = { { text = ccb.content.text("Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Hang on.  Need to confirm ya' location.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Hang on.  Need to confirm ya' location.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm getting close to that Department of Energy facility we talked about.  What's up?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_2"),
        },
        {
            text = ccb.content.text("What's going on?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_1",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_LIXA_surface_1a_later", "yes") },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_LIXA_surface_1a_later", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_recon",
    line = ccb.content.text("That's what I thought.  Turns out theah's some chattah about this place around the Hub with the mercs.  If you're there for a scan, set up the HEW, scan from outside, and get the fahk outta theah."),
    replies = { { text = ccb.content.text("Got it.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_1",
    line = ccb.content.text("&The line is silent a moment before Pat chirps back: \"Well, nothin'.  It's just that this buildin' isn' on my maps.  If I had to guess, it's some sort of government spook shit.  Ovah\""),
    replies = {
        {
            text = ccb.content.text("It's that LIXA place - that contract I accepted from the intercom.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_2",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"),
        },
        { text = ccb.content.text("I'll be careful.  Over and out."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_2",
    line = ccb.content.text("Right, right.  Without the intahnet I couldn't find shit about this, but I did ask around when I heard about it.  Some of the othah mercs have been avoidin' the job.  Nothin' concrete, but they just don't like the sound of it.  Doesn't bode well for us, I think.  Ovah'n'out."),
    replies = { { text = ccb.content.text("Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_temple_stairs",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  The photos I'm gettin' are worse than usual.  Somethin's fahkin' with the transmission.  Just be careful, yeah?  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  The photos I'm gettin' are worse than usual.  Somethin's fahkin' with the transmission.  Just be careful, yeah?  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm near the point from that treasure map you bought.  Think it's that?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_temple_stairs_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_3"),
        },
        { text = ccb.content.text("Alright.  Over and out."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("[Chirp Pat twice and stay silent]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_temple_stairs_recon",
    line = ccb.content.text("Might be.  Remembah, it's some sort of grate in the ground.  Might be tough'ta spot.  Keep an eye out."),
    replies = { { text = ccb.content.text("Right.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_mine_amigara_finale_central",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line, broken up by static: \"Pat ta' <pat_robo_nickname>. You heah tha-- sound?  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line, broken up by static: \"Pat heah.  You heah tha-- sound?  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("Hear what?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_mine_amigara_finale_central_1",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_mine_amigara_finale_central_later", "yes"),
            },
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_mine_amigara_finale_central_later", "yes"),
            },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_mine_amigara_finale_central_later", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_mine_amigara_finale_central_1",
    line = ccb.content.text("Sounded like someone--omething, chattin' on -- frequency.  It's gone-\"… the signal becomes dead static."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Is that a fahkin' CASTLE?  Holy shit.  What the fahk kinda' world are we livin' in?  Anyway, get in there and bring me back a sword!  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Is that a fahkin' CASTLE?  Holy shit.  What the fahk kinda' world are we livin' in?  Anyway, get in there and bring me back a sword!  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("It's gotta be that castle that crazy guy said \"blipped\" into existence, right?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_5"),
        },
        {
            text = ccb.content.text("It's that place the teamster told me about.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_1",
            when = predicates.has_mission("directions_exodii"),
        },
        {
            text = ccb.content.text("It's that place from that sign I found.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_1",
            when = predicates.has_mission("directions_exodii_signpost"),
        },
        {
            text = ccb.content.text("From here it looks like a pile of scrap metal, but I can't really tell.  That mean anything to you?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_1",
        },
        {
            text = ccb.content.text("I'll see what I can do.  Over and out."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_exodii_base_x0y0z0_later", "yes"),
            },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_exodii_base_x0y0z0_later", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_recon",
    line = ccb.content.text("Gotta fahkin' be.  Listen, I got an update.  While ya' was gone, I met some merc hangin' around with a strange gun - it's relevant, I sweah.  Anyway.  Asked'em where he got it, and he told me to mind my own fahkin' business, so I told him to fahk off, and anyway, long story short, he says he got it off some killah robot he found out in the wildahness, near some kind of fahkin' scrap-metal pod with a sign.  I dunno.  Seems relevant.  If it's killah-fahkin' robots, set the HEW up, get a scan, and bounce.  Ovah'n'out."),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_1",
    line = ccb.content.text("Ah, right.  Now that ya mention it, I saw some merc hangin' around with a strange gun - it's relevant, I sweah.  Anyway.  Asked'em where he got it, and he told me to mind my own fahkin' business, so I told him to fahk off, and anyway, long story short, he says he got it off some killah robot he found out in the wildahness, near some kind of fahkin' scrap-metal pod with a sign.  I dunno.  Seems relevant.  Ovah'n'out."),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_microlab_portal_security1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line, broken up by static: \"Pat ta' <pat_robo_nickname>.  I'm not gettin' a good--cshhh--signal.  Yo--cshhh--eep underground.  Somethin' bad--cshhh--\"…  the line is then filled with dead static."),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line, broken up by static: \"Pat heah.  I'm not gettin' a good--cshhh--signal.  Yo--cshhh--eep underground.  Somethin' bad--cshhh--\"…  the line is then filled with dead static."),
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_microlab_portal_security1_later", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm close to that place the hunk of meat came from.  See anything?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_2",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_7"),
        },
        {
            text = ccb.content.text("Hey, Pat.  I'm getting close to that… thing I'm supposed to go into for the Hub.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE"),
        },
        {
            text = ccb.content.text("Go ahead, Pat.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_2",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_corpse_surface_later", "yes") },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_corpse_surface_later", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_1",
    line = ccb.content.text("Ah, right.  Yeah, that ain't no fahkin' cave.  I looked ovah my old maps, and couldn't find anythin' theah before <the_cataclysm>.  Whatever it is is supahnatahral, ya' undahstand?"),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_2",
    line = ccb.content.text("You see that fahkin'… thing, nearby?  In the distance?  Looks like a cave, but it isn't no fahkin' cave.  I looked ovah my old maps, and couldn't find anythin' theah before <the_cataclysm>.  Whatever it is is supahnatahral, ya' undahstand?"),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  You see that?  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  You see that?  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("Yeah, that purple glow in the distance?  I'm getting close to the location that photo was taken.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_8"),
        },
        {
            text = ccb.content.text("Yeah, that faint purple glow in the distance, I think I do.  I've got an address from some \"XEDRA\" notebook.  Know anything about it?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_1",
            when = predicates.has_mission("MISSION_XEDRA_FIELD_STATION_1"),
        },
        {
            text = ccb.content.text("See what?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_2",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_xedra_rural_church_later", "yes"),
            },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_xedra_rural_church_later", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_recon",
    line = ccb.content.text("Yeah, check this out.  Aftah we talked I tracked down the merc that sold me the photo.  Turns out she went back.  She opened the door, crawled through a fahkin' blocked-up hallway, and got inside.  She tells me she opens the next door an' BAM - somethin' grabs her.  She said it didn' fahkin' hurt, but it was STRONG.  Wicked strong.  Said she couldn' even describe it, just, like, some kinda' fahkin' THING.  So whatevah it is, if ya' get close, make sure ya' got an escape, yeah?  Don't just fahkin' bumble in there like an idiot.  Pat ovah'n'out."),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_1",
    line = ccb.content.text("&The comm is silent a moment before Pat chirps back.  \"Dunno if it's helpful, but my old map cache says there's a church theah.  Go slow, quiet, and careful, yeah?"),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_2",
    line = ccb.content.text("Look closah, theah, in the distance.  Caught it on one'a the pics that came through.  Look's like it's glowin' purple.  Checked my maps, and it's definitely that church theah in the distance.  Somethin' goin' on.  Go slow, quiet, careful, yeah?"),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Gettin' a bit too close to Morgantown for my likin'.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Gettin' a bit too close to Morgantown for my likin'.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("Morgantown?  Look, I'm close to the place that merc said they saw a creature in the woods.  Must be there, yeah?  What do you know about Morgantown?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far_1",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_9"),
        },
        {
            text = ccb.content.text("Morgantown?  I've got an address from some \"XEDRA\" notebook leading me that direction.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far_1",
            when = predicates.has_mission("MISSION_XEDRA_FIELD_STATION_2"),
        },
        {
            text = ccb.content.text("Morgantown?  Never heard of it.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far_1",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_morgantown_2b_later", "yes") },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_morgantown_2b_later", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far_1",
    line = ccb.content.text("Yeah, some old place in the woods, all fenced off.  That place is fahkin' hauwnted - my uncle told me all about it.  They say it's full of ghosts and shit like that.  Wicked scary.  I don't believe in ghosts, don't get me wrong, but I didn't believe in zombies either before <the_cataclysm>, so, ya' know, put that in ya' pipe and smoke it."),
    replies = { { text = ccb.content.text("I'll be careful.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_close",
    line = ccb.content.text("&You hear a chirp in your comm and Pat's hushed voice comes over the line: \"Listen', don' respond.  I've just got a picture come through and I see them THINGS over theah.  Those freaky little SHITS look just like the parabolic dishes I used'ta'use to pickup sat signals.  If this ain't some tabletop RPG dumbass nerd shit I don't know what is, but I'd bet they use them to hear.  Be quiet or get the fahk outta' there.  Bettah' yeah, go around back and fiah off a few shots, yeah?  Maybe they'll scramble over there n' you can poke around in safety.\""),
    replies = { { text = ccb.content.text("[Chirp Pat once and stay silent]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_radio_tower_reverberation_mp3",
    line = {
        when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_11"),
        yes = ccb.content.text("&Your comm is filled with static and your HUD glitches.  Suddenly, the sound of soft, slightly distorted smooth jazz starts to play in your earpiece - it continues for a moment before you hear a chirp and Pat's voice:\n\n\"That's it!  That's the fahkin' sound I hear!  Pal, someone might be nearby with a transmittah, fahkin' with ya'.  There's not much but that radio towah we talked about, so maybe there.  Lock and load.  Ovah.\""),
        no = ccb.content.text("&Your comm is filled with static and your HUD glitches.  Suddenly, the sound of soft, slightly distorted smooth jazz starts to play in your earpiece - it continues for a moment before you hear a chirp and Pat's voice:\n\n\"What was that bullshit?  Pal, someone might be nearby with a transmittah, fahkin' with ya'.  There's not much but a radio towah nearby, so maybe there.  Lock and load.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'll check it out.  Over and out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_radio_tower_reverberation_mp3_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_radio_tower_reverberation_mp3_1",
    line = ccb.content.text("&Your comm is filled with static again and your HUD glitches.  Something, or someone, whispers an indiscernible word through the earpiece.  It then falls silent."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_mine_spiral_finale_s",
    line = ccb.content.text("Your comm is filled with static for a long moment before the faint sound of Pat's voice interrupts: \"I dunno what the fahk you're into down theah, but I'm recordin'.  Keep goin'!\""),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_cabin_3_reverberation_hint",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Some'a your recent images are wicked twisted with errors and noise.  Not sure what's nearby, but it's messin' with the signal.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Some'a your recent images are wicked twisted with errors and noise.  Not sure what's nearby, but it's messin' with the signal.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm close to the cabin we talked about.  Think that's it?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_cabin_3_reverberation_hint_1",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_10"),
        },
        {
            text = ccb.content.text("I'll be careful.  Thanks, Pat.  Over and out."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("[Chirp Pat twice and stay silent]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_cabin_3_reverberation_hint_1",
    line = ccb.content.text("Gotta be.  I asked around aftah we talked, and nobody has talked to that lonah in days, turns out.  They haven't been around.  They're either theah in the cabin, or gone.  Fahkin' lock'n'load and be ready.  Ovah'n'out."),
    replies = { { text = ccb.content.text("Thanks, Pat.  Over and out."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_string_dimension",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_exodii" } }),
        yes = ccb.content.text("That's fahkin' insane.  Look, I've been pourin' over the data the system collected while ya' was there, and the weathah is out of control.  Cold.  Real low preshah.  But also, when I'm checkin' temps and the rangefindah, I'm seein' little blops of heat in the distance, with some sorta structahs.  Lots'a little ones, and one big one.  Anothah thing.  I picked up some fahkin' radio signals, but I can't understand'em.  It's the EXACT same shit those robots from the scrap castle are kickin' out.  Odd, right?  If I had a dollah to bet, I bet if you looked around you'd find more'a them robots.  Dunno if it's anything you saw, but if ya' can get back, and wanna go back, may be worth explorin'."),
        no = ccb.content.text("That's fahkin' insane.  Look, I've been pourin' over the data the system collected while ya' was there, and the weathah is out of control.  Cold.  Real low preshah.  But also, when I'm checkin' temps and the rangefindah, I'm seein' little blops of heat in the distance, with some sorta structahs.  Lots'a little ones, and one big one.  Anothah thing.  I picked up some fahkin' radio signals, but I can't understand'em.  But it's somethin' I've picked up heah now and again, too.  Somethin' is alive theah.  Dunno if it's anything you saw, but if ya' can get back, and wanna go back, may be worth explorin'."),
    },
    replies = {
        {
            text = ccb.content.text("I'll remember that, Pat."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.handler("dlg_a_dda_b35540f5ff02") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_labyrinth",
    line = ccb.content.text("Me neithah."),
    replies = {
        {
            text = ccb.content.text("[shrug at Pat]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.handler("dlg_a_dda_8772355d2832") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_radiosphere",
    line = ccb.content.text("Ya' fahkin' kiddin' me.  I don't even know what to say."),
    replies = {
        {
            text = ccb.content.text("[shrug at Pat]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.handler("dlg_a_dda_c75ba8b85585") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_cabin_reverb",
    line = ccb.content.text("Ya' fahkin' kiddin' me.  I don't even know what to say."),
    replies = {
        {
            text = ccb.content.text("[shrug at Pat]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.handler("dlg_a_dda_f8ae05bc885e") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_spider_dimension",
    line = ccb.content.text("Ya' fahkin' kiddin' me.  I don't even know what to say."),
    replies = {
        {
            text = ccb.content.text("[shrug at Pat]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.handler("dlg_a_dda_f376975a2e26") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_portal_storm_dungeon",
    line = ccb.content.text("Well that's a real mind-fahk.  Think ya' go can go back?  Doesn't seem too fahkin' wise, but I guess it wasn't so wise in the first place, anyhow."),
    replies = {
        {
            text = ccb.content.text("[shrug at Pat]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.handler("dlg_a_dda_42d5089e8159") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_highlands",
    line = ccb.content.text("That's straight freakin' nuts.  But.  You were theah long enough for me to get some good data from ya' rangefindah and othah instruments.  Theah's definitely some man-made shit theah, but I didn't pick up a single other radio signal or anythin' of the sort.  Dunno what to make'a that."),
    replies = {
        {
            text = ccb.content.text("Not sure, Pat.  But I'll let you know if I learn anything."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.handler("dlg_a_dda_c2b615800f06") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_scarlet_storm",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  I'm startin' ta' lose ya'.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  I'm startin' ta' lose ya'.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm getting close to that storm you told me about.  Pick up any more recon?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_scarlet_storm_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_13"),
        },
        {
            text = ccb.content.text("Looks like I'm in some sort of storm, or fog.  It's not very clear.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_scarlet_storm_1",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_scarlet_storm_later", "yes") },
        },
        {
            text = ccb.content.text("[Quickly Chirp the radio twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_scarlet_storm_later", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_scarlet_storm_recon",
    line = ccb.content.text("Shit, I meant ta' call ya'.  That fuckah I got the photo from?  Dead as a fakhin' doornail.  Toast.  Kaput.  Maybe this isn't such a good idea.  Though, I guess that poor sap was in it for a day or two.  At least get yourself a mask, if you don't got one already.  Deal?  Ovah'n'out."),
    replies = {
        {
            text = ccb.content.text("Got it.  Thanks, Pat.  Over and out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_scarlet_storm_1",
    line = ccb.content.text("Pickin' up images now.  Shit.  That looks a lot like some photos some fuckah' hawkin' smokes just showed me.  Poor shit was hackin' up a lung.  Could hardly breath.  I think that's a bad sign, yeah?  I'd turn ya' ass around if ya don't got a respiratah - a gas mask - somethin'."),
    replies = {
        {
            text = ccb.content.text("Good to know.  Thanks, Pat.  Over and out."),
            next_topic = "TALK_DONE",
        },
    },
}
