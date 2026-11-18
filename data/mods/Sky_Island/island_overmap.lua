local ccb = require("ccb")
local content = ccb.content

for _, id in ipairs {
    "sky_island_core",
    "sky_island_edge",
    "sky_island_corner",
    "sky_island_subcorner",
    "sky_island_subcore",
    "sky_island_subedge",
} do
    content.add(content.OvermapTerrain {
        id = id,
        name = content.text("sky island"),
        symbol = "#",
        color = "c_white",
        monster_density = 0,
        see_cost = "low",
        looks_like = { "field" },
    })
end

content.add(content.OvermapSpecial {
    id = "HQislandspecial",
    terrains = {
        { point = { 0, 0, 7 }, terrain = "sky_island_core_north" },
        { point = { -1, -1, 7 }, terrain = "sky_island_corner_north" },
        { point = { -1, 0, 7 }, terrain = "sky_island_edge_west" },
        { point = { -1, 1, 7 }, terrain = "sky_island_corner_west" },
        { point = { 0, -1, 7 }, terrain = "sky_island_edge_north" },
        { point = { 0, 1, 7 }, terrain = "sky_island_edge_south" },
        { point = { 1, -1, 7 }, terrain = "sky_island_corner_east" },
        { point = { 1, 0, 7 }, terrain = "sky_island_edge_east" },
        { point = { 1, 1, 7 }, terrain = "sky_island_corner_south" },
        { point = { 0, 0, 6 }, terrain = "sky_island_subcore_north" },
        { point = { -1, -1, 6 }, terrain = "sky_island_subcorner_north" },
        { point = { -1, 0, 6 }, terrain = "sky_island_subedge_west" },
        { point = { -1, 1, 6 }, terrain = "sky_island_subcorner_west" },
        { point = { 0, -1, 6 }, terrain = "sky_island_subedge_north" },
        { point = { 0, 1, 6 }, terrain = "sky_island_subedge_south" },
        { point = { 1, -1, 6 }, terrain = "sky_island_subcorner_east" },
        { point = { 1, 0, 6 }, terrain = "sky_island_subedge_east" },
        { point = { 1, 1, 6 }, terrain = "sky_island_subcorner_south" },
    },
    locations = { "open_air" },
    occurrences = { 100, 100 },
    rotate = false,
    flags = { "SKY_ISLAND", "SAFE_AT_WORLDGEN", "GLOBALLY_UNIQUE" },
})
