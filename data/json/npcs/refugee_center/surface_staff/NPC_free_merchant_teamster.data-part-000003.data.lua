local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS",
    line = {
        when = predicates.handler("dlg_p_dda_93de4f1e1331"),
        yes = ccb.content.text("No, sorry.  Nothin' much worth notin' out there these days, just the odd scattered survivor and they usually don't want random visitors."),
        no = {
            when = predicates.handler("dlg_p_dda_2fad9a32b6ea"),
            yes = ccb.content.text("Matter of fact, yeah.  Ran into a bunch of farmers.  They don't want much to do with our caravans, but someone like you they might be OK with."),
            no = {
                when = predicates.handler("dlg_p_dda_ffef735f5e6b"),
                yes = ccb.content.gendered_line("There's been rumors.  Folks talkin' about some kind of secret lab, out in the wilds, with survivors in it.  I haven't seen it myself, mind you.", { "interlocutor" }),
                no = {
                    when = predicates.handler("dlg_p_dda_c854bbaab2c0"),
                    yes = ccb.content.text("Well, a few of my caravans have come back now talkin' about this giant metal castle on top of a rock, in the middle of nowhere.  They ain't been crazy enough to check it out, but you could if you want."),
                    no = {
                        when = predicates.handler("dlg_p_dda_aea23a04550e"),
                        yes = ccb.content.text("A few of my people have come back now talkin' about some yuppie trying to start a bank that uses bullets for money.  Silly idea but the lad lives on a homestead with a woman who wouldn't let my guys leave without a full belly."),
                        no = ccb.content.text("ERROR: out of bounds on randomize_directions."),
                    },
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("How do I get to that farm?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_a1b66fb7c4f1"),
            actions = { actions.assign_mission("directions_isherwood") },
            switch = true,
        },
        {
            text = ccb.content.text("How do I get to that lab?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_873376a17718"),
            actions = { actions.assign_mission("directions_hub01") },
            switch = true,
        },
        {
            text = ccb.content.text("How do I get to that castle?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_a2718e906bff"),
            actions = { actions.assign_mission("directions_exodii") },
            switch = true,
        },
        {
            text = ccb.content.text("Where was that?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_09f33bbde74b"),
            actions = { actions.assign_mission("directions_artisans") },
            switch = true,
        },
        {
            text = ccb.content.text("Ah, that's nothing new to me.  Thanks anyway though."),
            next_topic = "TALK_DONE",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Hold on, what were you saying before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}
