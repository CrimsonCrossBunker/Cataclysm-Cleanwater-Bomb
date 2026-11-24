local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates

-- A random scavenger visiting the refugee center to check it out, just like you.
ccb.content.define_npc {
    id = "RC_survivor_visiting",
    suffix = ccb.content.text("Survivor"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_RC_SURVIVOR_1",
    faction = "no_faction",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_1",
    line = ccb.content.text("Hey there.  Do you work here, or what?"),
    on_enter = {
        { actions = { actions.set_first_topic("TALK_RC_SURVIVOR_2"), actions.handler("dlg_a_dda_c231e68b393b") } },
    },
    replies = {
        {
            text = ccb.content.text("Me?  No, I'm just passing through, how about you?"),
            next_topic = "TALK_RC_SURVIVOR_Story",
        },
        {
            text = ccb.content.text("Work here?  No, of course not.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_2",
    line = ccb.content.text("What's up?"),
    replies = {
        { text = ccb.content.text("What's your story?"), next_topic = "TALK_RC_SURVIVOR_Story" },
        {
            text = ccb.content.text("You seen anything interesting out there?"),
            next_topic = "TALK_RC_SURVIVOR_Tips",
        },
        {
            text = ccb.content.text("Not much, just passing through.  Have a good day."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Story",
    line = ccb.content.gendered_line("I found a map to this place in an evac center and thought I'd see if it was just full of <zombies> or if there was something up.  Didn't expect to find so many survivors still alive though.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("You looking for a traveling companion?  I could use someone to watch my back."),
            next_topic = "TALK_RC_SURVIVOR_Join",
        },
        {
            text = ccb.content.text("You seen anything interesting out there?"),
            next_topic = "TALK_RC_SURVIVOR_Tips",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Tips",
    line = {
        when = predicates.handler("dlg_p_dda_93de4f1e1331"),
        yes = ccb.content.gendered_line("Sure.  Seen more'n I'd like to think about honestly.  Like, I think these zombies are evolving?  I've seen new things come out that I swear aren't natural.  One of them looked like it was sparking with electricity.", { "interlocutor" }),
        no = {
            when = predicates.handler("dlg_p_dda_2fad9a32b6ea"),
            yes = ccb.content.text("Come to think of it, yeah.  The other day, I met this weird old man in the woods.  Obsessed with rabbits.  He seemed like a nice fellow, open to visitors, if you'd like I can send you his way to trade."),
            no = {
                when = predicates.handler("dlg_p_dda_ffef735f5e6b"),
                yes = ccb.content.text("I could point you to some acquaintances of mine that have a farm, they're decent folk, if you have goods to trade.  Be careful around them, I get a vibe like they don't like visitors too much, and honestly it makes me nervous that they made it through this so together.  Kinda of ominous, you know?"),
                no = {
                    when = predicates.handler("dlg_p_dda_c854bbaab2c0"),
                    yes = ccb.content.gendered_line("There's so much weird stuff out there in the wilderness now.  A while back, I found this weird cartoon sign with a map on it, pointing to some kind of trade center.  Haven't been there yet but I can show you my copy of the map if you want.", { "interlocutor" }),
                    no = ccb.content.text("ERROR: out of bounds on randomize_directions."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Sure, show me where to find this guy."),
            next_topic = "TALK_RC_SURVIVOR_Tips2",
            when = predicates.handler("dlg_p_dda_b80a3ce20b48"),
            actions = { actions.assign_mission("directions_lapin") },
            switch = true,
        },
        {
            text = ccb.content.text("I'm always open to meet new survivors.  Where are these acquaintances of yours?"),
            next_topic = "TALK_RC_SURVIVOR_Tips2",
            when = predicates.handler("dlg_p_dda_8b6492c5cbde"),
            actions = { actions.assign_mission("directions_isherwood") },
            switch = true,
        },
        {
            text = ccb.content.text("Weird.  I guess I could check that out too, sure."),
            next_topic = "TALK_RC_SURVIVOR_Tips2",
            when = predicates.handler("dlg_p_dda_636a261c1cba"),
            actions = { actions.assign_mission("directions_exodii") },
            switch = true,
        },
        {
            text = ccb.content.text("Ah, yeah, I've heard of that too.  It's a weird world out there, hey?"),
            next_topic = "TALK_NONE",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Tips2",
    line = ccb.content.text("Sure, here, I'll draw you up a little map."),
    replies = {
        {
            text = ccb.content.text("Thanks!  What's your story?"),
            next_topic = "TALK_RC_SURVIVOR_Story",
        },
        { text = ccb.content.text("Thanks!  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Join",
    line = ccb.content.text("Sorry, I have people of my own to look out for.  I can't leave them in the lurch."),
    replies = {
        {
            text = ccb.content.text("They could come along too."),
            next_topic = "TALK_RC_SURVIVOR_Join1",
        },
        {
            text = ccb.content.text("Why don't I come back to your hideout?"),
            next_topic = "TALK_RC_SURVIVOR_Join2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Join1",
    line = ccb.content.text("It doesn't really work that way.  They're back in safety, and I've got to go check in with them with some supplies.  You know how it is, not everyone is suited to risk travel these days."),
    replies = {
        {
            text = ccb.content.text("Why don't I come back to your hideout?"),
            next_topic = "TALK_RC_SURVIVOR_Join2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Join2",
    line = ccb.content.text("Look, I don't know a better way to put this.  I don't know you, I can't bring some random back with me.  For all I know you're a cannibal psycho or something.  We all saw too much of that during <the_cataclysm>.  Me and mine, we're not looking to expand our tribe just now, OK?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
