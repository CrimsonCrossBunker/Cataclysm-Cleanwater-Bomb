local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_foul_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("Looking like a submerged buoy-line, this long strand of softball-sized, gelatinous eggs floats gently in the still water."),
    inheritance = { add = { rot_spawn = { monster = "mon_foul_bigtad", chance = 45 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_odd_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("This is a spiral strand of giant frog eggs.  Its increased weight and size nearly smothers the submerged vegetation it clings to."),
    inheritance = { add = { rot_spawn = { monster = "mon_odd_bigtad", chance = 45 } } },
    comestible = {},
    use_actions = { "POISON" },
}
