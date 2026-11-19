local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "afs_tunnel",
    name = ccb.content.text("cavern"),
    color = "light_blue",
    see_cost = "spaced_high",
    spawns = { group = "AFS_GROUP_FAUNA_TUNNELS", population = { 4, 10 }, chance = 30 },
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = "afs_tunnel_sinkhole_surface",
    name = ccb.content.text("sinkhole "),
    symbol = "v",
    color = "light_blue",
    flags = { "REQUIRES_PREDECESSOR" },
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = "afs_tunnel_sinkhole",
    name = ccb.content.text("cavern"),
    symbol = "^",
    color = "light_blue",
    spawns = { group = "AFS_GROUP_FAUNA_TUNNELS", population = { 4, 10 }, chance = 20 },
    see_cost = "medium",
}

ccb.content.define_overmap_terrain {
    id = "afs_tunnel_ravine_edge",
    name = ccb.content.text("cavern"),
    color = "light_blue",
    symbol = "v",
    see_cost = "all_clear",
    flags = { "RAVINE_EDGE" },
}

ccb.content.define_overmap_terrain {
    id = "afs_tunnel_river",
    name = ccb.content.text("underground river"),
    color = "blue",
    see_cost = "spaced_high",
    spawns = { group = "AFS_GROUP_FAUNA_TUNNELS", population = { 4, 10 }, chance = 30 },
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = "afs_tunnel_river_start",
    name = ccb.content.text("underground river"),
    color = "light_blue",
    symbol = "o",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "afs_tunnel_lake1", "afs_tunnel_lake2", "afs_tunnel_lake3", "afs_tunnel_lake4",
        "afs_tunnel_lake5", "afs_tunnel_lake6",
    },
    name = ccb.content.text("underground lake"),
    symbol = "#",
    color = "cyan",
    spawns = { group = "AFS_GROUP_FAUNA_TUNNELS", population = { 4, 10 }, chance = 80 },
    see_cost = "none",
}
