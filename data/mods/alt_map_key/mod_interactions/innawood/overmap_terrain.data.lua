local ccb = require("ccb")
local content = ccb.content

content.patch_overmap_terrain {
    ids = { "cave_innawood" },
    copy_from = "cave_innawood",
    symbol = "C",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "cave_underground_innawood" },
    copy_from = "cave_underground_innawood",
    symbol = "C",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "cave_rat_underground_innawood" },
    copy_from = "cave_rat_underground_innawood",
    symbol = "C",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "cave_rat_innawood" },
    copy_from = "cave_rat_innawood",
    symbol = "C",
    color = "brown",
}
