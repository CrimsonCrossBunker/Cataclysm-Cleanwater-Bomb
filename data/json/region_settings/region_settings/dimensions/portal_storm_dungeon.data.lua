local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "default_portal_storm_dungeon_extras",
    chance = 15,
    extras = {
        { extra = "mx_portal_cracked_mirror", weight = 1 },
        { extra = "mx_portal_ingress", weight = 1 },
        { extra = "mx_portal_distortion_item", weight = 1 },
    },
}
