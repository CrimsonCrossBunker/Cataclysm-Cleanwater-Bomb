local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_vocal_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("A patch of giant frog's eggs resembling a very thick, clear sack of oranges."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_vocal_bigtad", chance = 45 } } },
}
