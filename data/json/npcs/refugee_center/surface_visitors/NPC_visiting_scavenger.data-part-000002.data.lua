local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
