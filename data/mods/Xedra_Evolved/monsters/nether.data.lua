local ccb = require("ccb")

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
