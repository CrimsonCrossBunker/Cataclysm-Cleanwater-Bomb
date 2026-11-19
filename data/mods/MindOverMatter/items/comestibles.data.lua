local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_pigeon_passenger",
    name = ccb.content.text("feral pigeon egg"),
    copy_from = "egg_pigeon",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_pigeon_passenger", chance = 70 } } },
}
