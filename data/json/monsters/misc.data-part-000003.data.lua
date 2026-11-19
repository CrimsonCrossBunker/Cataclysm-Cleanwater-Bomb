local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_puller_weak",
    copy_from = "mon_debug_grabber",
    mass = "100 kg",
    name = ccb.content.text_without_extraction("weak debug puller"),
    description = ccb.content.text_without_extraction("This 100kg monster exists only to test ranged pulls using the base 0.5 pull weight ratio."),
    attacks = {
        {
            id = "ranged_pull",
            grab_settings = { pull_weight_ratio = 0.5 },
            cooldown = 0,
            move_cost = 0,
        },
    },
    inheritance = { add = { flags = { "ALL_SEEING" } } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_puller_strong",
    copy_from = "mon_debug_puller_weak",
    name = ccb.content.text_without_extraction("strong debug puller"),
    description = ccb.content.text_without_extraction("This 100kg monster is strong enough to pull 250kg targets."),
    attacks = {
        {
            id = "ranged_pull",
            grab_settings = { pull_weight_ratio = 2.5 },
            cooldown = 0,
            move_cost = 0,
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_puller_incompetent",
    copy_from = "mon_debug_puller_strong",
    name = ccb.content.text_without_extraction("incompetent debug puller"),
    description = ccb.content.text_without_extraction("This monster exists only to fail pulling its target despite technically being able to.  Truly a cursed existence."),
    attacks = {
        {
            id = "ranged_pull",
            grab_settings = { pull_weight_ratio = 2.5, pull_chance = 0 },
            cooldown = 0,
            move_cost = 0,
        },
    },
}
