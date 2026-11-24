local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_blank",
    copy_from = "mon_blank",
    name = ccb.content.plural_text("blank body", "blank bodies"),
    description = ccb.content.text("This is some form of unnatural changeling creature; its appearance is a bland mockery of the human form.  Featureless and pale, its repugnant countenance is all the more unsettling due to its lack of eyes and distinguishing features except for a perfectly round mouth.  Adding to its unearthly appearance is the way it moves, stiff and doll-like as though it was only feigning knowing how to walk."),
    harvest = "harvest_blank_body",
    categories = { "XE_CLASSIC" },
}

ccb.content.define_monster {
    id = "mon_kreck",
    copy_from = "mon_kreck",
    categories = { "XE_CLASSIC" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = "The %s stiffens and falls apart into fragments.",
            on_death = "w16b_mon_die_xedra_evolved_90651120d48a",
        },
    },
}

ccb.content.define_monster {
    id = "mon_shoggoth",
    copy_from = "mon_shoggoth",
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = "The %s bubbles and steams as it melts into protoplasmic ooze.",
            on_death = "w16b_mon_die_xedra_evolved_10e4860dc65e",
        },
    },
    inheritance = {
        add = {
            flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" },
        },
    },
}
