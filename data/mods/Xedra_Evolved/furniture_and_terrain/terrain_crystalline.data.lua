local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_wall_crystalline_spire",
    name = ccb.content.text("crystalline wall"),
    description = ccb.content.text("A wall of jagged, slightly translucent crystal, dimly reflecting your broken image back in shards."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    looks_like = "t_wall_warped",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
}
