local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_Situation",
    line = {
        when = predicates.handler("dlg_p_dda_0878c016a807"),
        yes = {
            when = predicates.handler("dlg_p_dda_d82dc5cb5113"),
            yes = {
                when = predicates.handler("dlg_p_dda_defb5ab5fdd2"),
                yes = ccb.content.text("It's tense here.  Maybe it always will be.  Still, things have been getting a bit better lately, and it's showing in a bit of a cascade effect.  It's hard to say what will be the ongoing effects of the trauma we've been through, but in the short term, people are starting to settle into whatever this new life we've got is.  I hope we can keep that going."),
                no = ccb.content.text("There have been a lot of improvements around here, and I think the pressure has gone off a bit.  There's a lot that still needs to be done, of course.  I don't think we're out of the woods yet.  We've all seen things that are hard to even wrap your head around; you know how that is."),
            },
            no = ccb.content.text("Things are maybe looking up, a tiny bit.  At least there's been some positive change.  Still, people up here are barely hanging on.  I've seen trauma before, a lot, but this is pretty much the worst imaginable.  Everyone has lost everything, with a huge dose of nightmare on top of it all.  We're putting on a brave face, and a little bit of hope is going a long way."),
        },
        no = ccb.content.text("People up here are barely hanging on.  I've seen trauma before, a lot, but this is pretty much the worst imaginable.  Everyone has lost everything, with a huge dose of nightmare on top of it all.  We're putting on a brave face, but without help, things are going to break, really soon."),
    },
}
