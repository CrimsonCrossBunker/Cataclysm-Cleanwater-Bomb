local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_peeper_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A loose grouping of surprisingly few frog's eggs, anchored to submerged vegetation."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_peeper_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_gray_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A small patch of frog's eggs rests on the water's surface."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_gray_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_mink_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A tight, spherical cluster of eggs, often found near submerged vegetation.  This cluster is polar, with dark pigment collected near the tops of the eggs and white left on the underside."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_mink_tadpole", chance = 20 } } },
}
