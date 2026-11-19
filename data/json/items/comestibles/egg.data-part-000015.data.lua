local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_shift_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("These golfball-sized frog eggs cling together by their sticky membranes."),
    inheritance = { add = { rot_spawn = { monster = "mon_shift_bigtad", chance = 45 } } },
    comestible = {},
    use_actions = { "POISON" },
}
