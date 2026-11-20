local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_march_lord_autumn",
    copy_from = "mon_march_lord",
    speed = 140,
    attacks = {
        { id = "march_lord_sword_autumn" },
        {
            id = "xe_touch_of_frailty",
            spell = { id = "touch_of_frailty_monster" },
            cooldown = 15,
            casting_message = ccb.content.text("The air wavers around %1$s's hand as they reach out for %3$s."),
            kind = "spell",
            when = "allow_march_lord_autumn_xe_touch_of_frailty",
        },
        {
            id = "xe_autumn_swirl_of_autumn_leaves",
            spell = { id = "swirl_autumn_leaves_monster", min_level = 0 },
            cooldown = 50,
            casting_message = ccb.content.text("%1$s gestures and whirling colored leaves surround them."),
            kind = "spell",
            when = "allow_march_lord_autumn_xe_autumn_swirl_of_autumn_leaves",
        },
    },
    inheritance = { add = { armor = { withering_damage = 32 } } },
    death = { drops = "changeling_lord_autumn_death_drops" },
}
