local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
