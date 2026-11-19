local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_fowler_toad",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("These eggs float in long strands, drifting in the still water."),
    inheritance = { add = { rot_spawn = { monster = "mon_fowler_tadpole", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_freedom_toad",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A spiral strand of frog eggs adorns a patch of underwater vegetation."),
    inheritance = { add = { rot_spawn = { monster = "mon_freedom_tadpole", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}
