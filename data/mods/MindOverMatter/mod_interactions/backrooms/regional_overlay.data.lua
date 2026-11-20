local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "backrooms",
    copy_from = "backrooms",
    add_extras = {
        { extra = "mx_alien_grass", weight = 100 },
        { extra = "mx_alien_grass_2", weight = 100 },
        { extra = "mx_alien_grass_3", weight = 100 },
        { extra = "mx_alien_grass_4", weight = 100 },
        { extra = "mx_alien_grass_5", weight = 100 },
        { extra = "mx_nether_pond", weight = 500 },
        { extra = "mx_glass_and_crystal", weight = 500 },
        { extra = "mx_phavian_science", weight = 300 },
    },
}
