local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_pickerel_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A globular mass of frog's eggs.  The individual eggs are colored a dark brown on top and a yellow-cream on the bottom."),
    inheritance = { add = { rot_spawn = { monster = "mon_pickerel_tadpole", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}
