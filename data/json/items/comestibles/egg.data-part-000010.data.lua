local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_green_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A thin sheet of clear, gelatinous eggs with dark embryos peppered throughout."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_green_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_wood_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("This softball-sized mass of gooey eggs clings together like a bunch of soft, transparent grapes.  The \"seeds\" inside these appear to be growing legs."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_wood_tadpole", chance = 20 } } },
}
