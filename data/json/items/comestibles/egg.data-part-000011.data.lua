local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_spade_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("Several short strands of tightly clustered black eggs connected together by their viscous coverings."),
    inheritance = { add = { rot_spawn = { monster = "mon_spade_tadpole", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}
