local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_atlas_permafrost",
    copy_from = "t_rock",
    name = ccb.content.text("permafrost"),
    description = ccb.content.text("A solid mass of permanently frozen earth, gravel, and ground ice."),
    looks_like = "t_rock",
    color = "light_blue",
    bash = {
        minimum_strength = 85,
        maximum_strength = 350,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("thump!"),
        terrain = "t_dirt_underground",
        terrain_from_above = "t_rock_floor_no_roof",
        drops = { { item = "material_soil", count = { 30, 80 } } },
    },
}
