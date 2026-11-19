local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_wasp_small_guard",
    name = ccb.content.plural_text("oversized wasp guard", "oversized wasp guards"),
    description = ccb.content.text("A mutated wasp worker, buzzing around the nest.  While her foraging sisters are relatively content to leave you be, this one won't hesitate to attack anything she considers a threat to the nest.  Don't linger."),
    copy_from = "mon_wasp_small",
    aggression = 0,
    melee_skill = 6,
    upgrade = { grow_at_age = 30, monster = "mon_wasp_guard" },
    fungalize_into = "mon_wasp_small_guard_fungus",
    inheritance = {
        add = { anger_triggers = { "HURT", "FIRE", "STALK" } },
        remove = { fear_triggers = { "HURT", "FIRE" } },
    },
}

ccb.content.define_monster {
    id = "mon_wasp_queen",
    name = ccb.content.plural_text("oversized wasp queen", "oversized wasp queens"),
    description = ccb.content.text("A mutated wasp queen grown to the size of a person, laying a single white egg in each empty cell she comes across while scurrying around on the paper walls of her home.  She struggles to fit into some of them, but the newer cells seem to be getting larger…"),
    copy_from = "mon_wasp_guard",
    harvest = "arachnid_wasp_queen",
    dissect = "dissect_insect_sample_large",
    reproduction = { offspring = { egg = "egg_wasp" }, count = 2, interval = 5 },
    upgrade = { grow_at_age = 30, monster = "mon_wasp_mega" },
    fungalize_into = "mon_wasp_queen_fungus",
    armor = { bash = 5, cut = 14, stab = 12, bullet = 12, electric = 3 },
}
