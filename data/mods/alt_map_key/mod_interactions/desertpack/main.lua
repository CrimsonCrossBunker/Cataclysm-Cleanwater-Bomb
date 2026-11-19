local ccb = require("ccb")
local content = ccb.content

content.patch_overmap_terrain {
    ids = { "river_center" },
    copy_from = "river_center",
    color = "light_gray",
}
